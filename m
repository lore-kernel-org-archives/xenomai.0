Message-ID: <bc4264770703110402x55f7b13chca39ed02f983feac@domain.hid>
Date: Sun, 11 Mar 2007 11:02:33 +0000
From: "roland Tollenaar" <rolandtollenaar@domain.hid>
Subject: Re: [Xenomai-help] your pending RT-Socket-CAN problems (was rtcan
	driver. rtcan_sja_interrupt made interruptible)
In-Reply-To: <45F3CD2C.5000400@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45F2B8BB.6060804@domain.hid> <45F2DE0A.1010207@domain.hid>
	<bc4264770703110035g6625e8a1t4f195507d72aaf66@domain.hid>
	<45F3CD2C.5000400@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

>
> Access to the parallel port is slow, indeed. Looking to
> rtcan_peak_dng_epp_readreg tells me, that 6 inb/outb are required to
> read one register and if every inb/outb takes up 1-2 us ... puh ... the
> problem gets obvious. Nevertheless, this problem is special for the PCAN
> dongle and it seems to be a bad choice for RT-Socket-CAN.
That may be. I was not aware of this beforehand and on my laptop its
all I have besides USB and PCMCIA which are not supported RT. Besides,
if we look at this fundamentally the PCAN dongle is not TOO slow. 200
micoseconds leaves me 800 ms in a 1ms task to do work. That should be
ample. So the problem (in my case) lies more in the behavior of the
ISR, the fact that it reacts to all Rx interrupts and rigorously
blocks all other processes. If you consider how the structure i
suggested earlier with a non-real-time CAN-service utilizing a driver
with interruptible Rx-ISR could be used to sort out my problem the
fact that the slowness of the hardware is not -as such- the constraint
becomes evident. Of course I agree that if hardware is used that would
provide 20 us reading time the problem would be less visible. But for
someone who is interested in a 200us task-time that may be a problem
again so such a person or project would then also benefit from an
interruptible Rx-ISR. Which again emphasizes my feeling that faster
hardware diminishes the symptoms of the problem, not really the
problem.

All other
> devices can read/write registers much faster. I'm going to do some more
> tests next week, also with other CAN hardware. Sebastian, have you
> realized similar latency problems with SJA1000 on the ISA bus (which is
> slow as well)?
>
> > Don't stress I will circumvent the problem even if it means discarding
> > CAN and using some other bus. So I am not really worried.
>
> The question is how we can help you quickly.

Thanks.

>
> > Taking the slow hardware as a given the only elegant solution IMHO is
> > letting the Rx-ISR be interruptible by the rt-tasks so that those can
> > at least complete their work and cycle with reasonable latency (50
> > microseconds max, 25microsecond average)
> >
> > Sebastian's opinion is that making it interruptible would be "the
> > start of chaos". I am sure he knows more about this than I ever will
> > but only out of academic interest before I sort this problem out
> > outside the realm of rtcan, I would like to know why.
>
> As I see it, the right solution would be to handle the CAN interrupts by
> a service task and disabled the corresponding IRQ till it's handled.
Agreed.

I
> do not see a real problem with this method, but it requires substantial
> implementation effort. I think threaded IRQs are on Jan's to-do list for
> RTDM as well, but they will also not be available soon.
I fully understand. Not the part about a "threaded IRQ" though. What
does that entail exactly?

> And if the
> problem is just relevant for the parallel port, it might not be worth
> the effort.
This is for you people to say. I on the other hand get the impression
that this touches a defining issue of real-time drivers. Earlier I
posted the question of what distinguishes a "real-time" driver from a
normal device driver. The answer if i understood correctly was related
to the inability of the RT driver to be interrupted by any old non-rt
process which would render any rt-task to be non-rt. If on the other
hand the rt-driver is a rigid block that can not even be interrupted
by the rt-task itself AND the rt-driver responds to external IRQ
signals at its own discretion, well IMHO the rt-task is broken. Using
my case as an example, what we have is a situation where the CAN-bus
dictates what the CPU must pay attention to instead of the rt-task
being dominant in that respect.

Don't get me wrong, the above is not intended to convince you or
anyone else to sort out this issue in the driver. Its just a point of
view that I have and am interested in the opinions about. I will
settle for solving the problem with faster hardware with no second
thoughts. I do have two concerns on this I will mention later.


> OK, what other CAN hardware would be an option for you. Do you have PCI
> on your board?
If you discover that Peak PCI boards have acceptable impact on the
latency then I will continue to develop with the dongle on my laptop
but use PCI when I finally reach implementation for production stage.

>
> > Hopefully below email will make more sense to you now.
>
> It does, thanks for pointing us to the problem. So far I was not aware
> of it and I'm curious, how much the latency will be affected on my
> Laptop and PC.
If you don't experience the problem,  tell me what laptop you are
using. I am always on the lookout for a good excuse to get a new one.
:)

I mentioned earlier that I would revert to two concerns regarding the
faster hardware.

The first concern is that it was mentioned in one of the threads that
the clock rate of the sja1000 is rather low and reading out the sja
registers is not a fast exercise. If that is the case then a faster
interface (PCI) might not help all that much to suppress the symptoms.

The second concern is that even if I have a faster interface even if
it is substantially faster (added latency < 20 us) I still have a
potential problem. Consider the case where I have a few nodes on the
bus. Most of them are relatively quiet, one of them sends a position
every 1ms and everything is running fine. Now suddenly some nodes post
an exception of some sort (emergency something or other and send a
host of messages). With the current driver design, the driver will
respond to all the Rx interrupts and be so busy reading the messages
and posting them to the sockets that the control tasks will have no
time to a) handle the exception quickly and b) get through
position-control calculations on time.
The net effect could be that the machine responds to the exception
badly, closes down too late and the feedback control goes off-kilter
crashing the physical process. To exclude the possibility of a broken
machine i would need to get control over the send behavior of the
nodes in every possible exception to ensure that the bus never gets
too busy etc etc.

So I really feel your suggestion of working with an (interruptible)
service-task and blocking IRQ's is a better approach.

Regards,

Roland.


>
> Wolfgang.
>
> > Regards,
> >
> > Roland.
> >
> >
> >
> >
> >
> >
> >
> >
> > On 3/10/07, Wolfgang Grandegger <wg@domain.hid> wrote:
> >> Hi Roland,
> >>
> >> hope most of your problems and questions with RT-Socket-CAN have already
> >> been solved or answered. I will not have the time to read carefully all
> >> your mails accumulated over the last week, sorry, it's too much traffic.
> >> Could you please briefly summarize the pending issues.
> >>
> >> Thanks,
> >>
> >> Wolfgang.
> >>
> >> Roland Tollenaar wrote:
> >> > Hi,
> >> >
> >> > The following probably relates to the functioning of the sja1000
> >> chip. I
> >> > cannot see how it can NOT be possible for the chip to function properly
> >> > without also having the ability to be read by a fully interruptible
> >> ISR.
> >> >
> >> > Could below just be clarified for me please?
> >> >
> >> > When the 14 registers of the sja1000 chip are being read, I presume
> >> this
> >> > is a single CAN frame that is being recovered which will
> >> subsequently be
> >> > written to the message buffer of the sockets currently connected to the
> >> > device. I also presume that while the registers are being read new
> >> > incoming messages from the Bus will not be written into these registers
> >> > because this would possibly corrupt the frame that is currently being
> >> > extracted from the registers. i.e. if the ISR has read 7 of the 14
> >> > messages and a new message is now written into the registers the
> >> > resulting frame will be a mixture of two distinct received messages. To
> >> > prevent that happening I presume it must be possible to lock the
> >> > registers while the Rx-ISR is busy doing its reading of the 14
> >> > registers? Messages that arrive on the bus while the Rx-ISR is locking
> >> > the 14 registers will then either be discarded or sent again by the
> >> node
> >> > as a result of the sending node not receiving an acknowledge message?
> >> >
> >> > The point of the above questions being that if it is possible to lock
> >> > the 14 registers there is no reason in my humble opinion (IMHO) that
> >> the
> >> > the Rx-ISR cannot be interrupted. Correct? Of course one wants to
> >> > minimize the delay to optimize bus traffic but such behaviour would
> >> > certainly improve Real-Time capabilities.
> >> >
> >> > If the non-real-time driver functions as described above (locks the 14
> >> > registers and allows itself to be interrupted) it will be better for me
> >> > to use the non-real-time driver in a stand-alone non-real-time
> >> > application which reads the CAN bus and presents the data it
> >> receives to
> >> > the real-time application (or any other application for that matter)
> >> via
> >> > a mechanism of choice. E.g. in a file on RAM-Disk, a pipe etc. In short
> >> > this would be a CAN-server which, since it is a fully interruptible
> >> > normal process will allow my real-time applications to tick away
> >> > undisturbed.
> >> >
> >> > Is the reasoning incorrect?
> >> >
> >> >
> >> > Having written the above I have just downloaded the datasheet of the
> >> > SJA1000 and it seems to confirm my above conjecture. Firstly there are
> >> > 64 bytes of FIFO receive buffer 13 of which are presented as a window
> >> > and are probably the ones referred to by Sebastian as the ones the ISR
> >> > reads out. This means that while reading out the window messages will
> >> > not get lost immediately.
> >> >
> >> > Then on page 10 with a more detailed explanation on page 14 they talk
> >> > about a command register with a bit switch called the Release receive
> >> > Buffer (RRB) which seems to have the function of the lock I was talking
> >> > about.
> >> >
> >> > Can you more knowledgeable people comment on this. It the above is
> >> > correct it could enormously improve the applicability of the driver for
> >> >  Real-Time control. Which I presume the driver is all about?
> >> >
> >> >
> >> > Regards,
> >> >
> >> > Roland.
> >> >
> >> >
> >> > _______________________________________________
> >> > Xenomai-help mailing list
> >> > Xenomai-help@domain.hid
> >> > https://mail.gna.org/listinfo/xenomai-help
> >> >
> >> >
> >>
> >>
> >
> >
>
>

