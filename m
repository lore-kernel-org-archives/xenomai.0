Message-ID: <305035a40704110221u348611ebs8fb73b7ddb0f8bd3@domain.hid>
Date: Wed, 11 Apr 2007 11:21:25 +0200
From: "Gregory CLEMENT" <gclement00@domain.hid>
In-Reply-To: <461CA604.4050809@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <305035a40704100947n5d426f9ahf8608957a2264f2f@domain.hid>
	<461BC626.3070403@domain.hid>
	<305035a40704110201i1ea65f11j162eecc46858f5ca@domain.hid>
	<461CA604.4050809@domain.hid>
Subject: Re: [Adeos-main] AT91SAM9261 adeos support for 2.6.19 kernel
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: BOUIN Alexandre <abouin@domain.hid>, adeos-main@gna.org

2007/4/11, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
> Gregory CLEMENT wrote:
> > 2007/4/10, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
> >
> >>Gregory CLEMENT wrote:
> >>
> >>>Hello,
> >>>
> >>>We port the adeos-ipipe-2.6.19-arm-1.6-05.patch for AT91SAM9261.
> >>>
> >>>This patch must be applied on vanilla 2.6.19 with at91 patch (
> >>>http://maxim.org.za/AT91RM9200/2.6/2.6.19-at91.patch.gz ) applied for
> >>>supporting AT91SAM9261.
> >>>So first get vanilla kernel, then apply at91 patch then apply our
> >>>patch instead of adeos-ipipe-2.6.19-arm-1.6-05.patch.
> >>>
> >>>For now it works with Xenomai on AT91SAM9261-EK, if someone is
> >>>intersting we can send the benchmark result.
> >>>As AT91SAM926x are pretty similar of AT91RM9200, there is a some
> >>>duplicate code and some common code.
> >>>In the future it could be also work on all AT91SAM926x, we can test
> >>>it. But before going ahead we would like some comment on this patch.
> >>>
> >>>The better would be working on 2.6.20 which already have support for
> >>>AT91SAM926x, but we didn't see any arm patch on this kernel nor any
> >>>file modified on git.
> >>>
> >>>Hope this patch will be usefull.
> >>
> >>It looks good. I will try and port the I-pipe patch for ARM to Linux
> >>2.6.20. In the meantime, could you separate the AT91SAM9261 specific
> >>code and the changes (if any) made to the rest of the I-pipe from the
> >>rest of the I-pipe ? This would ease distribution and maintenance.
> >
> >
> > OK I made a diff between our patch and
> > adeos-ipipe-2.6.19-arm-1.6-05.patch. I had to reworked our patch for
> > removing fake difference.
> > As you will see there is not many difference between the 2 patchs and
> > we don't modify the rest of I-pipe.
> > There is also difference due to the fact that we made our patch on a
> > kernel patched with at91 whereas adeos patch was made on vanilla
> > kernel.
> >
> > As this diff file isn't really readeable, I can say that the main file
> > we modified are:
> > * arch/arm/mach-at91rm9200/Kconfig
> > -> here we add support for AT91SAM9261
> >
> > * arch/arm/mach-at91rm9200/at91sam9261.c
> > -> here we add support for TCB0 and modify interrupt priority in the
> > same way of AT91RM9200
> >
> > * arch/arm/mach-at91rm9200/at91sam926x_time.c
> > -> and here we add the same code that was in
> > arch/arm/mach-at91rm9200/at91rm9200_time.c. As it is exactly the same
> > code added as we use the same peripheral, maybe we can add a common
> > file ( an at91_ipipe_time.c), instead of having duplicated code.
>
> Sorry, I did not make myself clear, I would like a difference between
> the trees, not between the diffs. In other words, the modifications you
> made.

Well this differences show the modification we made, but I agree it is
not really readable.

Between which tree do you want the diffs ?
Vanilla kernel +adeos patch  and at91 patched kernel + our patch ?
With this you'll have a lot of at91 patch in it.

Maybe we can try to make a diff between
at91 patched kernel +adeos patch  and at91 patched kernel + our patch ?
But with this solution we have to made some modification on adeos
patch for applying it on at91 patched kernel.

Last solution is to attach the file modified.

As you want.

-- 
Gregory CLEMENT
Adeneo
2, chemin du Ruisseau - BP21
69136 Ecully Cedex
France
Tel : +33-4 72 18 08 40

