# xkcd-936: random passphrases
[xkcd 936](https://www.xkcd.com/936/) famously pointed out that *passwords* (relatively short concatenations of characters) very often fall into one of three categories:

- easy for a human to remember and very easy for a machine to guess;
- hard for a human to remember but still rather easy for a machine to guess;
- very hard for a human to remember and hard for a machine to guess.

On the other hand, it is quite easy to make *passphrases* (relatively short concatenations of words) which are both easy for a human to remember and hard for a machine to guess.

The reason for this is relatively simple: humans are bad at remembering sequences of *characters* that they know, where those characters don't make up a word or anything like one.  So in order to make passwords easy to remember we need to make them significantly non-random, for instance by taking some word and altering it in various ways.  But this hugely reduces the search space when trying to guess the password and makes it far easier to guess by brute force.

On the other hand humans are rather good at remembering sequences of *words* they know (or which look like words from a language they know), even when those words do not make up a sentence or part of one.  This means that passphrases made up of *random* sequences of words from a language a human knows are relatively easy for them to remember, while being very hard to guess by brute force.

It is easy to see why this is true: while [it's not known how long humans have used natural language](https://en.wikipedia.org/wiki/Origin_of_language) it is clear that we have used it for tens or hundreds of thousands of years, and that we have evolved to use it: the ability to use natural language is hard-wired into us.  On the other hand [*written language*](https://en.wikipedia.org/wiki/History_of_writing) goes back much less far: only a few thousand years. Written language is also *learned*: we are not hard-wired to learn to read and write.  In other words we have hard-wired mechanisms that let us learn sequences of words (in my experience this works by turning them into some kind of strange image of some event or object, even though they have no grammar at all), but we need to learn sequences of *letters* 'by hand'.  Especially in the case when those sequences of letters do not make up any kind of recognisable word or word-like object they are extremely hard to learn.  It is much, much harder to remember `5'0:xpM"XD` than it is for us to remember `palpitatingly everblooming thyrocele monkery`, yet the former (10 random characters from an alphabet of 94, giving a search space of 5.4 &#215; 10<sup>19</sup>) is much easier to guess by brute force than the latter (four random words from a dictionary of 235,886 giving a search space of 3.1 &#215; 10<sup>21</sup>: 57 times larger).

As the comic points out:

> through 20 years of effort, we've successfully trained everyone to use passwords that are hard for humans to remember, but easy for computers to guess.

We've done this because we've insisted on using paswords, and have included increasingly complicated rules to try and make them more random, while not actually insisting that they are random.  Thus humans, since they need to remember the passwords, resort to tricks which fool the rules, while leaving the passwords in some way memorable, which almost always means that they are easy to guess by brute force, which computers are good at.  The reason for all this is that, once upon a time, computers had tiny memories and programming languages made it hard to work with non-fixed-size data, so short passwords were far easier to work with.  Computers now have vast memories, but because we still live in the past we act as if they don't, and we also still insist on using programming languages designed for rudimentary machines for the same reason, which we regard as being more important than security.

In the cases where we have insisted on passwords which are genuinely random then they become extremely hard for humans to remember.  In this case people either simply write them down, or resort to some kind of password-manager, which *itself* is usually controlled by a password, which this time will give access to *all* the passwords its owner knows, and may also have vulnerabilities of various kinds.

In this repo there are two tools:

- `random-passphrase` will generate a random sequence of words from one or more dictionaries;
- `random-password` will generate a random sequence of characters from one or more alphabets.

Both of them attempt to use true randomness provided by the platform on which they run, and both have a configuration mechanism which allows them to satisfy various requirements on passwords, say (even though these options typically reduce the search space and make passwords easier to brute-force).

`random-password` will generate passwords which are hard to remember and hard to guess.  `random-passphrase` will generate passphrases which are easy to remember and hard to guess.  With reasonable assumptions on the size of the wordlist the default settings are about equally hard to guess.

I have used `random-passphrase` for a long time to create passphrases which are easy to remember while being hard to brute-force, in an environment which required me to change my passphrase/password every month or so but, fortunately, allowed passphrases.

## Guessing random passwords and passphrases
### The size of the search space
If we consider only *random* passwords or passphrases then we can think of them as sequences of *symbols* drawn at random from some *alphabet*:

- for passwords the symbols are characters and the alphabet is the set of allowed characters;
- for passphrases the symbols are words and the alphabet is the dictionary they are taken from.

For a sequence of *n* randomly chosen symbols from an alphabet of size *m* then the number of possible passwords or passphrase of a given length is given by *m<sup>n</sup>*: this is the size of the search space which must be explored to guess them.  This is only true if they are truly random: there must be no correlation between successive symbols at all.

It's easy to see, then, how large this space is for various options.  `random-password` uses, by default, an alphabet of 94 symbols (by default it picks its passwords from elements of 26 uppercase letters, 26 lowercase letters, 10 digits and 32 punctuation characters), and generates passwords of 10 symbols.  This means there are 94<sup>10</sup> possible passwords, which is approximately 5.4 &#215; 10<sup>19</sup>.  `random-passphrase`, by default, picks its symbols, from an alphabet (`/usr/share/dict/words`) which contains, on my machine, 235,886 symbols (words) and generates passphrases which are 4 words long.  This means there are 235,866<sup>4</sup> possible passphrases, which is about 3.1 &#215; 10<sup>21</sup>.  On another machine the dictionary is much smaller (this is something to be careful about, and you can get the tool to report the dictionary size): 101,825 words.  Still there are about 1.1 &#215; 10<sup>20</sup> possible passphrases: about equivalent to a 10 character random password.

### Entropy
It's nice to have a quantity which is *extensive*: some quantity *E* for which, if I have two things with *E<sub>1</sub>* and *E<sub>2</sub>* then the combined value of *E* is just *E<sub>1</sub> + E<sub>2</sub>*.  We can get this from the search space size by taking [logs](https://en.wikipedia.org/wiki/Logarithm): since log(a &#215; b) = log(a) + log(b).  And because we're working with computers we take logs base 2, which gives us a number which is the size of the search space in bits.  This number is known as the *entropy* of the passwords or passphrases, and each increase in the entropy by 1 means the search space is twice as large.  Assuming 10 character passwords from an alphabet of 94 characters the entropy is about 65 bits, while for 4 word passphrases from a dictionary of 255,866 words the entropy is about 71 bits.  For 4 word passphrases from a dictionary of 101,825 words the entropy is about 67 bits (in fact the password entropy is about 65.5 and the lower passphrase entropy is about 66.5: there's only a bit between them).

And it really is easier to remember `pronoun risks reputes fornication's` than `"dl!o(1p&P`: try it! (Which pronoun exactly is it that is risking reputes fornication's, who is repute & is this some kind of political correctness thing?  And why is there a greengrocers' apostrophe and not one where there should be?  Perhaps it's a badly subedited newspaper headline?)

## The tools
`random-passphrase` generates random passphrases, `random-password` generates random passwords.  Both share a common heritage but they are different code.  Both are written in [Python](https://www.python.org/) (see below for notes on Python versions), and use machine randomness (specifically [`random.SystemRandom`](https://docs.python.org/3.7/library/random.html#random.SystemRandom)) to generate randomness: see below for notes & caveats on this.

Both of them simply print the resulting password or passphrase on standard output.  Neither stores any information about what they have generated nor need to keep any state about what they have done.

The documentation below is not really complete but it should be enough to get on with.

### `random-passphrase`
This snarfs words from wordlists / dictionaries, which can be specified, with the default being one or both of `/usr/share/dict/wotds` and `/usr/dict/words`.  To use it run it as

```
random-passphrase [options] [length]
```

where `length` is the length of the passphrase, which is 4 by default.  The possible options are below.

- `-h` / `--help`: print a help message including all the options.
- `-m` / `--man`: use `pydoc` to format the documentation in the program.  This may not work if `pydoc` is not installed or if something else goes wrong.
- `-c <config>` / `--config <config>`: read a JSON configuration file (see below).
- `-d` / `--dump`: dump the current effective configuration in JSON.  Does not generate a passphrase.
- `-s` / `--sequence`: use a special listy configuration to generate concatenated passphrases.  Don't use this unless you know what it does!
- `-v` / `--verbose`: be more verbose, and in particular print the dictionary size.

The [JSON](https://json.org/) configuration looks like this (this is the default built-in one):

```
{
 "sources": {
  "words": [
   "/usr/share/dict/words",
   "/usr/dict/words"
  ]
 },
 "requirements": {
  "words": 1
 },
 "uniqueness": {
  "words": true
 },
 "likelihoods": {
  "words": 1
 },
 "length": 4,
 "maxchars": null
}
```

- `sources` specifies one or more named sources of words, each of which consists of one or more files, which are all used if they exist, and at least one of which must exist.  The source files should contain words separated by whitespace: other than removing whitespace no further processing is done on the words (so if `Banana`, `banana` and `b-anana` are in the sources these are all different words).
- `requirements` specifies requirements on sources: a requirement says that at least that many words from the given source must be used.  It's possible to specify requirements which can't be met and this should be detected.
- `uniqueness` tells it whether to remove duplicates from a source (you almost certainly want to do this, especially when a source may involve multiple files which may or may not overlap).
- `likelihoods` tells you how likely words from each source should be.  They don't have to add to 1 as the probabilities are normalised before use.  For maximum randomness make them all equally likely.
- `length` is the length of the passphrase, in words.
- `maxchars` is how long the passphrase is allowed to be in *characters*, including a space between each word.  This allows you to deal with systems which have maximum lengths for passphrases, but it makes them less random.  The program works by successively generating passphrases and checking their lengths: if `maxlength` is too short then it can either take a very long time or fail to terminate.

In use:

```
$ random-passphrase 3
germarium Grallae whosomever
$ random-passphrase 8
subordinating rollerer resink centralism Opisthoparia carcinomatosis improgressiveness wheelwright
```

The words you get are a random selection from what is in the sources.  There may therefore be repeats although for large sources and relatively short passphrases this is unlikely.

### `random-password`
This works in a similar way to `random-passphrase` except that it picks passwords from alphabets you give it.  To use it run it as

```
random-password [options] [length]
```

Where `length` is the length of the password, which is 10 by default.  The possible options are below.

- `-h` / `--help`: print a help message including all the options.
-  `-m` / `--man`: use `pydoc` to format the documentation in the program.  This may not work if `pydoc` is not installed or if something else goes wrong.
- `-c <config>` / `--config <config>`: read a JSON configuration file (see below).
- `-d` / `--dump`: dump the current effective configuration in JSON.  Does not generate a passphrase.
- `-s` / `--sequence`: use a special listy configuration to generate concatenated words.  Don't use this unless you know what it does!
- `-v` / `--verbose`: be more verbose (currently does nothing).

The JSON configuration file looks like this (this is the default one):

```
{
 "classes": {
  "characters": "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~"
 },
 "requirements": {
  "characters": 1
 },
 "likelihoods": {
  "characters": 1
 },
 "length": 10
}
```

- `classes` specifies one or more named character classes, each of which specifies a string which is the possible characters in that class.
- `requirements` specifies the requirements on the classes: at least as many characters from each class must occur as specified.  It's possible to specify requirements which can't be met and this should be detected.
- `likelihoods` tells you how likely characters from each class should be.  They don't have to add to 1 as the probabilities are normalised before use.  For maximum randomness make them all equally likely.
- `length` is the length of the password, in characters.

In use:

```
$ random-password
Da|_@c(,!L
$ random-password 4
iheu
$ random-password 4
nTd/
```

## Dealing with password & passphrase requirements
Many systems have requirements on passwords: they must contain a digit, a punctuation character and some glue for instance.  You can meet these by specifying configuration files.  For `random-password` these are easy, for instance:

```
{
 "classes": {
  "digits": "0123456789",
  "uppercase": "ABCDEFGHIJKLMNOPQRSTUVWXYZ",
  "lowercase": "abcdefghijklmnopqrstuvwxyz",
  "punctuation": "!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~"
 },
 "requirements": {
  "digits": 1,
  "uppercase": 1,
  "lowercase": 1,
  "punctuation": 1
 },
 "likelihoods": {
  "digits": 1,
  "uppercase": 2,
  "lowercase": 3,
  "punctuation": 1
 },
 "length": 10
}
```

This used to be the default configuration in fact.  Note that is is *less* random than the default: these requirements are silly for random password generators, although they may make sense for humans, to avoid people just using words.

You can do similar things for `random-passphrase` although you now need to specify *files* containing words (which may be single-character words).  Alternatively I often simply add some requirement-meeting things to the start of a passphrase.  So if it generates `excretitious Malacanthidae meteorographic palaeoglaciology` I turn it into `Excretitious Malacanthidae meteorographic palaeoglaciology 12!` which: starts with a capital (so meeting any mixed-case requirement); has some digits (this is the 12th passphrase I've used wherever I'm working, easy to remember); ends with punctuation.

It is quite common to have to limit the character length of passphrases and for this you typically do need a configuration file: the obvious trick is to dump out the default one with `-d` and modify it appropriately.

The sequential mode of the tools also can help with this sort of problem: it's not yet documented here however.

---

## Installation notes
Both tools are currently maintained in Python 2.7 and then converted to Python 3 for installation: in due course I will switch to maintaining them in Python 3, when all machines I use come with Python 3 by default.  The programs therefore live in the `python-2.7` directory and the `Makefile` there will install them, by default in `~/bin` (see below).  In `python-3` there is a `Makefile` which will convert the Python 2.7 ones and install the converted copies.  In this directory there is a `Makefile` which, by default, installs the Python 2.7 versions.

### Installation control
The following `make` variables control various things.

- `PYTHONVER` (top-level `Makefile` only): control which version to install.  It may be either `2.7` or `3`: specifically the toplevel `Makefile` tries to do `make -C python-$(PYTHONVER) install`.  The default is `2.7`.
- `PREFIX`: the installation prefix, defaultly your home directory: the commands are installed in `$(PREFIX)/bin`.

There are some other variables, but none of them should matter for normal installs: see the `Makefile`s if you are interested.

### Example installations
To install the Python 2.7 versions in `/usr/local/bin`:

```
$ make PREFIX=/usr/local
```

To install the Python 3 versions in `~/bin`:

```
$ make PYTHONVER=3
```

## Prerequisites
This will probably only work on Unixoid systems although there's nothing particularly platform-specific about the code.

You need a working installation of the appropriate Python version: 2.7 or any 3, in such a way that `/usr/bin/env python2.7` (for instance) will work.

The OS needs to provide good randon numbers via `/dev/urandom` (see below).

`random-passphrase` needs a good-sized dictionary: it looks for the standard Unix/Linux dictionary by default, so unless you point it somewhere else that needs to be present.  The bigger the dictionary is the better: use `random-passphrase -v` to find out how big the dictionary is: less than 100,000 words is a problem.

The `Makefiles` quite probably depend on [GNU make](https://www.gnu.org/software/make/).

They have been currently tested on Python 2.7 (extensively) and Python 3.6 (lightly).

---

## Notes and caveats
**You use these tools at your own risk.**  I believe that both these tools do what they claim to, and I have personally used them for a long time.  But they may contain bugs which mean that the passwords and passphrases they generate are not really random.  I will not be held responsible for any deficiencies or vulnerabilities in their implementation: if you want to use them I suggest you at least cursorily read their source code to check they do what I claim they do.

In particular these tools make use of Python's [`random.SystemRandom`](https://docs.python.org/3.7/library/random.html#random.SystemRandom) & hence [`os.urandom()`](https://docs.python.org/3.7/library/os.html#os.urandom) to generate randomness: if there is a problem with this, or with the underlying platform's sources of randomness, then the passwords & passphrases will not be random.  I mostly trust that the implementations of these things are good, but I have not done other than very cursory tests to see that they are.  I hope & assume that others have done much more extensive tests.

## Futures
Or, a list of things to do.

- I should document the sequential mode.
- Python 3 at the right time.

## License
Copyright 2015-2019 Tim Bradshaw

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
