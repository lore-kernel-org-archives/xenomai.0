MIME-Version: 1.0
In-Reply-To: <CAM1yFZ_kvvh019OMe-_BCf_qqyuDAumL0mw4XdMx5TSRGRAWAw@domain.hid>
References: <CAM1yFZ_VhjCVxTBBo9a-6w-2g6xiiGTkuQ6CQ1nJquR0xZCC+g@domain.hid>
	<4F8D5458.6070603@domain.hid> <4F8D553B.6010101@domain.hid>
	<CAM1yFZ_kvvh019OMe-_BCf_qqyuDAumL0mw4XdMx5TSRGRAWAw@domain.hid>
Date: Wed, 18 Apr 2012 12:55:43 +0530
Message-ID: <CAM1yFZ-emKxt2D2x7DCS4mNzbD5x-9_W-Z0w4AhtMBo1P9kTeQ@mail.gmail.com>
From: Anisha Kaul <born.rebel.83@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Understanding the output of hackbench when run
 together with xeno-test
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

On 17 April 2012 17:04, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> Ok, it is not clear: but you need to pass a duration if you do not pass
> the patch to LTP, which means either the "-l path" or "seconds" argument
> is mandatory.

 Thanks for replying. I couldn't have made it out myself that the last
 argument is compulsory.
 The problem isn't solved yet, actually.

 I tried `dohell` separately with `hackbench` and `seconds` parameter
 as follows (and it worked properly):
 _____________________________________________________________
 linux-dopx:~ # /usr/xenomai/bin/dohell -b
 "/home/anisha/Desktop/RealTime/downloadedPages/hackbench -pipe 100
 process 100 seconds" 2
 Running with 100*40 (=3D=3D 4000) tasks.
 Time: 2.198
 /usr/xenomai/bin/dohell: line 94: 17276 Terminated =A0 =A0 =A0 =A0 =A0 =A0=
 =A0while :; do
 =A0 =A0$hackbench 1;
 done
 /usr/xenomai/bin/dohell: line 94: 17277 Terminated =A0 =A0 =A0 =A0 =A0 =A0=
 =A0while :; do
 =A0 =A0cat /proc/interrupts;
 done > /dev/null 2>&1
 /usr/xenomai/bin/dohell: line 94: 17279 Terminated =A0 =A0 =A0 =A0 =A0 =A0=
 =A0while :; do
 =A0 =A0ps w;
 done > /dev/null 2>&1
 /usr/xenomai/bin/dohell: line 94: 17280 Terminated =A0 =A0 =A0 =A0 =A0 =A0=
 =A0dd
 if=3D/dev/zero of=3D/dev/null
 /usr/xenomai/bin/dohell: line 94: 17281 Terminated =A0 =A0 =A0 =A0 =A0 =A0=
 =A0while :; do
 =A0 =A0ls -lR / > /dev/null 2>&1;
 done
 Killed
 _____________________________________________________________

 Then I tried the same with `xeno-test` as follows:

 _____________________________________________________________
> /usr/xenomai/bin/xeno-test -l "dohell -b
> "/home/anisha/Desktop/RealTime/downloadedPages/hackbench -pipe 100
> process 100 seconds" 2"
> and
> /usr/xenomai/bin/xeno-test -l "dohell -b
> /home/anisha/Desktop/RealTime/downloadedPages/hackbench -pipe 100
> process 100 seconds 2"
> and
> /usr/xenomai/bin/xeno-test -l dohell -b
> /home/anisha/Desktop/RealTime/downloadedPages/hackbench -pipe 100
> process 100 seconds 2
> and also,
> /usr/xenomai/bin/xeno-test -l "dohell -b
> /home/anisha/Desktop/RealTime/downloadedPages/hackbench -pipe 100
> process 100" -T 2
> and
> /usr/xenomai/bin/xeno-test -l "dohell -b
> /home/anisha/Desktop/RealTime/downloadedPages/hackbench -pipe 100
> process 100" -t 2
> _____________________________________________________________



 All of them resulted in the following end results:
 What is the way to run this? Please help.


 _____________________________________________________________
 Started child 21470: /usr/xenomai/bin/latency
 /usr/xenomai/bin/dohell [ -b path ] [ -s server ] [ -p port ] [ -m
 mntpoint ] [ -l path | seconds ]

 Generate load, using an assorted set of commands and optionnaly:
 - hackbench if the path to the hackbench binary is specified with -b;
 - nc to send TCP data to "server" port "port" if -s is specified (if -p
 is not specified, the port 9, aka discard is used);
 - dd to write data under "mntpoint" if -m is specified.

 during the runtime of the LTP test if the path to the LTP installation
 directory is specifed with -l or during "seconds" seconds.
 =3D=3D Sampling period: 100 us
 =3D=3D Test mode: periodic user-mode task
 =3D=3D All results in microseconds
 warming up...
 Load script terminated, terminating checked scripts
 ---|-----------|-----------|-----------|--------|------|------------------=
-------
 RTS| =A0 3574.296| =A0 =A0 =A00.000| =A0-3574.297| =A0 =A0 =A0 0| =A0 =A0 =
0| =A0 =A000:00:-01/00:00:-01
 _____________________________________________________________



 -Anisha

