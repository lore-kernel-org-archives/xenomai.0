From: Stephane Grosjean <s.grosjean@peak-system.com>
Message-ID: <55E9A9B6.50802@peak-system.com>
Date: Fri, 4 Sep 2015 16:24:54 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Fighting with deadlock in xenomai 2.6.3 + linux 3.5.7...
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

I'm working on a RT device driver on a dual-kernel configuration (see 
subject).

I'm going to be crazy with this simple case of a user task filling with 
data a driver
internal Tx queue, and going to sleep when the queue is full. The task 
enters the sleep state,
thanks to a rtdm_event_timedwait() call. The ISR uses the 
rtdm_event_signal() to wake any
sleeping task up (something actually very close to the 16550A serial 
driver).

My problem is that, as soon as the fifo is full, the whole system hangs, 
and a terminal
connected to the serial port (kernel cmd line changed with 
"console=ttyS0,115200")
displays such infos:

[ 3802.078363] Xenomai: stuck on nucleus lock c188d4c0
[ 3802.078363]    waiter = kernel/xenomai/nucleus/intr.c:114 
(xnintr_clock_handler(), CPU #2)
[ 3802.078363]    owner  = kernel/xenomai/skins/rtdm/drvlib.c:857 
(rtdm_event_signal(), CPU #0)
[ 3802.077955] Xenomai: stuck on nucleus lock c188d4c0
[ 3802.077955]    waiter = kernel/xenomai/nucleus/intr.c:114 
(xnintr_clock_handler(), CPU #1)
[ 3802.077955]    owner  = kernel/xenomai/skins/rtdm/drvlib.c:857 
(rtdm_event_signal(), CPU #0)
[ 3802.078610] Xenomai: stuck on nucleus lock c188d4c0
[ 3802.078610]    waiter = kernel/xenomai/nucleus/intr.c:114 
(xnintr_clock_handler(), CPU #3)
[ 3802.078610]    owner  = kernel/xenomai/skins/rtdm/drvlib.c:857 
(rtdm_event_signal(), CPU #0)
[ 3802.077955] Xenomai: stuck on nucleus lock c188d4c0
[ 3802.077955]    waiter = kernel/xenomai/nucleus/intr.c:114 
(xnintr_clock_handler(), CPU #1)
[ 3802.077955]    owner  = kernel/xenomai/skins/rtdm/drvlib.c:857 
(rtdm_event_signal(), CPU #0)
[ 3802.078610] Xenomai: stuck on nucleus lock c188d4c0
[ 3802.078610]    waiter = kernel/xenomai/nucleus/intr.c:114 
(xnintr_clock_handler(), CPU #3)
[ 3802.078610]    owner  = kernel/xenomai/skins/rtdm/drvlib.c:857 
(rtdm_event_signal(), CPU #0)
[ 3802.078363] Xenomai: stuck on nucleus lock c188d4c0
[ 3802.078363]    waiter = kernel/xenomai/nucleus/intr.c:114 
(xnintr_clock_handler(), CPU #2)
...

(yes, mys PC is equipped with a 4xcores i7).

My question is: how and why a "simple" "rtdm_event_signal()" may lock 
the entire system?
I know these system calls are using some global locks, but, in that 
case, why the
"rtdm_event_signal()" does not put this lock back?

Note that the rtdm_event_signal() is called by the ISR each time the Tx 
fifo is not full.
Thus, there are many calls before the hang that succeed! So it is 
reasonable to omit the cases
when the event pointer and/or its content is invalid...

Finally, note that the lock may also occur when the user task enters the 
rtdm_event_timedwait() call:

[  343.660015]    waiter = kernel/xenomai/nucleus/intr.c:114 
(xnintr_clock_handler(), CPU #3)
[  343.660015]    owner  = kernel/xenomai/skins/rtdm/drvlib.c:957 
(rtdm_event_timedwait(), CPU #1)

Any suggestion would be welcome.

Many thanks in advance for your help!

Stephane


--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt
Handelsregister Darmstadt HRB 9183 
Geschaeftsfuehrung: Alexander Gach, Uwe Wilhelm
--

