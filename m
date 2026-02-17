Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A3F288515
	for <xenomai@lists.linux.dev>; Tue, 17 Feb 2026 23:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771369563; cv=none; b=O4OGxrhyUPlFzyrZloVlDU7tIZJ3+0lFZv35tpvaEVNWQry3JlkBIkQTGaUFP1d7vy6gp+wbhYekLLPjYDb3s5MOGHGFeXza7CyJYGZ/Tkvlomnt12CjYs96JC4YsoYiRApeAIWtJEBHJyb8XBIB/aAy/4R7NhETu6Ij06niBho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771369563; c=relaxed/simple;
	bh=CdvZm+UyrlCsSWBsjiGLFEKswsI0p+xDIOH3gwQ26sA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G4JfJ/9HKxUdttFesrIkdhK0/Hmqory3m1HFrL3cKQygP16wPcbXZi/yuMJd2/yLEsVZkRYtAqDl8MDxeyekDKr4X2HZ/3A7XOyP8S83UHuyBUdTEy/u5wsairdEgk9S0JDixpJL2yc2WBB3YMElqeQmPcclpYPgTqoCcgq827s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=AmaCH95r; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="AmaCH95r"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20260217230551159a14adcd0002077f
        for <xenomai@lists.linux.dev>;
        Wed, 18 Feb 2026 00:05:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=U2rI9zDsjyr8JMx0Tj3rubOub0QiOJX+algq/D+4gY8=;
 b=AmaCH95rZ2Ps06fs1re3mQEyxdg1Q97m/Cl+pBSRPScer1SS+Z9bJlAjVmrdbMX8RKI+CZ
 1njL5ZPKcXkOIfyLMin22pt54SMfeHvk8PaaBv618yXKgvHyI/ixE978tTjS74nLMexUx9b5
 gOVwcBaqTvKmGRInORxXe92JvK/zZgpv6KMDJSq9plABDHTpxf8OviY8OMScnfBA3+sOGyZJ
 JQVi/TGimivB7myLJr9D5ny2cis8llQxYfSLqK3h7ySwe8q5RTXheYZQT3ilyP2XqtroMcX1
 5ZAjsnow7Mpmcsq5CyYInmoSDQ6B80bw++WHArTMWJT0uSrA201J/uFw==;
Message-ID: <982c1b8b306d2abd81c88bc4669035957b664f2e.camel@siemens.com>
Subject: Re: [PATCH Dovetail v2 1/2] dovetail: genirq: Add
 request_percpu_irq_affinity_flags()
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Cc: Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>
Date: Wed, 18 Feb 2026 00:05:50 +0100
In-Reply-To: <20260217-wip-flo-v6-19-dovetail-rebase-v2-1-45fc326a166a@siemens.com>
References: 
	<20260217-wip-flo-v6-19-dovetail-rebase-v2-0-45fc326a166a@siemens.com>
	 <20260217-wip-flo-v6-19-dovetail-rebase-v2-1-45fc326a166a@siemens.com>
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

On Tue, 2026-02-17 at 23:54 +0100, Florian Bezdeka wrote:
> cobalt / evl are currently using __request_percpu_irq() for setting up
> OOB IRQs. In 6.19 the signature of __request_percpu_irq() has been
> updated and 7.0 will remove the function entirely, so we need a
> replacement.
>=20
> All other variants (like the upcoming request_percpu_irq_affinity())
> are missing the flags parameter which we require.
>=20
> This could be backported to all supported dovetail versions. That
> would allow co-kernels to switch to the new API unconditionally.
>=20
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  include/linux/interrupt.h |  5 +++++
>  kernel/irq/manage.c       | 10 ++++++++++
>  2 files changed, 15 insertions(+)
>=20
> diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> index bf0511b438c65e119af917763ce92a8f3bfb4c4c..6cd8ad02ffbd87f71869d6737=
fbc8c1ae477c1ee 100644
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -213,6 +213,11 @@ request_percpu_irq_affinity(unsigned int irq, irq_ha=
ndler_t handler,
>  				    devname, affinity, percpu_dev_id);
>  }
> =20
> +int request_percpu_irq_affinity_flags(unsigned int irq, irq_handler_t ha=
ndler,
> +				      unsigned long flags, const char *devname,
> +				      const cpumask_t *affinity,
> +				      void __percpu *dev_id);
> +
>=20

Would be nice to get some feedback here. The affinity parameter is
currently not in use, but would allow us to provide it in the future.
Not sure if that will be necessary...

The idea behind were the upcoming 7.0 changes. The implementation of
request_percpu_irq_affinity() could move to the dovetail specific
variant and the Linux implementation can simply call the dovetail
variant.
