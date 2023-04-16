Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9297E8
	for <xenomai@lists.linux.dev>; Sun, 16 Apr 2023 08:48:45 +0000 (UTC)
Received: from relay11.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::231])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 62AD2C1F41
	for <xenomai@lists.linux.dev>; Sun, 16 Apr 2023 08:35:07 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 7C1B0100004;
	Sun, 16 Apr 2023 08:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1681634098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OlDXRbrW6hDN6V/KzYwhIr9qSZCl+cBhFL5ylxyQeEc=;
	b=jvpp7E+NVmuLo0jNb0f7HOpfwPK5rFTnb6xn2gRbzR0hMB6ZMe7roxpoUsR6EhKsqn9b09
	ovrT+qb8CtQtfsl7NR+y3gdbgHRMNWd9KIHEHEDMZXWKkMtS3Fhx24BfXuET323sdiWabS
	SfFqp9hN8p7eYzFwP9J1U/81Pw3tjc8lxnqZPAnrCYmMKj22+K/GLV9scVm5aKDwREimBL
	PlxF0EFH+qWA3Fm/c0nXrwW6xEmoIuBBVjmoHTGT7jPqExCus6MWGJRHNEd1564GurnWQH
	WF5wsFwioG7Ld/vFH7AIKID/VwCVX/sVWbsxI+UYcOlLDgY3kPKdgKDAp49IDw==
References: <20230412170927.80793-1-d.sanz@ecler.com>
User-agent: mu4e 1.8.11; emacs 28.2
From: Philippe Gerum <rpm@xenomai.org>
To: Dani Sanz <sbrk.modules@gmail.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [PATCH] spi: bcm2835: fix NULL pointer deref for OOB transfers.
Date: Sun, 16 Apr 2023 10:31:42 +0200
In-reply-to: <20230412170927.80793-1-d.sanz@ecler.com>
Message-ID: <87edokb4y7.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Dani Sanz <sbrk.modules@gmail.com> writes:

> From: Dani Sanz <sbrk.modules@gmail.com>
>
> There was a problem when calling ioctl(fd, SPI_IOC_ENABLE_OOB_MODE,
> oob_spi_setup) to use spidev in OOB mode after setting up the spidev.
>
> The kernel crashed because on function
> bcm2835_spi_start_oob_transfer(struct spi_controller *ctlr, struct
> spi_oob_transfer *xfer), it tried to access bs->slv->prepare_cs,
> however bs->slv was NULL.
>
> This patch sets the bs->slv value to the correct bcm2835_spidev object
> during bcm2835_spi_setup(struct spi_device *spi), so the NULL pointer
> dereference that happened later is avoided.
>
> Signed-off-by: Dani Sanz <sbrk.modules@gmail.com>
> ---
>  drivers/spi/spi-bcm2835.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
> index 2626abfc0a5b..1051482df945 100644
> --- a/drivers/spi/spi-bcm2835.c
> +++ b/drivers/spi/spi-bcm2835.c
> @@ -1244,6 +1244,8 @@ static int bcm2835_spi_setup(struct spi_device *spi)
>  
>  		spi_set_ctldata(spi, slv);
>  
> +		bs->slv = slv;
> +
>  		ret = bcm2835_spi_setup_dma(ctlr, spi, bs, slv);
>  		if (ret)
>  			goto err_cleanup;

This bug has been there for quite some time it seems. Merged into
5.15.y, 6.1.y and 6.3, dovetail and evl trees. Thanks for looking into
this.

-- 
Philippe.
