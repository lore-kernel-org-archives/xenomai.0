Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F130427F8A
	for <xenomai@lists.linux.dev>; Fri,  4 Sep 2026 06:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788503245; cv=none; b=oKmxG7jKS/VawpKRE54JGD3FfvGLg3ln4iipSQaJpAPw3f9IRTI0uVjFa/DgxP2UKGjdfbcQacSQxvqgxr62QH5unbYpK545xd7ffQ8ARaSo2QIQN2fYGGg7mKSjZKyVFem+XuvbYKntJhelB/DN+ciWC1Juexuq4UUjFwEuduY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788503245; c=relaxed/simple;
	bh=gJ9lfl0DuMQt9wFfeb3PLKoTEizOIm7izreb1vJoUXc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U77LeN17bhzUosvZE9jKTlD5gbe0bKmT97tDhv0LRNXLyPgt4dFRQY9CEtoKQYvyBOl7zFG2F8ErnNdxIXKY3mBzApNZaB0zbccJj/lSJM7qFa0wWVAKOn67iV2wygNHC7H1ooqvzO+6Fxa+fy1xYVQo9gRNHSl/v5FS09lgH5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=g7Xhq6NB; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="g7Xhq6NB"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20260904062715d9f918e08000020764
        for <xenomai@lists.linux.dev>;
        Fri, 04 Sep 2026 08:27:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=gJ9lfl0DuMQt9wFfeb3PLKoTEizOIm7izreb1vJoUXc=;
 b=g7Xhq6NBPsfySjRR9s/1Thbs9L6Th2YwOvbU0mWAwgRo9vHBs4odeIQ5uE2fHPOIHa1TZL
 Sg5eGU+TuBD1Y2AWa7WcvxYQCciJVERUX9AEPuFSgOydDbtvcRlAjVGu12/8qXuiN4RoHS9S
 PLFK0aXWP8Au1aXkFEYjzJpDLwkKfFljml87h11+G8rnP0Y0tDs0Kf2Oz2ssuvbnM+DAHMFT
 2SLIwJZwZWI8nedyJqBIkVFBvbnLX28s7UR/A1TWUK5leO4lAu4eTE0tojzN/mYWU1RbgNWQ
 RhgdIKlKnS8CBb3zsXRWge8Mb6xg+KCQgB78XZbRfv+tp0TeJzwUth2Q==;
Message-ID: <6ec6b7025d5ba370b4fefe411a9ff9b00c891c68.camel@siemens.com>
Subject: Re: [PATCH 1/3] docs(xeno3): Fix doxygen parsing of
 COBALT_IMPL_TIME64 wrappers
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Clara Kowalsky
	 <clara.kowalsky@siemens.com>, xenomai@lists.linux.dev
Date: Fri, 04 Sep 2026 08:27:14 +0200
In-Reply-To: <ca8fd24a-9e40-4d4d-ab9a-eccb3f2d9dda@siemens.com>
References: <20260903083447.2220024-1-clara.kowalsky@siemens.com>
	 <6af60166194fe03a0058c8cd3429d054125ef948.camel@siemens.com>
	 <541bece4-4a55-4be6-9886-228fb23b9da2@siemens.com>
	 <ca8fd24a-9e40-4d4d-ab9a-eccb3f2d9dda@siemens.com>
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

On Thu, 2026-09-03 at 12:58 +0200, Jan Kiszka wrote:
> On 03.09.26 12:34, Clara Kowalsky wrote:
> >=20
> >=20
> > On 9/3/26 11:48, Florian Bezdeka wrote:
> > > On Thu, 2026-09-03 at 10:34 +0200, Clara Kowalsky wrote:
> > > > The doxygen configuration lacks a definition for COBALT_IMPL_TIME64=
().
> > > > Therefore doxygen does not see the expanded wrapper prototype in
> > > > wrappers_time64.c and instead tries to match @param entries against=
 the
> > > > macro call.
> > > >=20
> > > > This raises warnings at doc build such as
> > > >=20
> > > > lib/cobalt/wrappers_time64.c:42: warning: argument 'clock_id' of
> > > > command @param is not found in the argument list of
> > > > COBALT_IMPL_TIME64(int, clock_getres, __clock_getres64,(clockid_t
> > > > clock_id, struct timespec *tp))
> > > >=20
> > > > as doxygen is seeing the raw macro form
> > > >=20
> > > > COBALT_IMPL_TIME64(int, clock_getres, __clock_getres64,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (clock=
id_t clock_id, struct timespec *tp))
> > > >=20
> > > > With the fix, doxygen rewrites the macro to
> > > >=20
> > > > int clock_getres(clockid_t clock_id, struct timespec *tp)
> > >=20
> > > Hm. The generated documentation should be "generic", right?
> > >=20
> > > Depending on the chosen build configuration clock_getres OR
> > > __clock_getres64 would be correct, but that is also hidden from the u=
ser
> > > in glibc land, so we should probably do the same "hiding" here.
> > >=20
> > > That said: LGTM.
> >=20
> > The doxygen mapping should describe the stable public API, not whicheve=
r
> > internal symbol is emitted for a particular time ABI. So the generated
> > docs should expose only the generic API name clock_getres, regardless
> > which build variant is selected.
> > >=20
> > > >=20
> > > > It uses the first macro argument (return type), the second (functio=
n
> > > > name) and fourth (parameter list), but ignores the third (alternate
> > > > function name, unneeded).
> > > > By this, doxygen sees the actual public function prototype.
> > > > See #18.
> > > >=20
> > > > Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> > > > ---
> > > > =C2=A0 doc/doxygen/xeno3prm-common.conf.in | 1 +
> > > > =C2=A0 1 file changed, 1 insertion(+)
> > > >=20
> > > > diff --git a/doc/doxygen/xeno3prm-common.conf.in b/doc/doxygen/
> > > > xeno3prm-common.conf.in
> > > > index 71db05686..ee4ede10d 100644
> > > > --- a/doc/doxygen/xeno3prm-common.conf.in
> > > > +++ b/doc/doxygen/xeno3prm-common.conf.in
> > > > @@ -647,6 +647,7 @@ PREDEFINED =3D DOXYGEN_CPP=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "EXPORT_SYMB=
OL_GPL(symbol)=3D//"=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "DECLARE_BIT=
MAP(symbol, nr)=3Dunsigned long
> > > > symbol[BITS_TO_LONGS(nr)]" \
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "COBALT_IMPL(T,I,A)=3DT I A"=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> > > > +=C2=A0=C2=A0=C2=A0 "COBALT_IMPL_TIME64(T,I,N,A)=3DT I A"=C2=A0=C2=
=A0=C2=A0 \
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "COBALT_DECL(T,P)=3DT P"=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> > >=20
> > > No complains about COBALT_DECL_TIME64? Would have expected something
> > > similar...
> >=20
> > I built the documentation with:
> > ./scripts/bootstrap
> > ./configure --enable-doc-build
> > make -C doc -B V=3D1 2>&1 | tee /tmp/xeno-doc-build.log
> >=20
> > And checked for warnings:
> > rg -i warn /tmp/xeno-doc-build.log
> >=20
> > I didn't get any warnings for COBALT_DECL_TIME64.
> >=20
>=20
> I guess that's because function docs are normally attached to the
> implementation, not the declaration.

Normally COBALT_IMPL and COBALT_IMPL_TIME64 as well as COBALT_DECL and
COBALT_DECL_TIME64 should be treated synchronously / in lock step.

COBALT_DECL_TIME64 is missing here, but maybe COBALT_DECL is not needed
as well?

Florian
> >=20
