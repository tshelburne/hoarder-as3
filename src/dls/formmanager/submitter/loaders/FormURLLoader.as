﻿package dls.formmanager.submitter.loaders {		import flash.net.URLRequest;		import dls.formmanager.form.IForm;		import dls.loaders.RelationalURLLoader;		public class FormURLLoader extends RelationalURLLoader {				/*=========================================================*		 * PROPERTIES		 *=========================================================*/				/*=========================================================*		 * FUNCTIONS		 *=========================================================*/		public function FormURLLoader(form:IForm, request:URLRequest = null) {			super(form, request);		}	}	}