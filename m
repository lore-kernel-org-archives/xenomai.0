Date: Mon, 12 Aug 2013 13:24:34 +0200
From: Richard Cochran <richardcochran@gmail.com>
Message-ID: <20130812112433.GB22099@netboy>
References: <1376258096.85759.YahooMailNeo@web171602.mail.ir2.yahoo.com>
	<20130812091316.GB11869@netboy>
	<1376303193.70876.YahooMailNeo@web171601.mail.ir2.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1376303193.70876.YahooMailNeo@web171601.mail.ir2.yahoo.com>
Subject: Re: [Xenomai] [Linuxptp-users] offset explosion and irregular phc
	offsets
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Julien Houles <jugean@yahoo.fr>
Cc: "linuxptp-users@lists.sourceforge.net" <linuxptp-users@lists.sourceforge.net>, xenomai@xenomai.org


(Adding xenomai onto CC)

On Mon, Aug 12, 2013 at 11:26:33AM +0100, Julien Houles wrote:
> Dear Richard,
> 
> Thank you very much for your answer !
> 
> 
> > Xenomai is great technology, but using it will introduce a *third*
> > clock into every host: the PHC, the Linux system clock, and the
> > Xenomai system clock. Probably you will want to directly synchronize
> > the Xenomai time with the PHC (= development effort).
> 
> I thought that the CLOCK_REALTIME argument you use with the
> clock_gettime function in phc2sys was pointing to the nucleus system
> clock thanks to the XenomaiPosix skin,

Are you compiling phc2sys with the posix skin?

That won't work, because then:

clock_gettime(CLOCK_REALTIME) - xenomai clock
clock_adjtime(CLOCK_REALTIME) - linux clock

This might explain the strange jumps that you are seeing.

> it's the same clock I use when I poll with the rtdm_clock_read
> function in my driver to send packets at the right time.

Xenomai recently added a read-only CLOCK_HOST_REALTIME for getting the
Linux system time in a Xenomai program. Remember that Xenomai
CLOCK_REALTIME and Linux CLOCK_REALTIME are separate clocks.

> > It sounds like you are using Xenomai for real time Ethernet packet
> > scheduling. An alternative solution would be to use the Intel i210
> > PCIe card. It is not expensive, and it has a special feature, namely
> > real time transmission scheduling (but you would have to write a
> > driver for this yourself). You can synchronize the i210 using PTP and
> > then transmit during a globally synchronized time slot.
> 
> Yes, an Intel engineer informed me about this new chip. But I
> couldn't find any cheap motherboard proposing several ethernet ports
> with i210 (I need at least 150 ports at a very low price !). And I
> don't want to introduce additionnal traffic to the ports I use for
> data transfer, I would like to reproduce the exact traffic the
> camera would generate. It's very difficult to find out documentation
> about AVB, therefore I didn't really understand how it works.

You can download the AVB standard for free from the IEEE website.

> > This chain will not work very well. The multi-port nodes (like board 2)
> > do not have their port clocks synchronized. I guess that using phc2sys
> > to synchronize them with introduce several hundred nanoseconds time
> > error per node. For good chaining performance, you really want to have
> > the PHC clocks synchronized in hardware.
> 
> Thank you for this information. But it seems to work with the three
> boards I have (am I mistaken ?). The offsets I get with phc2sys
> applied to the 2 ports clocks are very low ~ a few tens nanoseconds
> and it's the same for the ptp clock of board 3 (event better if I
> increase the pch2sys frequency on board 2). But It probably won't be
> the same with 50 boards...

This is only the apparent offset within the ptp4l program. The actual
offset is unknown to the program, but you can measure it using a PPS,
for example (but your hardware doesn't have this).

> > You might be able to break your network into ten chains of five,
> > connected by a 16 port transparent switch, for example.
> 
> Yes. 
> 
> > Have you looked at the white rabbit project?
> 
> Yes. White Rabbit is a competitor for the inter-telescopes
> synchronization in my project. But as I need a low cost architecture
> for a simulator which will have a short living time, I can't use
> White Rabbit.
> 
> 
> > > Could we use a mechanism built on a ethernet hub or switch (regular switch,
> > > not a IEEE1588 one because too expensive)? We’ll only use these links for
> > > a synchronization purpose. Can we expect a constant delay with a store and
> > > forward switch? Or should we use a hub?
> 
> > You can try a normal switch, but they will introduce variable packet
> > delays. I have read about using a managed switch with prioritized PTP
> > queues instead of a PTP switch.  However, I expect that you will need
> > special PTP hardware in order to meet your requirements.
> 
> In my idea, I would like to use an ethernet HUB (not a switch). As
> the delay between master and slaves will remain constant, in a first
> phase I would evaluate it for each port and memorize it. In a second
> phase, as the communication would only go from the master to the
> slaves, the master would only send Sync and follow up messages. It
> would be easy to synchronize the slaves (no other data transmission
> on the synchronization links) to the master. Do you think it's
> possible (modifying code doesn't frighten me) ?

Sounds like it is worth a try.

> And I still have the two problems I talked about in my last message :
> 
> - after a certain amount of time, the offset I get with ptp4l or
>   phc2sys (in a regular use of them with only two boards) increases
>   suddenly to very high values (tipically 69950604426874)
> - when I start to use phc2sys with a new board (just to synchronize
>   the CLOCK_REATIME to a ptp clock), offsets have an order of
>   several microseconds and suddenly, they decrease (it can happen
>   after hours to days) to a few nanoseconds and remain good even
>   after several reboots...
> Did you ever faced such problems or is it inherent to the use of Xenomai with ptp ?

I bet this is related to using Xenomai. Even assuming phc2sys is using
the correct clocks, there is a soft real time aspect to measuring the
clock offsets. Either we use a PPS interrupt in the Linux domain from
MAC to host, or we just read the two clocks in alternately. In both
cases, Xenomai can introduce extra latencies that will spoil these
measurements. Please try your setup as a normal Linux system.

If you want to use PTP time in a Xenomai application, it can be done,
but you will have to pay attention to some details. If I were doing
this, I would probably expand the PHC driver to be a RTDM driver, in
order to operate the clock (get, set, and adjust) from a real time
task.

Thanks,
Richard

