Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.27.42.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794501447;
	b=2+BXRyAi12FasNPFZw2fpfnmepsywcMjZkd95ulzQPk5SeYJkMjEveEg7yhGXiNIA+Ju
	 o2cu+tJoHyomsrFWpY0NIXnDwzI7IS0CElcYD1nW84xDaLeBMwYvCpL6yhsdQ8ganN6EG
	 uNZW99Zmc7Nuk4lcKRLIPCkZF+aCIk1mWiNWsAlsVbw3XAT2vEDPGNngCsbaBMQl5iIHX
	 71hCZertcH3zdt1bqTVnPSfzMq2TZrICOkGl9YcnoaaOl5yyyINkzR4U5w3CQfv3uAgtw
	 oPd7pZ7R+tXCZyYo6iMZrsDX6A/ZFwau4VPcB69iqgVUurQuoXyZERqAmI8YZ9hU0lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794501447;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:In-Reply-To:
	 Content-Type:X-Forward:Date:Cc:To:MIME-Version:Message-ID:Subject:
	 User-Agent:Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status;
	bh=q+H+qjC9LuIIL28Y8TQU9pSs+93M8yUshlUcXX7rwJE=;
	b=fvJ15SmwBwQb6YOG8lJrpN5a5uB4S9I619RFs3Es62KMLUjDZgV0HjOdt8KWG0DSxNRe
	 MnbiKUuvgZjbFRu/MpTsAB1LZX2i0zD6qghQJPGJh31lh9EPI9zovCy1jqb9x1pq1FWz0
	 R01svucxQ2OVi8Q9E+N9apu9CO9+EZDeXM5pbnZ8gJ31C9QBbS64bohF1+2P1w6+sILhG
	 AuCJ2wrRdxpU33/6THkP3xr5x77jC/s3ge9ZmFVRegKms9VoyB5Wz4WEAnuEXklPLjfxy
	 nkQs+66oG5gBMpGkG61ggHnOj3P+RMvvGuqToAa+WlOBb+69ZqzeYQBxYxBJZ1y4IWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=eventlab.fr;
	spf=pass smtp.mailfrom=eventlab.fr;
	dkim=permerror header.d=eventlab.fr header.i=@eventlab.fr header.a=ed25519-sha256 header.s=default header.b=DSakZna+;
	arc=none smtp.remote-ip=212.27.42.6
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14913606A32E
	for <xenomai@lists.linux.dev>; Thu, 12 Nov 2026 16:37:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14913606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eventlab.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eventlab.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror header.d=eventlab.fr header.i=@eventlab.fr header.a=ed25519-sha256 header.s=default header.b=DSakZna+
Received: from mail.thom.fr.eu.org (unknown [82.64.149.25])
	by smtp6-g21.free.fr (Postfix) with ESMTPS id 8E6A6780506;
	Thu, 12 Nov 2026 17:37:23 +0100 (CET)
Authentication-Results: smtp6-g21.free.fr;
	dkim=permerror header.d=eventlab.fr header.i=@eventlab.fr header.a=ed25519-sha256 header.s=default header.b=DSakZna+;
	dkim-atps=neutral
Received: from localhost ([127.0.0.1])
	by mail.thom.fr.eu.org (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTP id 6ACGbL702918961;
	Thu, 12 Nov 2026 17:37:22 +0100
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple; d=eventlab.fr;
	s=default; t=1794501443;
	bh=1MgCsURFVYBzSfzX2wEo8XE4VR4Mn4N+bru7FzQOkvw=;
	h=From:In-Reply-To:Date:Cc:To:Subject;
	b=DSakZna+91+vP1LSc5uuYK/+8DDQmMdY0SASiPjDqRYAihjegNjwg2A9+Rh+p013I
	 ATFvP1LBGBWb5ENQKSOo1jdiY/H7rCT6siW8nwzux59v4TP4h0voFR7l1it99YHieL
	 DD8007BpLAj6rYbQcFLbUgEvDFueRrTtd7PY3YiOyrUTCk1Q0JLoUvBctM4LXhWHXA
	 VrxXoxpekWLN5fAQunEeLplHR412OLh3P4oAaP8KL+K3LSR7NjvM24b9i0EYItrfhK
	 s0H7POzMT8x+Tw7DcjYB/LcLbklk98QM8rOW5WWB8yJ6k62irfbXnEO/hMQKMVBUbw
	 a4JTQ4t/NG75Q==
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <francois.legal@eventlab.fr>
In-Reply-To: <e321f2b8-7074-4e2e-8db3-3bf50232903c@siemens.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 217.109.173.233, 194.9.103.72
Date: Thu, 12 Nov 2026 17:37:21 +0100
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
Message-ID: <115efd-6af5eb80-27-36f80d40@101055125>
Subject: =?utf-8?q?Re=3A?= New issue with 64 bits wrapper
User-Agent: SOGoMail 5.0.1
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 1.4.3 at tls-srv-02
X-Virus-Status: Clean

Le Jeudi, Novembre 12, 2026 17:31 CET, Jan Kiszka <jan.kiszka@siemens.c=
om> a =C3=A9crit: 
 
> On 12.11.26 16:59, Fran=C3=A7ois Legal wrote:
> > Le Jeudi, Novembre 12, 2026 16:35 CET, Jan Kiszka <jan.kiszka@sieme=
ns.com> a =C3=A9crit: 
> >  
> >> On 12.11.26 15:34, Fran=C3=A7ois Legal wrote:
> >>> Still in the process of porting my app to linux 6.12/x3.3, I've g=
ot a build issue regarding mmap.
> >>> Arch is arm.
> >>>
> >>> if I build a function that calls mmap without =5F=5FSTD decoratio=
n, it gets translated to 
> >>> bl	0 <mmap64>
> >>> by the compiler.
> >>> However, when I use the =5F=5FSTD decoration, it gets translated =
to
> >>> bl	0 <=5F=5Freal=5Fmmap>
> >>>
> >>> which itself fails because the real mmap expects the offset be a =
32 bits integer, which is it not.
> >>>
> >>> So I wondering whether the definitions in cobalt/sys/mman.h
> >>> COBALT=5FDECL(void *, mmap,
> >>> 	    (void *addr, size=5Ft length, int prot, int flags, int fd,
> >>> 	     off=5Ft offset));
> >>>
> >>> #if defined(=5FLARGEFILE64=5FSOURCE) || defined(=5FGNU=5FSOURCE)
> >>> COBALT=5FDECL(void *, mmap64,
> >>> 	    (void *addr, size=5Ft length, int prot, int flags, int fd,
> >>> 	     off64=5Ft offset));
> >>> #endif
> >>>
> >>> should be replaced with
> >>>
> >>> COBALT=5FDECL=5FTIME64(void *, mmap, mmap64,
> >>> 	    (void *addr, size=5Ft length, int prot, int flags, int fd,
> >>> 	     off=5Ft offset));
> >>>
> >>
> >> Xenomai version? Would [1] help?
> >>
> >> Jan
> >>
> >> [1] https://gitlab.com/Xenomai/xenomai3/xenomai/-/commit/0bb6608b6=
fa7129de1ff4213ddf31298616cbf23
> >>
> >> -- 
> >> Siemens AG, Foundational Technologies
> >> Linux Expert Center
> >  
> > Hi Jan.
> > 
> > it's xenomai 3.3.
> > 
> > I don't believe [1] would help. I'm on ARM with -D=5FFILE=5FOFFSET=5F=
BITS=3D64.
> > In these conditions, mmap as its last parameter offset as a 64 bits=
 integer, an thus mmap64 should be called. Always.
> > 
> > 
> > Looking at [1], the decorated =5F=5Freal=5Fmmap still calls mmap wh=
ich is wrong in my case. I believe what is supposed to be fixed by [1] =
is only partial (the =5F=5Fcobalt=5Fmmap should work).
> > 
> 
> These mapping/wrapping topics always cause headache to me. That's why=
 I
> threw the fix I recalled at you, though also because I think it came
> from a compat x86 scenario.
> 
> Regarding your change proposal: It's likely pointing in the right
> direction, except that TIME64 would at least be a misnomer because th=
e
> actual control here is behind 64-bit for offset - although (not only)=
 we
> demand to couple both in Xenomai configurations.
> 

That's what I thought too while writing, but it was just to propose a s=
imple and understandable strategy.
I guess I can provide a patch with somethin named like  COBALT=5FDECL=5F=
OFFSET64 that follows the same logic  COBALT=5FDECL=5FTIME64 does.

Tell me if it's ok.

Fran=C3=A7ois

> Jan
> 
> -- 
> Siemens AG, Foundational Technologies
> Linux Expert Center

