Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07949371868
	for <xenomai@lists.linux.dev>; Mon,  5 Oct 2026 07:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791184387; cv=none; b=XPmG7146jL7SS6c1V1k/Y+cQG01UjcxX7LH85xqBhFb5hQ5yMrYtNggyLBu4wL5A73M+iOotcYINu2JDGKgJVJQNp5xzzY9yf+bWCOtwvYRTHP9SuC/mSV2vpKuDlikKSYh7ZIXjtJOO1WEYb5+S15dX/nA/Pel1NrXJPTh8jMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791184387; c=relaxed/simple;
	bh=Xx65C6Ugs2KqX4jIpbdXPpyaSjKJWzvPRVoeZ/Ox+YA=;
	h=From:In-Reply-To:Content-Type:Date:Cc:To:MIME-Version:Message-ID:
	 Subject; b=QODAY901fQh42kBFoEelLhUlNB9AU/wzLtIAUuNUqT9CzTJA8uqw1Ow4kjqNQGqvmqTWHcVCP4bUQa4RBKyNETTr/quLZcP8kaifYP84W45CnT9P65bT8xC5Ux0VjCO9wwdFGTmyvipkfKTf8PgJHGn6sEuZQQrnYwrdwvaBeds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eventlab.fr; spf=pass smtp.mailfrom=eventlab.fr; dkim=permerror (0-bit key) header.d=eventlab.fr header.i=@eventlab.fr header.b=vDv+QVlv; arc=none smtp.client-ip=212.27.42.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eventlab.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eventlab.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=eventlab.fr header.i=@eventlab.fr header.b="vDv+QVlv"
Received: from mail.thom.fr.eu.org (unknown [82.64.149.25])
	by smtp6-g21.free.fr (Postfix) with ESMTPS id 6CD6E780383;
	Mon,  5 Oct 2026 09:12:54 +0200 (CEST)
Authentication-Results: smtp6-g21.free.fr;
	dkim=permerror header.d=eventlab.fr header.i=@eventlab.fr header.a=ed25519-sha256 header.s=default header.b=vDv+QVlv;
	dkim-atps=neutral
Received: from localhost ([127.0.0.1])
	by mail.thom.fr.eu.org (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTP id 6957Cpte342622;
	Mon, 5 Oct 2026 09:12:52 +0200
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple; d=eventlab.fr;
	s=default; t=1791184372;
	bh=Xx65C6Ugs2KqX4jIpbdXPpyaSjKJWzvPRVoeZ/Ox+YA=;
	h=From:In-Reply-To:Date:Cc:To:Subject;
	b=vDv+QVlvqCBPZ2QMsrJNtFLOmm1cj4VVdcMEFNdwnZP85UhROeLFnAPTBUA4UB5aP
	 DZTo9011UZZNWNL9me4P1mHt2On+TFUu+ZpMhHjtZiUVcXxUuIeTr+Lu5xks1adKfg
	 6IXwN251zRNwNnwzkxyJZOgCUSLIb4CTCXgqxM9nEeuNouyfPGMsGY7Aa93G0nNp27
	 SK/9z/SSMVw4wUdCH1Xn23sC8GWaypjPWX1ZrHPx9f1Vx3WCz4d9OrqT9Txz+59EMt
	 GFn2zHh0T8L0cer2KILxUNEJoWNMh/rvUbnd7tqwu++m3kKqB16Q/u5vvIj1dhgsIV
	 uUU2OMCS93yzw==
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <francois.legal@eventlab.fr>
In-Reply-To: <eb7384fa-b236-4420-bffa-9ee5a24893e1@siemens.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 80.13.28.252, 194.9.100.114
Date: Mon, 05 Oct 2026 09:12:51 +0200
Cc: xenomai@lists.linux.dev
To: "Jan Kiszka" <jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <1209-6ac34e00-5f-5a2d1100@131661574>
Subject: =?utf-8?q?Re=3A?= Problem with timer on zynq 7000 platform
User-Agent: SOGoMail 5.0.1
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 1.4.3 at tls-srv-02
X-Virus-Status: Clean

Le Vendredi, Octobre 02, 2026 20:02 CEST, Jan Kiszka <jan.kiszka@siemen=
s.com> a =C3=A9crit: 
 
> On 02.10.26 17:11, Fran=C3=A7ois Legal wrote:
> > I ended up switching to Xenomai 3.3 + dovetail (linux 6.12 for now)=
 to fix my monotonic clock diverging between userland and kernel.
> > 
> > But now another problem arises. I'm using posix timer to trig certa=
in actions. And since the switch, those actions don't fire any more.
> > For example, if I set up a timer to fire at next second, it does no=
t. Checking /proc/xenomai/timer/coreclk, I kind of see something happen=
 :
> > CPU  SCHED/SHOT            TIMEOUT     INTERVAL    NAME
> > 0    294672/247088         3ms253us    -           [host-timer/0]
> > 0    6/0                   -           -           [watchdog]
> > 1    227779/211523         3ms247us    -           [host-timer/1]
> > 1    38/0                  -           -           [watchdog]
> > 1    1/0                   4789309920  949011081s  cobalt=5Ftimer=5F=
handler
> > 
> > I guess the last lime correspond to my timer, but the timeout does =
not really match my expectation, and the interval should be 0.
> > 
> > It looks like I'm having a time vs time64 issue, but I not sure how=
 to get through this.
> > 
> 
> Can you be more specific which API(s) you are using?
> 
> And if you suspect a time64=5Ft issue, how did you compile you app? A=
re
> you using the flags emitted by xeno-config? You may also try to disab=
le
> time64=5Ft support via --disable-y2038 when configuring Xenomai userl=
and,
> to either confirm or rebut the theory.
> 

I'm using this :
    ret =3D timer=5Fcreate (CLOCK=5FMONOTONIC, & timeEvent, & Timer);
    TimerInfo.it=5Fvalue.tv=5Fsec =3D 1;
    TimerInfo.it=5Fvalue.tv=5Fnsec =3D NSEC=5FIN=5FA=5FSECOND - startTi=
me.tv=5Fnsec;

    ret =3D timer=5Fsettime (Timer, 0, &TimerInfo, NULL);
    sigwaitinfo (&Signals, &signalinfo);

I used the flags given by xeno-config to build the app, yes, but I figu=
red out my built system garbled xeno-config CFLAGS regarding -D=5FTIME=5F=
BITS=3D64 -D=5FFILE=5FOFFSET=5FBITS=3D64

So this is a non problem.
Sorry for the noise

Fran=C3=A7ois
 
> Jan
> 
> -- 
> Siemens AG, Foundational Technologies
> Linux Expert Center

