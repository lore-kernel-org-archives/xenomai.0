Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD554190462
	for <xenomai@lists.linux.dev>; Tue,  3 Feb 2026 16:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770134737; cv=none; b=l7xHfK6idE4DwnTF5hdlNuvAnQezR297k76l7omjcpHLiJLhMcTbC8AeWaZV/8X7KGWXepJ668mn5PYMDRd1NuZIBh/7fdIaTJ2TWCra3N1V3hCtzKmXBYJpPLyqpPgG5lWh8Uei9oA7vhJEPCMytLHYBBGSf2B0KKmiJhSeTao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770134737; c=relaxed/simple;
	bh=XNV3QnrzPp5cMciWFXGCROdQYOX1Nt3GIHrt5+AEdGo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DAn4FRg6sQNDC1mGqwmWRCPxwiLKvNs6ajuh62Zq91uJLyLnSwntH3gI/eoilUe0J+iguq4qffHWacf41axeUH9ub2gHccH2ltBuUl0PYCZ6W4CMVYAgwwW2O4MBJNkQ3MVxkcHkCYOTVd2DHC1oo80epmzhXHT0B3pLPG7E6y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=gRnknxLq; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="gRnknxLq"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20260203152513fe6c97550c000207aa
        for <xenomai@lists.linux.dev>;
        Tue, 03 Feb 2026 16:25:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=kdM4gMO2fTaMmq4YYHZAEje/OXVpKwriQypBgjLGe9w=;
 b=gRnknxLqrITyqyVKVzVZWcIb0unqvbT2nzgy40kbSgZ6AjEggWgGvg24igJW3JctUQXbGf
 fTsCHtyqx+1o9RPI8TBYDizPszG53+FEbwHeFhNcY41JjXT44JvnNg80WIj5n7msrs8h9vJB
 ADlna6rOKA5Elq8qQ5QSsCyCYqtDWXTnnP4lr4jcOo87c7AaABNggaq4y9+POQ5kz0K8PE+Z
 BZe6PVeQehs61Vldwvoto0vge1V8gTAPjAUMTXv1o+sTC1sGYXsXXcbxE0+2MvCuNAm868is
 VQ5WAriuIsFDQP4H8Ntr4aR4SWkt0tGDwI4cvOhPCc8SF2czCetksV7Q==;
Message-ID: <513ae7f9858f1bc553be3c6fcbbcabf1c89d6b25.camel@siemens.com>
Subject: Re: [PATCH Dovetail 6.18 1/3] arm64: irq_pipeline: Fix mapping of
 SGI/LPI IPIs
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev, Jan Kiszka <jan.kiszka@siemens.com>
Date: Tue, 03 Feb 2026 16:25:12 +0100
In-Reply-To: <87o6m6vutd.fsf@xenomai.org>
References: <20260201-wip-flo-fixes-for-6-18-v1-0-91ea07c7eb7e@siemens.com>
		<20260201-wip-flo-fixes-for-6-18-v1-1-91ea07c7eb7e@siemens.com>
	 <87o6m6vutd.fsf@xenomai.org>
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

On Tue, 2026-02-03 at 14:08 +0100, Philippe Gerum wrote:
> -static inline void map_oob_ipis(int cpu)
> +static inline void map_oob_ipis(int cpu, int offset)
>  {
>  	int ipi;
> =20
>  	for (ipi =3D OOB_IPI_OFFSET; ipi < OOB_NR_IPI + OOB_IPI_OFFSET; ipi++)
> -		get_ipi_desc(cpu, ipi) =3D irq_to_desc(ipi_irq_base + ipi);
> +		get_ipi_desc(cpu, ipi) =3D irq_to_desc(ipi_irq_base + cpu * offset + i=
pi);
>  }

I'm still quite sure that the loop is wrong and should be=20

+static inline void map_oob_ipis(int cpu, int offset)
 {
        int ipi;
=20
-       for (ipi =3D OOB_IPI_OFFSET; ipi < OOB_NR_IPI + OOB_IPI_OFFSET; ipi=
++)
-               get_ipi_desc(cpu, ipi) =3D irq_to_desc(ipi_irq_base + ipi);
+       offset =3D ipi_irq_base + (cpu * offset);
+
+       for (ipi =3D OOB_IPI_OFFSET; ipi < nr_ipi; ipi++)
+               get_ipi_desc(cpu, ipi) =3D irq_to_desc(offset + ipi);
 }

instead. (Note OOB_NR_IPI + OOB_IPI_OFFSET vs. nr_ipi)

Example:

static void arm64_send_ipi(const cpumask_t *mask, unsigned int nr)
{
	unsigned int cpu;

	if (!percpu_ipi_descs)
		__ipi_send_mask(get_ipi_desc(0, nr), mask);

How should that work for IPI_IRQ_WORK? IPI_IRQ_WORK is located behind
the IPIs used for OOB and get_ipi_desc(0, IPI_IRQ_WORK) would return
NULL as we skipped the mapping in map_oob_ipis().

enum ipi_msg_type {
	IPI_RESCHEDULE,		// INBAND
	IPI_CALL_FUNC,		// OOB
	IPI_CPU_STOP,		// OOB
	IPI_CPU_STOP_NMI,	// OOB
	IPI_TIMER,		// Unmapped
	IPI_IRQ_WORK,		// Unmapped
	NR_IPI,
	/*
	 * Any enum >=3D NR_IPI and < MAX_IPI is special and not tracable
	 * with trace_ipi_*
	 */
	IPI_CPU_BACKTRACE =3D NR_IPI,
	IPI_KGDB_ROUNDUP,
	MAX_IPI
};

I agree that we can simplify the code a bit more, like you suggested.

Florian
