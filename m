From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <AANLkTim9bUjQBI43P2Z7DL4ZQsZdjMMQ3ZZf2p54bAso@domain.hid>
References: <AANLkTim9bUjQBI43P2Z7DL4ZQsZdjMMQ3ZZf2p54bAso@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 09 Jul 2010 10:45:31 +0200
Message-ID: <1278665131.1810.378.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] xenomia adeos pacht error
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?UTF-8?Q?G=C3=B6rkem_Karado=C4=9Fan?= <gkaradagan@domain.hid>
Cc: xenomai@xenomai.org

On Fri, 2010-07-09 at 10:28 +0300, G=C3=B6rkem Karado=C4=9Fan wrote:
> hi all,
>=20
> i follow this install introduction
> (http://www.xenomai.org/documentation/xenomai-2.5/README.INSTALL)
>=20
> and i write this code=20
>=20
> /opt/xenomai-2.5.3/scripts/prepare-kernel.sh --arch=3Darm \
>=20
> --adeos=3D/opt/xenomai-2.5.3/ksrc/arch/arm/patches/adeos-ipipe-2.6.20-arm=
-* \
> --linux=3D/opt/linux-02.01.03.11/
>=20
> and i got this error codes
>=20
> Hunk #1 FAILED at 156.
> 1 out of 1 hunk FAILED -- saving rejects to file mm/vmalloc.c.rej
> prepare-kernel.sh: Unable to patch kernel 2.6.29-rc3 with
> adeos-ipipe-2.6.20-arm-1.8-03.patch.
>=20
> i use linux-02.01.03.11 because of omap3530. Do you know which pacht
> is able with kernel 2.6.29.rc3..
>=20

Please make sure to actually read the answer you have been given before
rehashing the same question:
https://mail.gna.org/public/xenomai-help/2010-07/msg00078.html

That answer is crystal clear: i.e. Adeos patches for ARM are based on
the mainline kernel tree, and not on any vendor branch. I guess that you
can infer quite easily from this why those patches won't apply neatly on
your vendor kernel then.

Patches in ksrc/arm/patches/ should be used preferably. With a little
effort, you should be able to find more information about this in the
FAQ:
http://www.xenomai.org/index.php/FAQs#Which_I-pipe_patch_should_I_use_with_=
Xenomai_version_X_on_platform_Y.3F

To sum up:

- the information is there, please read it.
- from the information you gave us, and despite what Gilles told you
explicitly in the mail mentioned above, you are still trying to apply a
patch for kernel 2.6.20 to 2.6.29. This can't work, and very much looks
like masochistic, really. There must be a reason why we issued a
specific patch for each different kernel release we wanted to support
over time, right?
- you depend on a vendor kernel tree: you are on your own then. We just
cannot maintain patches for each and every tree variant, so don't expect
this patch to exist just because you need it. You could wait for quite a
long time.

Now, your options:

As mentioned in the FAQ, you can find older releases of Adeos patches on
our download site, including for 2.6.29. Those patches may or may not
work for your kernel and/or omap platform, you will have to try and
check by yourself. It is likely that those patches won't apply
out-of-the-box, and will require some updates to fit your kernel though,
be prepared for that.

How complex it might be to get a working patch for your vendor kernel is
unknown to us, just because we have no clue about what makes that kernel
tree different from mainline, and quite frankly, we don't care about
this. Time is a scarce resource for everyone.

> thanks...
>=20
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

--=20
Philippe.



