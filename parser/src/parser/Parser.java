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
	public static final String dataPath = "data/";
	public static final String partsPath = dataPath + "parts/";

	public static int vb;
	public static double cx;
	public static double cy;
	public static double cz;
	/**
	 * @param args the command line arguments
	 */
	public static void main(String[] args) throws IOException {
		FaceList fl = new FaceList();
		VertexList vl = new VertexList();

		File parts = new File(partsPath);
		parts.mkdir();

		double minx = 99999;
		double miny = 99999;
		double minz = 99999;
		double maxx = -99999;
		double maxy = -99999;
		double maxz = -99999;


		for(int i=0; i<90; i++){
			for(double[] v : vl.getArray(i)){
				if(v[0] < minx) minx = v[0];
				if(v[1] < miny) miny = v[1];
				if(v[2] < minz) minz = v[2];
				if(v[0] > maxx) maxx = v[0];
				if(v[1] > maxy) maxy = v[1];
				if(v[2] > maxz) maxz = v[2];
			}
		}
		cx = (minx + maxx) / 2;
		cy = (miny + maxy) / 2;
		cz = (minz + maxz) / 2;
		System.out.println("min: " + minx + " " + miny + " " + minz);
		System.out.println("max: " + maxx + " " + maxy + " " + maxz);
		System.out.println("ctr: " + cx + " " + cy + " " + cz);

		genAll(vl, fl);

	}
	
	private static void genOne(VertexList vl, FaceList fl) throws IOException{
		FileWriter w = new FileWriter(partsPath + "parts.obj");
		BufferedWriter bw = new BufferedWriter(w);
		vb = 0;
		for(int i=0; i<90; i++){
			generateOBJ(bw, "Brain part " + i, vl.getArray(i), fl.getArray(i));
			vb += vl.getArray(i).length;
		}
		bw.flush();
		bw.close();
	}
	
	private static void genAll(VertexList vl, FaceList fl) throws IOException{
		vb = 0;
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
			double x = vertices[v][0] - cx;
			double y = vertices[v][1] - cy;
			double z = vertices[v][2] - cz;
			out.write("v " + x + " " + y + " " + z);
			out.newLine();
		}
		out.newLine();
		for(int f=0; f<faces.length; f++){
			int v1 = (int) faces[f][0] + vb;
			int v2 = (int) faces[f][1] + vb;
			int v3 = (int) faces[f][2] + vb;
			out.write("f " + v1 + " " + v2 + " " + v3);
			out.newLine();
		}
		out.newLine();
	}


	private static void generateOBJScaled(BufferedWriter out, String name, double[][] vertices, double[][] faces, double scale) throws IOException {
		System.out.println("Generating part of " + vertices.length + " vertices and " + faces.length + " faces");
		out.write("o " + name);
		out.newLine();


		double minx = 99999;
		double miny = 99999;
		double minz = 99999;
		double maxx = -99999;
		double maxy = -99999;
		double maxz = -99999;
		for(double[] v : vertices){
			if(v[0] < minx) minx = v[0];
			if(v[1] < miny) miny = v[1];
			if(v[2] < minz) minz = v[2];
			if(v[0] > maxx) maxx = v[0];
			if(v[1] > maxy) maxy = v[1];
			if(v[2] > maxz) maxz = v[2];
		}
		double lcx = (minx + maxx) / 2;
		double lcy = (miny + maxy) / 2;
		double lcz = (minz + maxz) / 2;


		for(int v=0; v<vertices.length; v++){
			double x = (vertices[v][0] - lcx)*scale + lcx - cx;
			double y = (vertices[v][1] - lcy)*scale + lcy - cy;
			double z = (vertices[v][2] - lcz)*scale + lcz - cz;
			out.write("v " + x + " " + y + " " + z);
			out.newLine();
		}
		out.newLine();
		for(int f=0; f<faces.length; f++){
			int v1 = (int) faces[f][0] + vb;
			int v2 = (int) faces[f][1] + vb;
			int v3 = (int) faces[f][2] + vb;
			out.write("f " + v1 + " " + v2 + " " + v3);
			out.newLine();
		}
		out.newLine();
	}

}





