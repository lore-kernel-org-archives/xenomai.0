Message-Id: <47F25D9E0200000100193062@domain.hid>
Date: Tue, 01 Apr 2008 16:06:54 -0400
From: "Hubert Talbot" <Hubert.Talbot@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: [Xenomai-help] interrupt reception precision
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

Hi,

I have two applications:

- Server:

	an rt_task periodically (period =3D 1 sec) generating an interrupti=
on on the parallel port.

- Client:

	an rt_task waiting for interrupts on parallel port.
=09

The goal of these applications is to see the precision of the interrupt =
catching.


Client traces this way (description follows):

     2 -  100000, 1207069273545421305 *** T:   -4615 [  -4615..      0] (  =
0)
     3 -  100000, 1207069274545430160 *** T:    4240 [  -4615..   4240] (  =
0)    =20
     4 -  100000, 1207069275545425659 *** T:    -261 [  -4615..   4240] (  =
0)    =20
     5 -  100000, 1207069276545423510 *** T:   -2410 [  -4615..   4240] (  =
0)    =20
...
   125 -  100000, 1207069396545415808 *** T:  -10112 [ -15304..  72824] (  =
0)
   126 -  100000, 1207069397545454679 *** T:   28759 [ -15304..  72824] (  =
0)
   127 -  100000, 1207069398545672048 *** T:  246128 [ -15304.. 246128] (  =
1)
   128 -  100000, 1207069399545415469 *** T:  -10451 [ -15304.. 246128] (  =
1)
   129 -  100000, 1207069400545436692 *** T:   10772 [ -15304.. 246128] (  =
1)
...
   336 -  100000, 1207069607545421900 *** T:   -4020 [ -19102.. 246128] (  =
1)
   337 -  100000, 1207069608545425707 *** T:    -213 [ -19102.. 246128] (  =
1)
   338 -  100000, 1207069609545534088 *** T:  108168 [ -19102.. 246128] (  =
2)
   339 -  100000, 1207069610545413970 *** T:  -11950 [ -19102.. 246128] (  =
2)
   340 -  100000, 1207069611545416247 *** T:   -9673 [ -19102.. 246128] (  =
2)
...
  1027 -  100000, 1207070298545426101 *** T:     181 [ -23604.. 246128] (  =
2)
  1028 -  100000, 1207070299545425759 *** T:    -161 [ -23604.. 246128] (  =
2)
  1029 -  100000, 1207070300545653073 *** T:  227153 [ -23604.. 246128] (  =
3)
  1030 -  100000, 1207070301545405283 *** T:  -20637 [ -23604.. 246128] (  =
3)
  1031 -  100000, 1207070302545413832 *** T:  -12088 [ -23604.. 246128] (  =
3)
...
  2107 -  100000, 1207071378545416769 *** T:   -9151 [ -23604.. 246128] (  =
3)
  2108 -  100000, 1207071379545420930 *** T:   -4990 [ -23604.. 246128] (  =
3)
  2109 -  100000, 1207071380545418432 *** T:   -7488 [ -23604.. 246128] (  =
3)
  2110 -  100000, 1207071381545785841 *** T:  359921 [ -23604.. 359921] (  =
4)
  2111 -  100000, 1207071382545416399 *** T:   -9521 [ -23604.. 359921] (  =
4)
  2112 -  100000, 1207071383545417713 *** T:   -8207 [ -23604.. 359921] (  =
4)
...


The columns description is:

- first:	the number of the received interrupt.
- second:	the expected maximum time for receiving interrupt (nsec).
			(more or less 100000 nsec distant from the =
theoretical period).
- third:	the timestamp - rt_timer_read().
- *** T:	no meaning for this report.
- fifth:	time (nanosec) from timestamp and the theoretical period.
- sixth:	interval [min..max] of the values of the fifth column.
- seventh:times that fifth column exceeded 100000 from the theoretical =
period.
			(in this case, interrupts 127, 338, 1029 and 2110)
		=09

The time (nanosec) from timestamp and the theoretical period (fifth =
column)
are generally lower than 100 usec except interrupts 127, 338, 1029 and =
2110
that are far from 100 usec.

I expected something like [a..b] where b < 100 usec.

Three consoles run with "dd if=3D/dev/zero of=3D/dev/null".

What can cause these results?


Configuration:

	- Intel pentium 4 CPU 3.00 GHz
	- kernel 2.6.24
	- adeos-ipipe-2.6.24-x86-2.0-04.patch
	- Xenomai 2.4.2
=09

Thanks in advance.

Hubert


