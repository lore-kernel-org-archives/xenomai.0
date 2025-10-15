Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BE24502F
	for <xenomai@lists.linux.dev>; Wed, 15 Oct 2025 07:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760511673; cv=none; b=GSLZ0hnP+HEO3NhFHE1E/jCh1qGIZNepNyOLAPg/gLwUuKCv7Hw36rKau/PseothfEikwYXumw3bMO0lFhmfrRKlph2cSR5qUqV4EPdlXyozImeqeCsqUi96p0QZTFbgyQtTmRQx1yMCHMPB1Frjs8l/kd2ReiTLr5qMhdq5BEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760511673; c=relaxed/simple;
	bh=7tKB6mCM9NBZnVyCNsm7CdpOPP4F5fndJAv2EJ+VR1E=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LV2+QBeFhucHMmk0YzJ9FmK+ZFSqynXs8PF8IDYEPNIugIhBdh/vf7EVsBbjToGiKedetqT1Am1t6Bfg5mtnR+Bv1Rgvc9DQcFJ36wWb2Y48EDRu7IkdjTNj1gOiuzdNjDWoWYHzOA9X6/uQ6sKHGbQdW7ef/xjjL5nX5WVJ+ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=aNWz8CHT; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="aNWz8CHT"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2025101507005646836a86da000207ff
        for <xenomai@lists.linux.dev>;
        Wed, 15 Oct 2025 09:00:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=XglXP3Y7vWHLI1/osYPZsKso+L7mYHLVBCfrOgee0R4=;
 b=aNWz8CHTDan5rV6fvFH3+TX7JyKOLWN2W4Z8PJJfzwlothJC05TmHExvMChDUSuBnTvYUY
 0beFVxGmNahTHapQ1llsd3+nznTqYQxzOTXgqImplUydeI7cEdj2yGw3AgWjW+CpWRJsaEB4
 1AifVrMdldtoOVmZyOhTCgd5gMidoCGh2Ldj0L5pfNFCyPZs6H8DIGufqnVVM/yB3Vhq98p6
 yjL0QoBQfxIuAiehZ7OYIs1nu+eOGSS/i5AnxgjCNxJSs0uEC7cWrzSPmjNzT2A1/RpzMzhi
 RQrzD3SMyCGkDXcp69MX6nYMHw00E/3X0Je9EWFi9mXwMSAnKIFK51Kg==;
Message-ID: <ab02742a9249b19717a91c33572bad16efed73a2.camel@siemens.com>
Subject: Re: [PATCH 3/6] arm: fptest: Ensure that fp_regs_set/check
 functions are truly inline
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Date: Wed, 15 Oct 2025 09:00:56 +0200
In-Reply-To: <f601ea1438f94ac28c28d6eaca0eab2eac0de096.1760374860.git.jan.kiszka@siemens.com>
References: <cover.1760374860.git.jan.kiszka@siemens.com>
	 <f601ea1438f94ac28c28d6eaca0eab2eac0de096.1760374860.git.jan.kiszka@siemens.com>
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

On Mon, 2025-10-13 at 19:00 +0200, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> If they aren't, d8-d15 will be saved/restored, and that is ruining our
> tests.
>=20
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  kernel/cobalt/arch/arm/include/asm/xenomai/uapi/fptest.h | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/fptest.h b/k=
ernel/cobalt/arch/arm/include/asm/xenomai/uapi/fptest.h
> index d5c2c7515b..2b21bc5f55 100644
> --- a/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/fptest.h
> +++ b/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/fptest.h
> @@ -20,7 +20,8 @@
> =20
>  #define __COBALT_HAVE_VFP  0x1
> =20
> -static inline void fp_regs_set(int features, unsigned int val)
> +static inline void __attribute__ ((always_inline))
> +fp_regs_set(int features, unsigned int val)
>  {
>  	unsigned long long e[16];
>  	unsigned int i;
> @@ -41,8 +42,9 @@ static inline void fp_regs_set(int features, unsigned i=
nt val)
>  	}
>  }

Could we use the __always_inline macro from Linux here?

> =20
> -static inline unsigned int fp_regs_check(int features, unsigned int val,
> -					 int (*report)(const char *fmt, ...))
> +static inline unsigned int __attribute__ ((always_inline))
> +fp_regs_check(int features, unsigned int val,
> +	      int (*report)(const char *fmt, ...))
>  {
>  	unsigned int result =3D val, i;
>  	unsigned long long e[16];
> --=20
> 2.51.0
