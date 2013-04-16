Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
From: Stephan Kappertz <stephan.kappertz@kabelmail.de>
In-Reply-To: <516BA4E9.3070201@xenomai.org>
Date: Tue, 16 Apr 2013 12:26:21 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <90FBAEE5-D70C-4563-B9DB-776D6E4E7FA9@kabelmail.de>
References: <516BA4E9.3070201@xenomai.org>
Subject: Re: [Xenomai] Raspberry and Beaglebone patches
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

Am 15.04.2013 um 08:57 schrieb Gilles Chanteperdrix:

>=20
> Hi Stephan, Paul,
>=20
> we have a problem with the patches for Raspberry and BeagleBone: they
> are based on the 3.2.21 patch, which we know is broken. So, we can not
> really ship the next version of Xenomai with these patches.
>=20
> There are two ways we could keep patches for these machines:
> - you could send patches for 3.4 or 3.5, or even 3.8
> - we could backport the fixes to 3.2, but as already discussed on this
> list, this would cost some time to re-validate the 3.2 patch on all
> architectures. However, if you do the backport, validate it on your
> side, I could validate the result on my test boards, and we would
> release a new version of the patch for 3.2 only for the ARM =
architecture.
>=20
> Regards.
>=20
> --=20
>                                                                Gilles.
>=20

Hi Gilles,

there's a 3.8.7 branch available for beagleBone at =
https://github.com/beagleboard/kernel/tree/3.8.

I can look into updating the beagleBone patch for that repository. Where =
do I find the latest ipipe patch for 3.8 on ARM?

- Stephan



