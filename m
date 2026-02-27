Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93EA279DC3
	for <xenomai@lists.linux.dev>; Fri, 27 Feb 2026 12:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772194032; cv=none; b=ixVJV9YZjiSxzFkbjkF3BaV6i0zlWjAAcv1HYqH6GU6E2lg71qIAQ9vl0YBabFSqLro6tc7my+OvMgLeNirew3H+hkPS0SriSHlPg4Uk0W3EnzvyZdf4l/9xw3RxI3dZ7HJWCYr7i8/LBc88Yd7/YNNmj7n/CfnUzzlbAxYpvRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772194032; c=relaxed/simple;
	bh=3yuDCOKS6X6G1EflSnwnOCRWpDQVZ1ySq+HGzw+3zhY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p0cTTGpiCTDb2PAusTW60gg5V68yD0JQ5Dux6OCXBkGd0GSXeEkM38oRsrRjZ2u6NnvjSFECk2GbH2+HSoNu7jnTOL7A9z36DEiwOrT892cOSxLE/UEq5V3+gQrE76c7xaYPcaFCb5MQ+e0maNjBo0MtwyuusEUQU/t6DjzFGaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=IRHBSrci; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="IRHBSrci"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202602271156563bd08b051b00020767
        for <xenomai@lists.linux.dev>;
        Fri, 27 Feb 2026 12:56:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=H6zL+lgUXI4hr4RsYPrdqkYRvLJ65OOJFf+5gRxUCn4=;
 b=IRHBSrci7rUdJxTk4au0/ilMW+BmmPGMPNWqDth/oBZhUuZftz/8sHU9FU+K/hE7GJZHZR
 U+BWRVVmmXbzgTRCKeODw5eEKXojSB9/YTuUP3tir6cYerrFDM5mqotjBAySxEofYhZNwE3a
 HacNO0x/fJbOLbDd9rY7BEavZVq6YoTVaGqIP2nHTV2Y7jW6x9oarM7yP61k6GYomzNp77Zn
 2CpYFW7ufGkkHvXa1zKkI+xUfNwRByqqnVkV8tbmPPP4xC4jQlJltjYMq6hf5tfL4BVsnmwP
 eYKE+6lHv105ILatKhNQ8Wyia4fwm6PEhfEDc9CfychoklF7wY6B/KRw==;
Message-ID: <9b25b03bc5f4ab827d94edd9bafbb2d84561fdbe.camel@siemens.com>
Subject: Re: [PATCH 05/20] lib/cobalt: Introduce wrappers_time64.c
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@lists.linux.dev>
Date: Fri, 27 Feb 2026 12:56:56 +0100
In-Reply-To: <91cc0a1f-e1f7-4ce0-9607-606839d0c01c@siemens.com>
References: 
	<20260220-wip-flo-fix-time64-32bit-native-v1-0-731c773e72cc@siemens.com>
	 <20260220-wip-flo-fix-time64-32bit-native-v1-5-731c773e72cc@siemens.com>
	 <91cc0a1f-e1f7-4ce0-9607-606839d0c01c@siemens.com>
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

On Fri, 2026-02-20 at 15:36 +0100, Jan Kiszka wrote:
> On 20.02.26 10:08, Florian Bezdeka wrote:
> > All COBALT_IMPL_TIME64() services will be moved afterwards - step by
> > step - into the newly introduced wrappers_time64.c. At the end that
> > should allow us to compile libcobalt with time64_t support leaving
> > the native time_t services in place.
> >=20
> > Currently, all native time_t services are replaced by the 64 bit
> > variants. That is OK as long as applications are rebuild after
> > libcobalt, but we try to remove this limitation now.
> >=20
> > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> > ---
> >  lib/cobalt/Makefile.am       | 3 ++-
> >  lib/cobalt/wrappers_time64.c | 6 ++++++
> >  2 files changed, 8 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/lib/cobalt/Makefile.am b/lib/cobalt/Makefile.am
> > index f461e570ed42a0d5cbc43eabb373c3c9edd83bad..17e203f9015fe2bb5306609=
e4d51c62f3a725780 100644
> > --- a/lib/cobalt/Makefile.am
> > +++ b/lib/cobalt/Makefile.am
> > @@ -43,7 +43,8 @@ libcobalt_la_SOURCES =3D		\
> >  	timerfd.c		\
> >  	trace.c			\
> >  	umm.c			\
> > -	wrappers.c
> > +	wrappers.c		\
> > +	wrappers_time64.c
>=20
>=20
> So, a should we do a wrapper_off64 for mmap, or put both into the same
> one? I don't have a good name for common one yet, though.
>=20

Assuming we want to follow the same pattern as we do for the time64
series - both worlds provided within one libcobalt build:

At the end libcobalt has to provide two wrappers / symbols. One for
native and one for off64.

Linker magic (needed for __STD() and __RT() anyway) should do the
necessary routing.

As mmap() already resides in its own compile unit (which is fine, it's
not related to time64_t) we might follow the same implementation
pattern: Compile mmap.c twice, with different flags. Something similar
to the COBALT_IMPL_TIME64() macro would be needed - based on different
glibc / compile flag checks.
