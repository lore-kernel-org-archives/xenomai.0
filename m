Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBFF2472B3
	for <xenomai@lists.linux.dev>; Mon, 14 Apr 2025 14:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744640588; cv=none; b=HEhrnUi/LF/eN6DeS4YwRDTeBm0bz5bY91wW79+aj+tkxtmAOFvyoeigNk3/GM09z21/kN5KLeY/F4nJbC8pAnFMi/9JRbNkRDkLisvZ+6tcOdiSikWoTGwu+ZKRy9rUfKJT3y24RIFPGcJ88S4gXSLDU0mNjBLPXGynGl8lgC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744640588; c=relaxed/simple;
	bh=40DCIT9oCE3ZXS4MXcV1zFmKgzlfA2CTvnKqPyXI5i8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UdxBhrJr0/WlZRqEfinJzFVCSnJsVqKIm2le0ZQdGI+B4nK7FaTZaTkHFGoK/mtmNvjGES5Pxzkw1REILqD6Ew3Yi8Bdvq75dbaoSKQ+lhrJvp+jwuBxX/4XWtpOAWCqD6aZbcHVn0EhBYF/QTpS9cmf4S9Kf+uHN9gjCpQDQsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=QH5+6yiv; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="QH5+6yiv"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202504141422536bab841afddf9d0edf
        for <xenomai@lists.linux.dev>;
        Mon, 14 Apr 2025 16:22:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=r/Xy3DIylFgoVdZan2NjF2pVFUyIM8X/h72KXo6Gsqo=;
 b=QH5+6yiv8Fz0OEAsDRk2knjL66frzVFFcZ8PiRk1Ay6hhspesiA6ERsMMSBy1FCigAZCfn
 wAvON96BknCrRBx0DrZYmisnQ63g55LbpGt01taJ9n288/4ZUXdKgPIaE2O6JkDqfOJ+T3EI
 7v9aYkI11H36j2PNnnhLJaLIa/N4LiOWj43EdayJdAZVkIurYmrMPf49d3y8H7Lsx/zSNpjG
 9Uoaw1SCS7ychxHHEHAJD5h4mzM3oyFWsRsq8cL2rmNlUU0VPlFWq7QLo0y9tUKYpgpSGKg2
 X3Jck6hrSH18dVylFKqlXfZswJUo9QDrciaRaLybC0b6yMEnSAAfVxDw==;
Message-ID: <a94878f7d6af9e2c36a7956de3632a70bf286cd4.camel@siemens.com>
Subject: Re: [PATCH] prepare-kernel.sh: expand tilde in --outpatch path
 parameter
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Haiyang He <aspirestro@163.com>, jan.kiszka@siemens.com, richard@nod.at
Cc: xenomai@lists.linux.dev
Date: Mon, 14 Apr 2025 16:22:52 +0200
In-Reply-To: <20250414141034.1682520-1-aspirestro@163.com>
References: <20250414141034.1682520-1-aspirestro@163.com>
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

On Mon, 2025-04-14 at 22:10 +0800, Haiyang He wrote:
> Ensure shell expands tilde (~) in the --outpatch parameter path the
> same way as --linux and --dovetail parameters. This fixes
> "cd: can't cd to ~" errors when using home directory shortcuts in
> output path.
>=20
> The issue occurred because the ~ character in paths was not expanded
> before directory operations.
>=20
> $ ./scripts/prepare-kernel.sh \
> --linux=3D~/xenomai/linux-dovetail \
> --arch=3Darm64 \
> --outpatch=3D~/xenomai.patch
> ./scripts/prepare-kernel.sh: 1: cd: can't cd to ~
>=20
> Signed-off-by: Haiyang He <aspirestro@163.com>
> ---
>  scripts/prepare-kernel.sh | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
> index ecc830fd2..e15c1fe6e 100755
> --- a/scripts/prepare-kernel.sh
> +++ b/scripts/prepare-kernel.sh
> @@ -139,6 +139,7 @@ while test $# -gt 0; do
>  		;;
>  	--outpatch=3D*)
>  		output_patch=3D`echo $1|sed -e 's,^--outpatch=3D\\(.*\\)$,\\1,g'`
> +		output_patch=3D`eval "echo $output_patch"`

Something like "realpath" should do it (instead of eval), no?

Btw: AFAIR command substitutions should be done with the $() syntax
nowadays (instead of ``).

>  		;;
>  	--filterkvers=3D*)
>  		echo "$me: warning: --filterkvers=3D is deprecated and now a no-op" >&=
2
> --=20
> 2.34.1

