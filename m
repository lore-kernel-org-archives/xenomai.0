Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BF1BE4A
	for <xenomai@lists.linux.dev>; Mon, 14 Apr 2025 18:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744656625; cv=none; b=jE2WYe3gDLYXyBL0Az8keoU5FRaVMTBsRI3CW1MoP/YTRmAw421FYz7GuCUcNMnUH2J8JJd8wGNkgLNThqUfpjgyFjn6BkgvljK98b579FBBKUqPP66XKLg0lGevCc4SAMWp+FMNdQp3u4xphw5uX3+fJuWWt4CgH4TxTUE/3zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744656625; c=relaxed/simple;
	bh=+VOAVHvnnKXpO1yaP0KmlRsLCzr8IV5ifnmA36A7/5M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nNnrJjXGb5VuOYjzsCObV4K6ESeY4gOYU/1WzNfXnF9ApCph4ltGV1ADZIv8g95o/YGt26HP6cOYmrgUOjcm7iSgAtdemwgpGSEwv65qXDOuJimK4rwuAavFGNkJwoyDn8nfo4mXh0+JJg+iuvYoigJ4lyzFt4Hg/PJJXRVshtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=NmZV6YpW; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="NmZV6YpW"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 2025041418501800fb3311807d7b0bda
        for <xenomai@lists.linux.dev>;
        Mon, 14 Apr 2025 20:50:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=h3IiCmM2cfAxiLEj8zd9KIrfou8LIoANW3XvZoe4oHU=;
 b=NmZV6YpWRCXBaCtPp6MVxv5G1/92nbpa//gZ95Q2aNv3sRiMLPZnhttfaMH36baEZ3j6HG
 wuWCqXR+Ck+zdt2/y6y+u33FxP2Y2Lw03554kHiWG988H+UciFKUU81Sr+DFarHPbYscOp1+
 /CM6hOOL+stu/TjolCllVgU0v0hlYGFdQK5Dk0NvaEQ2EyZy91zA77TWVAtP5eeIL7L0Ge/N
 f2twAcgUfGXJRlyATWB00GaaesUTy0qkAqL+iwHZQ6NxHvCH4moRu7PPGTo6cR7uzyDyiBE5
 RNMUN29tpzpovtg6wnuTs3RW7QDWgoKBxP8Y/HxyMsr8lDPaOA4fI8mg==;
Message-ID: <3e4268139f9fb21608367b46d939b8d1c93e1f88.camel@siemens.com>
Subject: Re: [PATCH v2] prepare-kernel.sh: expand tilde in --outpatch path
 parameter
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Haiyang He <aspirestro@163.com>, jan.kiszka@siemens.com, richard@nod.at
Cc: xenomai@lists.linux.dev
Date: Mon, 14 Apr 2025 20:50:17 +0200
In-Reply-To: <89584308d4044af665ec7ed2ce71258edc237ca9.camel@siemens.com>
References: <20250414153817.1829100-1-aspirestro@163.com>
	 <89584308d4044af665ec7ed2ce71258edc237ca9.camel@siemens.com>
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

On Mon, 2025-04-14 at 17:53 +0200, Florian Bezdeka wrote:
> On Mon, 2025-04-14 at 23:38 +0800, Haiyang He wrote:
> > Ensure shell expands tilde (~) in the --outpatch parameter path.
> > This fixes "cd: can't cd to ~" errors when using home directory
> > shortcuts in output path.
> >=20
> > The issue occurred because the ~ character in paths was not expanded
> > before directory operations.
> >=20
> > $ ./scripts/prepare-kernel.sh \
> > --linux=3D~/xenomai/linux-dovetail \
> > --arch=3Darm64 \
> > --outpatch=3D~/xenomai.patch
> > ./scripts/prepare-kernel.sh: 1: cd: can't cd to ~
>=20
> Where is this "cd" command that fails? Which line of the script?
>=20
> >=20
> > Signed-off-by: Haiyang He <aspirestro@163.com>
> > ---
> >=20
> > Patch v2:
> > Change `eval "echo $output_patch"` to $(eval "realpath $output_patch")
> >=20
> >  scripts/prepare-kernel.sh | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
> > index ecc830fd2..ea7892b21 100755
> > --- a/scripts/prepare-kernel.sh
> > +++ b/scripts/prepare-kernel.sh
> > @@ -139,6 +139,7 @@ while test $# -gt 0; do
> >  		;;
> >  	--outpatch=3D*)
> >  		output_patch=3D`echo $1|sed -e 's,^--outpatch=3D\\(.*\\)$,\\1,g'`
> > +		output_patch=3D$(eval "realpath $output_patch")
>=20
> I think you got me wrong:
> Should read: output_patch=3D$(realpath "${output_patch}")
>=20
> But: Where exactly are we failing? Just tried to reproduce but failed
> so far... Would help to know where exactly the "cd" operation is that
> fails.
>=20
> We operate on output_patch with basename, dirname, ... which all should
> support ~.
>=20
> Maybe it helps the script with "bash -x ./scripts/prepare-kernel.sh" to
> enable some debugging.

Ha, seems I was missing that "~" is a bash feature... So called tilde
expansion. See [1].

My main point is that we should not use eval on user input. That might
bring us to security hell.

Maybe you can try the following:

diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
index ecc830fd2..308627ae2 100755
--- a/scripts/prepare-kernel.sh
+++ b/scripts/prepare-kernel.sh
@@ -139,6 +139,7 @@ while test $# -gt 0; do
 		;;
 	--outpatch=3D*)
 		output_patch=3D`echo $1|sed -e 's,^--outpatch=3D\\(.*\\)$,\\1,g'`
+		output_patch=3D"${output_patch/#\~/${HOME}}"
 		;;
 	--filterkvers=3D*)
 		echo "$me: warning: --filterkvers=3D is deprecated and now a no-op" >&2

That's basically a hand-made parameter expansion. Replacing "~" at the
beginning (#) with HOME.

[1] https://www.gnu.org/software/bash/manual/html_node/Tilde-Expansion.html

>=20
> >  		;;
> >  	--filterkvers=3D*)
> >  		echo "$me: warning: --filterkvers=3D is deprecated and now a no-op" =
>&2
> > --=20
> > 2.34.1
>=20

