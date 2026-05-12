Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6DB3B1EEE
	for <xenomai@lists.linux.dev>; Tue, 12 May 2026 14:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778596023; cv=none; b=gmHzA0Pj4RBUPKKPW8zICIrETmuvJMnjo61o/1EWUhkl5TNkA8lTmkKU9C+8ZqeiTNgnuerY5HuarE93MkS2znXp3zcWI8Io1FVbLdiasMP9fPRslD4L7igJUyqFfeqsdq678TJsX0MG171asmTfr+BRH7dTBxOJsH+vZgWxFXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778596023; c=relaxed/simple;
	bh=EVMUCahI2v0iLclG/y7s9xRkSQqEPU5pPOQcfpT1JQ0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=schy8z/E9T7aEYg2mLI1TcT7tU+S7T5trVz2XR6B+izQRBSx5C3IGtpwnpeSdsXFFdIcjms9sGmj++YVDKoA7nWh4kBM/2/eSCdG3fgOi+F7P1in6XJEdl7QAHEYMNIAclzHn4fq781iqchoAGa55y3I4SyZU+7Vr1Wcrb0ckc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=j8VOccC+; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="j8VOccC+"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202605121426543a0c325952000207a7
        for <xenomai@lists.linux.dev>;
        Tue, 12 May 2026 16:26:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=aCSyrGeJMjDEfiw0rjWXqZ0w1caAoIS6j/Cbltwhfm8=;
 b=j8VOccC+qZPYJeTMdmH1VZVEQLwryphL0x3nyvywXDkajfmWqBFHhKzKcyqnjcDBb+TyLY
 OrJzRwehmGmBhjW7z6vKO1gCCoh75I1QdnwlJT6RQui2JwgaDGgUBf/fzfwyvZLdppOGKt5L
 dIHsGcOhqP5RkLE6uxtdZ0ynUDPjZEEWREkBlV5WnhD0GpXcnqsfa8Vse2xM6QsaSP1jrHSe
 vzsJuA1FOfRrYiqHGNXH42WcrZVUKGkB1L7T6UNSCZwNB61HKrKvVGNO2eX/1uKa8K/6AIcY
 +SkN8WX4L1r+6viUwJnbblbjtQppnQbLEq7YSqZMlqyjObE2jz1+oqzA==;
Message-ID: <2211f3a8bcca094721e7537dc2854e27806da237.camel@siemens.com>
Subject: Re: [PATCH] Add build time guard to detect off_t mismatch
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Richard Weinberger <richard.weinberger@gmail.com>, Jan Kiszka
	 <jan.kiszka@siemens.com>
Cc: Richard Weinberger <richard@nod.at>, xenomai <xenomai@lists.linux.dev>
Date: Tue, 12 May 2026 16:26:54 +0200
In-Reply-To: <CAFLxGvw+Bnb_OFaBD8KnPqpY769VMnMeCK-tLxLoUyiE_eSyiA@mail.gmail.com>
References: <20260507122357.2463483-1-richard@nod.at>
	 <945cb32c-88ea-41fa-8223-f3d1e639e9d9@siemens.com>
	 <1863085876.2350.1778157171370.JavaMail.zimbra@nod.at>
	 <3997a44b-0ce4-46b1-a0a2-9ddbed951b5c@siemens.com>
	 <955375516.2805.1778158548523.JavaMail.zimbra@nod.at>
	 <84f6c3a9-b764-4774-b048-eb8e0c7fdc99@siemens.com>
	 <472857942.3063.1778163004494.JavaMail.zimbra@nod.at>
	 <2961c9be-b80f-438e-95b6-a2339f14d738@siemens.com>
	 <CAFLxGvzYXjy3kkZMSiOqFbHgWTOaBccg3oBtVDKbyB97fedfGw@mail.gmail.com>
	 <dfb6996f-1afc-4526-8b47-5972bccb2c39@siemens.com>
	 <CAFLxGvw+Bnb_OFaBD8KnPqpY769VMnMeCK-tLxLoUyiE_eSyiA@mail.gmail.com>
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

On Tue, 2026-05-12 at 15:15 +0200, Richard Weinberger wrote:
> On Tue, May 12, 2026 at 3:08=E2=80=AFPM Jan Kiszka <jan.kiszka@siemens.co=
m> wrote:
> >=20
> > On 12.05.26 15:01, Richard Weinberger wrote:
> > > On Thu, May 7, 2026 at 4:22=E2=80=AFPM Jan Kiszka <jan.kiszka@siemens=
.com> wrote:
> > > > OK, given that Xenomai intercepts the mmap path, we could argue tha=
t
> > > > this is also stable relevant.
> > > >=20
> > > > Can you confirm that this issue is truly gone in next, whatever mod=
e you
> > > > choose on both sides?
> > >=20
> > > Still had no chance to build or run tests with Xenomai next on my ARM=
 boards.
> > > But I had a look at the code.
> > >=20
> > > I think it's still broken, at least for the following scenario:
> > > - 32 bit application built with  _FILE_OFFSET_BITS=3D64
> > > - 32 bit libcobalt without
> > > - application calls mmap() using __RT(mmap), so __cobalt_mmap() in li=
bcobalt
> > > - off_t differs in size ass seen by caller and callee
> >=20
> > A 32-bit app built with _FILE_OFFSET_BITS=3D64 is supposed to call mmap=
64
> > (as symbol). In you scenario above, it should run into an unresolvable
> > symbol error.
>=20
> Hmm, not here.
> I'm building Xenomai with:  CFLAGS=3D"-m32" ./configure && make -j 8 inst=
all
> Then a program which does __RT(mmap):

__RT() might be the problem here. You will end up in __cobalt_mmap()
unconditionally, right? Does migrating to mmap() with all the wrapping
magic help here?

Probably the same question as we had for the time_t related services: Do
we want one libcobalt build to support both worlds at the same time?=20

> $ gcc -o hog hog.c -m32 -D_FILE_OFFSET_BITS=3D64
> $(/usr/xenomai/bin/xeno-config --cflags --skin=3Dposix --ldflags)
> $   nm hog|grep mmap
>         U __cobalt_mmap
>=20
> --=20
> Thanks,
> //richard
