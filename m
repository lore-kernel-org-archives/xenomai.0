From: Paul <paul_c@domain.hid>
Date: Mon, 19 Nov 2007 17:20:23 +0000
References: <4b7912400711172140p3e5e04feiacd53b66669942bb@domain.hid>
	<4b7912400711172205s2c086e8dp4f228fdf70f0cd1d@domain.hid>
	<4741B106.2070709@domain.hid>
In-Reply-To: <4741B106.2070709@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200711191720.23430.paul_c@domain.hid>
Subject: Re: [Xenomai-help] problem of xeno_hal
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

On Monday 19 November 2007 15:51, Jan Kiszka wrote:
> zhangwei zhang wrote:
> > Hello, I have some problem of instalingl xenomai on ppc. I use the
> > linux-2.6.19 and xenomai-2.3.4, I want to get the xeno_hal.ko for emc
> > porting. But it seems that it can be only compiled in to the
> > kernel,not as module. What can I do to implement it?
>
> Do you happen to confuse the EMC HAL with that hal, Xenomai provides?
> Both target different purposes and abstraction levels.

Or perhaps the rtai_hal module ?

>
> Maybe Paul can comment on the requirements of an EMC2(?) port over
> Xenomai as he already worked in this domain.

Not with emc2 - Most of my comments regarding the code base & implementation 
are far from complementary. I'll leave the code to speak for it's self...
There is one nice tool in there - the scope, but <snip>...

 Performance is pretty poor on anything less than an 800MHz i586, so I suspect 
a ppc platform would really struggle even if you could offload the GUI on to 
a remote host... That is assuming you can find a suitable math library to use 
in kernel space.

My efforts with Xenomai/EMC were based on sources derived from the original 
NIST code, and running entirely in user space. 
http://www.tuxcnc.org/pivot/entry.php?id=16 gives an overview.
Having demonstrated the viability, we are now forging ahead with a new code 
base.


Regards, Paul.


