
package parser;

import com.jmatio.io.MatFileReader;
import com.jmatio.types.MLArray;
import com.jmatio.types.MLDouble;
import com.jmatio.types.MLStructure;
import java.io.IOException;

/**
 * @author janinko
 */
class FaceList {
	MatFileReader mfr;

	FaceList() throws IOException {
		mfr = new MatFileReader(Parser.dataPath + "facelist_brain.mat");
		System.out.println(mfr.getContent());
		
		System.out.println("#################");
		System.out.println(mfr);
		System.out.println("#################");
		System.out.println(mfr.getMLArray("facelist"));
		System.out.println("#################");
		//System.out.println(struct.getField("facelist", 0));
		System.out.println("#################");
		System.out.println(countFaces(1));
		System.out.println(getVertex(1, 1));
		System.out.println("#################");
		/* for(MLArray a : struct.getAllFields()){
		MLDouble list = (MLDouble) a;
		//System.out.println(Arrays.toString(list.getArray()));
		}*/
	}

	double[][] getArray(int part) {
		return ((MLDouble) mfr.getMLArray("facelist")).getArray();
	}

	int countFaces(int part) {
		return ((MLDouble) mfr.getMLArray("facelist")).getArray().length;
	}

	double[] getVertex(int part, int index) {
		return getArray(part)[index];
	}

}
