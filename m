Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3F8215F4C
	for <xenomai@lists.linux.dev>; Thu, 17 Apr 2025 08:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744879403; cv=none; b=CY9x4ykb5/xhDC0c6+yQI0089QB+3R42DUdnAj3wko6rMfBKZUWHI4OnEeAz+RUHygdgmES6RRuQVwg4GMHy3TtwXeuOv3GALUu06JXDpUKvjfkZv4ZOjeioTNnJ0VXb/LUEjAFOsHw6MPVvnOKxJtGPXS8GjJqUE4kVKRhm3kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744879403; c=relaxed/simple;
	bh=tJgP6gSkxh0JDJEZ8Qal26pT8ncE538r3yz7g9yEQVw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IxhEs+reKE5edMlhFOP4bjovMgf8V9la6baZD6oP6/ZR1233a6Ybqf/T74UWQynShbY3AWqRbh2qXC/IMA3wyxJPZYgWZdauKHiF/dshmQ1le4br3R1oplKYcKb9vpkfbAMsBLcxjuwhybtXaj+YNaMfgKFvWRJqRQ6gPtMJ1bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=dOHDhxuF; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="dOHDhxuF"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202504170843100aa349d93a328f079d
        for <xenomai@lists.linux.dev>;
        Thu, 17 Apr 2025 10:43:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=GQoT6o+W3Mq/Gwkxys7M5zSKq/1QQ0IxTJ3v3UxwUwU=;
 b=dOHDhxuFrOuXLcqF7dtGszQYYcm/Iixsff1xVSapY+Gj7zqTswg8AMNkJ/LUQUo6VoWHSM
 EDtgk+ZIIF4xKL4PjeFPjZmcuqByFAvm/QWNdyU2SdnbBrxQy/3WkcNQOB99J2mNM3E8hk5h
 dtXRaGWsZH2eMo3gi1LIvx5/qIZKPgHYmk13fUj/ID42aHd6D1+0GraAgrDH+/9L9CI/A+tq
 bkSuAxDTcmgQv9CtJ3p7DoPMzPq7fnHE1gg+2KUwFsM9WyJe47H75LabJrCRyibEDsSzR7B7
 QERAl2WT+7MQdmVoIfaP0mZAsAZ5wQRSyJc5PzT165phskoz19Y08IVQ==;
Message-ID: <72c2c5cb18b635f1145c35b6592c661cf55aeb0f.camel@siemens.com>
Subject: Re: Build error of kernel/xenomai/debug.c
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: "Qiao, Wei" <wei.qiao@intel.com>, "xenomai@lists.linux.dev"
	 <xenomai@lists.linux.dev>
Cc: "Chen, Hongzhan" <hongzhan.chen@intel.com>, "Pirou, Florent"
	 <florent.pirou@intel.com>
Date: Thu, 17 Apr 2025 10:43:09 +0200
In-Reply-To: <IA1PR11MB6513EB0131E06C8CC865E8EF8CBC2@IA1PR11MB6513.namprd11.prod.outlook.com>
References: 
	<IA1PR11MB6513EB0131E06C8CC865E8EF8CBC2@IA1PR11MB6513.namprd11.prod.outlook.com>
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

On Thu, 2025-04-17 at 08:15 +0000, Qiao, Wei wrote:
> Hi All,
>=20
> If we build the kernel in ubuntu 24.04, there is build error:
>=20
> from kernel/xenomai/debug.c:23:
> In function 'strcpy',
>     inlined from 'hash_symbol' at kernel/xenomai/debug.c:94:2:
> ./include/linux/fortify-string.h:787:17: error: call to '__write_overflow=
' declared with attribute error: detected write beyond size of object (1st =
parameter)
>   787 |                 __write_overflow();
>       |                 ^~~~~~~~~~~~~~~~~~
>=20
> This is because new gcc version has stricter FORTIFY_SOURCE( =3D3 is =E2=
=80=8Cstricter=E2=80=8C than =3D2). Please help to fix, thanks.

That is the flexible array story...

You could try something like below (completely untested) and report
back if it works:

diff --git a/kernel/cobalt/debug.c b/kernel/cobalt/debug.c
index 25b194c26..d048dc757 100644
--- a/kernel/cobalt/debug.c
+++ b/kernel/cobalt/debug.c
@@ -47,7 +47,8 @@ EXPORT_SYMBOL_GPL(cobalt_debug_vfroot);
=20
 struct hashed_symbol {
 	struct hashed_symbol *next;
-	char symbol[];
+	size_t size;
+	char symbol[] __counted_by(size);
 };
=20
 static struct hashed_symbol *symbol_jhash[SYMBOL_HSLOTS];
@@ -91,6 +92,7 @@ static const char *hash_symbol(const char *symbol)
 		goto out;
 	}
=20
+	p->size =3D len + 1;
 	strcpy(p->symbol, symbol);
 	p->next =3D *h;
 	*h =3D p;

>=20
> Br,
> QiaoWei
>=20

