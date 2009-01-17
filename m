Message-ID: <49712694.9070005@domain.hid>
Date: Sat, 17 Jan 2009 01:30:12 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <200901162102.16706.sebastien.berruer@domain.hid>
In-Reply-To: <200901162102.16706.sebastien.berruer@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Xenomai on Gumstix
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: sebastien.berruer@domain.hid
Cc: xenomai@xenomai.org

BERRUER S=E9bastien wrote:
> Hello,
>=20
> I finally find a way to make it works. You showed me the way:
>> my bitbake recipe does have a few modifications to auto-patch adeos in=
to the=20
> kernel
> I've add only one line to my recipe for the kernel (~/gumstix/gumstix-
> oe/user.collection/packages/linux/gumstix-kernel_2.6.24.bb). After all =
the=20
> require files and specifics patchs, I've add:
> file://adeos-ipipe-2.6.24-arm-1.9-01.patch; patch=3D1
>=20
> That patch file come directly from Xenomai 2.4.3=20
> (Xenomai-2.4.3/ksrc/arch/arm/patches/). I've made a local copy of it in=
 the=20
> specific kernel directory=20
> (~/gumstix/gumstixoe/use.collection/packages/linux/gumstix-kernel-2.6.2=
4/).=20
> Then, I only ran:
> bitbake gumstix-kernel -c rebuild
> To produce the uImage.
>=20
> When I ran bitbake the first time to get the sources, I ran the previou=
s=20
> command (Yes, I only focus now that it wasn't the right thing to do). T=
here=20
> was a complete compilation on this source code. Only after that, I appl=
ied the=20
> Xenomai patch. So, when I compiled again, I suppose there would have be=
en some=20
> object code that would not be compile again. So, those parts would neve=
r know=20
> the existance of Adeos. It's probably that which gave me an error.
>=20
> Now, Adeos works ! I have to see what will append with the Xenomai=20
> userspace...

I still do not understand why you are picking up such old versions. When
starting a new development, there is simply no reason to pick an old
version, as you risk to hit and report bugs which have already been
fixed, and waste everybody's precious time.

Anyway, you are not doing things the proper way, as Felipe told you, as
explained in the README.INSTALL file which you can find in the xenomai
tarball, and as explained here:
http://www.xenomai.org/index.php/Xenomai_quick_build_quide

To get xenomai kernel-space support, you have to run the
prepare-kernel.sh script prior to compile the kernel.

If you do not do that, Xenomai user-space support will simply not work.

--=20
					    Gilles.


