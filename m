Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591173AD527
	for <xenomai@lists.linux.dev>; Mon, 23 Mar 2026 15:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774281329; cv=none; b=ZumPiusvUDZojeafsVqoZ3X3nLSJvNpRoJbmcH0i2RrwU1MZctKQAcbNlNBwtRoZsd9kIT+kqYYfW3dIBKoB9pl7adZ0lKxIIfOSXx7zAmq7/KYVSRs/aCWCGNHPwwmwa+Y/kyAftCjr3uqXzXqXTO3cgt4vxm/MbHYh12IQJU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774281329; c=relaxed/simple;
	bh=Su+sIfq6/scXxeCboTdk6jTEAcrV3nrCzIOuBe5Hwvw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rYh7kr3LkdrpH1L+Mlu3abphfpXfEZOMexP0bFSP6rI3gfaPrVzu2XVq4ONrKgk3OLSN7rUMQrd2lEeGw2zHq7gIZ+xASWX7Ro9jJJ8OFEOA4WSdB956NU7ryZISCZ+erXAALhFFP+i2DeaDkS8/FTaaBaUlQa92H4kBSL1NSUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gcnIC1PZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gcnIC1PZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDEB9C2BCB0;
	Mon, 23 Mar 2026 15:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774281329;
	bh=Su+sIfq6/scXxeCboTdk6jTEAcrV3nrCzIOuBe5Hwvw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=gcnIC1PZ4WgiVE8g0N/Y9Xxv/SqCTA0exPNV2wb2qI3eDlJDEc+hcps2c8J/aY0iX
	 fsyxArlCoNjR8cSE2aMl99RUQyirWqjXU7v+gjJAGAACzvVo2c/F2YV5lpcBciRnQm
	 NicNIyJVoRDIEnJXx7ADpXkrSviyeRkoM4uPkVdZhAphXaaeCcYDBp5ILwzS8AGHLV
	 I4Jz4gn4KE2iZqaXs2KiY2u4/u1iJZSNbygz/y4k8vJC4NtZ/qXtyeKF+vLvGNr8kQ
	 beAIhcJoy5koetoZKhH2NbrA6WvUncbwWRYKUYa8Br0TkIwGbxVGYUvsNXOpYxtHJL
	 6f45n8DTCEpnA==
Date: Mon, 23 Mar 2026 10:55:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tobias Schaffner <tobias.schaffner@siemens.com>
Cc: xenomai@lists.linux.dev, rpm@xenomai.org, florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com
Subject: Re: [PATCH dovetail v5 11/12] pci: plda: irq_pipeline: enable
 pipelined interrupt control
Message-ID: <20260323155526.GA822647@bhelgaas>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320213657.2210419-12-tobias.schaffner@siemens.com>

On Fri, Mar 20, 2026 at 10:36:56PM +0100, Tobias Schaffner wrote:

Please run "git log --oneline
drivers/pci/controller/plda/pcie-plda-host.c" and make your subject
line match the history.

Also add a commit log here.  It's OK if it repeats the subject.

> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  drivers/pci/controller/plda/pcie-plda-host.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/controller/plda/pcie-plda-host.c b/drivers/pci/controller/plda/pcie-plda-host.c
> index 3c2f68383010..8f0fda4b9421 100644
> --- a/drivers/pci/controller/plda/pcie-plda-host.c
> +++ b/drivers/pci/controller/plda/pcie-plda-host.c
> @@ -244,6 +244,7 @@ static struct irq_chip plda_intx_irq_chip = {
>  	.irq_ack = plda_ack_intx_irq,
>  	.irq_mask = plda_mask_intx_irq,
>  	.irq_unmask = plda_unmask_intx_irq,
> +	.flags = IRQCHIP_PIPELINE_SAFE,
>  };
>  
>  static int plda_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
> @@ -358,6 +359,7 @@ static struct irq_chip plda_event_irq_chip = {
>  	.irq_ack = plda_ack_event_irq,
>  	.irq_mask = plda_mask_event_irq,
>  	.irq_unmask = plda_unmask_event_irq,
> +	.flags = IRQCHIP_PIPELINE_SAFE,
>  };
>  
>  static const struct plda_event_ops plda_event_ops = {
> -- 
> 2.43.0
> 
