﻿/* * This file is part of the FormManager package. * * @author (c) Tim Shelburne <tim@dontlookstudios.com> * * For the full copyright and license information, please view the LICENSE * file that was distributed with this source code. */package dls.formmanager.form {		import dls.formmanager.form.IFormElement;		/*	 * This class is used to represent non-interactable items in forms.	 */	public class HiddenElement implements IFormElement {				/*=========================================================*		 * PROPERTIES		 *=========================================================*/		 		private var _name:String;		public function get name():String {			return _name;		}				private var _value:*;		public function get value():* {			return _value;		}				public function get validationRules():Object {			return {};		}				/*=========================================================*		 * FUNCTIONS		 *=========================================================*/		public function HiddenElement(aName:String, aValue:*) {			_name = aName;			_value = aValue;		}				public function resetValue(aValue:*):void {			_value = aValue;		}	}	}