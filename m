Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CB03ECBE5
	for <xenomai@lists.linux.dev>; Thu,  3 Sep 2026 09:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788428900; cv=none; b=dbuYzXBsHBRfqCb8tFnxSzxRY8aQjJNIF9oZP4zrCqUcBGDtzac1ik+o8DkQ0XUwujZXVz77kJUo3V3b31JkszDSccWbtcROFxjk5KdomySNrgH0RXRXY579XN/mS28ZdrHLhjng7KLa44HmXvY5vP4T/w0yT9n1ZGmjd+jekag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788428900; c=relaxed/simple;
	bh=h7DJrtxVjzVbmNwiyYAgvX9LATJYhnwPjEqI4Xw9oK0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XKkb2jcj8mR22plpFYQkMi+yM/KSp8DuDyZ155W63gd1HBOlkDW7UF0vZtejXshc3GTtZ0f8qDk7/OcY1jtVOM7bLYBQ92hAJc6Mu9GlVkuiTinIA6chGocPaJt4blMiIM1W6bZVLzLDNB51C0FVD6H5vglOS+5fkw7TCG4L88c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Uej/p1oq; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Uej/p1oq"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202609030948030f05eb410d00020791
        for <xenomai@lists.linux.dev>;
        Thu, 03 Sep 2026 11:48:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=nOxLs+4uwBSS+26+lXifDypEFad3iEnSgnlD9NzGkBE=;
 b=Uej/p1oqu5Z34aDo287Sgof1b+Vc78sQPYM6fLlW1Wj+lyGV6ttwfppx3iNQeWcWTEKgqq
 MaVtSJin8yH8KRKQC4OwphtrjKT/gWMQHSpq0Wt7VVb35D/lZIzYcvfMPLPcFOvDG0322Lqf
 fJyyf5QyzeaDtJutSW1IijSQx5gb7S07rXaVLcJqqSlyGazBjz4WlXM2d329NgK5/A5O7NU4
 4pab72l5+5e5MBq7ZyxE9nDr0cadUWoNfuR/tcu5gD72ddIH2JR/nsBBEJee6X/3QKea4swM
 0q/ac5tAQQHTPByurY0nbU9caTQuYq0OKu1l2Il1XTxFbwtFbrlCN38g==;
Message-ID: <6af60166194fe03a0058c8cd3429d054125ef948.camel@siemens.com>
Subject: Re: [PATCH 1/3] docs(xeno3): Fix doxygen parsing of
 COBALT_IMPL_TIME64 wrappers
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Clara Kowalsky <clara.kowalsky@siemens.com>, xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com
Date: Thu, 03 Sep 2026 11:48:03 +0200
In-Reply-To: <20260903083447.2220024-1-clara.kowalsky@siemens.com>
References: <20260903083447.2220024-1-clara.kowalsky@siemens.com>
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

On Thu, 2026-09-03 at 10:34 +0200, Clara Kowalsky wrote:
> The doxygen configuration lacks a definition for COBALT_IMPL_TIME64().
> Therefore doxygen does not see the expanded wrapper prototype in
> wrappers_time64.c and instead tries to match @param entries against the
> macro call.
>=20
> This raises warnings at doc build such as
>=20
> lib/cobalt/wrappers_time64.c:42: warning: argument 'clock_id' of command =
@param is not found in the argument list of COBALT_IMPL_TIME64(int, clock_g=
etres, __clock_getres64,(clockid_t clock_id, struct timespec *tp))
>=20
> as doxygen is seeing the raw macro form
>=20
> COBALT_IMPL_TIME64(int, clock_getres, __clock_getres64,
>           (clockid_t clock_id, struct timespec *tp))
>=20
> With the fix, doxygen rewrites the macro to
>=20
> int clock_getres(clockid_t clock_id, struct timespec *tp)

Hm. The generated documentation should be "generic", right?=20

Depending on the chosen build configuration clock_getres OR
__clock_getres64 would be correct, but that is also hidden from the user
in glibc land, so we should probably do the same "hiding" here.=20

That said: LGTM.

>=20
> It uses the first macro argument (return type), the second (function
> name) and fourth (parameter list), but ignores the third (alternate
> function name, unneeded).
> By this, doxygen sees the actual public function prototype.
> See #18.
>=20
> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> ---
>  doc/doxygen/xeno3prm-common.conf.in | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/doc/doxygen/xeno3prm-common.conf.in b/doc/doxygen/xeno3prm-c=
ommon.conf.in
> index 71db05686..ee4ede10d 100644
> --- a/doc/doxygen/xeno3prm-common.conf.in
> +++ b/doc/doxygen/xeno3prm-common.conf.in
> @@ -647,6 +647,7 @@ PREDEFINED =3D DOXYGEN_CPP			\
>          "EXPORT_SYMBOL_GPL(symbol)=3D//"		\
>          "DECLARE_BITMAP(symbol, nr)=3Dunsigned long symbol[BITS_TO_LONGS=
(nr)]" \
>  	"COBALT_IMPL(T,I,A)=3DT I A"		\
> +	"COBALT_IMPL_TIME64(T,I,N,A)=3DT I A"	\
>  	"COBALT_DECL(T,P)=3DT P"			\

No complains about COBALT_DECL_TIME64? Would have expected something
similar...

>  	"COBALT_SYSCALL(N,M,T,A)=3DT N A"		\
>  	"COBALT_SYSCALL_DECL(N,T,A)=3DT N A"
> --=20
> 2.55.0

Question to the complete series: Is
https://gitlab.com/Xenomai/xenomai3/xenomai/-/work_items/18 completely
closed with this series applied?
