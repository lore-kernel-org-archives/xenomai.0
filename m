Message-ID: <47151926.8060806@domain.hid>
Date: Tue, 16 Oct 2007 22:03:50 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: Roland Tollenaar <rwatollenaar@domain.hid>
Subject: [Xenomai-help] RTCAN halfsize PC, PCI backplane,
	parallel port and...
Reply-To: rolandtollenaar@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai-help@domain.hid

Hi,

Firstly RTCAN has been functioning perfectly over the parallel port of a 
number of machines I have run it on. At the moment I am testing a 
halfsize PC with PCI backplane which has a parallel port linked from a 
COM port adapter as PCI card. Bios set to EPP mode irq 7 and address 
0x378. The standard.

On calling modprobe xeno_can_peak_dng.ko type=epp io=0x378 irq=7 the 
result is

FATAL: Error inserting xeno_can_peak_dng: No such device.

Since I call this with a script I use on all other machines I am surely 
not doing something wrong. Before I start hollering at the vendor about 
his LPT card, is there a problem from the driver's point of view working 
with an LPT port over PCI?

Yes yes, the next step WILL be to use the peak PCI card.

Kind regards,

Roland

