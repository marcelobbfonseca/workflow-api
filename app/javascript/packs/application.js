/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb
// import { FunctionName, AnotherFunction} from 'path/file'
// import * as helpers from 'path/file'
// import MyJsFile from 'my_js_file';

import JQuery from 'jquery'
import Fs from 'fs'
import Browserify from 'browserify'
import BPMNJs from 'bpmn-js'

import modelerIndex from '../bpmn_stuff/modeler_index.js';
console.log('Hello World from webpacker')

var BpmnViewer = require('bpmn-js');

var xml; // my BPMN 2.0 xml
var viewer = new BpmnViewer({ container: '#canvas' });

viewer.importXML(xml, function(err) {

    if (err) {
        console.log('error rendering', err);
    } else {
        console.log('rendered');
    }
});
