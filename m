Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4A71991B2
	for <xenomai@lists.linux.dev>; Mon, 14 Apr 2025 16:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744646647; cv=none; b=T80QeY0tpGOso78/NzyQRhVwAFCC30PJZWqE+6Vjx+pDfpz8YZP1Hc2Ds2Dg54wC5nESxToEPY/epcUC6rYW8lo8gJi/kBcBW6Gr847KlSdCDL9sqfRXVmEBhNreSmuXfTJnrZEZAyQaV65VYBX2CZEII5nopnmpfo+pJNz0lxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744646647; c=relaxed/simple;
	bh=Y+F8O++DYQuMvFUfIMI1/Q2W0x6zQwPtoWiN9l/VqS4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XdxVAGoNZ4mDPrgRqTPSLT285G5wcY1UG2tq097QQjAnSUR4UZAYBazpUiDkB/Pd/RlbyRUG0KxNmt3PMy2Mrl32tpTt+E8Hl4yKVQy6dMH5uvSWq1PGF4xB2XOqBOhLdGVkkaahjm8MJ8Q1fKXf6Sa2kNo7AhFkUbQqVy+9An4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=KJ+2GJCo; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="KJ+2GJCo"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202504141553449aa7808afd18ef7505
        for <xenomai@lists.linux.dev>;
        Mon, 14 Apr 2025 17:53:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=L350Wm+xNE17j6fO7YEzYFpDia25CAY95w62t5a+JxA=;
 b=KJ+2GJConKBn9VVA8FvK8NIpQ7Dtk6luyV4Zc9fimo5rZ4bKz4UVeEslcueNfx1PsxLZqm
 8uQNM5ZhGEZ3+4ibuUH400q0+6y5NtVDqV1KSSdguFkj1OF5XdHsLgnjoMTaGn0ReGJfY1eB
 bYl7wkvl3OzvoEnWPwIiB+Y8buzz+DxIlRnOrZE4bcF/fgMNXJyJy2vf8/aztZe1E9GtAfK0
 PNfZWDLrkRv93j7pja8BtSt784fl93+ZY7jPcrwoMPzgtr8Z0vEFrXZ/p75gWGDWQ5bnTA0e
 HNSNNacjgOFcgt5ULXzZspYHg8vDYmZtYVAXt2Kpz2XStvv7MjHzSnkg==;
Message-ID: <89584308d4044af665ec7ed2ce71258edc237ca9.camel@siemens.com>
Subject: Re: [PATCH v2] prepare-kernel.sh: expand tilde in --outpatch path
 parameter
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Haiyang He <aspirestro@163.com>, jan.kiszka@siemens.com, richard@nod.at
Cc: xenomai@lists.linux.dev
Date: Mon, 14 Apr 2025 17:53:43 +0200
In-Reply-To: <20250414153817.1829100-1-aspirestro@163.com>
References: <20250414153817.1829100-1-aspirestro@163.com>
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

On Mon, 2025-04-14 at 23:38 +0800, Haiyang He wrote:
> Ensure shell expands tilde (~) in the --outpatch parameter path.
> This fixes "cd: can't cd to ~" errors when using home directory
> shortcuts in output path.
>=20
> The issue occurred because the ~ character in paths was not expanded
> before directory operations.
>=20
> $ ./scripts/prepare-kernel.sh \
> --linux=3D~/xenomai/linux-dovetail \
> --arch=3Darm64 \
> --outpatch=3D~/xenomai.patch
> ./scripts/prepare-kernel.sh: 1: cd: can't cd to ~

Where is this "cd" command that fails? Which line of the script?

>=20
> Signed-off-by: Haiyang He <aspirestro@163.com>
> ---
>=20
> Patch v2:
> Change `eval "echo $output_patch"` to $(eval "realpath $output_patch")
>=20
>  scripts/prepare-kernel.sh | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
> index ecc830fd2..ea7892b21 100755
> --- a/scripts/prepare-kernel.sh
> +++ b/scripts/prepare-kernel.sh
> @@ -139,6 +139,7 @@ while test $# -gt 0; do
>  		;;
>  	--outpatch=3D*)
>  		output_patch=3D`echo $1|sed -e 's,^--outpatch=3D\\(.*\\)$,\\1,g'`
> +		output_patch=3D$(eval "realpath $output_patch")

I think you got me wrong:
Should read: output_patch=3D$(realpath "${output_patch}")

But: Where exactly are we failing? Just tried to reproduce but failed
so far... Would help to know where exactly the "cd" operation is that
fails.

We operate on output_patch with basename, dirname, ... which all should
support ~.

Maybe it helps the script with "bash -x ./scripts/prepare-kernel.sh" to
enable some debugging.

>  		;;
>  	--filterkvers=3D*)
>  		echo "$me: warning: --filterkvers=3D is deprecated and now a no-op" >&=
2
> --=20
> 2.34.1

