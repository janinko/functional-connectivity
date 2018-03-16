
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
	MatFileReader mfr;

	VertexList() throws IOException {
		mfr = new MatFileReader(Parser.dataPath + "vertexlist_brain.mat");
		System.out.println("#################");
		System.out.println(mfr);
		System.out.println("#################");
		System.out.println(mfr.getContent());
		System.out.println("#################");
		System.out.println(mfr.getMLArray("vertexlist"));
		System.out.println("#################");
		System.out.println(countVertices(1));
		System.out.println(getVertex(1, 1));
		System.out.println(getVertex(1, 6940));
		System.out.println(getVertex(1, 6795));
		System.out.println(getVertex(1, 6940));
		System.out.println("#################");
		
	}

	double[][] getArray(int part) {
		return ((MLDouble) mfr.getMLArray("vertexlist")).getArray();
	}

	int countVertices(int part) {
		return ((MLDouble) mfr.getMLArray("vertexlist")).getArray().length;
	}

	double[] getVertex(int part, int index) {
		return getArray(part)[index];
	}

}
