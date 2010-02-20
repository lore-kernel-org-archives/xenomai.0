Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Feb 2010 12:58:13 -0600
Message-ID: <181804936ABC2349BE503168465576460DE4CD0E@exchserver.basler.com>
References: <181804936ABC2349BE503168465576460DD4DE8B@exchserver.basler.com> 
	<181804936ABC2349BE503168465576460DDA2F4F@exchserver.basler.com> 
	<181804936ABC2349BE503168465576460DE4CCFC@exchserver.basler.com> 
	<4B7FBBB8.1010806@domain.hid>
From: "Steve Deiters" <SteveDeiters@domain.hid>
Subject: Re: [Xenomai-help] Supported I-pipe versions?
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

> -----Original Message-----
> From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org
> Sent: Saturday, February 20, 2010 4:39 AM
> To: Steve Deiters
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai-help] Supported I-pipe versions?
>=20
> Steve Deiters wrote:
> > Sorry to keep bringing this up, but does anybody know if there are=20
> > compatibility issues with Xenomai 2.5.1, PowerPC Linux=20
> 2.6.24.6, and=20
> > the following adeos patch:
> >=20
> http://download.gna.org/adeos/patches/v2.6/powerpc/older/adeos-ipipe-2
> > .6
> > .24.6-powerpc-DENX-2.4-03.patch?
>=20
> 2.6.24 has a bug which has only be fixed with recent patches.=20
> So, even if you use it with an older Xenomai version, and it=20
> seems to work, in fact it does not.
>=20
> --=20
> 					    Gilles.
>=20

Could you elaborate on this a bit more?  Is there a bug in the kernel=
 or
the I-pipe patch?  Should I upgrade the kernel version, or I-pipe, or
both?

Is there a list of supported versions somewhere, or do I assume that it
is not supported if the I-pipe patch is not bundled with the tarball?

Thanks.


