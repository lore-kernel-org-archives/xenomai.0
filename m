Message-ID: <1215525959.487374472c1bc@domain.hid>
Date: Tue, 08 Jul 2008 16:05:59 +0200
From: nourry@domain.hid
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] rt_read_timer value
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

i try to make a little program that just records time reaction : a pictur=
e
appears and we must press a key. Time between image appeared and keypress=
 is
recorded.

For that, i use rt_time_read() in aperiodic mode (since if we don't speci=
fy
rt_task_set_periodic(), aperiodic mode is default, that's right ?).

It seems working until a little bit more 2 seconds, but after that, value
returned is negative and decreasing, while it was positive and increasing=
 (weird
because i've read that in aperiodic mode it should be decreasing all the =
time).

Moreover, i believe remember that while beginning this program, time was =
always
decreasing, like real-time task were affected by the rest of the program.

I must record time until 5 seconds after image appeared, and this problem
doesn't ease the task.

I must have made a mistake, can someone help me ?

Another little question, which functions, librairies, calls in one word c=
an we
make in real-time tasks without breaking it ? I want to use event detecti=
on from
SDL library to catch keypress, there's a function that polls for events (=
for the
moment i use kbhit). It doesn't seems to increase latency in an endless l=
oop. I
must keep latency under 1 ms since goal is to measure time reaction with
accuracy.


Thanks to all,
Antoine

