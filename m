Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB45A935
	for <xenomai@lists.linux.dev>; Wed, 12 Apr 2023 21:43:18 +0000 (UTC)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2023041221330778c2de129b62cc77e3
        for <xenomai@lists.linux.dev>;
        Wed, 12 Apr 2023 23:33:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=TtJEunGPXQqRcAYq9yciYVIp1CzbDaYJ3O0XfEWJfR0=;
 b=PrH7KP8Vu22OPWf08Ssh6VlceXc7rCnPKjWt+LEXgqn398j8dAJGloWDmF2K5ciea/N0q/
 9QvTJ9/DIcv2jhHoGp0Y5hSX0M03Q2ybrfCbzDIoJnt+DTqTQ39xOk1kLPbPsPEDVvE1ZUQS
 RrOkC47oWet7KntjUaWGl1Z4hcVBk=;
Message-ID: <dc1cc7a3be7f77baf0e6de5a6ca4baa548f05165.camel@siemens.com>
Subject: Re: [PATCH] spi: bcm2835: fix NULL pointer deref for OOB transfers.
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Dani Sanz <sbrk.modules@gmail.com>, xenomai@lists.linux.dev
Cc: rpm@xenomai.org
Date: Wed, 12 Apr 2023 23:33:06 +0200
In-Reply-To: <20230412170927.80793-1-d.sanz@ecler.com>
References: <20230412170927.80793-1-d.sanz@ecler.com>
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

On Wed, 2023-04-12 at 19:09 +0200, Dani Sanz wrote:
> From: Dani Sanz <sbrk.modules@gmail.com>
>=20
> There was a problem when calling ioctl(fd, SPI_IOC_ENABLE_OOB_MODE,
> oob_spi_setup) to use spidev in OOB mode after setting up the spidev.
>=20
> The kernel crashed because on function
> bcm2835_spi_start_oob_transfer(struct spi_controller *ctlr, struct
> spi_oob_transfer *xfer), it tried to access bs->slv->prepare_cs,
> however bs->slv was NULL.
>=20
> This patch sets the bs->slv value to the correct bcm2835_spidev object
> during bcm2835_spi_setup(struct spi_device *spi), so the NULL pointer
> dereference that happened later is avoided.
>=20
> Signed-off-by: Dani Sanz <sbrk.modules@gmail.com>
> ---
>  drivers/spi/spi-bcm2835.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
> index 2626abfc0a5b..1051482df945 100644
> --- a/drivers/spi/spi-bcm2835.c
> +++ b/drivers/spi/spi-bcm2835.c

Hi!

Thanks for your patch, but his is the wrong mailing list for this
issue. The patch should be submitted upstream (Linux) and we will fetch
it during the next update cycle of Dovetail or IPIPE.

[1] should provide the necessary details on how to submit such a patch.

It's common practice to include the kernel stack trace in the commit
message so others can search for the same issue and will hopefully be
directed to your patch.

Best regards,
Florian

[1] https://www.kernel.org/doc/html/latest/process/submitting-patches.html

> @@ -1244,6 +1244,8 @@ static int bcm2835_spi_setup(struct spi_device *spi=
)
> =20
>  		spi_set_ctldata(spi, slv);
> =20
> +		bs->slv =3D slv;
> +
>  		ret =3D bcm2835_spi_setup_dma(ctlr, spi, bs, slv);
>  		if (ret)
>  			goto err_cleanup;

