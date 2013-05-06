MIME-Version: 1.0
Date: Mon, 6 May 2013 13:14:18 -0400
Message-ID: <CANzNmi8eBtvVn9PcLSsrpHN+4YSCgHiGgacFgOeWjm6cQe6hsg@mail.gmail.com>
From: Sebastian Pavez <sebastian.pavez.t@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Doubts about priorities with periodic tasks (Posix Skin)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hi,

I've previously asked a question related to this topic:
http://www.mail-archive.com/xenomai@xenomai.org/msg03134.html

But now I have more specific doubts (I think) and hopefully someone could
help me with this.

Like I said in my other question I have two tasks, one to control a DC
motor and the other one acting like a perturbation. I attached a simplify
code of this program (without the code of the control and other stuff).
When I execute it (the real one) and try 'cat /proc/xenomai/sched' I get:

CPU  PID    CLASS  PRI      TIMEOUT   TIMEBASE   STAT       NAME
  0         0      idle      -1                 -         master
R          ROOT/0
  1         0      idle      -1                 -         master
R          ROOT/1
  2         0      idle      -1                 -         master
R          ROOT/2
  3         0      idle      -1                 -         master
R          ROOT/3
  4         0      idle      -1                 -         master
R          ROOT/4
  5         0      idle      -1                 -         master
R          ROOT/5
  6         0      idle      -1                 -         master
R          ROOT/6
  7         0      idle      -1                 -         master
R          ROOT/7
  0    2339         rt       0                 -         master
X          control
  0    2341         rt       1              23us      master
D          control
  0    2342         rt       2               8us       master
D          control

So, one of my worries is answered, the threads are executed on the same
CPU. When I try cat /proc/xenomai/stat I get:

CPU  PID    MSW        CSW        PF    STAT         %CPU  NAME
  0       0      0          23906158        0     00500080     17.8  ROOT/0
  1       0      0                    0          0     00500080    100.0
ROOT/1
  2       0      0                    0          0     00500080    100.0
ROOT/2
  3       0      0                    0          0     00500080    100.0
ROOT/3
  4       0      0                    0          0     00500080    100.0
ROOT/4
  5       0      0                    0          0     00500080    100.0
ROOT/5
  6       0      0                    0          0     00500080    100.0
ROOT/6
  7       0      0                    0          0     00500080    100.0
ROOT/7
  0  2339      3                    3          0     00b00380       0.0
control
  0  2341      1          10157707        0     00300184     31.7  control
  0  2342      1          10157706        0     00300184     48.6  control
  0       0      0          70802151        0     00000000       1.6
IRQ2312: [timer]

I have 1 MSW, does this mean that the threads are being executed on a
secondary mode? If is so, is there a way to avoid this?

I've been trying to increment the execution time of the perturbation thread
(which have the highest priority) and see how the control is degrade
(because my goal is to get practical results related with my professor
simulations) but I get nothing. The idea after getting this is change the
priority, giving the control thread the highest one, and have system
working ok, in simple words we would like to prove the theory of real time
approach in practice. All this by having the same period for both tasks, I
would like to have a bigger period, something like 1ms, but I'm trying to
get the test to the edge first.

Sometimes when I increment the execution time of the perturbation the
computer hangs up before the control could even fail, so I'm starting to
doubt if all this is even possible to see in practice. In a straightforward
question: What I'm trying to do, is it even possible to get?

If you need more information about it just ask. I know that this
utilization of Xenomai may not be in the scope of this mail list, but some
help with this would be appreciated, because I'm quite stuck at the moment
and I need to know if at least I'm in the right path.

Thanks for your time and patience,
Sebasti=E1n Pavez
-------------- next part --------------
A non-text attachment was scrubbed...
Name: pthread.c
Type: text/x-csrc
Size: 2839 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130506/5a86fda=
4/attachment.c>
