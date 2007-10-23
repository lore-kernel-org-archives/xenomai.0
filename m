Message-ID: <471DF78D.6040405@domain.hid>
Date: Tue, 23 Oct 2007 15:30:53 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: Roland Tollenaar <rwatollenaar@domain.hid>
Subject: [Xenomai-help] rtcan bit of help
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

new machine, new chances. rtnet running only the peak_dongle to get into
action. But this is giving some problems.

First the BIOS setup. Must set LPT1 to EPP mode but I only have the
following options:
	1-EPP+ECP
	2-Bi-Directional
	3-One directional

Only 2 allows me to load the driver without getting the message that the
device does not exist. So Bi-Directional = EPP?

There is one other setting in the BIOS (that I have found) which may
affect this which is the address and IRQ and DMA line.
The options are a whole lot of things but I have chosen
0x378 and IRQ 7. No DMA line

I mention this because I can select the same address with DMA 1 or DMA 2
but I have chosen the one with no direct memory access.

Once the driver is loaded, there is no adverse message in the system log
that I can see. dmesg report rtcan2 loaded.

I get flooding of the read buffer when I run my application. I can see
this in dmesg.

Is there something obviously wrong with my BIOS choice? If not what can
I check.

I have done some other tests but to prevent this email becoming too
long, especially if the problem is obviously BIOS related i refrain from
mentioning the outcome.


Kind regards,

Roland


