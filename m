Message-ID: <45F3CD2C.5000400@domain.hid>
Date: Sun, 11 Mar 2007 10:34:36 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] your pending RT-Socket-CAN problems (was rtcan
	driver. rtcan_sja_interrupt made interruptible)
References: <45F2B8BB.6060804@domain.hid> <45F2DE0A.1010207@domain.hid>
	<bc4264770703110035g6625e8a1t4f195507d72aaf66@domain.hid>
In-Reply-To: <bc4264770703110035g6625e8a1t4f195507d72aaf66@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: roland Tollenaar <rolandtollenaar@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Hi Roland,

in the meantime I browsed the interesting threads and I think I 
understood the problem with the PCAN dongle.

roland Tollenaar wrote:
> Hi Wolfgang,
> 
> 
> Just to bring you up to speed. You can skip most of the discussion.
> The problem is that the rtcan driver is breaking up the RT performance
> as soon as there are incoming messages on the bus. My rt task period
> times start to shift from the steady 1 repspectively 2 ms with
> latencies ranging between 20 and 40 micorseconds to latencies of about
> 200 microseconds when messages come in on the bus.
> 
> The problem we are all convinced is fairly certainly in the duration
> that it takes the interrupt handler rtcan_sja_interrupt to process the
> reading out of the messages and sending it to the socket.
> 
> The general consensus is that the hardware is slow i.e. parallel port.
> Some rule-of-thumb calculations confirm the 200 microseconds.
> Apparently PCI would be faster but even if it is 50% faster its still
> not really worth using. I cannot use the driver like this.

Access to the parallel port is slow, indeed. Looking to 
rtcan_peak_dng_epp_readreg tells me, that 6 inb/outb are required to 
read one register and if every inb/outb takes up 1-2 us ... puh ... the 
problem gets obvious. Nevertheless, this problem is special for the PCAN 
dongle and it seems to be a bad choice for RT-Socket-CAN. All other 
devices can read/write registers much faster. I'm going to do some more 
tests next week, also with other CAN hardware. Sebastian, have you 
realized similar latency problems with SJA1000 on the ISA bus (which is 
slow as well)?

> Don't stress I will circumvent the problem even if it means discarding
> CAN and using some other bus. So I am not really worried.

The question is how we can help you quickly.

> Taking the slow hardware as a given the only elegant solution IMHO is
> letting the Rx-ISR be interruptible by the rt-tasks so that those can
> at least complete their work and cycle with reasonable latency (50
> microseconds max, 25microsecond average)
> 
> Sebastian's opinion is that making it interruptible would be "the
> start of chaos". I am sure he knows more about this than I ever will
> but only out of academic interest before I sort this problem out
> outside the realm of rtcan, I would like to know why.

As I see it, the right solution would be to handle the CAN interrupts by 
a service task and disabled the corresponding IRQ till it's handled. I 
do not see a real problem with this method, but it requires substantial 
implementation effort. I think threaded IRQs are on Jan's to-do list for 
RTDM as well, but they will also not be available soon. And if the 
problem is just relevant for the parallel port, it might not be worth 
the effort.

> That is all there is to it at the moment.

OK, what other CAN hardware would be an option for you. Do you have PCI 
on your board?

> Hopefully below email will make more sense to you now.

It does, thanks for pointing us to the problem. So far I was not aware 
of it and I'm curious, how much the latency will be affected on my 
Laptop and PC.

Wolfgang.

> Regards,
> 
> Roland.
> 
> 
> 
> 
> 
> 
> 
> 
> On 3/10/07, Wolfgang Grandegger <wg@domain.hid> wrote:
>> Hi Roland,
>>
>> hope most of your problems and questions with RT-Socket-CAN have already
>> been solved or answered. I will not have the time to read carefully all
>> your mails accumulated over the last week, sorry, it's too much traffic.
>> Could you please briefly summarize the pending issues.
>>
>> Thanks,
>>
>> Wolfgang.
>>
>> Roland Tollenaar wrote:
>> > Hi,
>> >
>> > The following probably relates to the functioning of the sja1000 
>> chip. I
>> > cannot see how it can NOT be possible for the chip to function properly
>> > without also having the ability to be read by a fully interruptible 
>> ISR.
>> >
>> > Could below just be clarified for me please?
>> >
>> > When the 14 registers of the sja1000 chip are being read, I presume 
>> this
>> > is a single CAN frame that is being recovered which will 
>> subsequently be
>> > written to the message buffer of the sockets currently connected to the
>> > device. I also presume that while the registers are being read new
>> > incoming messages from the Bus will not be written into these registers
>> > because this would possibly corrupt the frame that is currently being
>> > extracted from the registers. i.e. if the ISR has read 7 of the 14
>> > messages and a new message is now written into the registers the
>> > resulting frame will be a mixture of two distinct received messages. To
>> > prevent that happening I presume it must be possible to lock the
>> > registers while the Rx-ISR is busy doing its reading of the 14
>> > registers? Messages that arrive on the bus while the Rx-ISR is locking
>> > the 14 registers will then either be discarded or sent again by the 
>> node
>> > as a result of the sending node not receiving an acknowledge message?
>> >
>> > The point of the above questions being that if it is possible to lock
>> > the 14 registers there is no reason in my humble opinion (IMHO) that 
>> the
>> > the Rx-ISR cannot be interrupted. Correct? Of course one wants to
>> > minimize the delay to optimize bus traffic but such behaviour would
>> > certainly improve Real-Time capabilities.
>> >
>> > If the non-real-time driver functions as described above (locks the 14
>> > registers and allows itself to be interrupted) it will be better for me
>> > to use the non-real-time driver in a stand-alone non-real-time
>> > application which reads the CAN bus and presents the data it 
>> receives to
>> > the real-time application (or any other application for that matter) 
>> via
>> > a mechanism of choice. E.g. in a file on RAM-Disk, a pipe etc. In short
>> > this would be a CAN-server which, since it is a fully interruptible
>> > normal process will allow my real-time applications to tick away
>> > undisturbed.
>> >
>> > Is the reasoning incorrect?
>> >
>> >
>> > Having written the above I have just downloaded the datasheet of the
>> > SJA1000 and it seems to confirm my above conjecture. Firstly there are
>> > 64 bytes of FIFO receive buffer 13 of which are presented as a window
>> > and are probably the ones referred to by Sebastian as the ones the ISR
>> > reads out. This means that while reading out the window messages will
>> > not get lost immediately.
>> >
>> > Then on page 10 with a more detailed explanation on page 14 they talk
>> > about a command register with a bit switch called the Release receive
>> > Buffer (RRB) which seems to have the function of the lock I was talking
>> > about.
>> >
>> > Can you more knowledgeable people comment on this. It the above is
>> > correct it could enormously improve the applicability of the driver for
>> >  Real-Time control. Which I presume the driver is all about?
>> >
>> >
>> > Regards,
>> >
>> > Roland.
>> >
>> >
>> > _______________________________________________
>> > Xenomai-help mailing list
>> > Xenomai-help@domain.hid
>> > https://mail.gna.org/listinfo/xenomai-help
>> >
>> >
>>
>>
> 
> 


