# === Copy videos metafiles ===

# Usefull script to copy metadata from a file to other
# The function can be used to fix converted videos using handbreak that don't keep the metadata from the original
# original source: https://www.reddit.com/r/handbrake/comments/8bm1wg/retain_creation_date_metadata_on_converted_file/

# Required program to keep/edit exif data , GPS location etc:
# brew install exiftool

# Must be executed in the folder with the .avi and .mp4 files, both original and new mus have the same filename

function copyVideosMeta {
   for f in *.avi; do
      export originalfile=$(echo ${f} | sed 's/\.avi//g')

      echo
      echo $originalfile

      # copy metadata from mov file to mp4 file
      exiftool -TagsFromFile $originalfile.avi -all:all $originalfile.mp4 
      exiftool -TagsFromFile $originalfile.avi "-AllDates<DateTimeOriginal" "-FileCreateDate<DateTimeOriginal" "-FileModifyDate<DateTimeOriginal" $originalfile.mp4
      # force the copy of the created and modified at for videos
      # alternative 1
      # exiftool -d "%Y:%m:%d %H:%M:%S" -TagsFromFile $originalfile.avi "-QuickTime:CreateDate<FileModifyDate" "-QuickTime:CreationDate<FileModifyDate" "-FileCreateDate<FileModifyDate" "-FileModifyDate<FileModifyDate" -api QuickTimeUTC $originalfile.mp4
      # alternative 2
      # exiftool -TagsFromFile $originalfile.avi -GlobalTimeShift +3 "-QuickTime:CreateDate<FileModifyDate" -TagsFromFile $originalfile.avi -d "%Y:%m:%d %H:%M:%S-03:00" "-QuickTime:CreationDate<FileModifyDate" "-FileCreateDate<FileModifyDate" "-FileModifyDate<FileModifyDate" -overwrite_original $originalfile.mp4
      # alternative 3
      exiftool -TagsFromFile $originalfile.avi -d "%Y:%m:%d %H:%M:%S-03:00" "-QuickTime:CreateDate<FileModifyDate" "-QuickTime:CreationDate<FileModifyDate" "-FileCreateDate<FileModifyDate" "-FileModifyDate<FileModifyDate" -overwrite_original $originalfile.mp4
      # alternative 4
      exiftool -TagsFromFile $originalfile.avi "-QuickTime:CreationDate<FileModifyDate" "-FileCreateDate<FileModifyDate" "-FileModifyDate<FileModifyDate" -GlobalTimeShift +3 "-QuickTime:CreateDate<FileModifyDate" -overwrite_original $originalfile.mp4
      # copy creation date from mov file to mp4 file
      # touch -r $originalfile.avi $originalfile.mp4

      # optional (remove comment) remove original file and backup from exiftool
      # rm $originalfile.mov $originalfile.mp4_original
   done
}
