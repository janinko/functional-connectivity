
package parser;

import com.jmatio.io.MatFileReader;
import com.jmatio.types.MLArray;
import com.jmatio.types.MLDouble;
import com.jmatio.types.MLStructure;
import java.io.IOException;

/**
 * @author janinko
 */
class VertexList {
	MLStructure struct;

	VertexList() throws IOException {
		MatFileReader mfr = new MatFileReader(Parser.dataPath + "vertexlist.mat");
		struct = (MLStructure) mfr.getMLArray("V");
		System.out.println("#################");
		System.out.println(struct);
		System.out.println("#################");
		System.out.println(struct.contentToString());
		System.out.println("#################");
		System.out.println(struct.getField("vertexlist", 0));
		System.out.println("#################");
		System.out.println(countVertices(1));
		System.out.println(getVertex(1, 1));
		System.out.println(getVertex(1, 6940));
		System.out.println(getVertex(1, 6795));
		System.out.println(getVertex(1, 6940));
		System.out.println("#################");
		for (MLArray a : struct.getAllFields()) {
			MLDouble list = (MLDouble) a;
			//System.out.println(Arrays.toString(list.getArray()));
		}
	}

	double[][] getArray(int part) {
		return ((MLDouble) struct.getField("vertexlist", part)).getArray();
	}

	int countVertices(int part) {
		return ((MLDouble) struct.getField("vertexlist", part)).getArray().length;
	}

	double[] getVertex(int part, int index) {
		return getArray(part)[index];
	}

}
