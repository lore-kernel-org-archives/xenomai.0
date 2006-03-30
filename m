Message-ID: <2cf1ee820603300724w1335df09nf4d2abb0755107d5@domain.hid>
Date: Thu, 30 Mar 2006 18:24:19 +0300
From: "emin ak" <eminak71@domain.hid>
Subject: Re: [Xenomai-help] gigabit rate packet processing with xenomai
In-Reply-To: <44296668.10300@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
References: <2cf1ee820603280009r5adec759h99aa69809f68b457@domain.hid>
	<44296668.10300@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Dear All;
Thanks for the answers firstly.
I'am using linux (and also xenomai ) for a powerpc (PQ3/MPC8540) and
will use on chip gigabit ethernet controller (tsec) that is not
supported on rt-net yet (maybe untill I'll write one:)
In my opinion and my basic tests shows that context switch times and
system call latecies in linux decrease user space performance
significally even with highest RT_FIFO priority and this reasons
prevent my gigabit rate data processing in user space.
I think I'll firstly choose un-deterministical way, write a realtime
user space thread that process the data coming from linux ethernet
driver, if it fails, I'll adapt the driver for rt-net or wait for the
up-coming realtime-preemptive patch.
Thanks again.


2006/3/28, Jan Kiszka <jan.kiszka@domain.hid>:
> emin ak wrote:
> > Dear All;
> > I'am new with xenomai (and also adeos), firstly I would like to thank
> > who contributed to this project for this  high quality job. I have an
> > project that needs gigabit rate ethernet packet processing in user
> > space and need your recommendations.
> > I want to archive this with minimal kernel level device driver changes.
> >  According to my plan, I'll create a realtime user level thread and
> > this thread sleeps (with the mutex machanism in the native api) until
>
> In general, mutexes are not the right mechanism to wait on a specific
> event, they are used to synchronise concurrent access to resources. What
> you are likely looking for are e.g. semaphores.
>
> > receiving a valid ethernet packet on ethernet interface that is
> > working regular linux domain. After receiving the packet, ethernet
> > driver releases the lock and sends packet to user level thread (with
> > shared memory or an other way).With this way, I have left the device
> > driver in linux domain, I'll only need to add locking and shared
> > memory system in the device driver.Does this system work? Does the
>
> Not very well (which means: not deterministically). You need to put the
> driver under Xenomai control to achieve predictable latencies.
>
> > user level thread affect the functionallty of ethernet interface?Do I
> > need to implement all my user space thread and kernel level driver in
> > primaly domain?
>
> Yep, but you might be lucky: there is one Gigabit Ethernet driver
> already available with RTnet (Realtek 8169). If you are only looking for
> deterministic packet processing in an arbitrary network, you just have
> to load the RTnet core and the rt_r8169 driver, and then you can
> register your protocol types for sending and receiving (via rt-packet
> sockets). There are also examples available with RTnet. Feel free to ask
> for more details on the RTnet list.
>
> Jan
>
>
>
>

