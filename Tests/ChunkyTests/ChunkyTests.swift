import XCTest
@testable import Chunky

final class ChunkyTests:XCTestCase
{
    func filePutContents( file:URL, contents:String, fileManager:FileManager )->Bool
    {
        guard let data = contents.data( using:.ascii ) else
        {
            return false
        }

        try? fileManager.createDirectory( at:file.deletingLastPathComponent( ), withIntermediateDirectories:true, attributes:nil )
        return fileManager.createFile( atPath:file.path, contents:data, attributes:nil )
    }
    
    
    func testExample( )
    {
        let fileManager:FileManager = .default
        let tmpFile = fileManager.temporaryDirectory.appendingPathComponent( UUID.init( ).uuidString )
        
        let testData = "HELLO123Test"
        
        guard filePutContents( file:tmpFile, contents:testData, fileManager:fileManager ) else
        {
            fatalError( )
        }
        
        let CHUNK_SIZE:Int = 2
        
        let chunker:FileChunker = .init( input:tmpFile, outputDirectory:fileManager.temporaryDirectory, chunkSize:CHUNK_SIZE, bufferSize:1 )
        do
        {
            let urls = try chunker.chunk( )
            XCTAssertEqual( urls.count, Int( ceil( Double( testData.count ) / Double( CHUNK_SIZE ) ) ) )
            var dataChunks:[Data] = [ ]
            for url in urls
            {
                let data:Data = try .init( contentsOf:url )
                dataChunks.append( data )
            }
            
            let recontstructed = dataChunks.map( { String.init( data:$0, encoding:.ascii )! } ).joined( separator:"" )
            XCTAssertEqual( recontstructed, testData )
            try fileManager.removeItem( at:tmpFile )
            for url in urls
            {
                try fileManager.removeItem( at:url )
            }
        }
        catch
        {
            fatalError( error.localizedDescription )
        }
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
