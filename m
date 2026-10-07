Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5233D45C5
	for <xenomai@lists.linux.dev>; Wed,  7 Oct 2026 12:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791375446; cv=none; b=gZ/mXSwgv1oI/Elzvyt9kva4qnK23lrb9gsQGkkweQzO/iherN1BRwD2xgF/9Z/swG66a070z/XieAdzSB5fY2pRtlwuxjmBmKWXYnA6B2cX5OoK4uOpMbdHkD/4g+JBtPKCg1BkbmHHlhW2myiPEllH2UISJSo/OmwndK1u8AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791375446; c=relaxed/simple;
	bh=ReKSUntHt4INsT8ULEqye0z5Pcsi+lYcExivsS6guiw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g+AcerK5O/XgL5Ng+CvX0IMWmW/+TGsKnCuEvpHED56SH865Lc0/W5m2P8g/lp64CxbvpPi2DMsS6P1IwMwf367DlokOPwkmVL/ASZJqPAGtRr47Ofd8Qg5LqJVoK+CW6Q/dGy+04x/UiTGv+SeqpXeXcVsc8dOuoYMMXWOx1Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=ZlZcvfUs; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="ZlZcvfUs"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202610071217104cfc4856c30002079a
        for <xenomai@lists.linux.dev>;
        Wed, 07 Oct 2026 14:17:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=EhhzzuPIjbcu8hxwPi5/vFOGh/QHyS/pTN7VbCEArvA=;
 b=ZlZcvfUsmKn48ThJrkoV1QUYwXL/klmnDw3On0GH637vHcl55+DWoF3uJWQWQ+NToSNoRT
 3kZBvKImwZSw7wTuEJuV8HE4kgISNKyYyfYqV/8WOn4LB7ACUdXPPk8gHA6yrlDoS7CrPKKl
 g4nMmS0ySoThF7lwMuLTiYIQq8/ojBlccEk1hUIxWG5VLAUuKT20GscbTWqBHy4hR8bSrd14
 7escu1tRURyju2AGa4vozP40dka5Ni3kIMGJ/K29Eb2/0s2YqLV8IgZgb8yuA0mqGuLBimmB
 HZ5fGi64aZNo/2QZQzGmeWJZDOTCzAQ1HO6Pmtxrpv3WlJYYgnpiQ29Q==;
Message-ID: <204eab76c02426e8ce0ffacc1ec091e13781e6ca.camel@siemens.com>
Subject: Re: Issue using recvmsg
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: =?ISO-8859-1?Q?Fran=E7ois?= Legal <francois.legal@eventlab.fr>
Cc: xenomai@lists.linux.dev
Date: Wed, 07 Oct 2026 14:17:10 +0200
In-Reply-To: <1207-6ac5f680-31-3e404bc0@80343394>
References: <1207-6ac5f680-31-3e404bc0@80343394>
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

On Wed, 2026-10-07 at 09:36 +0200, Fran=C3=A7ois Legal wrote:
> Le Mardi, Octobre 06, 2026 23:41 CEST, Florian Bezdeka <florian.bezdeka@s=
iemens.com> a =C3=A9crit:=20
> =C2=A0
> > On Tue, 2026-10-06 at 09:09 +0200, Fran=C3=A7ois Legal wrote:
> > > Hello,
> > >=20
> > > still porting my system from Xenomai 3.2 + linux 5.4 Ipipe to Xenomai=
 3.3 + linux 6.12 dovetail, I'm having what looks like a weird build issue =
:
> > > I'm using the recvmsg call to get network message + ancillary data. O=
n my new system, it returns -1 + errno set to 88 (ENOTSOCK). So I dug a lit=
tle, and it happens that recvmsg64 gets called, which does not seem to be w=
rapped by libcobalt to xenomai SC.
> > >=20
> > > The fix for this is decorating the recvmsg call with a __RT() or __CO=
BALT() macro
> > >=20
> > > Is it expected ?
> >=20
> > Not sure yet. Probably not.
> >=20
> > Can you please elaborate which (g)libc version is being used and for
> > full transparency write down the code from your application and the
> > necessary prototypes from your standard libc library.
> >=20
> > The wrappers in place are matching glibc, where the 64 bit variant of
> > recvmsg() is named __recvmsg64.
> >=20
> >=20
> > Note: There is a conference week going on. Expect some delays. I will
> > try to come back to that topic.
>=20
> Do you need the complete code of the app ?
>=20
> My glibc version is 2.35.
>=20
> It looks like a preprocessor issue, or a build system issue.
> By looking at the preprocessed file, I found these lines :
>=20
> # 178 "/opt/sdk_recorder/sysroots/cortexa9hf-neon-oe-linux-gnueabi/usr/in=
clude/sys/socket.h" 3 4
> extern ssize_t sendmsg (int __fd, const struct msghdr *__message, int __f=
lags) __asm__ ("" "__sendmsg64")
>=20
> # 219 "/opt/sdk_recorder/sysroots/cortexa9hf-neon-oe-linux-gnueabi/usr/in=
clude/sys/socket.h" 3 4
> extern ssize_t recvmsg (int __fd, struct msghdr *__message, int __flags) =
__asm__ ("" "__recvmsg64")
>=20
> # 108 "/opt/sdk_recorder/sysroots/cortexa9hf-neon-oe-linux-gnueabi/usr/in=
clude/sys/select.h" 3 4
> extern int select (int __nfds, fd_set *__restrict __readfds, fd_set *__re=
strict __writefds, fd_set *__restrict __exceptfds, struct timeval *__restri=
ct __timeout) __asm__ ("" "__select64")
>=20
> which comes from :
> #ifndef __USE_TIME_BITS64
> extern ssize_t recvmsg (int __fd, struct msghdr *__message, int __flags);
> #else
> # ifdef __REDIRECT
> extern ssize_t __REDIRECT (recvmsg,
> 			=C2=A0=C2=A0 (int __fd, struct msghdr *__message, int __flags),
> 			=C2=A0=C2=A0 __recvmsg64);
> # else
> extern ssize_t __recvmsg64 (int __fd, struct msghdr *__message, int __fla=
gs);
> #=C2=A0 define recvmsg __recvmsg64
> # endif
> #endif
>=20
> with __REDIRECT being defined in sys/cdefs.h :
>=20
> =C2=A0/* __asm__ ("xyz") is used throughout the headers to rename functio=
ns
> =C2=A0=C2=A0 at the assembly language level.=C2=A0 This is wrapped by the=
 __REDIRECT
> =C2=A0=C2=A0 macro, in order to support compilers that can do this some o=
ther
> =C2=A0=C2=A0 way.=C2=A0 When compilers don't support asm-names at all, we=
 have to do
> =C2=A0=C2=A0 preprocessor tricks instead (which don't have exactly the ri=
ght
> =C2=A0=C2=A0 semantics, but it's the best we can do).
>=20
> =C2=A0=C2=A0 Example:
> =C2=A0=C2=A0 int __REDIRECT(setpgrp, (__pid_t pid, __pid_t pgrp), setpgid=
); */
>=20
> #if (defined __GNUC__ && __GNUC__ >=3D 2) || (__clang_major__ >=3D 4)
>=20
> # define __REDIRECT(name, proto, alias) name proto __asm__ (__ASMNAME (#a=
lias))
> # ifdef __cplusplus
> #=C2=A0 define __REDIRECT_NTH(name, proto, alias) \
> =C2=A0=C2=A0=C2=A0=C2=A0 name proto __THROW __asm__ (__ASMNAME (#alias))
> #=C2=A0 define __REDIRECT_NTHNL(name, proto, alias) \
> =C2=A0=C2=A0=C2=A0=C2=A0 name proto __THROWNL __asm__ (__ASMNAME (#alias)=
)
> # else
> #=C2=A0 define __REDIRECT_NTH(name, proto, alias) \
> =C2=A0=C2=A0=C2=A0=C2=A0 name proto __asm__ (__ASMNAME (#alias)) __THROW
> #=C2=A0 define __REDIRECT_NTHNL(name, proto, alias) \
> =C2=A0=C2=A0=C2=A0=C2=A0 name proto __asm__ (__ASMNAME (#alias)) __THROWN=
L
> # endif
> # define __ASMNAME(cname)=C2=A0 __ASMNAME2 (__USER_LABEL_PREFIX__, cname)
> # define __ASMNAME2(prefix, cname) __STRING (prefix) cname
>=20
> Fran=C3=A7ois

Thanks.

So,
  - glibc version is in the expected range
  - the aml redirect feature should work

How does the code in the application look like?

Expected:
  - application calling recvmsg()
  - redirection to __recvmsg64() (on asml level), but
  - __recvmsg64() being wrapped by Xenomai

I can't see how recvmsg64() (as reported) would be involved, but you
reported that...

Just to make that clear again: The time64 wrappers should only be
active/enabled when building an 32 bit application with time64_t support
requested.

Is that the case on your end?

Have you checked that the CFLAGS provided by the xeno-config utility are
correctly forwarded to your build environment? Maybe the time64 wrapping
related flags are missing?

Best regards,
Florian


