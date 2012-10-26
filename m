MIME-Version: 1.0
In-Reply-To: <CAHzTO8nxt5KcK_mekgArQXqdLGQC=d3bWFBse=H6cZmpRvon-A@mail.gmail.com>
References: <CAMVghhVFiQNbPLgS5zpLw7Bu5t9mxdY5U9htVOOrRxQt_RWgVQ@mail.gmail.com>
	<CAHzTO8nxt5KcK_mekgArQXqdLGQC=d3bWFBse=H6cZmpRvon-A@mail.gmail.com>
From: Howard Lee Harkness <howard.lee.harkness@gmail.com>
Date: Fri, 26 Oct 2012 09:46:40 -0500
Message-ID: <CAMVghhVXP=VckoAcgSjYBxO=2i2gsAse-or0xvBbNJNuodu2yA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] Seeking recommendations for SBC with precision timer
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai@xenomai.org

Thank you for your fast responses!

1) Not necessarily fanless, but that would be nice.

2) Don't need a timestamp. All I need is a precision interval. I want to be
able to send a signal to a device, and read a measurement exactly 11 us (or
5 us, or 17 us, or 31 us, etc.) later, plus or minus no more than about 1
us. <1 us precision would be better, but I think for now 1 us resolution is
sufficient. Reliably, repeatably.

3) The client can stick stuff on the PC/104, but would prefer to have GPIB
and USB2 on-board.

4) I've go some inquiry emails out to a couple of vendors, including
Advantech. I may be getting some evaluation boards Real Soon Now to play
with.

Interesting observation about ICOP boards having a problem with latency
once an hour. Might be able to deal with that by not scheduling a test
during the high-latency period. Also, since the intervals I'm interested in
are short (and there should be nothing else going on), I could sit and spin
while waiting for completion with interrupts off. Although my understanding
is that there are some interrupts you can't turn off.

I'm wondering about the use of a dual core CPU. Can I run one core with
(most) interrupts off, while running the other normally?

Anybody know if Xenomai works with DSL (Damned Small Linux -- a somewhat
unfortunate name)?

All of the real-time stuff I've done to date didn't have an OS at all (I
wrote my own cooperative multitasker), so I'm a bit new at using an RTOS at
this level. I would welcome suggestions for reading material on the subject.

On Fri, Oct 26, 2012 at 7:38 AM, Nicholas Mc Guire der.herr@hofr.at wrote:

> On Fri, 26 Oct 2012, Howard Lee Harkness wrote:
>
> > I have a client requirement for a system that can handle hard real time
> > with precision timing, and I'm looking for recommendations for a SBC to
> > support it. Here's what is needed:
> >
> > 1) x86 architecture
>
> fanless ?
>
> > 2) support for Linux (I will probably be using Xenomai)
> > 3) precision timer with 1 us resolution
>
> many systems will be able to give you a timer reolution of <=1us
> but there is no system that will bee able to timstamp an event with
> that precission - that is any timestamp you get will have an
> uncertenty atleast in the range of a few microseconds to a few
> tens of microseconds (thats independent of using Xenomai, Preept-RT
> or RTAI)
>
> > 4) PC/104 bus
> > 5) lots of I/O (USB 2, I2C, SPI, GPIB, etc)
> >
> > Anybody here have any experience with a board that has all this?
>
> it does to some extent depend on the "etc" of the "lots of I/O" unless you
> are good with it all being stacked on the PC/104.
>
> you might want to look at the boards in the http:/www.OSADL.org/QA,
> unfortunately not xenomai based systems in the farm but the jitter/latency
> numbers will most likely hold for Xenomai based systems with negligable
> offsets.
>
> thx!
> hofrat
>

On Fri, Oct 26, 2012 at 7:38 AM, Giampaolo Bellini <iw2lsi@gmail.com> wrote:

> Hello Howard
>
> I'll suggest you to use an Advantech board... for example a PCM3362 or a
> PCM-9562... as I'm succesfully using these cards with RTAI...
>
> In these years I've test also other boards like ICOP and IEI (IEI Nova
> 9452) but falls in trouble with them... ICOP's boards are very low cost but
> seems to have a hard-coded MTBF routine that results in long latencies
> exactly every hour, IEI Nova maybe a buggy BIOS... not sure...
>
>    Best Regards,
>
>              Giampaolo
>
>
> 2012/10/26 Howard Lee Harkness <howard.lee.harkness@gmail.com>
>
>> I have a client requirement for a system that can handle hard real time
>> with precision timing, and I'm looking for recommendations for a SBC to
>> support it. Here's what is needed:
>>
>> 1) x86 architecture
>> 2) support for Linux (I will probably be using Xenomai)
>> 3) precision timer with 1 us resolution
>> 4) PC/104 bus
>> 5) lots of I/O (USB 2, I2C, SPI, GPIB, etc)
>>
>> Anybody here have any experience with a board that has all this?
>> --
>> Howard Lee Harkness
>> (214) 390-4896
>> _______________________________________________
>> Xenomai mailing list
>> Xenomai@xenomai.org
>> http://www.xenomai.org/mailman/listinfo/xenomai
>>
>
>

-- 
Howard Lee Harkness
(214) 390-4896
