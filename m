Message-ID: <4715FE93.6010406@domain.hid>
Date: Wed, 17 Oct 2007 14:22:43 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <47151926.8060806@domain.hid>
In-Reply-To: <47151926.8060806@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] RTCAN halfsize PC, PCI backplane,
 parallel port and...
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
> Firstly RTCAN has been functioning perfectly over the parallel port of a 
> number of machines I have run it on. At the moment I am testing a 
> halfsize PC with PCI backplane which has a parallel port linked from a 
> COM port adapter as PCI card. Bios set to EPP mode irq 7 and address 
> 0x378. The standard.
> 
> On calling modprobe xeno_can_peak_dng.ko type=epp io=0x378 irq=7 the 
> result is
> 
> FATAL: Error inserting xeno_can_peak_dng: No such device.

Does "dmesg" reveal other related error messages when you load the module?

Wolfgang.


