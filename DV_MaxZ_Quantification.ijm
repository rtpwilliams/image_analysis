//wd = "/Users/rtpw/Documents/01_RESEARCH/05_NOTEBOOK4/RWP032_ELT-2_Target_Regulation/210416_GLH1_Rep2/ELT7rnai";
#@ File (label = "Input directory", style = "directory") input_dir

print("Begin Deltavision Batch Max Z Quantification");

list = getFileList(input_dir);

for(j = 0; j< list.length; j++){
	subdir = list[j];
	if(File.isDirectory(input_dir + File.separator + subdir)){
		print("Analyzing directory..." + subdir);
		fileList = getFileList(input_dir + File.separator + subdir);
			for (i = 0; i < fileList.length; i+=3){
				print(i);
				print(i+3);
				print(fileList[i]);
				fileName = File.getName(fileList[i]);
		//if(endsWith(fileName, "Worm01_01_R3D.dv")){ //|| endsWith(fileName, "Worm_09_R3D.dv")){
		//	continue;
		//};			// open relevant files
						chop = parseInt(fileName.indexOf("Worm"))+7;
						sub_str = substring(fileName, 0, chop);
						print(sub_str);
						filePath = input_dir + File.separator + subdir;
						run("Image Sequence...", "open=[filePath] file=" + sub_str+" sort");

						print("outline intestine ROI");
						// go to DAPI channel
						setSlice(3);
						// make intestine ROI
						//setTool("polygon");
						waitForUser;
						Roi.setName("intestine");
						roiManager("Add");
						
						print("4 background ROI");
						// make background ROI loop 4 times
						for (x = 0; x < 4; x++) {
							makeRectangle(608, 367, 50, 50);
							waitForUser;
							Roi.setName("background");
							roiManager("Add");
							};

						print("measuring ROI");
						// measure fluorescence for each channel
						for (y = 1; y <= nSlices; y++) {
    					setSlice(y);
    					roiManager("multi-measure append");
						};
						roiManager("delete");
						run("Close All");	
						};
					};
				}


print("Batch Max Z Quantification Completed");
