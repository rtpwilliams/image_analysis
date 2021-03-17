/*
 * Macro to perform Max Z Projection from Z stacks imaged with Keyence Microscope
 * Written by Robert TP Williams, Nishimura Lab
 * August 17th, 2020
 * Setup: Output folder is made manually, preferably in the parent directory 
 * 	that contains original images
 * 	NOTE: IMAGES MUST BE LOCATED ON A LOCAL DRIVE AND CANNOT BE PROCESSED FROM A NETWORK DRIVE
 */

#@ File (label = "Input directory", style = "directory") input
#@ File (label = "Output directory", style = "directory") output
#@ String (label = "File suffix", value = ".tif") suffix

// See also Process_Folder.py for a version of this code
// in the Python scripting language.

processFolder(input);

// function to scan folders/subfolders/files to find files with correct suffix
// 
function processFolder(input) {
	list = getFileList(input);
	list = Array.sort(list);
	for (i = 0; i < list.length; i++) {
		if(File.isDirectory(input + File.separator + list[i])){
			
			run("Image Sequence...", "open=[" + input + File.separator + list[i] + "] file=CH2 sort");
			run("Z Project...", "projection=[Max Intensity]");
			sub_str = substring(list[i], 0, parseInt(list[i].indexOf("/")) );
			//print("MAX_" + sub_str + suffix);
			save(output + File.separator + "MAX_" + sub_str + suffix);
			close("*");
		}
	}
}

// to save remove slash, add image suffix, close the files