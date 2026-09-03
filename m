Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7558A43F0A7
	for <xenomai@lists.linux.dev>; Thu,  3 Sep 2026 11:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788434298; cv=none; b=Og3p09muqW54QbH36vdyUXEvdjxYqIMWha8u84U0aKtXBuA2R7WfZSBZJ/jqK0dsOsh9ilWQvdMLHaXYj7wJYEHboP+HM4a6WSAFBb+IE25feU7oW4IryxVNNkiYvwE9bMXNJHqHx2Sk3wXzavdp5uuKcjOXc4GC6cHXFOYOn0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788434298; c=relaxed/simple;
	bh=5nCM5D2F81A68JDnDPtD8YlYczjl1tPz7q9AoNXcvGk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hSfXVVSCGQ4gNDHX+Tlgobv99incNAhPPhzU4Mq7mwbiy/Ja94rgxqn9+HXxtORFqIIDPBvrutyYw01ngjUsdJLIGoN2NUZwJ4v8x3KBjWOyJjyhEGkFRic2U2fMojvNGXpqoM686GAljQ1VXewHrzVog4LkssnrVx4MbfR4CzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=H5s5B74Y; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="H5s5B74Y"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20260903111755c7f9d0b210000207d1
        for <xenomai@lists.linux.dev>;
        Thu, 03 Sep 2026 13:17:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=rHnF5N2s9c8WYaJGyfdfzJEuDz0BEhaA1CBKcdc4lJI=;
 b=H5s5B74YTrw2yQcDmjIa9gc3Lw6CpuUvCPNDgVIEMcwaqUqhzRVtLvIwJfkBkmYkfLQvfK
 xVLlQaW4MRVZ5wgFOgc/qxM5tZyEbsmKrKAqlgVjXv49y72lEVP25H1CzndUgNgWU8OGxZXf
 pPtRHPRl7PCGhsPlL6Qwlb+KBBw+6vJyCHELLEMjl0aebrbtC/jp02NVCEhEcWt6hpKi9uQI
 8y6WwSnyJUE0mSdHT7edumnRT/jj3G02xqvKusUihszkw+4mkRlTdAhSfdrS9Qi1S8GZCDkO
 W7mcoLQYJoayd4XPheVm6q+7i1hkxDabulvIM/jgd37QFA41OT5RlVZA==;
Message-ID: <f83d041a355d118073325382100f9fca7f205126.camel@siemens.com>
Subject: Re: [PATCH 1/3] docs(xeno3): Fix doxygen parsing of
 COBALT_IMPL_TIME64 wrappers
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Clara Kowalsky <clara.kowalsky@siemens.com>, xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com
Date: Thu, 03 Sep 2026 13:17:55 +0200
In-Reply-To: <541bece4-4a55-4be6-9886-228fb23b9da2@siemens.com>
References: <20260903083447.2220024-1-clara.kowalsky@siemens.com>
	 <6af60166194fe03a0058c8cd3429d054125ef948.camel@siemens.com>
	 <541bece4-4a55-4be6-9886-228fb23b9da2@siemens.com>
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

On Thu, 2026-09-03 at 12:34 +0200, Clara Kowalsky wrote:
> On 9/3/26 11:48, Florian Bezdeka wrote:
> > On Thu, 2026-09-03 at 10:34 +0200, Clara Kowalsky wrote:
> > > The doxygen configuration lacks a definition for COBALT_IMPL_TIME64()=
.
> > > Therefore doxygen does not see the expanded wrapper prototype in
> > > wrappers_time64.c and instead tries to match @param entries against t=
he
> > > macro call.
> > >=20
> > > This raises warnings at doc build such as
> > >=20
> > > lib/cobalt/wrappers_time64.c:42: warning: argument 'clock_id' of comm=
and @param is not found in the argument list of COBALT_IMPL_TIME64(int, clo=
ck_getres, __clock_getres64,(clockid_t clock_id, struct timespec *tp))
> > >=20
> > > as doxygen is seeing the raw macro form
> > >=20
> > > COBALT_IMPL_TIME64(int, clock_getres, __clock_getres64,
> > >            (clockid_t clock_id, struct timespec *tp))
> > >=20
> > > With the fix, doxygen rewrites the macro to
> > >=20
> > > int clock_getres(clockid_t clock_id, struct timespec *tp)
> >=20
> > Hm. The generated documentation should be "generic", right?
> >=20
> > Depending on the chosen build configuration clock_getres OR
> > __clock_getres64 would be correct, but that is also hidden from the use=
r
> > in glibc land, so we should probably do the same "hiding" here.
> >=20
> > That said: LGTM.
>=20
> The doxygen mapping should describe the stable public API, not whichever=
=20
> internal symbol is emitted for a particular time ABI. So the generated=
=20
> docs should expose only the generic API name clock_getres, regardless=20
> which build variant is selected.
> >=20
> > >=20
> > > It uses the first macro argument (return type), the second (function
> > > name) and fourth (parameter list), but ignores the third (alternate
> > > function name, unneeded).
> > > By this, doxygen sees the actual public function prototype.
> > > See #18.
> > >=20
> > > Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> > > ---
> > >   doc/doxygen/xeno3prm-common.conf.in | 1 +
> > >   1 file changed, 1 insertion(+)
> > >=20
> > > diff --git a/doc/doxygen/xeno3prm-common.conf.in b/doc/doxygen/xeno3p=
rm-common.conf.in
> > > index 71db05686..ee4ede10d 100644
> > > --- a/doc/doxygen/xeno3prm-common.conf.in
> > > +++ b/doc/doxygen/xeno3prm-common.conf.in
> > > @@ -647,6 +647,7 @@ PREDEFINED =3D DOXYGEN_CPP			\
> > >           "EXPORT_SYMBOL_GPL(symbol)=3D//"		\
> > >           "DECLARE_BITMAP(symbol, nr)=3Dunsigned long symbol[BITS_TO_=
LONGS(nr)]" \
> > >   	"COBALT_IMPL(T,I,A)=3DT I A"		\
> > > +	"COBALT_IMPL_TIME64(T,I,N,A)=3DT I A"	\
> > >   	"COBALT_DECL(T,P)=3DT P"			\
> >=20
> > No complains about COBALT_DECL_TIME64? Would have expected something
> > similar...
>=20
> I built the documentation with:
> ./scripts/bootstrap
> ./configure --enable-doc-build
> make -C doc -B V=3D1 2>&1 | tee /tmp/xeno-doc-build.log
>=20
> And checked for warnings:
> rg -i warn /tmp/xeno-doc-build.log
>=20
> I didn't get any warnings for COBALT_DECL_TIME64.
>=20
> >=20
> > >   	"COBALT_SYSCALL(N,M,T,A)=3DT N A"		\
> > >   	"COBALT_SYSCALL_DECL(N,T,A)=3DT N A"
> > > --=20
> > > 2.55.0
> >=20
> > Question to the complete series: Is
> > https://gitlab.com/Xenomai/xenomai3/xenomai/-/work_items/18 completely
> > closed with this series applied?
>=20
> Yes, those 3 commits fix all doxygen warnings.
>=20
Nice. Adding a

Closes: #18

tag to the commit description would auto-close the issue once the commit
reaches main/master.
