Date: Wed, 27 Jan 2016 23:25:21 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160127222521.GD3685@hermes.click-hack.org>
References: <56A5761B.70501@grom.net>
 <CA+CJOCykM6VeHwyRtjwVC9H+RZw--=qTySzCv8bBXdJU1PHbpQ@mail.gmail.com>
 <trinity-bd1a5d81-52a6-42b4-b2f3-5dcc1648aa1b-1453929363385@3capp-gmx-bs50>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <trinity-bd1a5d81-52a6-42b4-b2f3-5dcc1648aa1b-1453929363385@3capp-gmx-bs50>
Subject: Re: [Xenomai] Xenomai build for Raspberry Pi
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Marcel Vornholt <Marcel.Vornholt@gmx.net>
Cc: xenomai@xenomai.org

On Wed, Jan 27, 2016 at 10:16:03PM +0100, Marcel Vornholt wrote:
>    Hi,
>    I have got a problem with the patch that Mathieu Rondonneau wrote two
>    months ago.
>    So first to the Situation and sorry for my bad english but I hope you
>    can help me.
>    I've got a RPI2 and want to build a kernel with xenomai. So I
>    downloaded the "rpi-3.18.y" kernel, and xenomai 3.0.
>    After a lot of time where i tryed to build the kernel without the Patch
>    from Mathieu i was really desperated.
>    So yesterday i found the patch and first thank you that some one had
>    time for that ;)
>    First I prepared the Cobal Kernel with the
>    ipipe-core-3.18.20-arm-6.patch
>    But when I try to use the patch i get the error:
>       ~/Rasp/linux-rpi-3.18.y $ patch -p1 <
>    rpi-ipipe-core-3.18-arm-1.patch
>       (Stripping trailing CRs from patch; use --binary to disable.)
>       patching file arch/arm/Kconfig
>       (Stripping trailing CRs from patch; use --binary to disable.)
>       patching file arch/arm/mach-bcm2709/armctrl.c
>       (Stripping trailing CRs from patch; use --binary to disable.)
>       patching file arch/arm/mach-bcm2709/bcm2708_gpio.c
>       Hunk #3 succeeded at 295 with fuzz 2 (offset -1 lines).
>       (Stripping trailing CRs from patch; use --binary to disable.)
>       patching file arch/arm/mach-bcm2709/bcm2709.c
>       (Stripping trailing CRs from patch; use --binary to disable.)
>       patching file arch/arm/mach-bcm2709/include/mach/entry-macro.S
>       patch unexpectedly ends in middle of line
> 
>    So what can I do against it?
>    Or was it wrong that I prepared the Cobalt Kernel first?
> 
>    I hope that I used the mailing list right and have a nice evening

As the error messages say, your patch is borked, doubly so even:
- it probably has been downloaded with a machine which added ms-dos
line breaks;
- additional line breaks have probably been added by whatever
software you used to retrieve the patch.

The only fix is to get a proper patch.

-- 
					    Gilles.
https://click-hack.org

