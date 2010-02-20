Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Feb 2010 15:25:08 -0600
Message-ID: <181804936ABC2349BE503168465576460DE4CD12@domain.hid>
References: <181804936ABC2349BE503168465576460DD4DE8B@exchserver.basler.com> 
	<181804936ABC2349BE503168465576460DDA2F4F@exchserver.basler.com> 
	<181804936ABC2349BE503168465576460DE4CCFC@exchserver.basler.com> 
	<4B7FBBB8.1010806@domain.hid> 
	<181804936ABC2349BE503168465576460DE4CD0E@exchserver.basler.com> 
	<4B803236.4040704@domain.hid>
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
> Sent: Saturday, February 20, 2010 1:04 PM
> To: Steve Deiters
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai-help] Supported I-pipe versions?
>=20
> Steve Deiters wrote:
> >> -----Original Message-----
> >> From: Gilles Chanteperdrix=20
> [mailto:gilles.chanteperdrix@xenomai.org]
> >> Sent: Saturday, February 20, 2010 4:39 AM
> >> To: Steve Deiters
> >> Cc: xenomai@xenomai.org
> >> Subject: Re: [Xenomai-help] Supported I-pipe versions?
> >>
> >> Steve Deiters wrote:
> >>> Sorry to keep bringing this up, but does anybody know if=20
> there are=20
> >>> compatibility issues with Xenomai 2.5.1, PowerPC Linux
> >> 2.6.24.6, and
> >>> the following adeos patch:
> >>>
> >>=20
> http://download.gna.org/adeos/patches/v2.6/powerpc/older/adeos-ipipe-
> >> 2
> >>> .6
> >>> .24.6-powerpc-DENX-2.4-03.patch?
> >> 2.6.24 has a bug which has only be fixed with recent patches.=20
> >> So, even if you use it with an older Xenomai version, and=20
> it seems to=20
> >> work, in fact it does not.
> >>
> >> --=20
> >> 					    Gilles.
> >>
> >=20
> > Could you elaborate on this a bit more?  Is there a bug in=20
> the kernel=20
> > or the I-pipe patch?
>=20
> The I-pipe patch. For details, search the archives, the bug=20
> was announced publicly on this list.

I will check the list archives.

>=20
> > Should I upgrade the kernel version, or I-pipe, or both?
>=20
> I do not understand this question.

I was simply asking to what the bug you were referring to applies, the
kernel version, or to the I-pipe patch version, and for which one of
these I should look for updates if there is some issue with 2.6.24.6.

> >=20
> > Is there a list of supported versions somewhere, or do I=20
> assume that=20
> > it is not supported if the I-pipe patch is not bundled with=20
> the tarball?
>=20
> Looks to me like you have not read ksrc/arch/powerpc/patches/README.
>=20
> --=20
> 					    Gilles.
>=20

I have read that.  In the README it lists the 2.6.24.6-DENX-2.4-03 patch
in the list of older patches, and only makes a note that they are not
guaranteed to work, but likely will as you try to maintain backward
compatibility.  This patch was included in Xenomai 2.4.10 as
'ksrc/arch/powerpc/patches/adeos-ipipe-2.6.24.6-powerpc-DENX-2.4-03.patc
h', which seems to be leading to my confusion as this patch and kernel
version seem to no longer work, and you are telling me it should have
never worked.


So as to not dwell on this issue, is there a recommended version of the
Linux kernel for running a PowerPC?  I was using a branch of the DENX
tree for 2.6.24.6, as it had support for the MPC5121e.  The latest
mainstream kernel that seems to have good support for this is the 2.6.33
series, but I do not see an adeos patch for that version of the kernel
either.  Maybe the 2.6.32 patch will work, but I haven't tried it.

