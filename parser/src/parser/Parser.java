package parser;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

/**
 *
 * @author janinko
 */
public class Parser {
	public static final String dataPath = "/home/janinko/Programování/functional-connectivity/data/";
	public static final String partsPath = dataPath + "parts/";

	/**
	 * @param args the command line arguments
	 */
	public static void main(String[] args) throws IOException {
		FaceList fl = new FaceList();
		VertexList vl = new VertexList();

		File parts = new File(partsPath);
		parts.mkdir();

		for(int i=0; i<90; i++){
			FileWriter w = new FileWriter(partsPath + "part_" + i + ".obj");
			BufferedWriter bw = new BufferedWriter(w);
			generateOBJ(bw, "Brain part " + i, vl.getArray(i), fl.getArray(i));
			bw.flush();
			bw.close();
		}

	}

	private static void generateOBJ(BufferedWriter out, String name, double[][] vertices, double[][] faces) throws IOException {
		System.out.println("Generating part of " + vertices.length + " vertices and " + faces.length + " faces");
		out.write("o " + name);
		out.newLine();
		for(int v=0; v<vertices.length; v++){
			double x = vertices[v][0];
			double y = vertices[v][1];
			double z = vertices[v][2];
			out.write("v " + x + " " + y + " " + z);
			out.newLine();
		}
		out.newLine();
		for(int f=0; f<faces.length; f++){
			int v1 = (int) faces[f][0];
			int v2 = (int) faces[f][1];
			int v3 = (int) faces[f][2];
			out.write("f " + v1 + " " + v2 + " " + v3);
			out.newLine();
		}
		out.newLine();
	}


}





