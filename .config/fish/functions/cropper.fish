# crop images for wallpaper
function cropper
    set x_res (swaymsg -t get_outputs | jq '.[0].current_mode.width')
    set y_res (swaymsg -t get_outputs | jq '.[0].current_mode.height')
    set x_img (magick identify -format '%w' $argv[1])
    set y_img (magick identify -format '%h' $argv[1])
    if test $x_img -gt $x_res && test $y_img -gt $y_res
        magick convert -resize $x_res"x"$y_res"^" $argv[1] $argv[2] 
    end
end
