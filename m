MIME-Version: 1.0
Date: Tue, 17 Apr 2012 16:41:52 +0530
Message-ID: <CAM1yFZ_VhjCVxTBBo9a-6w-2g6xiiGTkuQ6CQ1nJquR0xZCC+g@domain.hid>
From: Anisha Kaul <born.rebel.83@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai-help] Understanding the output of hackbench when run
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

Greetings,

The hackbench command I issued is as follows: _______________________________

/usr/xenomai/bin/xeno-test -l "dohell -b ./hackbench -pipe 100 process 100"

The end result of the same was:
_______________________________
...
Started child 8805: dohell -b ./hackbench -pipe 100 process 100
Started child 8806: /usr/xenomai/bin/latency
/usr/xenomai/bin/dohell [ -b path ] [ -s server ] [ -p port ] [ -m
mntpoint ] [ -l path | seconds ]

Generate load, using an assorted set of commands and optionnaly:
- hackbench if the path to the hackbench binary is specified with -b;
- nc to send TCP data to "server" port "port" if -s is specified (if -p
is not specified, the port 9, aka discard is used);
- dd to write data under "mntpoint" if -m is specified.

during the runtime of the LTP test if the path to the LTP installation
directory is specifed with -l or during "seconds" seconds.
== Sampling period: 100 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
Load script terminated, terminating checked scripts
---|-----------|-----------|-----------|--------|------|-------------------------
RTS|   3574.877|      0.000|  -3574.878|       0|     0|    00:00:-01/00:00:-01

_______________________________

The last `Residual Time Stamp` table doesn't have the headings. How do
I know what do each of the numbers represent?
Secondly, does `hackbench` when run along with xeno-test runs all its
processes within the "real time"?


Please guide.
-Anisha

