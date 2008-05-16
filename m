Date: Fri, 16 May 2008 11:34:15 +0200
Message-Id: <1165644528@domain.hid>
MIME-Version: 1.0
From: Paradoxxa2001@domain.hid
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help]
 =?iso-8859-15?q?at91sam9263_and_user-space_support?=
 =?iso-8859-15?q?_compile_fails?=
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Sure,
the Output of "readelf --sections vmlinux" is:

--------------------------------------------------------------------------=
------------
There are 29 section headers, starting at offset 0x2132b94:

Section Headers:
  [Nr] Name              Type            Addr     Off    Size   ES Flg Lk =
Inf Al
  [ 0]                   NULL            00000000 000000 000000 00      0 =
  0  0
  [ 1] .note.gnu.build-i NOTE            00000000 008000 000024 00   A  0 =
  0  4
  [ 2] .text.head        PROGBITS        c0008000 010000 000240 00  AX  0 =
  0 32
  [ 3] .init             PROGBITS        c0008240 010240 019dc0 00 WAX  0 =
  0 32
  [ 4] .text             PROGBITS        c0022000 02a000 307cb8 00  AX  0 =
  0 1024
  [ 5] =5F=5Fksymtab         PROGBITS        c032a000 332000 005548 00   A  0 =
  0  4
  [ 6] =5F=5Fksymtab=5Fgpl     PROGBITS        c032f548 337548 0016a0 00   A  0 =
  0  4
  [ 7] =5F=5Fksymtab=5Fgpl=5Ffut PROGBITS        c0330be8 338be8 000018 00   A  0 =
  0  4
  [ 8] =5F=5Fkcrctab         PROGBITS        c0330c00 338c00 002aa4 00   A  0 =
  0  4
  [ 9] =5F=5Fkcrctab=5Fgpl     PROGBITS        c03336a4 33b6a4 000b50 00   A  0 =
  0  4
  [10] =5F=5Fkcrctab=5Fgpl=5Ffut PROGBITS        c03341f4 33c1f4 00000c 00   A  0 =
  0  4
  [11] =5F=5Fksymtab=5Fstrings PROGBITS        c0334200 33c200 00e968 00   A  0 =
  0  1
  [12] =5F=5Fparam           PROGBITS        c0342b68 34ab68 0006b8 00   A  0 =
  0  4
  [13] .data             PROGBITS        c0344000 34c000 022658 00  WA  0 =
  0 32
  [14] .bss              NOBITS          c0366660 36e658 03ed40 00  WA  0 =
  0 32
  [15] .comment          PROGBITS        00000000 36e658 007b4a 00      0 =
  0  1
  [16] .ARM.attributes   ARM=5FATTRIBUTES  00000000 3761a2 000027 00      0 =
  0  1
  [17] .debug=5Fline       PROGBITS        00000000 3761c9 175a4c 00      0 =
  0  1
  [18] .debug=5Finfo       PROGBITS        00000000 4ebc15 1753949 00      0=
   0  1
  [19] .debug=5Fabbrev     PROGBITS        00000000 1c3f55e 0ca742 00      0=
   0  1
  [20] .debug=5Faranges    PROGBITS        00000000 1d09ca0 0072b0 00      0=
   0  8
  [21] .debug=5Fpubnames   PROGBITS        00000000 1d10f50 024da2 00      0=
   0  1
  [22] .debug=5Fstr        PROGBITS        00000000 1d35cf2 0cc8d1 01  MS  0=
   0  1
  [23] .debug=5Fframe      PROGBITS        00000000 1e025c4 06c354 00      0=
   0  4
  [24] .debug=5Floc        PROGBITS        00000000 1e6e918 24e506 00      0=
   0  1
  [25] .debug=5Franges     PROGBITS        00000000 20bce20 075c20 00      0=
   0  8
  [26] .shstrtab         STRTAB          00000000 2132a40 000153 00      0=
   0  1
  [27] .symtab           SYMTAB          00000000 213301c 0b87a0 10     28=
 36997  4
  [28] .strtab           STRTAB          00000000 21eb7bc 09dabd 00      0=
   0  1
Key to Flags:
  W (write), A (alloc), X (execute), M (merge), S (strings)
  I (info), L (link order), G (group), x (unknown)
  O (extra OS processing required) o (OS specific), p (processor specific)=

--------------------------------------------------------------------------=
------------


Thomas
-----Urspr=FCngliche Nachricht-----
Von: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
Gesendet: 16.05.08 11:27:41
An: Paradoxxa2001@domain.hid
CC: xenomai@xenomai.org
Betreff: Re: [Xenomai-help] at91sam9263 and user-space support compile fai=
ls

On Fri, May 16, 2008 at 11:24 AM,  <Paradoxxa2001@domain.hid> wrote:
>
> -rwxr-xr-x 1 paradoxxa paradoxxa 35M 16. Mai 11:20 vmlinux

You have a problem, my vmlinux is 4MB large. Could you run
readelf --sections vmlinux
=3F

--=20
 Gilles



=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
Bis 50 MB Dateianh=E4nge=3F Kein Problem!
http://freemail.web.de/club/landingpage.htm/=3Fmc=3D025556


