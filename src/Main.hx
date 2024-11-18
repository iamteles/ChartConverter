import Converter;

class Main {
    static var songsToConvert:Array<Array<String>> = [
        ["dadbattle", "erect", "dadbattle-chart-erect.json", "dadbattle-metadata-erect.json", "FNF_VSLICE", "FNF_DOIDO", "dadbattle/"],
        ["bopeebo", "erect", "bopeebo-chart-erect.json", "bopeebo-metadata-erect.json", "FNF_VSLICE", "FNF_DOIDO", "bopeebo/"],
        ["fresh", "erect", "fresh-chart-erect.json", "fresh-metadata-erect.json", "FNF_VSLICE", "FNF_DOIDO", "fresh/"],
        ["senpai", "erect", "senpai-chart-erect.json", "senpai-metadata-erect.json", "FNF_VSLICE", "FNF_DOIDO", "senpai/"],
        ["roses", "erect", "roses-chart-erect.json", "roses-metadata-erect.json", "FNF_VSLICE", "FNF_DOIDO", "roses/"],
        ["thorns", "erect", "thorns-chart-erect.json", "thorns-metadata-erect.json", "FNF_VSLICE", "FNF_DOIDO", "thorns/"],

        ["dadbattle", "nightmare", "dadbattle-chart-erect.json", "dadbattle-metadata-erect.json", "FNF_VSLICE", "FNF_DOIDO", "dadbattle/"],
        ["bopeebo", "nightmare", "bopeebo-chart-erect.json", "bopeebo-metadata-erect.json", "FNF_VSLICE", "FNF_DOIDO", "bopeebo/"],
        ["fresh", "nightmare", "fresh-chart-erect.json", "fresh-metadata-erect.json", "FNF_VSLICE", "FNF_DOIDO", "fresh/"],
        ["senpai", "nightmare", "senpai-chart-erect.json", "senpai-metadata-erect.json", "FNF_VSLICE", "FNF_DOIDO", "senpai/"],
        ["roses", "nightmare", "roses-chart-erect.json", "roses-metadata-erect.json", "FNF_VSLICE", "FNF_DOIDO", "roses/"],
        ["thorns", "nightmare", "thorns-chart-erect.json", "thorns-metadata-erect.json", "FNF_VSLICE", "FNF_DOIDO", "thorns/"],
    ];

    public static function main() {
        for(song in songsToConvert) {
            Sys.println('Converting ${song[0]}-${song[1]} from ${song[4]} to ${song[5]}');
            Converter.convert(song[0], song[1], song[6] + song[2], song[6] + song[3], song[4], song[5]);
        }
    }
}