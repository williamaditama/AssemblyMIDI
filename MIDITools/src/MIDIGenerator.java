import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;

public class MIDIGenerator {

    int[] convertChordArray(String[] chords) {
        int[] intArray = new int[chords.length];
        for (int i = 0; i < chords.length; i++) {
            String chord = chords[i];
            intArray[i] = convertChord(chord);
        }
        return intArray;
    }

    int convertChord(String chord) {
        Scanner sc = null;
        try {
            sc = new Scanner(new File("res\\valuePairs"));
        } catch (FileNotFoundException e) {
            e.printStackTrace();
            return -1;
        }

        while (sc.hasNextLine()) {
            String[] line = sc.nextLine().split(",");
            if (line[0].equals(chord))
                return Integer.parseInt(line[1]);
        }
        return -1;
    }

    public static void main(String[] args) {
        Scanner input = new Scanner(System.in);
        MIDIGenerator generator = new MIDIGenerator();
        System.out.print("Enter Notes: ");
        String[] userIn = input.nextLine().split(",");

        int[] intArray = generator.convertChordArray(userIn);

        //Octave Offset
        System.out.print("Enter octave offset");
        int octaveOffset = Integer.parseInt(input.nextLine());
        for(int i = 0; i<intArray.length; i++){
            intArray[i] = intArray[i] + octaveOffset*12;
        }

        String midiOut = "" + intArray[0];
        for (int i = 1; i < intArray.length; i++) {
            midiOut += "," + intArray[i];
        }


        System.out.print("Enter duration: ");
        String duration = input.nextLine();
        String durOut = duration;
        for(int i = 0; i<intArray.length; i++){
            durOut+="," + duration;
        }

        System.out.println("Length: " + intArray.length);
        System.out.println(midiOut);
        System.out.println(durOut);
    }
}
