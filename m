Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE711E2307
	for <xenomai@lists.linux.dev>; Tue, 27 May 2025 08:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748333250; cv=none; b=cwM33Hf8WchtYM2T8ZCaY1Ozq6trLS0V3BDr/h2n9Di59tE+z53QqRql8qDYsxNzxorVD9img1Zd5YXwqBmyI3Ho66nkNOyOeb3nssZzS5Yl/JeRGZYwrrC+M1aaC1PSrfjs5+eduMAE60vbVTezee/mE2xgUXoRcex1gVeitNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748333250; c=relaxed/simple;
	bh=7+Dzqa1mtqP5UjbP2Tz0HlI5Pm3T00OYFj5eTdvbOoA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CaGhZZAn0cZyPKhpnHH9KaBZfcr2szwTb9pD6/z/n3PV4uzxofLb6bWV1rK10e5EnO/nI5/o7oT/kJ3FIiyj8Be4PDP/SMkFyewUaXSNWwtBnazaYE1+gvgNyxUkJ5Guehaeep95VwatL3VAf5QAUQJD74NlZmCR079cAfU+oAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=lvb0OVb9; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="lvb0OVb9"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20250527080716422c387198d6a07556
        for <xenomai@lists.linux.dev>;
        Tue, 27 May 2025 10:07:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=aJh8lJ8f87UIdDJ9XpWFmrPmnExfEN2RV6jgHOzf360=;
 b=lvb0OVb9B8eeQRfOFmf/WHZndhEJl1+/pgISdmVA5cEzgKxDKZYUqWZcJ9B0oL8CWCIOEi
 TrxeHf+c/On3FuwSwD14IiIhreiLx3NAPBkifRetR23Z9PGAB8hqVP4atFdS1PgThxTeCKFO
 +72QJwcXzRBaIcoBXkSpG2ysF2axZtwB2+Fr0YrrzReZdTJDlX8LLN6Wpue3O1iNJM/DvX7P
 NQbGPEWkXEZUkux13JYs7Z19ucGlGFBZHi4DVOM692FpviNVS1eKCnQbeaYS1Wi8Q42PvuWv
 thV4S15ojB7ACMf53TvvkuINTK4u8rMrjQ7CUqRn6mL2TBZP3dywWUpg==;
Message-ID: <408e8837d729b0f3ee23e707a12b5f64ee2d1cb7.camel@siemens.com>
Subject: Re: [PATCH] debian: Install cobalt-glibc-time64.wrappers
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@lists.linux.dev>
Date: Tue, 27 May 2025 10:07:16 +0200
In-Reply-To: <dd5f7483-c648-4985-928d-bb3e902e060f@siemens.com>
References: <dd5f7483-c648-4985-928d-bb3e902e060f@siemens.com>
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

On Mon, 2025-05-26 at 19:46 +0200, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> This was forgotten by c2b883446b80.
>=20

Reviewed-by: Florian Bezdeka <florian.bezdeka@siemens.com>

> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  debian/libxenomai-dev.install | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/debian/libxenomai-dev.install b/debian/libxenomai-dev.instal=
l
> index b57231585c..9edb13269b 100644
> --- a/debian/libxenomai-dev.install
> +++ b/debian/libxenomai-dev.install
> @@ -5,5 +5,6 @@ usr/lib/*.a
>  usr/lib/*.so
>  usr/lib/modechk.wrappers
>  usr/lib/cobalt.wrappers
> +usr/lib/cobalt-glibc-time64.wrappers
>  usr/lib/dynlist.ld
>  usr/lib/xenomai/bootstrap*.o
> --=20
> 2.43.0

