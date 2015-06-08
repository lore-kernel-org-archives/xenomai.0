From: Paul <paul_c@tuxcnc.org>
Date: Mon, 8 Jun 2015 12:11:15 +0100
References: <DUB121-W42B693A503D6EC1D2F144381BF0@phx.gbl>
In-Reply-To: <DUB121-W42B693A503D6EC1D2F144381BF0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201506081211.15597.paul_c@tuxcnc.org>
Subject: Re: [Xenomai] Raspberry Pi 2 patch - BCM2709
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Monday 08 June 2015, mobin Motallebizadeh wrote:
> HiCan anybody provide some information about making a patch for
> Raspberry Pi 2 ?The patches :
> xenomai-2.6.4/ksrc/arch/arm/patches/raspberryand the both `pre` and
> `post` patch need some changes to be applicable for rpi2 and 3.18
> kernel.Specially in :
> https://github.com/raspberrypi/linux/blob/rpi-3.18.y/arch/arm/mach-bc
>m2709/bcm2708_gpio.c Thanx in advance


There are two separate development paths for the Raspberry kernel.

1) The "official" Raspberry Pi Foundation (RPF) work which is found 
under mach-bcm2708 - This is what is targeted by the pre/post patches 
you refer to. 

2) The "official" Linux support is to be found in the mach-bcm2709 tree. 
This is still "work in progress", but looks to be at the stage where it 
is usable - I've not been following developments too closely, is it in 
the mainline kernel yet ?


If the RPF kernel runs on the RPi2 board, it wouldn't take much to 
update the pre/post patches to 3.18.

