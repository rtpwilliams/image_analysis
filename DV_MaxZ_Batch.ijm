// Deltavision Format Changer 1.0
// David Stirling, 2019
// Runs through a directory
// Generates a maximum projection
// Saves to a new folder
//
run("Close All");
//input_dir = getDirectory("Select Input Folder");
//save_dir = getDirectory("Select Output Folder");
//input_dir = "/Volumes/WormHole/robert/210506_ELT2_Targets_ETS4_Rep1/01_L4440rnai/"
//save_dir = "/Users/rtpw/Documents/01_RESEARCH/05_NOTEBOOK4/RWP032_ELT-2_Target_Regulation/210506_ETS4gfp_Rep1/Max_Z/L4440/"
#@ File (label = "Input directory", style = "directory") input_dir
#@ File (label = "Output directory", style = "directory") save_dir

print("Begin Deltavision Batch Max Z Quantification");

list = getFileList(input_dir);

for(j = 0; j< list.length; j++){
	subdir = list[j];
	if(File.isDirectory(input_dir + File.separator + subdir)){
		print("Analyzing directory..." + subdir);
		fileList = getFileList(input_dir + File.separator + subdir);
			for (i = 0; i < fileList.length; i++){
				fileName = File.getName(fileList[i]);
					if(endsWith(fileName, "R3D.dv")){
					//if(endsWith(fileName, "R3D.dv") && startsWith(fileName, "CEBP1gfp_ELT7rnai_Rep5_Worm01_01_R3D") != true){
		//if(endsWith(fileName, "Worm01_01_R3D.dv")){ //|| endsWith(fileName, "Worm_09_R3D.dv")){
		//	continue;
		//};
						filePath = input_dir + File.separator + subdir + fileName;
						sub_str = substring(fileName, 0, parseInt(fileName.indexOf("_R3D.dv")));
						print("opened file: " + sub_str);
						run("Bio-Formats Windowless Importer", "open=[filePath]");
						run("Z Project...", "projection=[Max Intensity]");
						run("Split Channels");
						print("saving as...");
						print(save_dir + File.separator + subdir + "MAX_" + sub_str + "...");
						saveAs("Tiff", save_dir + File.separator + subdir + "MAX_" + sub_str + "_C3");
						close();
						saveAs("Tiff", save_dir + File.separator + subdir + "MAX_" + sub_str + "_C2");
						close();
						saveAs("Tiff", save_dir + File.separator + subdir + "MAX_" + sub_str + "_C1");
						run("Close All");	
						};
					};
				}
			}

print("Batch Max Z Completed");
