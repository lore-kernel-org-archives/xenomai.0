Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.27.42.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794499187;
	b=KX5PjHUana3BdGRySLi5ZbiNB5H1yx48m5HErrH0A4cT8YSeneE0RCIBdyUS46m06CbZ
	 Aow2oeoxHqqmQZMgO7+bDUVUIIcQQaDfgPjsUsC9Jg93qgkXbHaw474Ou/WrKL74l1IXW
	 fQb8+J6owrLeyWn2IYWqX2dJiQTfCJksf165tFrK5NbPWqiEbKc2Ags7Re7LIL1sj8LJm
	 G0RI4EdZLu+CPgkd6/d6n0FiGozkhx9Lw44xD8m7OLvFftj4w8bsUWybrKjRoLgnYYGc4
	 0ngL9v4SEha9c51QvUSyHX6PRS8EVk9ZpPkx6slC5RiioKqANETrGKgZTcCi7qEW6ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794499187;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:In-Reply-To:
	 Content-Type:X-Forward:Date:Cc:To:MIME-Version:Message-ID:Subject:
	 User-Agent:Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status;
	bh=aycR3AlneJDvjj8PWvdhDzeZSzLSWiBzZT819/Za05A=;
	b=Dib+y3iKRnlkNua3U4abpRHYwDf0+aPkiTH7nbQ/Vshp6AQZzvo8UbubebJzG9kykB3C
	 ibqvlNWglMNoZTRsBEVha8JiPTgPI7M52UTTq07B/doZnOY1s0oarVBS/x/zaION+OKZg
	 MwBhfxxCr84juKWeQck4K24Lh7DOneTWVr23ik9MIza6Ao+WLD+GbRpDHRjsD/ll6U0aE
	 4B9IQp0Ame77JfxO5fv3TzrsIKg53KgB1jw3afAKlXt1bswSlOXuw/CwKGnrkf+1JcEMq
	 xz49MesTY5v/JNGOqiMsQn5HcV7I577VqbC54W3K6IYnuKVy+aB06D9SLbVgMN3ETLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=eventlab.fr;
	spf=pass smtp.mailfrom=eventlab.fr;
	dkim=permerror header.d=eventlab.fr header.i=@eventlab.fr header.a=ed25519-sha256 header.s=default header.b=mEPm6Tv7;
	arc=none smtp.remote-ip=212.27.42.6
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49E2606A31C
	for <xenomai@lists.linux.dev>; Thu, 12 Nov 2026 15:59:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C49E2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eventlab.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eventlab.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror header.d=eventlab.fr header.i=@eventlab.fr header.a=ed25519-sha256 header.s=default header.b=mEPm6Tv7
Received: from mail.thom.fr.eu.org (unknown [82.64.149.25])
	by smtp6-g21.free.fr (Postfix) with ESMTPS id C2D50780395;
	Thu, 12 Nov 2026 16:59:42 +0100 (CET)
Authentication-Results: smtp6-g21.free.fr;
	dkim=permerror header.d=eventlab.fr header.i=@eventlab.fr header.a=ed25519-sha256 header.s=default header.b=mEPm6Tv7;
	dkim-atps=neutral
Received: from localhost ([127.0.0.1])
	by mail.thom.fr.eu.org (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTP id 6ACFxfoN2917296;
	Thu, 12 Nov 2026 16:59:42 +0100
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple; d=eventlab.fr;
	s=default; t=1794499182;
	bh=vai5JOIoQ9ZCgMhKR1mXcEA0kLuLO6s4MzfKJ5bii8k=;
	h=From:In-Reply-To:Date:Cc:To:Subject;
	b=mEPm6Tv7NQlCjwAnWVO5gKoSl33SI8xr6L7OYP6vEuXN5dZO5Ui6VT9cEffE5jtwY
	 DzTIvSV8mZGJuAZSKnJQFh6Nhyggpmh9ntWXUXEQeiHePamwGkZPOfzkNF/MAOMqrJ
	 hNf5aBgH+i3jjTTS7EGr5hKJYVkx6IUFD0p0zUcz3OUP9rQ0Slz2yu486poSB9T/an
	 v4VLfD6wMS3t+37Cmi5KWH8ljJ4OhtX8H2k6HHiAxStEMOJqnCRllp/woWEr2k5dAC
	 7RQD9lPdtJjdIlyOoF6Kz3H2Z8tPIbFohUM4CBjSGhke+HPXJG5THY5RS+9s/54VBa
	 2oPHEQEHVRVMw==
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <francois.legal@eventlab.fr>
In-Reply-To: <4b4fedb4-ba63-4be0-9561-405f9c6d3950@siemens.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 80.13.28.252, 194.9.100.114
Date: Thu, 12 Nov 2026 16:59:41 +0100
Cc: xenomai@lists.linux.dev
To: "Jan Kiszka" <jan.kiszka@siemens.com>
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Message-ID: <1209-6af5e280-177-5a2d1100@131733382>
Subject: =?utf-8?q?Re=3A?= New issue with 64 bits wrapper
User-Agent: SOGoMail 5.0.1
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 1.4.3 at tls-srv-02
X-Virus-Status: Clean

Le Jeudi, Novembre 12, 2026 16:35 CET, Jan Kiszka <jan.kiszka@siemens.c=
om> a =C3=A9crit: 
 
> On 12.11.26 15:34, Fran=C3=A7ois Legal wrote:
> > Still in the process of porting my app to linux 6.12/x3.3, I've got=
 a build issue regarding mmap.
> > Arch is arm.
> > 
> > if I build a function that calls mmap without =5F=5FSTD decoration,=
 it gets translated to 
> > bl	0 <mmap64>
> > by the compiler.
> > However, when I use the =5F=5FSTD decoration, it gets translated to=

> > bl	0 <=5F=5Freal=5Fmmap>
> > 
> > which itself fails because the real mmap expects the offset be a 32=
 bits integer, which is it not.
> > 
> > So I wondering whether the definitions in cobalt/sys/mman.h
> > COBALT=5FDECL(void *, mmap,
> > 	    (void *addr, size=5Ft length, int prot, int flags, int fd,
> > 	     off=5Ft offset));
> > 
> > #if defined(=5FLARGEFILE64=5FSOURCE) || defined(=5FGNU=5FSOURCE)
> > COBALT=5FDECL(void *, mmap64,
> > 	    (void *addr, size=5Ft length, int prot, int flags, int fd,
> > 	     off64=5Ft offset));
> > #endif
> > 
> > should be replaced with
> > 
> > COBALT=5FDECL=5FTIME64(void *, mmap, mmap64,
> > 	    (void *addr, size=5Ft length, int prot, int flags, int fd,
> > 	     off=5Ft offset));
> > 
> 
> Xenomai version? Would [1] help?
> 
> Jan
> 
> [1] https://gitlab.com/Xenomai/xenomai3/xenomai/-/commit/0bb6608b6fa7=
129de1ff4213ddf31298616cbf23
> 
> -- 
> Siemens AG, Foundational Technologies
> Linux Expert Center
 
Hi Jan.

it's xenomai 3.3.

I don't believe [1] would help. I'm on ARM with -D=5FFILE=5FOFFSET=5FBI=
TS=3D64.
In these conditions, mmap as its last parameter offset as a 64 bits int=
eger, an thus mmap64 should be called. Always.


Looking at [1], the decorated =5F=5Freal=5Fmmap still calls mmap which =
is wrong in my case. I believe what is supposed to be fixed by [1] is o=
nly partial (the =5F=5Fcobalt=5Fmmap should work).

Fran=C3=A7ois

