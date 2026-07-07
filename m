Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA693D75A1
	for <xenomai@lists.linux.dev>; Tue,  7 Jul 2026 22:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783463460; cv=none; b=m1xjt+7oZ/V7oAsyKCSQSx+zoS8K/b+w37LtU2RDycfqjG09t4TXuFnWs2kl1X68urOYR8toNYlpSK1XU4EJsFXhax1YDI/2T2L56CseOV7y4HpOBofLwb3BsOkmnPdDnuOfnSFxfss6bFcJ5kLcBceC0f0NLcG+RzgeWf4anHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783463460; c=relaxed/simple;
	bh=IlJ+wo8VyHvFRlJ9YBokkMiL0VSTtQ+u6MDdBnkTUs4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gGGAxUR6DKZL9I4zq9+g+RcVQYNpqIHYgLPzdxNQKmTwzB1oHH75SspZjilyKN5SlFf31FfrdZTc15B7o12d7m4L/G/G/8wtosbPNYXC/thDLg0BfES974rdApv9w+Ttoe4WxZW4hljrOeiJPryHGb6EQbNYyCQTOHSZ5PLA58s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Plf778hG; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Plf778hG"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202607072230557f12ab711300020726
        for <xenomai@lists.linux.dev>;
        Wed, 08 Jul 2026 00:30:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=IlJ+wo8VyHvFRlJ9YBokkMiL0VSTtQ+u6MDdBnkTUs4=;
 b=Plf778hGSdVHlmcXNOeNpWRuV/Gj2rw9rdgJOuBwx8MsiE7cUamYiYSIj0cvGkHDfAuOjB
 ljZjH5FHisZmN52p2bvSxFeh/irsdwQk4+32dqnudY8CiF2G+fWDUOGVY1lhun+99qR5ImcD
 Wp/+7QZmEZidqFvS8X9Gh/HZo6mGMt4vtEy8af0fvUByEh/elANC46GoftjUH1sIArdWg1UY
 2bHkgcX+mz5Lum5TAUGDK2g8upJnCjWK8dwqUQrTy90mbz+a61lPu3kFHoWB3BMihvONvYiI
 VIZBfxO6Qfnk2qucouX1dV7SxGwpjCuhUh5TRfIXqmFXmLXWO7T0wtaA==;
Message-ID: <837969b0d849fb716bc712df566bde246c5ffc41.camel@siemens.com>
Subject: Re: [PATCH linux-evl 0/2] Add RISC-V support to EVL
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Tobias Schaffner <tobias.schaffner@siemens.com>, Philippe Gerum
	 <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev
Date: Wed, 08 Jul 2026 00:30:55 +0200
In-Reply-To: <20251010101130.3758633-1-tobias.schaffner@siemens.com>
References: <20251010101130.3758633-1-tobias.schaffner@siemens.com>
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

On Fri, 2025-10-10 at 12:10 +0200, Tobias Schaffner wrote:
> Hi all,
>=20
> this series introduces an initial EVL port for RISC-V.
>=20
> While some tests are still failing, I=E2=80=99d like to share this early
> version with the community to gather feedback, reviews, and hopefully
> some assistance in refining the port.
>=20
> The patches have been tested in combination with the Dovetail RISC-V
> port on top of v6.12-evl1-rebase.
>=20
> Looking forward to your feedback and suggestions.
>=20

I tried to apply this series today, and run into the following issues
reported by my tooling.

Patch 1 is fine, patch 2 has some checkpatch findings.

A couple of debatable warnings like:

WARNING: Misplaced SPDX-License-Identifier tag - use line 1 instead
#58: FILE: arch/riscv/include/uapi/asm/evl/fptest.h:2:
+ * SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note

WARNING: unnecessary whitespace before a quoted newline
#95: FILE: arch/riscv/include/uapi/asm/evl/fptest.h:34:
+

In addition to a serious one:

ERROR: Missing Signed-off-by: line by nominal patch author 'shannmu
<shanmu1901@gmail.com>'

My perspective: We definitely need that.

Best regards,
Florian
