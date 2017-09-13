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

//import $ from 'jquery'
import 'bpmn-js'
import 'diagram-js'
import 'bpmn-moddle'


import 'bootstrap/dist/css/bootstrap'
import 'bootstrap/dist/css/bootstrap-theme'
//import 'bpmn-js/assets/bpmn-font/bpmn'
//import 'bpmn-js/assets/bpmn-font/bpmn-embedded'
//import 'diagram-js/assets/diagram-js'

//import ModelerIndex from 'bpmn_stuff/modeler_index.js';

console.log('Hello World from webpacker')

'use strict';

var $ = require('jquery');
var BpmnModeler = require('bpmn-js/lib/Modeler');

var container = $('#js-drop-zone');

var canvas = $('#js-canvas');

var modeler = new BpmnModeler({ container: canvas });

//var newDiagramXML = fs.readFileSync(__dirname + '/../resources/newDiagram.bpmn', 'utf-8');
var newDiagramXML = '<?xml version="1.0" encoding="UTF-8"?>\n'+
'<bpmn:definitions xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:bpmn="http://www.omg.org/spec/BPMN/20100524/MODEL" xmlns:bpmndi="http://www.omg.org/spec/BPMN/20100524/DI" xmlns:dc="http://www.omg.org/spec/DD/20100524/DC" targetNamespace="http://bpmn.io/schema/bpmn" id="Definitions_1">\n'+
'  <bpmn:process id="Process_1" isExecutable="false">\n'+
'    <bpmn:startEvent id="StartEvent_1"/>\n'+
'  </bpmn:process>\n' +
'  <bpmndi:BPMNDiagram id="BPMNDiagram_1">\n' +
'    <bpmndi:BPMNPlane id="BPMNPlane_1" bpmnElement="Process_1">\n' +
'      <bpmndi:BPMNShape id="_BPMNShape_StartEvent_2" bpmnElement="StartEvent_1">\n' +
'        <dc:Bounds height="36.0" width="36.0" x="173.0" y="102.0"/>\n' +
'      </bpmndi:BPMNShape>\n' +
'    </bpmndi:BPMNPlane>\n' +
'  </bpmndi:BPMNDiagram>' +
'</bpmn:definitions>';



function createNewDiagram() {
    console.log('entrou aqui!');
    openDiagram(newDiagramXML);
}
function openDiagram(xml) {
    modeler.importXML(xml, function(err) {

        if (err) {
            container
                .removeClass('with-diagram')
                .addClass('with-error');

            container.find('.error pre').text(err.message);

            console.error(err);
        } else {
            container
                .removeClass('with-error')
                .addClass('with-diagram');
        }


    });
}

function saveSVG(done) {
    modeler.saveSVG(done);
}

function saveDiagram(done) {

    modeler.saveXML({ format: true }, function(err, xml) {
        done(err, xml);
    });
}

function registerFileDrop(container, callback) {

    function handleFileSelect(e) {
        e.stopPropagation();
        e.preventDefault();

        var files = e.dataTransfer.files;

        var file = files[0];

        var reader = new FileReader();

        reader.onload = function(e) {

            var xml = e.target.result;

            callback(xml);
        };

        reader.readAsText(file);
    }

    function handleDragOver(e) {
        e.stopPropagation();
        e.preventDefault();

        e.dataTransfer.dropEffect = 'copy'; // Explicitly show this is a copy.
    }

    container.get(0).addEventListener('dragover', handleDragOver, false);
    container.get(0).addEventListener('drop', handleFileSelect, false);
}


////// file drag / drop ///////////////////////

// check file api availability
if (!window.FileList || !window.FileReader) {
    window.alert(
        'Looks like you use an older browser that does not support drag and drop. ' +
        'Try using Chrome, Firefox or the Internet Explorer > 10.');
} else {
    registerFileDrop(container, openDiagram);
}

// bootstrap diagram functions

//$(document).on('ready', function() {

    $('#js-create-diagram').click(function(e) {
        e.stopPropagation();
        e.preventDefault();

        createNewDiagram();
    });

    var downloadLink = $('#js-download-diagram');
    var downloadSvgLink = $('#js-download-svg');

    $('.buttons a').click(function(e) {
        if (!$(this).is('.active')) {
            e.preventDefault();
            e.stopPropagation();
        }
    });

    function setEncoded(link, name, data) {
        var encodedData = encodeURIComponent(data);

        if (data) {
            link.addClass('active').attr({
                'href': 'data:application/bpmn20-xml;charset=UTF-8,' + encodedData,
                'download': name
            });
        } else {
            link.removeClass('active');
        }
    }

    var _ = require('lodash');

    var exportArtifacts = _.debounce(function() {

        saveSVG(function(err, svg) {
            setEncoded(downloadSvgLink, 'diagram.svg', err ? null : svg);
        });

        saveDiagram(function(err, xml) {
            setEncoded(downloadLink, 'diagram.bpmn', err ? null : xml);
        });
    }, 500);

    modeler.on('commandStack.changed', exportArtifacts);
//});

