Message-ID: <5187F3AA.6040801@xenomai.org>
Date: Mon, 06 May 2013 20:17:14 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CANzNmi8eBtvVn9PcLSsrpHN+4YSCgHiGgacFgOeWjm6cQe6hsg@mail.gmail.com>
In-Reply-To: <CANzNmi8eBtvVn9PcLSsrpHN+4YSCgHiGgacFgOeWjm6cQe6hsg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Doubts about priorities with periodic tasks (Posix
 Skin)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Sebastian Pavez <sebastian.pavez.t@gmail.com>
Cc: Xenomai <xenomai@xenomai.org>

On 05/06/2013 07:14 PM, Sebastian Pavez wrote:

> Hi,
> 
> I've previously asked a question related to this topic:
> http://www.mail-archive.com/xenomai@xenomai.org/msg03134.html
> 
> But now I have more specific doubts (I think) and hopefully someone could
> help me with this.
> 
> Like I said in my other question I have two tasks, one to control a DC
> motor and the other one acting like a perturbation. I attached a simplify
> code of this program (without the code of the control and other stuff).
> When I execute it (the real one) and try 'cat /proc/xenomai/sched' I get:
> 
> CPU  PID    CLASS  PRI      TIMEOUT   TIMEBASE   STAT       NAME
>   0         0      idle      -1                 -         master
> R          ROOT/0
>   1         0      idle      -1                 -         master
> R          ROOT/1
>   2         0      idle      -1                 -         master
> R          ROOT/2
>   3         0      idle      -1                 -         master
> R          ROOT/3
>   4         0      idle      -1                 -         master
> R          ROOT/4
>   5         0      idle      -1                 -         master
> R          ROOT/5
>   6         0      idle      -1                 -         master
> R          ROOT/6
>   7         0      idle      -1                 -         master
> R          ROOT/7
>   0    2339         rt       0                 -         master
> X          control
>   0    2341         rt       1              23us      master
> D          control
>   0    2342         rt       2               8us       master
> D          control
> 
> So, one of my worries is answered, the threads are executed on the same
> CPU. When I try cat /proc/xenomai/stat I get:
> 
> CPU  PID    MSW        CSW        PF    STAT         %CPU  NAME
>   0       0      0          23906158        0     00500080     17.8  ROOT/0
>   1       0      0                    0          0     00500080    100.0
> ROOT/1
>   2       0      0                    0          0     00500080    100.0
> ROOT/2
>   3       0      0                    0          0     00500080    100.0
> ROOT/3
>   4       0      0                    0          0     00500080    100.0
> ROOT/4
>   5       0      0                    0          0     00500080    100.0
> ROOT/5
>   6       0      0                    0          0     00500080    100.0
> ROOT/6
>   7       0      0                    0          0     00500080    100.0
> ROOT/7
>   0  2339      3                    3          0     00b00380       0.0
> control
>   0  2341      1          10157707        0     00300184     31.7  control
>   0  2342      1          10157706        0     00300184     48.6  control
>   0       0      0          70802151        0     00000000       1.6
> IRQ2312: [timer]


Under Linux, every task has an "affinity" defining on which cpus it may
run, you can set affinity at task creation with some recent glibcs with
pthread_attr_setaffinity_np, or later with pthread_setaffinity or the
older service sched_setaffinity. See the glibc documentation for more
details.

> 
> I have 1 MSW, does this mean that the threads are being executed on a
> secondary mode? If is so, is there a way to avoid this?


If you want to be informed of the switches to secondary mode, see
pthread_set_mode_np documentation.

> 
> I've been trying to increment the execution time of the perturbation thread
> (which have the highest priority) and see how the control is degrade
> (because my goal is to get practical results related with my professor
> simulations) but I get nothing.


I may have misread your code, but it seems to me that in the code you
sent to this list, you do not control the execution time: each thread
keeps suspending itself in its inner loop by calling pthread_wait_np.

In general, however, a Xenomai system where a real-time task consumes a
lot of cpu does tend to crash, it is recommended to let linux run (by
having all your real-time tasks suspended at some point) from time to
time. A safe solution is to let it run at least for its timer tick, so
every millisecond, 4 milliseconds, or 10 milliseconds depending on
CONFIG_HZ value.

> The idea after getting this is change the
> priority, giving the control thread the highest one, and have system
> working ok, in simple words we would like to prove the theory of real time
> approach in practice. All this by having the same period for both tasks, I
> would like to have a bigger period, something like 1ms, but I'm trying to
> get the test to the edge first.
> 
> Sometimes when I increment the execution time of the perturbation the
> computer hangs up before the control could even fail


That is not normal. What version of Xenomai are you running, what
versino of the I-pipe patch, on what hardware, with what kernel
configuration? If you are running in graphic mode, could you try running
in text mode to see if you get a kernel error? If not, could you enable
the I-pipe and Xenomai debugging options to see if one trigs?

-- 
                                                                Gilles.

