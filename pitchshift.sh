#!/bin/bash

set -e

function get_param_from_pitch_shift() {
    # http://www.microsoftbob.com/post/Adjusting-Pitch-for-MP3-Files-with-FFmpeg
    RAISE_PITCH_01=asetrate=r=46722.3224612449211671764955071340,atempo=0.94387431268169349664191315666753
    RAISE_PITCH_02=asetrate=r=49500.5763304433484812188074908520,atempo=0.89089871814033930474022620559051
    RAISE_PITCH_03=asetrate=r=52444.0337716199990422417487017170,atempo=0.84089641525371454303112547623321
    RAISE_PITCH_04=asetrate=r=55562.5183003639065662339877809700,atempo=0.79370052598409973737585281963615
    RAISE_PITCH_05=asetrate=r=58866.4375688985154890396859602340,atempo=0.74915353843834074939964036601490
    RAISE_PITCH_06=asetrate=r=62366.8181006534916521544727376480,atempo=0.70710678118654752440084436210485
    RAISE_PITCH_07=asetrate=r=66075.3420902616540970482802825140,atempo=0.66741992708501718241541594059223
    RAISE_PITCH_08=asetrate=r=70004.3863917975968365502186919090,atempo=0.62996052494743658238360530363911
    RAISE_PITCH_09=asetrate=r=74167.0638253776226953452670037700,atempo=0.59460355750136053335874998528024
    RAISE_PITCH_10=asetrate=r=78577.2669399779266780879513330830,atempo=0.56123102415468649071676652483959
    RAISE_PITCH_11=asetrate=r=83249.7143785253664038167404180770,atempo=0.52973154717964763228091264747317
    RAISE_PITCH_12=asetrate=r=88200.0000000000000000000000000000,atempo=0.50000000000000000000000000000000
    
    LOWER_PITCH_01=asetrate=r=41624.8571892626832019083702090380,atempo=1.05946309435929526456182529494630
    LOWER_PITCH_02=asetrate=r=39288.6334699889633390439756665420,atempo=1.12246204830937298143353304967920
    LOWER_PITCH_03=asetrate=r=37083.5319126888113476726335018850,atempo=1.18920711500272106671749997056050
    LOWER_PITCH_04=asetrate=r=35002.1931958987984182751093459540,atempo=1.25992104989487316476721060727820
    LOWER_PITCH_05=asetrate=r=33037.6710451308270485241401412570,atempo=1.33483985417003436483083188118450
    LOWER_PITCH_06=asetrate=r=31183.4090503267458260772363688240,atempo=1.41421356237309504880168872420970
    LOWER_PITCH_07=asetrate=r=29433.2187844492577445198429801170,atempo=1.49830707687668149879928073202980
    LOWER_PITCH_08=asetrate=r=27781.2591501819532831169938904850,atempo=1.58740105196819947475170563927230
    LOWER_PITCH_09=asetrate=r=26222.0168858099995211208743508580,atempo=1.68179283050742908606225095246640
    LOWER_PITCH_10=asetrate=r=24750.2881652216742406094037454260,atempo=1.78179743628067860948045241118100
    LOWER_PITCH_11=asetrate=r=23361.1612306224605835882477535670,atempo=1.88774862536338699328382631333510
    LOWER_PITCH_12=asetrate=r=22050.0000000000000000000000000000,atempo=2.00000000000000000000000000000000

    shift_amt="$1"

    ret=''
    case $shift_amt in
    +1)
        ret=${RAISE_PITCH_01}
        ;;
    +2)
        ret=${RAISE_PITCH_02}
        ;;
    +3)
        ret=${RAISE_PITCH_03}
        ;;
    +4)
        ret=${RAISE_PITCH_04}
        ;;
    +5)
        ret=${RAISE_PITCH_05}
        ;;
    +6)
        ret=${RAISE_PITCH_06}
        ;;
    -1)
        ret=${LOWER_PITCH_01}
        ;;
    -2)
        ret=${LOWER_PITCH_02}
        ;;
    -3)
        ret=${LOWER_PITCH_03}
        ;;
    -4)
        ret=${LOWER_PITCH_04}
        ;;
    -5)
        ret=${LOWER_PITCH_05}
        ;;
    -6)
        ret=${LOWER_PITCH_06}
        ;;
    *)
        echo "Currently not supported!"
        exit 1
    esac

    echo "$ret"
}

function display_usage() {
    echo -e "\nUsage: ${0} <input_audio_file> <pitch_shift_amount>"
    echo -e "\tExample1: ${0} input.mp3 +2"
    echo -e "\tExample2: ${0} input.mp3 -3"
}

function main() {
    if [ $# -ne 2 ]
    then
        display_usage
        exit 1
    fi
    
    input_file=${1}
    pitch_shift=${2}
    
    ls "$input_file"
    
    filename=$(basename -- "$input_file")
    extension="${filename##*.}"
    filename="${filename%.*}"
    outfile="${filename}.${pitch_shift}.${extension}"
    
    param=$(get_param_from_pitch_shift "$pitch_shift")
    
    #TMP_FILE=tmp.4a
    #ffmpeg -i ${input_file} -ar 44100 ${TMP_FILE}
    ffmpeg -i "${input_file}" -af "${param}" "${outfile}"
    #rm -f${TMP_FILE} 
}

main "$@" 
