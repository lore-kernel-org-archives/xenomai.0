Message-ID: <471DFCC3.8020304@domain.hid>
Date: Tue, 23 Oct 2007 15:53:07 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <471DF78D.6040405@domain.hid>
In-Reply-To: <471DF78D.6040405@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rtcan bit of help
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
Cc: Xenomai-help@domain.hid

Roland Tollenaar wrote:
> Hi,
> 
> new machine, new chances. rtnet running only the peak_dongle to get into
> action. But this is giving some problems.
> 
> First the BIOS setup. Must set LPT1 to EPP mode but I only have the
> following options:
> 	1-EPP+ECP
> 	2-Bi-Directional
> 	3-One directional
> 
> Only 2 allows me to load the driver without getting the message that the
> device does not exist. So Bi-Directional = EPP?
> 
> There is one other setting in the BIOS (that I have found) which may
> affect this which is the address and IRQ and DMA line.
> The options are a whole lot of things but I have chosen
> 0x378 and IRQ 7. No DMA line
> 
> I mention this because I can select the same address with DMA 1 or DMA 2
> but I have chosen the one with no direct memory access.
> 
> Once the driver is loaded, there is no adverse message in the system log
> that I can see. dmesg report rtcan2 loaded.

This means, that at least the first register accesses worked.

> I get flooding of the read buffer when I run my application. I can see
> this in dmesg.

Do you see interrupts with /proc/xenomai/irq.

> Is there something obviously wrong with my BIOS choice? If not what can
> I check.

Don't know he magics of the BIOS and the parallel port setupo, sorry,

> I have done some other tests but to prevent this email becoming too
> long, especially if the problem is obviously BIOS related i refrain from
> mentioning the outcome.

Do you see errors listed by /proc/rtcan/sockets or /proc/rtcan/devices?

Wolfgang.


