import std.stdio;
import std.algorithm;
import std.file;
import std.conv;
import std.string;
import std.array;

void main(string[] args)
{

	auto file = File(args[1]);

	auto words = file.byLineCopy.map!(a => a.split.map!(to!int).array).array;
	int[int] alphabet;
	int[ulong] lengths;

	foreach(line; words) {
		foreach(word; line) {
			if(word in alphabet)
 				alphabet[word]++;
			else
				alphabet[word] = 1;
		}
	}

	foreach(line; words) {
			if(line.length in lengths)
 				lengths[line.length]++;
			else
				lengths[line.length] = 1;
	}
	writeln(alphabet.length);
	writeln(words.length);
	writeln(words.map!(a => a.length).sum);
	writeln("caractere occurences");
	alphabet.byKeyValue().array.sort!((a,b) => a.key < b.key).each!(a => writeln(a.key, " ", a.value));
	writeln("length occurences");
	lengths.byKeyValue().array.sort!((a,b) => a.key < b.key).each!(a => writeln(a.key, " ", a.value));

	

   /* const wordCount = file.byLine()            // Read lines
                          .map!split           // Split into words
                          .map!(a => a.length) // Count words per line
                          .reduce!((a,b) => (a>b) ? a : b)
	                  ;              // Total word count(a => a.split.length);
	writeln(wordCount);
	file = File(args[1]);
    const wordsum = file.byLine()            // Read lines
                          .map!split           // Split into words
                          .map!(a => a.length) // Count words per line
                          .sum
	                  ;              // Total word count(a => a.split.length);
	file = File(args[1]);
    const lineCount = file.byLine()            // Read lines
                          .map!split           // Split into words
                          .map!(a => 1) // Count words per line
                          .sum
	                  ;              // Total word count(a => a.split.length);
	writeln(wordsum.to!double / lineCount.to!double);*/
}
