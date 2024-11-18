import moonchart.backend.FormatDetector;
import moonchart.backend.FormatData;
import moonchart.formats.BasicFormat;

import sys.io.File;
import haxe.Json;
import sys.FileSystem;

using StringTools;

typedef ChartFile = {
	var ?formatData:FormatData;
	var ?parser:DynamicFormat;
}

class Converter {
	static var from:ChartFile = {};
	static var to:ChartFile = {};

	static var oldChartFile:String;
	static var oldMetadataFile:String;

	static var newChartFile:String = 'converted-chart';
	static var newMetadataFile:String = 'converted-metadata';

	var songVersion:String = '';

	public static function convert(songName:String,  difficulty:String, oldChartFile:String, oldMetadataFile:String, parseFrom:String, convertTo:String) {
		FormatDetector.getList();

		if (!FileSystem.exists(oldChartFile)) {
			close('The chart file "$oldChartFile" doesn\'t exist.');
		}

		from.formatData = FormatDetector.getFormatData(parseFrom);
		if (from.formatData == null) {
			close('Format "$parseFrom" doesn\'t exist.');
		}
		
		if (from.formatData.hasMetaFile == TRUE) {
			if (!FileSystem.exists(oldMetadataFile)) {
				close('The metadata file "$oldMetadataFile" doesn\'t exist.');
			}
		} else oldMetadataFile = null;

		to.formatData = FormatDetector.getFormatData(convertTo);
		if (to.formatData == null) {
			close('Format "$convertTo" doesn\'t exist.');
		}

		// set the new file's extensions
		newChartFile += '.${to.formatData.extension}';
		newMetadataFile += '.${to.formatData.metaFileExtension}';

		var errorOccured:Bool = false;

		// finally start converting
		try {
			Sys.println('Converting...');

			from.parser = Type.createInstance(from.formatData.handler, []).fromFile(oldChartFile, oldMetadataFile, difficulty);
			to.parser = Type.createInstance(to.formatData.handler, []).fromFormat(from.parser, difficulty);

			// using reflect instead
			// because `parser`'s default type is `BasicFormat<{}, {}>`
			// and not `BasicJsonFormat<D, M>`

			// also setting the `formatting` var directly
			// because `beautify` is basically inlined
			// since it's both a getter and a setter inside of an abstract
			// which is why you get the error `Invalid field:beautify` if you try setting it with reflect
			if (to.formatData.extension == 'json') Reflect.setProperty(to.parser, 'formatting', "\t"); //to.parser.beautify = true;
			//Reflect.setProperty(to.parser, 'song', songName);

			final converted:FormatStringify = to.parser.stringify();

			switch(convertTo) {
				case "FNF_VSLICE":
					newChartFile = songName + '-' + 'chart';
					newMetadataFile = songName + '-' + 'metadata';
				default:
					newChartFile = songName + '-' + difficulty + '.' + to.formatData.extension;
			}

			// save the chart
			File.saveContent(newChartFile, converted.data);
			Sys.println('Chart saved! "$newChartFile"');

			// save the metadata if the format supports it
			if (to.formatData.hasMetaFile == TRUE || to.formatData.hasMetaFile == POSSIBLE) {
				File.saveContent(newMetadataFile, converted.meta);
				Sys.println('Metadata saved! "$newMetadataFile"');
			}

		} catch(e:haxe.Exception) {
			Sys.println('Error occured while processing chart:\n\n$e');
			errorOccured = true;
		}
	}

	static function close(?output:String, ?secondsToWait:Float = 5) {
		if (output != null) Sys.println(output);
		Sys.sleep(secondsToWait);
		Sys.exit(0);
	}
}