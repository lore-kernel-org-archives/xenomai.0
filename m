Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB2D46F4A0
	for <xenomai@lists.linux.dev>; Wed,  7 Oct 2026 12:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791377438; cv=none; b=TqY0I589hxrCDCtkWgABJSnFZo4PamM9TIyBRhP7KqWThhmPOu0ghZZL1fpideAXp/Jv8bfKZbxOOIXvKjiVArJNbaUy36gTwIr5WXnGrhxuLAYBv2J/ZrKWSyIGYkHuhCg+cIOqZwnHfQLm/Jso4IlAoTi1EpHcF1H9IeNIZjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791377438; c=relaxed/simple;
	bh=XONiW7BgjG4Me9LnY4vQBJc/NwTQ4ZelGXXB0rvaCfA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mXVXljlwVRQpxjOX6r4LSWT+b6F0kv9FeuAxYwgbuQEiGNy/obhGF+wu+gSZxwzFS6P7sYzgBoXv99HipsCkVE+DI9/kbwhXWT2qiPShW2Nxj3mkCojcErfDxyJlA6pwIWhg6vdj+1U6XhNRJdiI0un2BBMWnO6qLfZmAPvIF7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=K7Z6tppE; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="K7Z6tppE"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20261007125020eb94f6a8920002079d
        for <xenomai@lists.linux.dev>;
        Wed, 07 Oct 2026 14:50:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=hYjqqe6W17gE6tKsLq3ak2UxkYeSKK39K1sgVyLpMX8=;
 b=K7Z6tppEGwHJxxpcTtzr1+c6M41IukmkroWtUiX8fBOUzIej8JFzG1bfUb74rW77j05+Tv
 u8SSGG1xJ7Ha3xLCIm+wuqKDONt/5qzKSUxRRFzt0lx+UY9uzsbNoWjBLeRE/xw3lpYG7+2Z
 uux+zy55uT0OKJEh4ogbgRFcurH+W7vnqRWIu0VC1YoIhjN0x8CGj2KY33vEGtsSWwUBXBgV
 m3bYya90es595EqBjhk0mOXJf2JSeQV4rjSH3rC+V97rezeMWpVJ2cM2ND9mzOGQHn5FFfrB
 ycebuxcP0BR9WF5U2hmF+NAnRJU+Bi7eE2W6xTe+iM/q5qvg1ljcnp7A==;
Message-ID: <5d811de1976bf98599300ffd787865fee291ebab.camel@siemens.com>
Subject: Re: Issue using recvmsg
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: =?ISO-8859-1?Q?Fran=E7ois?= Legal <francois.legal@eventlab.fr>
Cc: xenomai@lists.linux.dev
Date: Wed, 07 Oct 2026 14:50:20 +0200
In-Reply-To: <1207-6ac63b00-37-3e404bc0@80343493>
References: <1207-6ac63b00-37-3e404bc0@80343493>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Wed, 2026-10-07 at 14:28 +0200, Fran=C3=A7ois Legal wrote:
> Le Mercredi, Octobre 07, 2026 14:17 CEST, Florian Bezdeka <florian.bezdek=
a@siemens.com> a =C3=A9crit:=20
> =C2=A0
> > On Wed, 2026-10-07 at 09:36 +0200, Fran=C3=A7ois Legal wrote:
> > > Le Mardi, Octobre 06, 2026 23:41 CEST, Florian Bezdeka <florian.bezde=
ka@siemens.com> a =C3=A9crit:=20
> > > =C2=A0
> > > > On Tue, 2026-10-06 at 09:09 +0200, Fran=C3=A7ois Legal wrote:
> > > > > Hello,
> > > > >=20
> > > > > still porting my system from Xenomai 3.2 + linux 5.4 Ipipe to Xen=
omai 3.3 + linux 6.12 dovetail, I'm having what looks like a weird build is=
sue :
> > > > > I'm using the recvmsg call to get network message + ancillary dat=
a. On my new system, it returns -1 + errno set to 88 (ENOTSOCK). So I dug a=
 little, and it happens that recvmsg64 gets called, which does not seem to =
be wrapped by libcobalt to xenomai SC.
> > > > >=20
> > > > > The fix for this is decorating the recvmsg call with a __RT() or =
__COBALT() macro
> > > > >=20
> > > > > Is it expected ?
> > > >=20
> > > > Not sure yet. Probably not.
> > > >=20
> > > > Can you please elaborate which (g)libc version is being used and fo=
r
> > > > full transparency write down the code from your application and the
> > > > necessary prototypes from your standard libc library.
> > > >=20
> > > > The wrappers in place are matching glibc, where the 64 bit variant =
of
> > > > recvmsg() is named __recvmsg64.
> > > >=20
> > > >=20
> > > > Note: There is a conference week going on. Expect some delays. I wi=
ll
> > > > try to come back to that topic.
> > >=20
> > > Do you need the complete code of the app ?
> > >=20
> > > My glibc version is 2.35.
> > >=20
> > > It looks like a preprocessor issue, or a build system issue.
> > > By looking at the preprocessed file, I found these lines :
> > >=20
> > > # 178 "/opt/sdk_recorder/sysroots/cortexa9hf-neon-oe-linux-gnueabi/us=
r/include/sys/socket.h" 3 4
> > > extern ssize_t sendmsg (int __fd, const struct msghdr *__message, int=
 __flags) __asm__ ("" "__sendmsg64")
> > >=20
> > > # 219 "/opt/sdk_recorder/sysroots/cortexa9hf-neon-oe-linux-gnueabi/us=
r/include/sys/socket.h" 3 4
> > > extern ssize_t recvmsg (int __fd, struct msghdr *__message, int __fla=
gs) __asm__ ("" "__recvmsg64")
> > >=20
> > > # 108 "/opt/sdk_recorder/sysroots/cortexa9hf-neon-oe-linux-gnueabi/us=
r/include/sys/select.h" 3 4
> > > extern int select (int __nfds, fd_set *__restrict __readfds, fd_set *=
__restrict __writefds, fd_set *__restrict __exceptfds, struct timeval *__re=
strict __timeout) __asm__ ("" "__select64")
> > >=20
> > > which comes from :
> > > #ifndef __USE_TIME_BITS64
> > > extern ssize_t recvmsg (int __fd, struct msghdr *__message, int __fla=
gs);
> > > #else
> > > # ifdef __REDIRECT
> > > extern ssize_t __REDIRECT (recvmsg,
> > > =C2=A0			=C2=A0=C2=A0 (int __fd, struct msghdr *__message, int __flag=
s),
> > > =C2=A0			=C2=A0=C2=A0 __recvmsg64);
> > > # else
> > > extern ssize_t __recvmsg64 (int __fd, struct msghdr *__message, int _=
_flags);
> > > #=C2=A0 define recvmsg __recvmsg64
> > > # endif
> > > #endif
> > >=20
> > > with __REDIRECT being defined in sys/cdefs.h :
> > >=20
> > > =C2=A0/* __asm__ ("xyz") is used throughout the headers to rename fun=
ctions
> > > =C2=A0=C2=A0 at the assembly language level.=C2=A0 This is wrapped by=
 the __REDIRECT
> > > =C2=A0=C2=A0 macro, in order to support compilers that can do this so=
me other
> > > =C2=A0=C2=A0 way.=C2=A0 When compilers don't support asm-names at all=
, we have to do
> > > =C2=A0=C2=A0 preprocessor tricks instead (which don't have exactly th=
e right
> > > =C2=A0=C2=A0 semantics, but it's the best we can do).
> > >=20
> > > =C2=A0=C2=A0 Example:
> > > =C2=A0=C2=A0 int __REDIRECT(setpgrp, (__pid_t pid, __pid_t pgrp), set=
pgid); */
> > >=20
> > > #if (defined __GNUC__ && __GNUC__ >=3D 2) || (__clang_major__ >=3D 4)
> > >=20
> > > # define __REDIRECT(name, proto, alias) name proto __asm__ (__ASMNAME=
 (#alias))
> > > # ifdef __cplusplus
> > > #=C2=A0 define __REDIRECT_NTH(name, proto, alias) \
> > > =C2=A0=C2=A0=C2=A0=C2=A0 name proto __THROW __asm__ (__ASMNAME (#alia=
s))
> > > #=C2=A0 define __REDIRECT_NTHNL(name, proto, alias) \
> > > =C2=A0=C2=A0=C2=A0=C2=A0 name proto __THROWNL __asm__ (__ASMNAME (#al=
ias))
> > > # else
> > > #=C2=A0 define __REDIRECT_NTH(name, proto, alias) \
> > > =C2=A0=C2=A0=C2=A0=C2=A0 name proto __asm__ (__ASMNAME (#alias)) __TH=
ROW
> > > #=C2=A0 define __REDIRECT_NTHNL(name, proto, alias) \
> > > =C2=A0=C2=A0=C2=A0=C2=A0 name proto __asm__ (__ASMNAME (#alias)) __TH=
ROWNL
> > > # endif
> > > # define __ASMNAME(cname)=C2=A0 __ASMNAME2 (__USER_LABEL_PREFIX__, cn=
ame)
> > > # define __ASMNAME2(prefix, cname) __STRING (prefix) cname
> > >=20
> > > Fran=C3=A7ois
> >=20
> > Thanks.
> >=20
> > So,
> > =C2=A0=C2=A0 - glibc version is in the expected range
> > =C2=A0=C2=A0 - the aml redirect feature should work
> >=20
> > How does the code in the application look like?
> >=20
> > Expected:
> > =C2=A0=C2=A0 - application calling recvmsg()
> > =C2=A0=C2=A0 - redirection to __recvmsg64() (on asml level), but
> > =C2=A0=C2=A0 - __recvmsg64() being wrapped by Xenomai
> >=20
> > I can't see how recvmsg64() (as reported) would be involved, but you
> > reported that...
>=20
> I made a mistake. it is clearly __recvmsg64, but, I can see not track of =
__recvmsg64 in cobalt-glibc-time64.wrappers.
> only __recvmmsg64 is wrapped :=20
>=20

Seems we missed __recvmsg64() and __sendmsg64() while doing the y2038
implementation. Most likely because the time32 problem is not in one of
the function arguments but one level down in the argument list.

Xenomai is missing a proper wrapper for those two. The code base should
be prepared for those an additional wrapper. It just needs someone to
sit down and implement it. I would happily do the review in case you
want to give it a try.

>=20
[snip]
> --wrap __recvmmsg64

Close. I ignored the double "m" here.
