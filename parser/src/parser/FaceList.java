
package parser;

import com.jmatio.io.MatFileReader;
import com.jmatio.types.MLDouble;
import com.jmatio.types.MLStructure;
import java.io.IOException;

/**
 * @author janinko
 */
class FaceList {
	MLStructure struct;

	FaceList(String dataPath) throws IOException {
		MatFileReader mfr = new MatFileReader(dataPath + "facelist.mat");
		struct = (MLStructure) mfr.getMLArray("F");
		System.out.println("#################");
		System.out.println(struct);
		System.out.println("#################");
		System.out.println(struct.contentToString());
		System.out.println("#################");
		System.out.println(struct.getField("facelist", 0));
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
		return ((MLDouble) struct.getField("facelist", part)).getArray();
	}

	int countFaces(int part) {
		return ((MLDouble) struct.getField("facelist", part)).getArray().length;
	}

	double[] getVertex(int part, int index) {
		return getArray(part)[index];
	}

}
