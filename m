Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.136.64.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795598043;
	b=r80XNUAk176FU+CTjcL76QAvIHZoudkEVHbp+wL+AwRWAtPaTegSYI4XbgJzIc0a3c2V
	 oLYJdrKBvj5adioFCExfElux/bN6djSkIYD8qmPcIdt8/xzSdWg3tc2CQYbLG9wnXqoMA
	 GFC/twUhPieQtUdFs1MTgiWuYSaW9h7dbAs+O0gqYhuFSnZn2fgF6y59sLIIdSgRfGbut
	 MH1jRpAOj3b+oWxaho2waYEZWbXzBxljLksPB6MnZWbiIet06sF1DGJeecKAv5DX+pvt5
	 6j9brbiBHGwRlA1+fRl13CdrsyJHvQjyp00tGnmfY685560UF04K9TcurHeXtsdKbyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795598043;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 MIME-Version:X-Flowmailer-Platform:Feedback-ID;
	bh=/mDikV4yP/qgYmPfwsLMdZkReIGxWDq1d5kdTNrXeUQ=;
	b=eTCeq4hvI1iXazGIbeWD+GCvWMDWjK3Goeyv7Exypq3BtdfxDlifqB3z4kbpSedA96nM
	 f7Au8q2EePZLvtU6W1i5ZQF2E8ZG6abwGJkZ0TRIuMK4r0M1r330e3MYzXhb94xOCYo1u
	 Vm9bqnqAr2/yX3V4kkSTVjWD7Nb5pjUIuind3LKffGAGLZvq0GRaw/VVEbhO12bPebydp
	 IDl0VtE3LHjA1uD78rN5QqJ8KxMOH29tOUg7Wz/6kstrFaZvBstdivM9zSWqJEVZxWy4o
	 wleCaLT3AqEDY8bvIuhiY3ghx2NQtwwg0a3fEkndVqBqtr3rZ0ekuIzgNjMMUqhmJ6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=rts-flowmailer.siemens.com;
	dkim=pass header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=icmFubpC;
	arc=none smtp.remote-ip=185.136.64.225
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC7B606A68C
	for <xenomai@lists.linux.dev>; Wed, 25 Nov 2026 09:13:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEC7B606A68C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=icmFubpC
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20261125091341a65b2589fb0002075c
        for <xenomai@lists.linux.dev>;
        Wed, 25 Nov 2026 10:13:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=/mDikV4yP/qgYmPfwsLMdZkReIGxWDq1d5kdTNrXeUQ=;
 b=icmFubpCpYPBZmYV/Axj03zXBvwwwGzVYKWS9DdfLIVtn7g9O5Hm2wiKAgkt1oMVe9ciXC
 o+GScLQCdPa/NFByAKSASNfKNEHSO1ZgyxzcpkzmUJsYejVMAg9mOO3vQ87tRKiNnh44QfKv
 bdbYTwc60NqPYRUDDcBxR2YC2yvRfBlp2g74lECBpG2yEoaZD1iybrCKssuszpiUwTLRG7eZ
 G663AILsXl3V3bdWWlkp8ziHVus8DDZ53DvFTYVnPhelucRaX4AqqlLnpM9TAdIErqgKLaGa
 JwbUf+EQaHLK+RYfJU/axhatKFOBlYNDipNdSeRFjBl5Oftl7kNGPiTg==;
Message-ID: <8e670dcbe9ce7d1107d0fb2a8e3055bd967b6dcf.camel@siemens.com>
Subject: Re: [PATCH] configure.ac: Fix typo
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, "Richard Weinberger (sigma star
 gmbh)" <rw@kernel.org>, xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at, Richard Weinberger <richard@nod.at>
Date: Wed, 25 Nov 2026 10:13:41 +0100
In-Reply-To: <907cbf6f-9277-43be-979a-c6ab0a030cca@siemens.com>
References: <20261124213345.2245315-1-rw@kernel.org>
	 <907cbf6f-9277-43be-979a-c6ab0a030cca@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Wed, 2026-11-25 at 06:45 +0100, Jan Kiszka wrote:
> On 24.11.26 22:33, Richard Weinberger (sigma star gmbh) wrote:
> > From: Richard Weinberger <richard@nod.at>
> >=20
> > It's XENO_USER_CFLAGS, not XENU_USER_CFLAGS.
> > With the misnamed variable, xenomai was never built with -O2
> > on my side and caused funny performance regressions.
> >=20
> > Fixes: 89c1436b3 ("configure: Propagate debug build settings also to pl=
ain applications")
>=20
> At least no stable regression.

Shouldn't the optimization level be separated from the debug settings?
-02 inside a variable named XENO_USER_CFLAGS_DEBUG looks a bit strange.

>=20
> > Signed-off-by: Richard Weinberger <richard@nod.at>
> > ---
> >  configure.ac | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/configure.ac b/configure.ac
> > index 0d6dd87b6..d707fb11d 100644
> > --- a/configure.ac
> > +++ b/configure.ac
> > @@ -743,7 +743,7 @@ fi
> >  if test x$use_assert =3D x; then
> >     XENO_USER_CFLAGS_DEBUG=3D"-DNDEBUG $XENO_USER_CFLAGS_DEBUG"
> >  fi
> > -XENU_USER_CFLAGS=3D"$XENO_USER_CFLAGS_DEBUG $XENO_USER_CFLAGS"
> > +XENO_USER_CFLAGS=3D"$XENO_USER_CFLAGS_DEBUG $XENO_USER_CFLAGS"
> > =20
> >  XENO_USER_CFLAGS_STDLIB=3D"$XENO_USER_CFLAGS"
> >  XENO_USER_CFLAGS=3D"$XENO_USER_CFLAGS -I$topdir/include/$rtcore_type"
>=20
> Thanks, applied.
>=20
> Jan
>=20
> --=20
> Siemens AG, Foundational Technologies
> Linux Expert Center
