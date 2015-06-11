Message-ID: <b692bb78ab6f887dfd41f71655a0a205.squirrel@sourcetrek.com>
In-Reply-To: <79A9E4882C44D44FA53B5AB15E6198011385C369@ADEERL01SMS001.cznet.zeiss.org>
References: <79A9E4882C44D44FA53B5AB15E6198011385C369@ADEERL01SMS001.cznet.zeiss.org>
Date: Thu, 11 Jun 2015 14:00:40 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] init failed code -19 on Cyclone V SoC
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Lopes, Alexandre" <alexandre.lopes.ext@zeiss.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>


Lopes, Alexandre wrote:
> Hello,
>
> I am trying to get Xenomai 3.0 rc4 with the 3.18.12 Linux Kernel and the
> corresponding ipipe patch to work on an ARM SoC.
> The device in question is a MitySoM module which is based on the Cyclone V
> from Altera and contains a dual core ARM Cortex A9.
>
> I have followed the "Porting Xenomai dual kernel to a new ARM SoC"
> guide. Even though Linux boots without any  problems, Xenomai is not
> working.
>
> The output of dmesg | grep -E 'Xenomai|I-pipe' is the following:
>
> [    0.000000] I-pipe, 200.000 MHz timer
> [    0.123073] I-pipe, 200.000 MHz timer
> [    0.249682] [Xenomai] scheduling class idle registered.
> [    0.249689] [Xenomai] scheduling class rt registered.
> [    0.249758] I-pipe: high-resolution clock not working
> [    0.249789] [Xenomai] init failed, code -19
>
> Which seems to indicate a problem with the timer.

Nope. clock != timer.

On Cortex A9, the hardware timer used as clock is the "global timer"
normally. So, with recent kernels, you need the proper data in the device
tree, and to enable the device in the kernel configuration. Look at what
the I-pipe patch does for OMAP4 and IMX-6.

Alternatively, if the SOC you use proposes another hardware timer that can
be used as clocksource, you can use that as clock for Xenomai too.

In the porting guide, the clock is called a "high-resolution counter",
simply follow the instructions for the "not cortex A9" case, if you do
not want to use the I-pipe cortex A9 default clocksource.

-- 
                    Gilles.


