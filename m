From: Sebastian Smolorz <ssm@domain.hid>
Subject: Re: [Xenomai-help] RTCAN and tsc
Date: Thu, 8 Mar 2007 15:12:38 +0100
References: <bc4264770703060706x5dafb942weec4d4c2c5756427@domain.hid>
	<E1HOs43-0008OG-Ki@domain.hid> <45EFFE22.9060401@domain.hid>
In-Reply-To: <45EFFE22.9060401@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <E1HPJMF-0008IL-F2@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rolandtollenaar@domain.hid
Cc: xenomai@xenomai.org

Roland Tollenaar wrote:
> Hi
>
> >> What does this mean? This is as good as it gets?
> >
> > Hm. To be more verbose on what happens between the beginning of
> > rtcan_sja_interrupt and rtcan_rcv please remove the "inline" from the
> > functions rtcan_sja_err_interrupt in the file
> > ksrc/drivers/can/sja1000/rtcan_sja1000.c line 156 and from the function
> > rtcan_sja_rx_interrupt in the same file in line 87. Compile your
> > modules/kernel again and repeat the tracer/latency test.
> >
> > I assume that most of the time is spent in the latter function where
> > several SJA HW regs are read out. A slow access to the regs could be the
> > explanation for the long time the interrupt handler has to spend.
>
> Where are the registers located? On the dongle or are these in the PC?

These are registers located in the SJA1000 CAN controller.

> Just to know whether there might not be a problem with the PEAK device.
> Is there any way you could check what the access times are to
> rtcan_sja_interrupt on your systems when performing the same experiment
> and recieving messages (pref PDO with length 8) over the bus?

Unfortunately, I do not have the opportunity to perform tests with the driver 
ATM.

>
> I am developing on a pretty high-end machine here,

Didn't you speak of 486's in a previous mail?

> in fact every aspect 
> almost as fast as is on the market at the moment so its would surprise
> me if there is a hardware shortcoming if the registers you speak of are
> on the PC.
>
> In the mean time I will try doing as you suggest, I presume you want me
> to send the frozen trace to you again after that.

Exactly.

> Is it worth while removing the virtual driver from the kernel build and
> running over rtcan0.

Turn it off although it is unlikely that it has something to do with the 
problem. But you never know.

> Is there any chance that you have never encountered 
> this problem

I never worked with the virtual device.

-- 
Sebastian

