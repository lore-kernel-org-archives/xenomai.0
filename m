Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792A5346A18
	for <xenomai@lists.linux.dev>; Wed,  7 Oct 2026 12:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791376150; cv=none; b=lNwjjhzFB3sZigiRNfQA04Gzwt0BKgJYQCsmafP7gEqfcYzOFXo0xjKq1ztsTRmD75QASrfiFjanX0sN/fOSjfMcwyhg8vmJtm99bQ3fROJm5jrkn9+TlP0HY0wyQblgkzBU0RvlEyFxbnmgSBV89tJ4rV58/lSBORqrmhY4nns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791376150; c=relaxed/simple;
	bh=DLIMPOvvexHi3D+zR6Ld0tDy2cYYhDAnk8T3zKShWiE=;
	h=From:In-Reply-To:Content-Type:Date:Cc:To:MIME-Version:Message-ID:
	 Subject; b=qZPsiv4YNnz0pgoO5irNOeurLzQyU9Y1WZOT0/BZ1//n3E80n8rcQbOyYAzV5fC8Y43lyVuyRxEtgejZivaRCIo7M92ly0iwkOKNfGmY4vJA4Qy5ZW8uGt1yWXdlr322ThyYn6Rut6JSdH5TcT0fY97dT9lkhqIuoKMrdR1g1RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eventlab.fr; spf=pass smtp.mailfrom=eventlab.fr; dkim=permerror (0-bit key) header.d=eventlab.fr header.i=@eventlab.fr header.b=RZSHIeR/; arc=none smtp.client-ip=212.27.42.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eventlab.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eventlab.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=eventlab.fr header.i=@eventlab.fr header.b="RZSHIeR/"
Received: from mail.thom.fr.eu.org (unknown [82.64.149.25])
	by smtp6-g21.free.fr (Postfix) with ESMTPS id 401EA780107;
	Wed,  7 Oct 2026 14:28:55 +0200 (CEST)
Authentication-Results: smtp6-g21.free.fr;
	dkim=permerror header.d=eventlab.fr header.i=@eventlab.fr header.a=ed25519-sha256 header.s=default header.b=RZSHIeR/;
	dkim-atps=neutral
Received: from localhost ([127.0.0.1])
	by mail.thom.fr.eu.org (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTP id 697CSsLQ444721;
	Wed, 7 Oct 2026 14:28:54 +0200
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple; d=eventlab.fr;
	s=default; t=1791376134;
	bh=DLIMPOvvexHi3D+zR6Ld0tDy2cYYhDAnk8T3zKShWiE=;
	h=From:In-Reply-To:Date:Cc:To:Subject;
	b=RZSHIeR/oL8VNFFxZYaoabEPenLPGc7bTY/KvVH7VlTn4HLIyyY24Gu/tDqExzidD
	 MpuHA8SC6YEhNEXw+tQbHS1oSlRfXyDfj5PbVfdDXpsOUW8p57/7zq43JcNawnYO9w
	 9MtMBAKNRLCWoiU5IQXTu7nSvBxAijaSA3BDH2SGzOjQK+cTpoK3Jga26X6dj/DhVT
	 r4ytEL+SLyjHmKup8/cPDZmB/jSVviUxQYWVQXF6lpRtbpH9TD9CkxJe/oLehGT5Se
	 /HcEX0ZGJI68eErvrhpwJ3BUL/lO738jxUy5E2Sg11nnxpUreBKPJAW6sKHOZivycG
	 o+WMWm/VOH+3Q==
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <francois.legal@eventlab.fr>
In-Reply-To: <204eab76c02426e8ce0ffacc1ec091e13781e6ca.camel@siemens.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 217.109.173.233, 194.9.103.72
Date: Wed, 07 Oct 2026 14:28:54 +0200
Cc: xenomai@lists.linux.dev
To: "Florian Bezdeka" <florian.bezdeka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <1207-6ac63b00-37-3e404bc0@80343493>
Subject: =?utf-8?q?Re=3A?= Issue using recvmsg
User-Agent: SOGoMail 5.0.1
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 1.4.3 at tls-srv-02
X-Virus-Status: Clean

Le Mercredi, Octobre 07, 2026 14:17 CEST, Florian Bezdeka <florian.bezd=
eka@siemens.com> a =C3=A9crit: 
 
> On Wed, 2026-10-07 at 09:36 +0200, Fran=C3=A7ois Legal wrote:
> > Le Mardi, Octobre 06, 2026 23:41 CEST, Florian Bezdeka <florian.bez=
deka@siemens.com> a =C3=A9crit: 
> > =C2=A0
> > > On Tue, 2026-10-06 at 09:09 +0200, Fran=C3=A7ois Legal wrote:
> > > > Hello,
> > > > 
> > > > still porting my system from Xenomai 3.2 + linux 5.4 Ipipe to X=
enomai 3.3 + linux 6.12 dovetail, I'm having what looks like a weird bu=
ild issue :
> > > > I'm using the recvmsg call to get network message + ancillary d=
ata. On my new system, it returns -1 + errno set to 88 (ENOTSOCK). So I=
 dug a little, and it happens that recvmsg64 gets called, which does no=
t seem to be wrapped by libcobalt to xenomai SC.
> > > > 
> > > > The fix for this is decorating the recvmsg call with a =5F=5FRT=
() or =5F=5FCOBALT() macro
> > > > 
> > > > Is it expected ?
> > > 
> > > Not sure yet. Probably not.
> > > 
> > > Can you please elaborate which (g)libc version is being used and =
for
> > > full transparency write down the code from your application and t=
he
> > > necessary prototypes from your standard libc library.
> > > 
> > > The wrappers in place are matching glibc, where the 64 bit varian=
t of
> > > recvmsg() is named =5F=5Frecvmsg64.
> > > 
> > > 
> > > Note: There is a conference week going on. Expect some delays. I =
will
> > > try to come back to that topic.
> > 
> > Do you need the complete code of the app ?
> > 
> > My glibc version is 2.35.
> > 
> > It looks like a preprocessor issue, or a build system issue.
> > By looking at the preprocessed file, I found these lines :
> > 
> > # 178 "/opt/sdk=5Frecorder/sysroots/cortexa9hf-neon-oe-linux-gnueab=
i/usr/include/sys/socket.h" 3 4
> > extern ssize=5Ft sendmsg (int =5F=5Ffd, const struct msghdr *=5F=5F=
message, int =5F=5Fflags) =5F=5Fasm=5F=5F ("" "=5F=5Fsendmsg64")
> > 
> > # 219 "/opt/sdk=5Frecorder/sysroots/cortexa9hf-neon-oe-linux-gnueab=
i/usr/include/sys/socket.h" 3 4
> > extern ssize=5Ft recvmsg (int =5F=5Ffd, struct msghdr *=5F=5Fmessag=
e, int =5F=5Fflags) =5F=5Fasm=5F=5F ("" "=5F=5Frecvmsg64")
> > 
> > # 108 "/opt/sdk=5Frecorder/sysroots/cortexa9hf-neon-oe-linux-gnueab=
i/usr/include/sys/select.h" 3 4
> > extern int select (int =5F=5Fnfds, fd=5Fset *=5F=5Frestrict =5F=5Fr=
eadfds, fd=5Fset *=5F=5Frestrict =5F=5Fwritefds, fd=5Fset *=5F=5Frestri=
ct =5F=5Fexceptfds, struct timeval *=5F=5Frestrict =5F=5Ftimeout) =5F=5F=
asm=5F=5F ("" "=5F=5Fselect64")
> > 
> > which comes from :
> > #ifndef =5F=5FUSE=5FTIME=5FBITS64
> > extern ssize=5Ft recvmsg (int =5F=5Ffd, struct msghdr *=5F=5Fmessag=
e, int =5F=5Fflags);
> > #else
> > # ifdef =5F=5FREDIRECT
> > extern ssize=5Ft =5F=5FREDIRECT (recvmsg,
> > 			=C2=A0=C2=A0 (int =5F=5Ffd, struct msghdr *=5F=5Fmessage, int =5F=
=5Fflags),
> > 			=C2=A0=C2=A0 =5F=5Frecvmsg64);
> > # else
> > extern ssize=5Ft =5F=5Frecvmsg64 (int =5F=5Ffd, struct msghdr *=5F=5F=
message, int =5F=5Fflags);
> > #=C2=A0 define recvmsg =5F=5Frecvmsg64
> > # endif
> > #endif
> > 
> > with =5F=5FREDIRECT being defined in sys/cdefs.h :
> > 
> > =C2=A0/* =5F=5Fasm=5F=5F ("xyz") is used throughout the headers to =
rename functions
> > =C2=A0=C2=A0 at the assembly language level.=C2=A0 This is wrapped =
by the =5F=5FREDIRECT
> > =C2=A0=C2=A0 macro, in order to support compilers that can do this =
some other
> > =C2=A0=C2=A0 way.=C2=A0 When compilers don't support asm-names at a=
ll, we have to do
> > =C2=A0=C2=A0 preprocessor tricks instead (which don't have exactly =
the right
> > =C2=A0=C2=A0 semantics, but it's the best we can do).
> > 
> > =C2=A0=C2=A0 Example:
> > =C2=A0=C2=A0 int =5F=5FREDIRECT(setpgrp, (=5F=5Fpid=5Ft pid, =5F=5F=
pid=5Ft pgrp), setpgid); */
> > 
> > #if (defined =5F=5FGNUC=5F=5F && =5F=5FGNUC=5F=5F >=3D 2) || (=5F=5F=
clang=5Fmajor=5F=5F >=3D 4)
> > 
> > # define =5F=5FREDIRECT(name, proto, alias) name proto =5F=5Fasm=5F=
=5F (=5F=5FASMNAME (#alias))
> > # ifdef =5F=5Fcplusplus
> > #=C2=A0 define =5F=5FREDIRECT=5FNTH(name, proto, alias) \
> > =C2=A0=C2=A0=C2=A0=C2=A0 name proto =5F=5FTHROW =5F=5Fasm=5F=5F (=5F=
=5FASMNAME (#alias))
> > #=C2=A0 define =5F=5FREDIRECT=5FNTHNL(name, proto, alias) \
> > =C2=A0=C2=A0=C2=A0=C2=A0 name proto =5F=5FTHROWNL =5F=5Fasm=5F=5F (=
=5F=5FASMNAME (#alias))
> > # else
> > #=C2=A0 define =5F=5FREDIRECT=5FNTH(name, proto, alias) \
> > =C2=A0=C2=A0=C2=A0=C2=A0 name proto =5F=5Fasm=5F=5F (=5F=5FASMNAME =
(#alias)) =5F=5FTHROW
> > #=C2=A0 define =5F=5FREDIRECT=5FNTHNL(name, proto, alias) \
> > =C2=A0=C2=A0=C2=A0=C2=A0 name proto =5F=5Fasm=5F=5F (=5F=5FASMNAME =
(#alias)) =5F=5FTHROWNL
> > # endif
> > # define =5F=5FASMNAME(cname)=C2=A0 =5F=5FASMNAME2 (=5F=5FUSER=5FLA=
BEL=5FPREFIX=5F=5F, cname)
> > # define =5F=5FASMNAME2(prefix, cname) =5F=5FSTRING (prefix) cname
> > 
> > Fran=C3=A7ois
> 
> Thanks.
> 
> So,
>   - glibc version is in the expected range
>   - the aml redirect feature should work
> 
> How does the code in the application look like?
> 
> Expected:
>   - application calling recvmsg()
>   - redirection to =5F=5Frecvmsg64() (on asml level), but
>   - =5F=5Frecvmsg64() being wrapped by Xenomai
> 
> I can't see how recvmsg64() (as reported) would be involved, but you
> reported that...

I made a mistake. it is clearly =5F=5Frecvmsg64, but, I can see not tra=
ck of =5F=5Frecvmsg64 in cobalt-glibc-time64.wrappers.
only =5F=5Frecvmmsg64 is wrapped : 

--wrap =5F=5Fsem=5Ftimedwait64
--wrap =5F=5Fclock=5Fgettime64
--wrap =5F=5Fclock=5Fsettime64
--wrap =5F=5Fclock=5Fnanosleep=5Ftime64
--wrap =5F=5Fclock=5Fgetres64
--wrap =5F=5Fclock=5Fadjtime64
--wrap =5F=5Fpthread=5Fmutex=5Ftimedlock64
--wrap =5F=5Fmq=5Ftimedsend=5Ftime64
--wrap =5F=5Fmq=5Ftimedreceive=5Ftime64
--wrap =5F=5Fsigtimedwait64
--wrap =5F=5Frecvmmsg64
--wrap =5F=5Fpthread=5Fcond=5Ftimedwait64
--wrap =5F=5Ftimer=5Fsettime64
--wrap =5F=5Ftimer=5Fgettime64
--wrap =5F=5Ftimerfd=5Fsettime64
--wrap =5F=5Ftimerfd=5Fgettime64
--wrap =5F=5Fsetsockopt64
--wrap =5F=5Fgetsockopt64
--wrap =5F=5Fselect64
--wrap =5F=5Fioctl=5Ftime64
--wrap =5F=5Fgettimeofday64
--wrap =5F=5Ftime64
--wrap =5F=5Fnanosleep64

> 
> Just to make that clear again: The time64 wrappers should only be
> active/enabled when building an 32 bit application with time64=5Ft su=
pport
> requested.
> 
> Is that the case on your end?
> 

I use xeno-config --ldflags --posix which gives me (among others) :
 -Wl,@/opt/sdk=5Frecorder/sysroots/cortexa9hf-neon-oe-linux-gnueabi/usr=
/lib/cobalt-glibc-time64.wrappers
 -Wl,@/opt/sdk=5Frecorder/sysroots/cortexa9hf-neon-oe-linux-gnueabi/usr=
/lib/cobalt.wrappers

> Have you checked that the CFLAGS provided by the xeno-config utility =
are
> correctly forwarded to your build environment? Maybe the time64 wrapp=
ing
> related flags are missing?

and xeno-config --cflags --posix gives me (among others) :
 -D=5FTIME=5FBITS=3D64 -D=5FFILE=5FOFFSET=5FBITS=3D64 -D=5F=5FCOBALT=5F=
=5F -D=5F=5FCOBALT=5FWRAP=5F=5F

> 
> Best regards,
> Florian
> 
> 
 
Fran=C3=A7ois

