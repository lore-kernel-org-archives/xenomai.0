Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56E233121E
	for <xenomai@lists.linux.dev>; Thu,  9 Jul 2026 15:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783610249; cv=none; b=FlEzqDtwlPxye2Kw5EIlg/YeTDVgIwTN11SuGFQyxgSSWjHgnhDWi3OmTV1OMdNA8L15N97EiqPvBj3f7dzGJfkvtyMt5Ilq1ztKn80HM0woh64ixLFmqe1TudYt7cf8NB3eVhRi6Uw2PatLc9bM5kH39fA4Q5IU92OiP1smS/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783610249; c=relaxed/simple;
	bh=xIy/5rBaFMPjQKB+gNnzWP4I75Mr0k/aU2TCaqW87Fo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iGQ800yJSUsZCzk24OU2OISX5lNgozN3CYLEKbfuEGwKT6vCBt6qYdFs7Vl9aPZ2qd8lEiEPvKEBTxPW0bh4fMBAinJ9dqqouZAg+oZqf+7LVCJZo/cEI15xTanH88fQEAbVWEX1OKycg1LWUMLAf+i88QWCOtNf0zXyV1GqFHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=i+jsSil+; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="i+jsSil+"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202607091517160e2f6f4fd3000207f9
        for <xenomai@lists.linux.dev>;
        Thu, 09 Jul 2026 17:17:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=5opmmWdLDkTfY386YX9PiQHzPIdurCejhFgTE7L6/uc=;
 b=i+jsSil+G6ILnXkQ6n9AMqAeUB2kX/m8ypeNWHRRrE960sbYZOWveiqAzOFh00g22e0949
 GvtVNEAwTPKCqa3LySd8+XAy5f6O2hn83oB/fXGFBhZZw5UazG5yj1+VPrw7HfkXmamV3jTn
 LOIr3lhywbO6KryI7brku81HZmgRu0LMr2IfqVbwdKMV+ADowKtsN0KDPADPBX02PyFCwIa3
 wg7JqukDaneZM6H9rwdj5M2ugJFQzfum3B+26NJD0vEwn26OJF116fbit8XhB6SM2Y0gxzsJ
 q/VB5H285M7Yfu3BgiBE02tevs5hxfvz5F/ci0qepa77HfomD4cMRgOg==;
Message-ID: <2dcc2289d120ec592539490954f262732f4966b7.camel@siemens.com>
Subject: Re: [PATCH libevl v2] build: add initial RISC-V support
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Cc: rpm@xenomai.org
Date: Thu, 09 Jul 2026 17:17:16 +0200
In-Reply-To: <20260709134451.325524-1-tobias.schaffner@siemens.com>
References: <20260709134451.325524-1-tobias.schaffner@siemens.com>
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

On Thu, 2026-07-09 at 15:44 +0200, Tobias Schaffner wrote:
> Provide the basic build infrastructure and VDSO definitions
> required to build libevl on RISC-V.
>=20
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  lib/arch/riscv/include/asm/evl/vdso.h | 14 ++++++++++++++
>  meson.build                           |  4 ++++
>  meson/riscv64-linux-gnu               | 17 +++++++++++++++++
>  3 files changed, 35 insertions(+)
>  create mode 100644 lib/arch/riscv/include/asm/evl/vdso.h
>  create mode 100644 meson/riscv64-linux-gnu
>=20
> diff --git a/lib/arch/riscv/include/asm/evl/vdso.h b/lib/arch/riscv/inclu=
de/asm/evl/vdso.h
> new file mode 100644
> index 0000000..5e331fb
> --- /dev/null
> +++ b/lib/arch/riscv/include/asm/evl/vdso.h
> @@ -0,0 +1,14 @@
> +/*
> + * SPDX-License-Identifier: MIT
> + *
> + * Copyright (C) 2021 Philippe Gerum  <rpm@xenomai.org>
> + */

^^ Copy paste mistake? At least wrong year...


