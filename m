From: =?iso-8859-1?Q?C=E9dric_Perles?= <cperles@sepro-group.com>
Date: Wed, 22 Nov 2017 17:10:37 +0100 (CET)
Message-ID: <023601d363ac$6ce04c40$46a0e4c0$@sepro-group.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Language: fr
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Strange scheduling behaviour
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

I=92m working on an iMX6 based board with NXP kernel 4.1.15.
I would like to understand why latency max returned by cyclictest
increases from 20=B5s to 100=B5s when dohell accesses to USB.

Since i-pipe tracer refuses to work, I used ftrace to record cobalt,
scheduling and irq events. Here is what I see on kernelshark:

As expected, cyclictest has 1 xenomai thread per core (I can see them on
/proc/xenomai/sched/threads) that wakes up periodically after a 200=B5s
nanosleep.

Sometimes, the wake up seems to be delayed (400=B5s instead of 200=B5s)
because of an USB irq treatment followed by a call to usb-storage.
Other times, the wake up seems to be delayed (400=B5s instead of 200=B5s)=
 by a
Linux call to ktimersoft, rcu and cat (see
https://drive.google.com/file/d/18-B3WO2QH7PvBzJrt9tK5-TXvAkDxTPn/view?us=
p
=3Dsharing)

Is it normal to delay a xenomai task wake up because of a Linux interrupt
(I expected ipipe to act as a shield) ?
How a simple Linux "cat" can delay a xenomai wake up ?

Regards,

C=E9dric.

