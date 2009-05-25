MIME-Version: 1.0
Date: Mon, 25 May 2009 14:46:04 +0300
Message-ID: <9c789a000905250446t78fd6b38x1a6f28e35b70d7d6@domain.hid>
From: Cristian Axenie <cristian.axenie@domain.hid>
Content-Type: multipart/alternative; boundary=001636c5abccb1b5fb046abb2797
Subject: [Xenomai-help] Driver testing procedure ?!
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

--001636c5abccb1b5fb046abb2797
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello!
I've took a snapshot of the git tree from Alexis's when he added the PCIMIO
drivers. I've built my kernel and created an own usbflash filesystem. Now
what should I do to begin testing the drivers ?
The drivers are now kernel built-in and there is no comedi_config anymore.

The outputs from cmd_read and cmd_write are the following, and it seems that
is a problem with the file descriptors :

/usr/xenomai/bin # ./cmd_read
cmd_read: comedi_fill_desc failed (ret=-22)
*** glibc detected *** ./cmd_read: free(): invalid next size (fast):
0x10046008 ***
======= Backtrace: =========
/lib/libc.so.6[0xfd7b1ac]
/lib/libc.so.6[0xfd7cb8c]
/lib/libc.so.6(cfree+0xfc)[0xfd7d280]
./cmd_read[0x100022a0]
/lib/libc.so.6[0xfd22260]
/lib/libc.so.6[0xfd223ec]
======= Memory map: ========
00100000-00103000 r-xp 00100000 00:00 0          [vdso]
0fd04000-0fe40000 r-xp 00000000 08:01 16376      /lib/libc-2.6.so
0fe40000-0fe7f000 ---p 0013c000 08:01 16376      /lib/libc-2.6.so
0fe7f000-0fe81000 r--p 0013b000 08:01 16376      /lib/libc-2.6.so
0fe81000-0fe84000 rwxp 0013d000 08:01 16376      /lib/libc-2.6.so
0fe84000-0fe87000 rwxp 0fe84000 00:00 0
0fe97000-0feab000 r-xp 00000000 08:01 16499      /lib/libpthread-2.6.so
0feab000-0feeb000 ---p 00014000 08:01 16499      /lib/libpthread-2.6.so
0feeb000-0feec000 r--p 00014000 08:01 16499      /lib/libpthread-2.6.so
0feec000-0feed000 rwxp 00015000 08:01 16499      /lib/libpthread-2.6.so
0feed000-0feef000 rwxp 0feed000 00:00 0
0feff000-0ff02000 r-xp 00000000 08:01 47615
/usr/xenomai/lib/librtdm.so.1.0.0
0ff02000-0ff41000 ---p 00003000 08:01 47615
/usr/xenomai/lib/librtdm.so.1.0.0
0ff41000-0ff42000 rwxp 00002000 08:01 47615
/usr/xenomai/lib/librtdm.so.1.0.0
0ff52000-0ff5b000 r-xp 00000000 08:01 47591
/usr/xenomai/lib/libnative.so.3.0.0
0ff5b000-0ff9b000 ---p 00009000 08:01 47591
/usr/xenomai/lib/libnative.so.3.0.0
0ff9b000-0ff9c000 rwxp 00009000 08:01 47591
/usr/xenomai/lib/libnative.so.3.0.0
0ffac000-0ffb0000 r-xp 00000000 08:01 47586
/usr/xenomai/lib/libcomedi.so.0.0.0
0ffb0000-0ffef000 ---p 00004000 08:01 47586
/usr/xenomai/lib/libcomedi.so.0.0.0
0ffef000-0fff0000 rwxp 00003000 08:01 47586
/usr/xenomai/lib/libcomedi.so.0.0.0
10000000-10004000 r-xp 00000000 08:01 47292      /usr/xenomai/bin/cmd_read
10043000-10044000 rwxp 00003000 08:01 47292      /usr/xenomai/bin/cmd_read
10044000-10067000 rwxp 10044000 00:00 0          [heap]
48000000-4801d000 r-xp 00000000 08:01 16303      /lib/ld-2.6.so
4801d000-48020000 rw-p 4801d000 00:00 0
48020000-48023000 rw-s 00000000 08:01 31436      /dev/rtheap
48023000-48026000 rw-s 00000000 08:01 31436      /dev/rtheap
4805c000-4805d000 r--p 0001c000 08:01 16303      /lib/ld-2.6.so
4805d000-4805e000 rwxp 0001d000 08:01 16303      /lib/ld-2.6.so
bfdda000-bfdef000 rw-p bffeb000 00:00 0          [stack]
Aborted


/usr/xenomai/bin # ./cmd_write
cmd_write: comedi_get_desc failed (ret=-22)
*** glibc detected *** ./cmd_write: free(): invalid next size (fast):
0x10046008 ***
======= Backtrace: =========
/lib/libc.so.6[0xfd7b1ac]
/lib/libc.so.6[0xfd7cb8c]
/lib/libc.so.6(cfree+0xfc)[0xfd7d280]
./cmd_write[0x100021a0]
/lib/libc.so.6[0xfd22260]
/lib/libc.so.6[0xfd223ec]
======= Memory map: ========
00100000-00103000 r-xp 00100000 00:00 0          [vdso]
0fd04000-0fe40000 r-xp 00000000 08:01 16376      /lib/libc-2.6.so
0fe40000-0fe7f000 ---p 0013c000 08:01 16376      /lib/libc-2.6.so
0fe7f000-0fe81000 r--p 0013b000 08:01 16376      /lib/libc-2.6.so
0fe81000-0fe84000 rwxp 0013d000 08:01 16376      /lib/libc-2.6.so
0fe84000-0fe87000 rwxp 0fe84000 00:00 0
0fe97000-0feab000 r-xp 00000000 08:01 16499      /lib/libpthread-2.6.so
0feab000-0feeb000 ---p 00014000 08:01 16499      /lib/libpthread-2.6.so
0feeb000-0feec000 r--p 00014000 08:01 16499      /lib/libpthread-2.6.so
0feec000-0feed000 rwxp 00015000 08:01 16499      /lib/libpthread-2.6.so
0feed000-0feef000 rwxp 0feed000 00:00 0
0feff000-0ff02000 r-xp 00000000 08:01 47615
/usr/xenomai/lib/librtdm.so.1.0.0
0ff02000-0ff41000 ---p 00003000 08:01 47615
/usr/xenomai/lib/librtdm.so.1.0.0
0ff41000-0ff42000 rwxp 00002000 08:01 47615
/usr/xenomai/lib/librtdm.so.1.0.0
0ff52000-0ff5b000 r-xp 00000000 08:01 47591
/usr/xenomai/lib/libnative.so.3.0.0
0ff5b000-0ff9b000 ---p 00009000 08:01 47591
/usr/xenomai/lib/libnative.so.3.0.0
0ff9b000-0ff9c000 rwxp 00009000 08:01 47591
/usr/xenomai/lib/libnative.so.3.0.0
0ffac000-0ffb0000 r-xp 00000000 08:01 47586
/usr/xenomai/lib/libcomedi.so.0.0.0
0ffb0000-0ffef000 ---p 00004000 08:01 47586
/usr/xenomai/lib/libcomedi.so.0.0.0
0ffef000-0fff0000 rwxp 00003000 08:01 47586
/usr/xenomai/lib/libcomedi.so.0.0.0
10000000-10003000 r-xp 00000000 08:01 47293      /usr/xenomai/bin/cmd_write
10043000-10044000 rwxp 00003000 08:01 47293      /usr/xenomai/bin/cmd_write
10044000-10067000 rwxp 10044000 00:00 0          [heap]
48000000-4801d000 r-xp 00000000 08:01 16303      /lib/ld-2.6.so
4801d000-48020000 rw-p 4801d000 00:00 0
48020000-48023000 rw-s 00000000 08:01 31436      /dev/rtheap
48023000-48026000 rw-s 00000000 08:01 31436      /dev/rtheap
4805c000-4805d000 r--p 0001c000 08:01 16303      /lib/ld-2.6.so
4805d000-4805e000 rwxp 0001d000 08:01 16303      /lib/ld-2.6.so
bfdbe000-bfdd3000 rw-p bffeb000 00:00 0          [stack]
Aborted


Some hints ?

How should I test the validity of my solution? In fact how can I test that
the NI drivers are working properly now that are Xenomai built-in?

Best !

--001636c5abccb1b5fb046abb2797
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello!<br>I&#39;ve took a snapshot of the git tree from Alexis&#39;s when h=
e added the
PCIMIO drivers. I&#39;ve built my kernel and created an own usbflash filesy=
stem. Now what should I
do to begin testing the drivers ?<br>The drivers are now kernel built-in an=
d there is no comedi_config anymore.<br>
<br>The outputs from cmd_read and cmd_write are the following, and it seems=
 that is a problem with the file descriptors :<br><br>/usr/xenomai/bin # ./=
cmd_read <br>cmd_read: comedi_fill_desc failed (ret=3D-22)<br>*** glibc det=
ected *** ./cmd_read: free(): invalid next size (fast): 0x10046008 ***<br>

=3D=3D=3D=3D=3D=3D=3D Backtrace: =3D=3D=3D=3D=3D=3D=3D=3D=3D<br>/lib/libc.s=
o.6[0xfd7b1ac]<br>/lib/libc.so.6[0xfd7cb8c]<br>/lib/libc.so.6(cfree+0xfc)[<=
div id=3D":3h" class=3D"ii gt">0xfd7d280]<br>./cmd_read[0x100022a0]<br>/lib=
/libc.so.6[0xfd22260]<br>/lib/libc.so.6[0xfd223ec]<br>
=3D=3D=3D=3D=3D=3D=3D Memory map: =3D=3D=3D=3D=3D=3D=3D=3D<br>
00100000-00103000 r-xp 00100000 00:00 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [vdso]<b=
r>0fd04000-0fe40000 r-xp 00000000 08:01 16376=A0=A0=A0=A0=A0 /lib/<a href=
=3D"http://libc-2.6.so/" target=3D"_blank">libc-2.6.so</a><br>0fe40000-0fe7=
f000 ---p 0013c000 08:01 16376=A0=A0=A0=A0=A0 /lib/<a href=3D"http://libc-2=
.6.so/" target=3D"_blank">libc-2.6.so</a><br>

0fe7f000-0fe81000 r--p 0013b000 08:01 16376=A0=A0=A0=A0=A0 /lib/<a href=3D"=
http://libc-2.6.so/" target=3D"_blank">libc-2.6.so</a><br>0fe81000-0fe84000=
 rwxp 0013d000 08:01 16376=A0=A0=A0=A0=A0 /lib/<a href=3D"http://libc-2.6.s=
o/" target=3D"_blank">libc-2.6.so</a><br>
0fe84000-0fe87000 rwxp 0fe84000 00:00 0 <br>
0fe97000-0feab000 r-xp 00000000 08:01 16499=A0=A0=A0=A0=A0 /lib/<a href=3D"=
http://libpthread-2.6.so/" target=3D"_blank">libpthread-2.6.so</a><br>0feab=
000-0feeb000 ---p 00014000 08:01 16499=A0=A0=A0=A0=A0 /lib/<a href=3D"http:=
//libpthread-2.6.so/" target=3D"_blank">libpthread-2.6.so</a><br>

0feeb000-0feec000 r--p 00014000 08:01 16499=A0=A0=A0=A0=A0 /lib/<a href=3D"=
http://libpthread-2.6.so/" target=3D"_blank">libpthread-2.6.so</a><br>0feec=
000-0feed000 rwxp 00015000 08:01 16499=A0=A0=A0=A0=A0 /lib/<a href=3D"http:=
//libpthread-2.6.so/" target=3D"_blank">libpthread-2.6.so</a><br>

0feed000-0feef000 rwxp 0feed000 00:00 0 <br>0feff000-0ff02000 r-xp 00000000=
 08:01 47615=A0=A0=A0=A0=A0 /usr/xenomai/lib/librtdm.so.1.0.0<br>0ff02000-0=
ff41000 ---p 00003000 08:01 47615=A0=A0=A0=A0=A0 /usr/xenomai/lib/librtdm.s=
o.1.0.0<br>0ff41000-0ff42000 rwxp 00002000 08:01 47615=A0=A0=A0=A0=A0 /usr/=
xenomai/lib/librtdm.so.1.0.0<br>

0ff52000-0ff5b000 r-xp 00000000 08:01 47591=A0=A0=A0=A0=A0 /usr/xenomai/lib=
/libnative.so.3.0.0<br>0ff5b000-0ff9b000 ---p 00009000 08:01 47591=A0=A0=A0=
=A0=A0 /usr/xenomai/lib/libnative.so.3.0.0<br>0ff9b000-0ff9c000 rwxp 000090=
00 08:01 47591=A0=A0=A0=A0=A0 /usr/xenomai/lib/libnative.so.3.0.0<br>

0ffac000-0ffb0000 r-xp 00000000 08:01 47586=A0=A0=A0=A0=A0 /usr/xenomai/lib=
/libcomedi.so.0.0.0<br>0ffb0000-0ffef000 ---p 00004000 08:01 47586=A0=A0=A0=
=A0=A0 /usr/xenomai/lib/libcomedi.so.0.0.0<br>0ffef000-0fff0000 rwxp 000030=
00 08:01 47586=A0=A0=A0=A0=A0 /usr/xenomai/lib/libcomedi.so.0.0.0<br>

10000000-10004000 r-xp 00000000 08:01 47292=A0=A0=A0=A0=A0 /usr/xenomai/bin=
/cmd_read<br>10043000-10044000 rwxp 00003000 08:01 47292=A0=A0=A0=A0=A0 /us=
r/xenomai/bin/cmd_read<br>10044000-10067000 rwxp 10044000 00:00 0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 [heap]<br>48000000-4801d000 r-xp 00000000 08:01 16303=A0=
=A0=A0=A0=A0 /lib/<a href=3D"http://ld-2.6.so/" target=3D"_blank">ld-2.6.so=
</a><br>

4801d000-48020000 rw-p 4801d000 00:00 0 <br>48020000-48023000 rw-s 00000000=
 08:01 31436=A0=A0=A0=A0=A0 /dev/rtheap<br>48023000-48026000 rw-s 00000000 =
08:01 31436=A0=A0=A0=A0=A0 /dev/rtheap<br>4805c000-4805d000 r--p 0001c000 0=
8:01 16303=A0=A0=A0=A0=A0 /lib/<a href=3D"http://ld-2.6.so/" target=3D"_bla=
nk">ld-2.6.so</a><br>

4805d000-4805e000 rwxp 0001d000 08:01 16303=A0=A0=A0=A0=A0 /lib/<a href=3D"=
http://ld-2.6.so/" target=3D"_blank">ld-2.6.so</a><br>bfdda000-bfdef000 rw-=
p bffeb000 00:00 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [stack]<br>Aborted<br><br><br=
>/usr/xenomai/bin # ./cmd_write <br>
cmd_write: comedi_get_desc failed (ret=3D-22)<br>
*** glibc detected *** ./cmd_write: free(): invalid next size (fast): 0x100=
46008 ***<br>=3D=3D=3D=3D=3D=3D=3D Backtrace: =3D=3D=3D=3D=3D=3D=3D=3D=3D<b=
r>/lib/libc.so.6[0xfd7b1ac]<br>/lib/libc.so.6[0xfd7cb8c]<br>/lib/libc.so.6(=
cfree+0xfc)[0xfd7d280]<br>./cmd_write[0x100021a0]<br>

/lib/libc.so.6[0xfd22260]<br>/lib/libc.so.6[0xfd223ec]<br>=3D=3D=3D=3D=3D=
=3D=3D Memory map: =3D=3D=3D=3D=3D=3D=3D=3D<br>00100000-00103000 r-xp 00100=
000 00:00 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [vdso]<br>0fd04000-0fe40000 r-xp 000=
00000 08:01 16376=A0=A0=A0=A0=A0 /lib/<a href=3D"http://libc-2.6.so/" targe=
t=3D"_blank">libc-2.6.so</a><br>

0fe40000-0fe7f000 ---p 0013c000 08:01 16376=A0=A0=A0=A0=A0 /lib/<a href=3D"=
http://libc-2.6.so/" target=3D"_blank">libc-2.6.so</a><br>0fe7f000-0fe81000=
 r--p 0013b000 08:01 16376=A0=A0=A0=A0=A0 /lib/<a href=3D"http://libc-2.6.s=
o/" target=3D"_blank">libc-2.6.so</a><br>
0fe81000-0fe84000 rwxp 0013d000 08:01 16376=A0=A0=A0=A0=A0 /lib/<a href=3D"=
http://libc-2.6.so/" target=3D"_blank">libc-2.6.so</a><br>
0fe84000-0fe87000 rwxp 0fe84000 00:00 0 <br>0fe97000-0feab000 r-xp 00000000=
 08:01 16499=A0=A0=A0=A0=A0 /lib/<a href=3D"http://libpthread-2.6.so/" targ=
et=3D"_blank">libpthread-2.6.so</a><br>0feab000-0feeb000 ---p 00014000 08:0=
1 16499=A0=A0=A0=A0=A0 /lib/<a href=3D"http://libpthread-2.6.so/" target=3D=
"_blank">libpthread-2.6.so</a><br>

0feeb000-0feec000 r--p 00014000 08:01 16499=A0=A0=A0=A0=A0 /lib/<a href=3D"=
http://libpthread-2.6.so/" target=3D"_blank">libpthread-2.6.so</a><br>0feec=
000-0feed000 rwxp 00015000 08:01 16499=A0=A0=A0=A0=A0 /lib/<a href=3D"http:=
//libpthread-2.6.so/" target=3D"_blank">libpthread-2.6.so</a><br>

0feed000-0feef000 rwxp 0feed000 00:00 0 <br>0feff000-0ff02000 r-xp 00000000=
 08:01 47615=A0=A0=A0=A0=A0 /usr/xenomai/lib/librtdm.so.1.0.0<br>0ff02000-0=
ff41000 ---p 00003000 08:01 47615=A0=A0=A0=A0=A0 /usr/xenomai/lib/librtdm.s=
o.1.0.0<br>0ff41000-0ff42000 rwxp 00002000 08:01 47615=A0=A0=A0=A0=A0 /usr/=
xenomai/lib/librtdm.so.1.0.0<br>

0ff52000-0ff5b000 r-xp 00000000 08:01 47591=A0=A0=A0=A0=A0 /usr/xenomai/lib=
/libnative.so.3.0.0<br>0ff5b000-0ff9b000 ---p 00009000 08:01 47591=A0=A0=A0=
=A0=A0 /usr/xenomai/lib/libnative.so.3.0.0<br>0ff9b000-0ff9c000 rwxp 000090=
00 08:01 47591=A0=A0=A0=A0=A0 /usr/xenomai/lib/libnative.so.3.0.0<br>

0ffac000-0ffb0000 r-xp 00000000 08:01 47586=A0=A0=A0=A0=A0 /usr/xenomai/lib=
/libcomedi.so.0.0.0<br>0ffb0000-0ffef000 ---p 00004000 08:01 47586=A0=A0=A0=
=A0=A0 /usr/xenomai/lib/libcomedi.so.0.0.0<br>0ffef000-0fff0000 rwxp 000030=
00 08:01 47586=A0=A0=A0=A0=A0 /usr/xenomai/lib/libcomedi.so.0.0.0<br>

10000000-10003000 r-xp 00000000 08:01 47293=A0=A0=A0=A0=A0 /usr/xenomai/bin=
/cmd_write<br>10043000-10044000 rwxp 00003000 08:01 47293=A0=A0=A0=A0=A0 /u=
sr/xenomai/bin/cmd_write<br>10044000-10067000 rwxp 10044000 00:00 0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 [heap]<br>48000000-4801d000 r-xp 00000000 08:01 16303=
=A0=A0=A0=A0=A0 /lib/<a href=3D"http://ld-2.6.so/" target=3D"_blank">ld-2.6=
.so</a><br>

4801d000-48020000 rw-p 4801d000 00:00 0 <br>48020000-48023000 rw-s 00000000=
 08:01 31436=A0=A0=A0=A0=A0 /dev/rtheap<br>48023000-48026000 rw-s 00000000 =
08:01 31436=A0=A0=A0=A0=A0 /dev/rtheap<br>4805c000-4805d000 r--p 0001c000 0=
8:01 16303=A0=A0=A0=A0=A0 /lib/<a href=3D"http://ld-2.6.so/" target=3D"_bla=
nk">ld-2.6.so</a><br>

4805d000-4805e000 rwxp 0001d000 08:01 16303=A0=A0=A0=A0=A0 /lib/<a href=3D"=
http://ld-2.6.so/" target=3D"_blank">ld-2.6.so</a><br>bfdbe000-bfdd3000 rw-=
p bffeb000 00:00 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [stack]<br>Aborted<br><br><br=
>Some hints ?<br><br>How should I test the validity of my solution? In fact=
 how can I test that the NI drivers are working properly now that are Xenom=
ai built-in?<br>
<br>Best !<br></div>

--001636c5abccb1b5fb046abb2797--

