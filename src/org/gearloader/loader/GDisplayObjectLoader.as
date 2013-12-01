package org.gearloader.loader {
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLLoaderDataFormat;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	
	public class GDisplayObjectLoader extends GBaseLoader {
		protected var _loader:Loader;
		
		public function GDisplayObjectLoader() {
			super();
			dataFormat = URLLoaderDataFormat.BINARY;
		}
		
		override protected function init():void {
			super.init();
			_loader = new Loader();
		}
		
		protected function loadBytes(bytes:ByteArray, context:LoaderContext = null):void {
			addLoaderEventListener()
			_loader.loadBytes(bytes, context);
		}
		
		protected function addLoaderEventListener():void {
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaderCompleteHandler);
		}
		
		protected function removeLoaderEventListener():void {
			_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoaderCompleteHandler);
		}
		
		//use this class "loader" load parent class content bytes when the parent class URLLoader load complete; 
		override protected function executeCompleteAfterHandler():void {
			var bytes:ByteArray = content as ByteArray;
			loadBytes(bytes);
		}
		//on this class "loader" load Complete
		protected function onLoaderCompleteHandler(e:Event):void {
			content = _loader.contentLoaderInfo.content;
			executeLoaderCompleteAfterHandler();
		}
		//on this class "loader" execute handler method after load complete, just execute parent class method "executeCompleteAfterHandler" to callBack onComplete function
		protected function executeLoaderCompleteAfterHandler():void {
			super.executeCompleteAfterHandler();
		}
		
		override public function dispose():void {
			removeLoaderEventListener();
			_loader = null;
			super.dispose();
		}
		
		
	}
}