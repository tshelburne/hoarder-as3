﻿/* * This file is part of the FormManager package. * * @author (c) Tim Shelburne <tim@dontlookstudios.com> * * For the full copyright and license information, please view the LICENSE * file that was distributed with this source code. */package dls.formmanager.submitter {		import flash.events.Event;	import flash.events.IOErrorEvent;	import flash.net.URLRequest;	import flash.net.URLVariables;		import org.osflash.signals.ISignal;	import org.osflash.signals.Signal;	import org.osflash.signals.natives.NativeSignal;		import dls.debugger.Debug;	import dls.formmanager.form.IForm;	import dls.formmanager.submitter.IFormSubmitter;	import dls.formmanager.submitter.loaders.FormURLLoader;		/*	 * A class to submit and wait for a response to relay form submission information to and from forms.	 */	public class SimpleSubmitter implements IFormSubmitter {				/*=========================================================*		 * PROPERTIES		 *=========================================================*/				private var _debugOptions:Object = { "source" : "FormManager (SimpleSubmitter)" };				private var _urlLoaders:Vector.<FormURLLoader> = new <FormURLLoader>[];				private var _success:Signal = new Signal();		public function get success():ISignal {			return _success;		}				private var _error:Signal = new Signal();		public function get error():ISignal {			return _error;		}				/*=========================================================*		 * FUNCTIONS		 *=========================================================*/		 		public function canSubmit(form:IForm):Boolean {			return form.submitType == "simple";		}				/**		 * initialize the request and add a loader to the loaders Vector.		 */		public function submit(form:IForm):void {			var data:URLVariables = objectToURLVariables(form.getValuesObject());						var request:URLRequest = new URLRequest();			request.url = form.action;			request.method = form.method;			request.data = data;						Debug.out("Submitting form to " + form.action + "...", Debug.DETAILS, _debugOptions);			Debug.out(data, Debug.DEBUG, _debugOptions);						var loader:FormURLLoader = new FormURLLoader(form);			_urlLoaders.push(loader);						new NativeSignal(loader, Event.COMPLETE, Event).addOnce(responseReceived);			new NativeSignal(loader, IOErrorEvent.IO_ERROR, IOErrorEvent).addOnce(errorReceived);			loader.load(request);		}				/**		 * dispatch a success signal and clean out the loader.		 */		private function responseReceived(e:Event):void {			Debug.out("Response received...", Debug.DEBUG, _debugOptions);			_success.dispatch(e.target.relation, e.target.data);			cleanLoader(e.target as FormURLLoader);		}				/**		 * dispatch an error signal and clean out the loader		 */		private function errorReceived(e:IOErrorEvent):void {			Debug.out("Error received...", Debug.DEBUG, _debugOptions);			_error.dispatch(e.target.relation, e.toString());			cleanLoader(e.target as FormURLLoader);		}				/**		 * remove the given loader from the list of loaders		 */		private function cleanLoader(loader:FormURLLoader):void {			_urlLoaders.splice(_urlLoaders.indexOf(loader), 1);		}				/**		 * convenience function to convert a plain object to URLVariables		 *		 * @author - Riccardo <http://www.rblab.com/blog/2009/04/as3-snippet-object-to-urlvariables/>		 */		private function objectToURLVariables(parameters:Object):URLVariables {			var paramsToSend:URLVariables = new URLVariables();			for (var i:String in parameters) {				if (i != null) {					if (parameters[i] is Array) {						paramsToSend[i] = parameters[i];					}					else {						paramsToSend[i] = parameters[i].toString();					}				}			}			return paramsToSend;		}	}	}