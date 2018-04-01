package utils {
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.utils.ByteArray;

public class Files {

    private static var _instance:Files;
    private static var _path:String = "IdeaProjects/Interact/";

    public function Files():void {

    }

    public function createFolder(dir:String):void {

        var newDir:File = File.documentsDirectory.resolvePath(_path + dir);
        newDir.createDirectory();

    }

    public function deleteFolder(dir:String):void {

        var dirToDelete:File = File.documentsDirectory.resolvePath(_path + dir);
        dirToDelete.addEventListener(Event.COMPLETE, onDelete);
        dirToDelete.deleteDirectoryAsync(true);

    }

    private function onDelete(event:Event):void {
        trace(event.currentTarget.data);
    }

    public function saveJSON(path:String, object:String):void {

        var file:File = File.documentsDirectory.resolvePath(_path + path);
        var stream:FileStream = new FileStream();

        stream.open(file, FileMode.WRITE);
        stream.writeUTFBytes(object);
        stream.close();
    }

    public function loadJSON(path:String, callback:Function):void {

        var loader:URLLoader = new URLLoader();
        var file:File = File.documentsDirectory.resolvePath(_path + path);
        loader.addEventListener(Event.COMPLETE, loaded);
        loader.addEventListener(IOErrorEvent.IO_ERROR, onError);
        loader.load(new URLRequest(file.nativePath));

        function loaded(e:Event):void {
            callback(JSON.parse(loader.data));
        }

    }

    private function onError(e:*):void {

        trace(e);

    }

    public function createBinary(object:Object, path:String):void {

        var byteArray:ByteArray = new ByteArray();
        byteArray.writeObject(object);

        var file:File = File.documentsDirectory.resolvePath(_path + path);

        var stream:FileStream = new FileStream();

        stream.addEventListener(Event.CLOSE, onClose);
        stream.openAsync(file, FileMode.WRITE);

        stream.writeBytes(byteArray);

        stream.close();

    }

    public function saveBinary(byteArray:ByteArray, path:String):void {

        var file:File = File.documentsDirectory.resolvePath(_path + path);
        var stream:FileStream = new FileStream();

        stream.addEventListener(Event.CLOSE, onClose);
        stream.openAsync(file, FileMode.WRITE);

        stream.writeBytes(byteArray);

        stream.close();

        trace(path, "  BINARY SAVED!");

    }

    private function onClose(e:Event):void {
        //trace("Binary file written");
    }

    public function loadFilesByType(path:String, types:Array, callback:Function):void {

        var counter:int;
        var file:File = File.documentsDirectory.resolvePath(_path + path);
        var files:Array = file.getDirectoryListing();
        var filteredFiles:Array = new Array();
        var objects:Array = new Array();

        for(var i:int = 0; i < files.length; i++) {

            for (var j:int = 0; j < types.length; j++) {

                if (files[i].name.indexOf(types[j]) != -1) {
                    filteredFiles.push(files[i]);
                }
            }
        }

        loadBinary(path + "/" + filteredFiles[0].name, partialCallBack);

        function partialCallBack(byteArray:ByteArray):void {

            objects.push(byteArray);
            counter++;

            if(filteredFiles.length > counter){
                loadBinary(path + "/" + filteredFiles[counter].name, partialCallBack);
            }
            else {
                callback(objects);
            }
        }
    }

    public function loadBinary(path:String, callback:Function):void {

        var file:File = File.documentsDirectory.resolvePath(_path + path);
        var stream:FileStream = new FileStream();
        var byteArray:ByteArray = new ByteArray();

        stream.addEventListener(Event.COMPLETE, loaded);
        stream.openAsync(file, FileMode.READ);

        function loaded(e:Event):void {
            stream.readBytes(byteArray);
            callback(byteArray);
            stream.close();
        }
    }





    public function retrieveFoldersIn(path:String):Array {

        var file:File = File.documentsDirectory.resolvePath(_path + path);
        var files:Array = file.getDirectoryListing();
        var folders:Array = new Array();

        for(var i:int = 0; i < files.length; i++) {

            if (files[i].isDirectory) {
                folders.push(files[i]);
            }
        }

        return folders;

    }




















    public static function getInstance():Files {
        if(!_instance){
            _instance = new Files();
        }
        return _instance;
    }











}

}