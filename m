Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.27.42.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794507035;
	b=NwrW03fu+eg5vshvzDjE3p6xXETd1EowsQuDFUl/erSM/0oiHm0KG0JnICOlLPgVR9dK
	 PYXsNTztfKimiQKYiXEIosI4J65jR7BQrJ7fd5e6dXgbEm9HQkaM8mVMixKyfALmVhfn5
	 0Q1T0zU2QNAAMErED6sVU9S1yklWkREnUDKw2yPRPJcqKQZiUebYLO2QuMl1sq8ZCveGx
	 kJNeXjm1DZJRIAXY/5MipH3Le3wCP/h4ZFxYjOtjPxwXMmechsqh+O4gfk0ODJklOyzTp
	 0Y/4rrRE+w/5iSkId88lF6GdvNZ7/uieRZDrAY5+VFB9/Sinw3cmiqL9aAZQ2wIoRYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794507035;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:In-Reply-To:
	 Content-Type:X-Forward:Date:Cc:To:MIME-Version:Message-ID:Subject:
	 User-Agent:Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status;
	bh=74OEP4eqwIHZSw6eOc5Rv42lbkUW1GVsZAMhuIAOY/E=;
	b=tBBKzRoaQp/FCnj7Jfht8rRLt22BcOR2lC3nHu7iVdZFWKIyl6BAXcdeGO34FWADD+Gh
	 ctkjIjDSrOYbaV1S/eb1n4T0PdJXl8VAchMGxhW6FMjRn1UijDumuIRUqOAhRDqltWCUU
	 HgiZ8gD61zQhLb5J225IKJCD7OrvnRHgyu8PStfB8Xh7WaqvBjMPwpBBJ+PgbDdhwd/99
	 sjKD9nWskdOXY+H5NaETFKFLPBnlKCIvmm4MPH6/huXWahbLizAzIqcDbLaOO+dFEN28y
	 u3yjYua0iBeyp9gGk6cXVYlasM8Zm07m6YLHd3NdN56MP7O+z+ipKd+Y9ystuk1CKIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=eventlab.fr;
	spf=pass smtp.mailfrom=eventlab.fr;
	dkim=permerror header.d=eventlab.fr header.i=@eventlab.fr header.a=ed25519-sha256 header.s=default header.b=i3ygr0fr;
	arc=none smtp.remote-ip=212.27.42.6
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C0B606A321
	for <xenomai@lists.linux.dev>; Thu, 12 Nov 2026 18:10:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5C0B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eventlab.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eventlab.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror header.d=eventlab.fr header.i=@eventlab.fr header.a=ed25519-sha256 header.s=default header.b=i3ygr0fr
Received: from mail.thom.fr.eu.org (unknown [82.64.149.25])
	by smtp6-g21.free.fr (Postfix) with ESMTPS id 316F27803A2;
	Thu, 12 Nov 2026 19:10:32 +0100 (CET)
Authentication-Results: smtp6-g21.free.fr;
	dkim=permerror header.d=eventlab.fr header.i=@eventlab.fr header.a=ed25519-sha256 header.s=default header.b=i3ygr0fr;
	dkim-atps=neutral
Received: from localhost ([127.0.0.1])
	by mail.thom.fr.eu.org (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTP id 6ACIAUFs2922663;
	Thu, 12 Nov 2026 19:10:31 +0100
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple; d=eventlab.fr;
	s=default; t=1794507031;
	bh=dmMJdcfJumjCa7ik9xqaU6pUjhiYqcbpnmJQCOWOGzo=;
	h=From:In-Reply-To:Date:Cc:To:Subject;
	b=i3ygr0fr3IlyhPuZfJUqVd1qoLNFwqqHp29fogDPX7F89d9b443XKT8hbfZLcsmsJ
	 iD4gqQ54hTV4ZzMKYuhngMyHaoaIwrLLS/0E2i0+M6QZOSrHvnVMglKFA7r3pihetG
	 6lydkPDVuD8626YL8Cslpnj6OWQ5DXehcqE/vO1I1svHBjBouaSjyc6ZrOiRnppvvj
	 MUzWvU6vIZzWLI/cJktMRUjk/Ypi0fGdoP3ceH6fPJVzLKueXUOOzuYwit4ZztIhcm
	 VLi0k5cCn6Nk39LFF7g+h6tRfc4ITVQUrEzjXL0ikMcWImA3e/okBMIFzTl/xBt4ZD
	 AoEv4Bpb2pWzQ==
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <francois.legal@eventlab.fr>
In-Reply-To: <bd84bf4b-12e7-462b-8fcc-6180a737fe27@siemens.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 217.109.173.233, 194.9.103.72
Date: Thu, 12 Nov 2026 19:10:30 +0100
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
Message-ID: <115efd-6af60100-2f-36f80d40@101055257>
Subject: =?utf-8?q?Re=3A?= New issue with 64 bits wrapper
User-Agent: SOGoMail 5.0.1
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 1.4.3 at tls-srv-02
X-Virus-Status: Clean

Le Jeudi, Novembre 12, 2026 18:00 CET, Jan Kiszka <jan.kiszka@siemens.c=
om> a =C3=A9crit: 
 
> On 12.11.26 17:37, Fran=C3=A7ois Legal wrote:
> > Le Jeudi, Novembre 12, 2026 17:31 CET, Jan Kiszka <jan.kiszka@sieme=
ns.com> a =C3=A9crit: 
> >  
> >> On 12.11.26 16:59, Fran=C3=A7ois Legal wrote:
> >>> Le Jeudi, Novembre 12, 2026 16:35 CET, Jan Kiszka <jan.kiszka@sie=
mens.com> a =C3=A9crit: 
> >>>  
> >>>> On 12.11.26 15:34, Fran=C3=A7ois Legal wrote:
> >>>>> Still in the process of porting my app to linux 6.12/x3.3, I've=
 got a build issue regarding mmap.
> >>>>> Arch is arm.
> >>>>>
> >>>>> if I build a function that calls mmap without =5F=5FSTD decorat=
ion, it gets translated to 
> >>>>> bl	0 <mmap64>
> >>>>> by the compiler.
> >>>>> However, when I use the =5F=5FSTD decoration, it gets translate=
d to
> >>>>> bl	0 <=5F=5Freal=5Fmmap>
> >>>>>
> >>>>> which itself fails because the real mmap expects the offset be =
a 32 bits integer, which is it not.
> >>>>>
> >>>>> So I wondering whether the definitions in cobalt/sys/mman.h
> >>>>> COBALT=5FDECL(void *, mmap,
> >>>>> 	    (void *addr, size=5Ft length, int prot, int flags, int fd,=

> >>>>> 	     off=5Ft offset));
> >>>>>
> >>>>> #if defined(=5FLARGEFILE64=5FSOURCE) || defined(=5FGNU=5FSOURCE=
)
> >>>>> COBALT=5FDECL(void *, mmap64,
> >>>>> 	    (void *addr, size=5Ft length, int prot, int flags, int fd,=

> >>>>> 	     off64=5Ft offset));
> >>>>> #endif
> >>>>>
> >>>>> should be replaced with
> >>>>>
> >>>>> COBALT=5FDECL=5FTIME64(void *, mmap, mmap64,
> >>>>> 	    (void *addr, size=5Ft length, int prot, int flags, int fd,=

> >>>>> 	     off=5Ft offset));
> >>>>>
> >>>>
> >>>> Xenomai version? Would [1] help?
> >>>>
> >>>> Jan
> >>>>
> >>>> [1] https://gitlab.com/Xenomai/xenomai3/xenomai/-/commit/0bb6608=
b6fa7129de1ff4213ddf31298616cbf23
> >>>>
> >>>> -- 
> >>>> Siemens AG, Foundational Technologies
> >>>> Linux Expert Center
> >>>  
> >>> Hi Jan.
> >>>
> >>> it's xenomai 3.3.
> >>>
> >>> I don't believe [1] would help. I'm on ARM with -D=5FFILE=5FOFFSE=
T=5FBITS=3D64.
> >>> In these conditions, mmap as its last parameter offset as a 64 bi=
ts integer, an thus mmap64 should be called. Always.
> >>>
> >>>
> >>> Looking at [1], the decorated =5F=5Freal=5Fmmap still calls mmap =
which is wrong in my case. I believe what is supposed to be fixed by [1=
] is only partial (the =5F=5Fcobalt=5Fmmap should work).
> >>>
> >>
> >> These mapping/wrapping topics always cause headache to me. That's =
why I
> >> threw the fix I recalled at you, though also because I think it ca=
me
> >> from a compat x86 scenario.
> >>
> >> Regarding your change proposal: It's likely pointing in the right
> >> direction, except that TIME64 would at least be a misnomer because=
 the
> >> actual control here is behind 64-bit for offset - although (not on=
ly) we
> >> demand to couple both in Xenomai configurations.
> >>
> > 
> > That's what I thought too while writing, but it was just to propose=
 a simple and understandable strategy.
> > I guess I can provide a patch with somethin named like  COBALT=5FDE=
CL=5FOFFSET64 that follows the same logic  COBALT=5FDECL=5FTIME64 does.=

> > 
> > Tell me if it's ok.
> > 
> 
> My brain-extension suggested COBALT=5FDECL=5FOFF64 as well - please g=
o for that.
> 
> AI also found another issue along that road, will send a patch soon.
> 
> Jan
> 
> -- 
> Siemens AG, Foundational Technologies
> Linux Expert Center
 
Patch sent, which I believe obsoletes [1]

Fran=C3=A7ois

