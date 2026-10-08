Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892F04A49BC
	for <xenomai@lists.linux.dev>; Thu,  8 Oct 2026 13:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791466056; cv=none; b=cAG23g/64RIa5pmj3oLNSGTmhPZGa3dIkz61Dfh27GkCtMBLdqXZFdfghwjt1MIvsD4pnLZmdfM11JBkp70qYRgVGV2Tbv0UAT6330qFPSKOQCVEUNQttVuqFc1Evid0xa0zQsKeq+sMioFBbE4xprNq+2TzgQk21QoupQZdwsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791466056; c=relaxed/simple;
	bh=+1JCDGWQB5drT3BAKax3ha1RGsLyOp2Qbc9Om6FWLqE=;
	h=From:In-Reply-To:Content-Type:Date:Cc:To:MIME-Version:Message-ID:
	 Subject; b=kfdSgpwr2ukkbd/KBcY1g0o0Pkjm/LdpR6yMXKdX3mGZsUiAHLfKm/txL3Tuml89qlZsdbxb1cJGZqcmO7pfmW9dJvYB9kNKRppxntffcFhI9p1DpwjbULym3i0Z0yVrWF0t+Gb4gMRbDAYyHSwRbsk8CaV8FzkVrOb10HoHYeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eventlab.fr; spf=pass smtp.mailfrom=eventlab.fr; dkim=permerror (0-bit key) header.d=eventlab.fr header.i=@eventlab.fr header.b=S4u5ixhF; arc=none smtp.client-ip=212.27.42.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eventlab.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eventlab.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=eventlab.fr header.i=@eventlab.fr header.b="S4u5ixhF"
Received: from mail.thom.fr.eu.org (unknown [82.64.149.25])
	by smtp6-g21.free.fr (Postfix) with ESMTPS id 76414780509;
	Thu,  8 Oct 2026 15:27:29 +0200 (CEST)
Authentication-Results: smtp6-g21.free.fr;
	dkim=permerror header.d=eventlab.fr header.i=@eventlab.fr header.a=ed25519-sha256 header.s=default header.b=S4u5ixhF;
	dkim-atps=neutral
Received: from localhost ([127.0.0.1])
	by mail.thom.fr.eu.org (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTP id 698DRRlx492753;
	Thu, 8 Oct 2026 15:27:27 +0200
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple; d=eventlab.fr;
	s=default; t=1791466047;
	bh=+1JCDGWQB5drT3BAKax3ha1RGsLyOp2Qbc9Om6FWLqE=;
	h=From:In-Reply-To:Date:Cc:To:Subject;
	b=S4u5ixhF32JEZZ9g3LiZTisD6XksF3yB9IDXQLMGP3acCd2eoS9Jq6sCmdHBSzj8F
	 LvZulCQZtrEYD7qkzGoYFkceTkNbIoWXqAgxgNwqmCw5cKqZAOY9+KGhPTYUlpDWLK
	 XSiRB+wjFZnk8GANPNawjqNXWKVGArP+R+gPOjs2nuMr0sIvj70ihIuro9W69eIQTA
	 rSDKzoFfW2jT/4NGo6TVSFTYu8vfipvmzIZtf0wAxWDfL6CQQmvn7C/hAc34cBE8CK
	 z6Bk4kyQgiDIf8JrK71vdN/vmmIQKG+aJjhfnB6JNJKZEWUW1DUIOSM3HO5S9aJMZm
	 I9qW6XhVjPlQA==
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <francois.legal@eventlab.fr>
In-Reply-To: <33a2d74603987c026bbe1a6647b8d74b846fad38.camel@siemens.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 217.109.173.233, 194.9.103.72
Date: Thu, 08 Oct 2026 15:27:27 +0200
Cc: "Jan Kiszka" <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
To: "Florian Bezdeka" <florian.bezdeka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <1207-6ac79a00-41-3e404bc0@80344945>
Subject: =?utf-8?q?Re=3A?= [patch] fixed missing time64 wrappers
User-Agent: SOGoMail 5.0.1
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 1.4.3 at tls-srv-02
X-Virus-Status: Clean

Le Jeudi, Octobre 08, 2026 15:14 CEST, Florian Bezdeka <florian.bezdeka=
@siemens.com> a =C3=A9crit: 
 
> On Thu, 2026-10-08 at 14:33 +0200, Jan Kiszka wrote:
> > On 08.10.26 11:48, Fran=C3=A7ois Legal wrote:
> > > There are missing wrappers for 64 bits time in xenomai 3.3 :
> > > - =5F=5Frecvmsg64
> > > - =5F=5Fsendmsg64
> > > - =5F=5Fsendmmsg64
> > > 
> > 
> > Hmm, where do these functions carry a timeout? I thought they only =
do
> > implicitly, set upfront via socket options? But maybe is still too =
early
> > for me today.
> 
> Something like that is the problem:
> 
> recvmsg(fd, &msghdr, flags)
>             |
>             +-- msg=5Fcontrol ------> ancillary data
>                                   |
>                                   +-- SCM=5FTIMESTAMP
>                                   +-- SCM=5FTIMESTAMPNS
>                                   +-- SCM=5FTIMESTAMPING
> 

I thought about that too (and I might be the one who contributed the pa=
tch to bring timestamping events IIRC) but it happens that the values r=
eturned in these ancillary data are in the form of a 64 bits integer wh=
ich unity is a nanosecond, so we don't really care about time64 here.

At least that's my understanding.

Fran=C3=A7ois

> That "nesting" is quite likely the problem why I initially missed it.=

> 
> I have to look into the details again. Most likely a separate syscall=
 or
> a different routing of the syscall might be necessary. IOW this patch=

> might be incomplete.
> 
> > 
> > Jan
> > 
> > > Signed-off-by: Fran=C3=A7ois LEGAL <devel@thom.fr.eu.org>
> > > ---
> > > diff --git a/lib/cobalt/cobalt-glibc-time64.wrappers b/lib/cobalt=
/cobalt-glibc-time64.wrappers
> > > index 0bf895ca9..483a8ce24 100644
> > > --- a/lib/cobalt/cobalt-glibc-time64.wrappers
> > > +++ b/lib/cobalt/cobalt-glibc-time64.wrappers
> > > @@ -8,7 +8,10 @@
> > > =C2=A0 --wrap =5F=5Fmq=5Ftimedsend=5Ftime64
> > > =C2=A0 --wrap =5F=5Fmq=5Ftimedreceive=5Ftime64
> > > =C2=A0 --wrap =5F=5Fsigtimedwait64
> > > +--wrap =5F=5Frecvmsg64
> > > =C2=A0 --wrap =5F=5Frecvmmsg64
> > > +--wrap =5F=5Fsendmsg64
> > > +--wrap =5F=5Fsendmmsg64
> > > =C2=A0 --wrap =5F=5Fpthread=5Fcond=5Ftimedwait64
> > > =C2=A0 --wrap =5F=5Ftimer=5Fsettime64
> > > =C2=A0 --wrap =5F=5Ftimer=5Fgettime64
> > > diff --git a/lib/cobalt/rtdm.c b/lib/cobalt/rtdm.c
> > > index 00c1aaf4b..264de8ace 100644
> > > --- a/lib/cobalt/rtdm.c
> > > +++ b/lib/cobalt/rtdm.c
> > > @@ -254,7 +254,7 @@ static ssize=5Ft do=5Frecvmsg(int fd, struct =
msghdr *msg, int flags)
> > > =C2=A0=C2=A0	return ret;
> > > =C2=A0 }
> > > =C2=A0 
> > > -COBALT=5FIMPL(ssize=5Ft, recvmsg, (int fd, struct msghdr *msg, i=
nt flags))
> > > +COBALT=5FIMPL=5FTIME64(ssize=5Ft, recvmsg, =5F=5Frecvmsg64, (int=
 fd, struct msghdr *msg, int flags))
> > > =C2=A0 {
> > > =C2=A0=C2=A0	int ret;
> > > =C2=A0 
> > > @@ -301,7 +301,7 @@ static ssize=5Ft do=5Fsendmsg(int fd, const s=
truct msghdr *msg, int flags)
> > > =C2=A0=C2=A0	return ret;
> > > =C2=A0 }
> > > =C2=A0 
> > > -COBALT=5FIMPL(ssize=5Ft, sendmsg, (int fd, const struct msghdr *=
msg, int flags))
> > > +COBALT=5FIMPL=5FTIME64(ssize=5Ft, sendmsg, =5F=5Fsendmsg64, (int=
 fd, const struct msghdr *msg, int flags))
> > > =C2=A0 {
> > > =C2=A0=C2=A0	int ret;
> > > =C2=A0 
> > > @@ -312,7 +312,7 @@ COBALT=5FIMPL(ssize=5Ft, sendmsg, (int fd, co=
nst struct msghdr *msg, int flags))
> > > =C2=A0=C2=A0	return =5F=5FSTD(sendmsg(fd, msg, flags));
> > > =C2=A0 }
> > > =C2=A0 
> > > -COBALT=5FIMPL(int, sendmmsg, (int fd, struct mmsghdr *msgvec,
> > > +COBALT=5FIMPL=5FTIME64(int, sendmmsg, sendmmsg64, (int fd, struc=
t mmsghdr *msgvec,
> > > =C2=A0=C2=A0			=C2=A0=C2=A0=C2=A0 unsigned int vlen, unsigned int=
 flags))
> > > =C2=A0 {
> > > =C2=A0=C2=A0	int ret, oldtype;
> > > 
> > > 
> > 
> > 
> > --
> > Siemens AG, Foundational Technologies
> > Linux Expert Center

