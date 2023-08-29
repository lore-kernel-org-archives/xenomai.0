Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E64154AA
	for <xenomai@lists.linux.dev>; Tue, 29 Aug 2023 11:44:30 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20230829110411e9a2f49b46b8066bdb
        for <xenomai@lists.linux.dev>;
        Tue, 29 Aug 2023 13:04:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=Zv1DzmhyoemUoFMAcLccnVeFt18A9XPNkaIcnrL6to8=;
 b=marug8TdOuOVXi/ElL91IICUPqi8NDEhQQHPa6q3/hlNU3G9h1lLXiHwLmVpop9GnXtziL
 KJzmtr1Iq+lmyQnd1Ms/BmCpdmSgns4u28hZiqxA8B44SbcaJA6bIrg/14w3xFeFQEUd+RQS
 46HI/0hhc2EghARFbqEl8H20TRPBo=;
Message-ID: <d0819b6742607b5763ff643e9b7a540e5de7d544.camel@siemens.com>
Subject: Re: [PATCH v3] cobalt: Adjust dev_addr_set wrapper to 5.10, 5.1 and
 4.19 backports
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@lists.linux.dev>
Date: Tue, 29 Aug 2023 13:04:10 +0200
In-Reply-To: <f4a0e665-394e-46b6-ac61-cb3d3f76ea21@siemens.com>
References: <f4a0e665-394e-46b6-ac61-cb3d3f76ea21@siemens.com>
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

On Tue, 2023-08-29 at 11:40 +0200, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> Some stable kernels gained this helper meanwhile as well.
>=20
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  kernel/cobalt/include/asm-generic/xenomai/wrappers.h | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h b/kerne=
l/cobalt/include/asm-generic/xenomai/wrappers.h
> index ea7ed3ad56..a533d46690 100644
> --- a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
> +++ b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
> @@ -54,7 +54,13 @@
>  #define close_fd(__ufd)	__close_fd(current->files, __ufd)
>  #endif
> =20
> -#if LINUX_VERSION_CODE < KERNEL_VERSION(5,15,0)
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(5,15,0) && \
> +    (LINUX_VERSION_CODE >=3D KERNEL_VERSION(5,11,0) || \
> +     LINUX_VERSION_CODE < KERNEL_VERSION(5,10,188)) && \
> +    (LINUX_VERSION_CODE >=3D KERNEL_VERSION(5,4,0) || \
> +     LINUX_VERSION_CODE < KERNEL_VERSION(5,4,251)) && \
> +    (LINUX_VERSION_CODE >=3D KERNEL_VERSION(4,19,0) || \
> +     LINUX_VERSION_CODE < KERNEL_VERSION(4,19,291))

This is still broken. I have a 5.4.253 kernel here which already
provides eth_hw_addr_set.=20

LINUX_VERSION_CODE >=3D KERNEL_VERSION(5,4,0) is true for that kernel.

>  #define dev_addr_set(dev, addr)		memcpy((dev)->dev_addr, addr, MAX_ADDR_=
LEN)
>  #define eth_hw_addr_set(dev, addr)	memcpy((dev)->dev_addr, addr, ETH_ALE=
N)
>  #endif
> --=20
> 2.35.3

