Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADFE2C15B5
	for <xenomai@lists.linux.dev>; Fri, 20 Feb 2026 14:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771598776; cv=none; b=a6TxAFWIPDwGD/s3VFKJV4Goj/E7rZQNGxIynLynv7tkqKkHWlhXp6Vz67iST79QCXjuoi+tq4/8K+/8H5mtvFyfVNTHcWxvOHI4Jxk2rMkpNqRwWnDJcnWc9zf4sO7ryZxKwve42AVb11vsfTlBVidfHxHSDuvTIcSFKnoIIX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771598776; c=relaxed/simple;
	bh=bR6lxzR1DIWIpsc6ZyFy7xSbeupt4yUJ0rH5KEbbsuo=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W9NEncTlL7hhprN2wAKeC9bN+71UR3wMrRRYD/nMK+sQqe8SpXZIaO/X98q2HOYNBEIXH3fDvDd7NQXya7bDGmF/OAAecOK9OPb+KD4X7lG3LsvJh9+gdwP3xUcKii2biVot+nQhfYMy8TNnsaJ3u1DnZq0P1vnmZQlJiYHvvXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=FsKp++3s; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="FsKp++3s"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20260220144608f6eba17008000207c0
        for <xenomai@lists.linux.dev>;
        Fri, 20 Feb 2026 15:46:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=g4uWrAb+TBssjZTvtjJ3Vjf992piyLLVCyDmko0scfg=;
 b=FsKp++3sLbbj2pemeHmyLDdXYAOtw9ykbpniNbra9iqZoLH3Vx5PdCfe/tvTPFp37F+09l
 kFKPvRoaUKGGP+IBLRu6DmQ2OaiTrxZFn0+nYFWTNwgD7k9kaoBQQOEFKZKguo7WBLbs1P8h
 J1UBWcTZxovCaklW6IVefNi7HD3saxUfOfRvDjgaTFKg0npimTy4fRgAbogHCb/7MRs9x1J8
 5PGrhe+l2Vj4/q8hmVaBryuv35GIgKtr0E0pkYGiK5sK6kK4blfAHAc3XZ8pGpMiWS7BuJuC
 Fxxl88UQnqmm+5zN9VjGxkiyLKHk5ZNKXiU4RsdhPjPGe+l996w/n92g==;
Message-ID: <579b891e2b25c8e86a2f878aeb4725b61c14d13b.camel@siemens.com>
Subject: Re: [PATCH 05/20] lib/cobalt: Introduce wrappers_time64.c
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@lists.linux.dev>
Date: Fri, 20 Feb 2026 15:46:07 +0100
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

Both should be possible, I think, but testing has to prove that.

>=20
> > =20
> >  libcobalt_la_CPPFLAGS =3D			\
> >  	@XENO_COBALT_CFLAGS@		\
> > diff --git a/lib/cobalt/wrappers_time64.c b/lib/cobalt/wrappers_time64.=
c
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..4c4e0db0650b49f46cbd6d9=
ecf7cd656bb04bbe4
> > --- /dev/null
> > +++ b/lib/cobalt/wrappers_time64.c
> > @@ -0,0 +1,6 @@
> > +/*
> > + * Magic ahead:
> > + * This file is compiled twice in case y2038/time64_t support is neces=
sary
> > + * and requested. The first time with time64_t and a second time with =
native
> > + * time_t.
> > + */
> >=20
>=20
> Header, but still no copyright notices...
>=20

Yes, I forgot the license headers / copyright notices because I was not
sure if I should add SDPX headers or the full blown license text...

Any preferences?
