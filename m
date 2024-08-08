Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4855839EB
	for <xenomai@lists.linux.dev>; Thu,  8 Aug 2024 07:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723102519; cv=none; b=C8GEzoLLlHPA3GcGfxCTawzOVYThMT4R913PGH7YVGUdCDuvnqts++xmvt7fnrg1nvbYHTOFNcQ9zI2oPDUE5XbhQmiL7ufGePmjdqEdSOI8YA5CPb9y5cquATfFSmfJJucujLP8BWIlvcdvUVbc8O6qvP3jW3ofUJco0ZEn+Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723102519; c=relaxed/simple;
	bh=XewXLIlgkk+JQMXnRA1/09ys24Dg0X3AudBlN2inQmE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rScnzM5IEKGtFsRqumlL0UjoPsiAR7+h/INEy7OuF0eNvqV7amui5r8OA7lRGsPo1rxqyt8ReQ0vlzG0t9qKBTM/nqAjcIsTj5BykyIS2juhpHkr4lGYkiiBrsfXnTv6mRafxA4NOQv3cr/A007qZibhUvtWDZ5lXGhHL910vuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Bq5NX8dG; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Bq5NX8dG"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20240808073503aec0b2235128533c31
        for <xenomai@lists.linux.dev>;
        Thu, 08 Aug 2024 09:35:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=kB0zQoWbRvMMoklw5sdvLM/Wjiietoest28eFsXkQyc=;
 b=Bq5NX8dGULzCGM0uWGgZjEEtYBZTLTiU1MbflmpdK3letk6AKmA2ur7RBQ6NeJR4/ebGhk
 aZ0zCZVMUBz9JXjbe3AlG3vV7sKqPPM/91BEKXWTprLNNbFI3QzfoqsBy/vRchAJ8oAZO4yP
 xfSJKgPhIB0bi2dD40Z9EU8KVkD5IsQGMlxXXoM59b601Bq6VuKUiDebpUBzqUgkue5WKERu
 CAQlaeinqv/8V6LPS0rb5Ra5u+vsTyAZd9cAMUqXxDstwGMDOPdqlYEFoAfCmEx1NgGA5wAT
 jyB70sTjEjqAmH92Nbf9MDmKgkZdrhpVeL677Fo6ZbvJHKKguPI5i3rw==;
Message-ID: <bf4e1f32bdd708d5a438e87e697e40c404b0865b.camel@siemens.com>
Subject: Re: [PATCH] drivers: Account for different platform driver remove
 callback in 6.11
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@lists.linux.dev>
Date: Thu, 08 Aug 2024 09:35:02 +0200
In-Reply-To: <c91fe1f4-5f33-4bfd-b869-be2d9ba352a2@siemens.com>
References: <c91fe1f4-5f33-4bfd-b869-be2d9ba352a2@siemens.com>
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

On Wed, 2024-08-07 at 23:29 +0200, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> Unfortunately, this requires a bit of #ifdef'ery.
>=20
> The fec driver was the only one actually returning non-zero as well.
> Adjust it to what upstream does.
>=20
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  .../drivers/can/c_can/rtcan_c_can_platform.c  |  6 +++++
>  kernel/drivers/can/rtcan_flexcan.c            |  6 +++++
>  kernel/drivers/net/drivers/at91_ether.c       |  6 +++++
>  .../drivers/net/drivers/freescale/fec_main.c  | 22 ++++++++++++++-----
>  kernel/drivers/net/drivers/macb.c             |  6 +++++
>  kernel/drivers/serial/mpc52xx_uart.c          |  6 +++++
>  kernel/drivers/serial/rt_imx_uart.c           |  6 +++++
>  kernel/drivers/spi/spi-bcm2835.c              |  6 +++++
>  kernel/drivers/spi/spi-omap2-mcspi-rt.c       |  6 +++++
>  kernel/drivers/spi/spi-sun6i.c                |  6 +++++
>  10 files changed, 71 insertions(+), 5 deletions(-)
>=20
> diff --git a/kernel/drivers/can/c_can/rtcan_c_can_platform.c b/kernel/dri=
vers/can/c_can/rtcan_c_can_platform.c
> index 0d29d98771..aef6f8895c 100644
> --- a/kernel/drivers/can/c_can/rtcan_c_can_platform.c
> +++ b/kernel/drivers/can/c_can/rtcan_c_can_platform.c
> @@ -432,13 +432,19 @@ exit:
>  	return ret;
>  }
> =20
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(6,11,0)
>  static int c_can_plat_remove(struct platform_device *pdev)
> +#else
> +static void c_can_plat_remove(struct platform_device *pdev)
> +#endif
>  {
>  	struct rtcan_device *dev =3D platform_get_drvdata(pdev);
> =20
>  	rtcan_c_can_unregister(dev);
>  	rtcan_c_can_dev_free(dev);
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(6,11,0)
>  	return 0;
> +#endif
>  }
> =20
>  static struct platform_driver c_can_plat_driver =3D {
> diff --git a/kernel/drivers/can/rtcan_flexcan.c b/kernel/drivers/can/rtca=
n_flexcan.c
> index edaaad7031..1658599232 100644
> --- a/kernel/drivers/can/rtcan_flexcan.c
> +++ b/kernel/drivers/can/rtcan_flexcan.c
> @@ -1482,14 +1482,20 @@ static int flexcan_probe(struct platform_device *=
pdev)
>  	return err;
>  }
> =20
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(6,11,0)
>  static int flexcan_remove(struct platform_device *pdev)
> +#else
> +static void flexcan_remove(struct platform_device *pdev)
> +#endif
>  {
>  	struct rtcan_device *dev =3D platform_get_drvdata(pdev);
> =20
>  	unregister_flexcandev(dev);
>  	rtcan_dev_free(dev);
> =20
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(6,11,0)
>  	return 0;
> +#endif
>  }
> =20
>  static struct platform_driver flexcan_driver =3D {
> diff --git a/kernel/drivers/net/drivers/at91_ether.c b/kernel/drivers/net=
/drivers/at91_ether.c
> index f8223b0bc5..a5ef40c579 100644
> --- a/kernel/drivers/net/drivers/at91_ether.c
> +++ b/kernel/drivers/net/drivers/at91_ether.c
> @@ -421,7 +421,11 @@ err_free_dev:
>  	return res;
>  }
> =20
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(6,11,0)
>  static int at91ether_remove(struct platform_device *pdev)
> +#else
> +static void at91ether_remove(struct platform_device *pdev)
> +#endif
>  {
>  	struct rtnet_device *dev =3D platform_get_drvdata(pdev);
>  	struct macb *lp =3D rtnetdev_priv(dev);
> @@ -440,7 +444,9 @@ static int at91ether_remove(struct platform_device *p=
dev)
>  	clk_disable(lp->pclk);
>  	rtdev_free(dev);
> =20
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(6,11,0)
>  	return 0;
> +#endif
>  }
> =20
>  static struct platform_driver at91ether_driver =3D {
> diff --git a/kernel/drivers/net/drivers/freescale/fec_main.c b/kernel/dri=
vers/net/drivers/freescale/fec_main.c
> index d1b6fd166f..9561fbc589 100644
> --- a/kernel/drivers/net/drivers/freescale/fec_main.c
> +++ b/kernel/drivers/net/drivers/freescale/fec_main.c
> @@ -3522,8 +3522,11 @@ failed_rt_init:
>  	return ret;
>  }
> =20
> -static int
> -fec_drv_remove(struct platform_device *pdev)
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(6,11,0)
> +static int fec_drv_remove(struct platform_device *pdev)
> +#else
> +static void fec_drv_remove(struct platform_device *pdev)
> +#endif
>  {
>  	struct net_device *ndev =3D platform_get_drvdata(pdev);
>  	struct fec_enet_private *fep =3D netdev_priv(ndev);
> @@ -3532,7 +3535,9 @@ fec_drv_remove(struct platform_device *pdev)
> =20
>  	ret =3D pm_runtime_resume_and_get(&pdev->dev);
>  	if (ret < 0)
> -		return ret;
> +		dev_err(&pdev->dev,
> +			"Failed to resume device in remove callback (%pe)\n",
> +			ERR_PTR(ret));

No bailout anymore?

> =20
>  	cancel_work_sync(&fep->tx_timeout_work);
>  	fec_ptp_stop(pdev);
> @@ -3547,13 +3552,20 @@ fec_drv_remove(struct platform_device *pdev)
>  		of_phy_deregister_fixed_link(np);
>  	of_node_put(fep->phy_node);
> =20
> -	clk_disable_unprepare(fep->clk_ahb);
> -	clk_disable_unprepare(fep->clk_ipg);
> +        /* After pm_runtime_get_sync() failed, the clks are still off, s=
o skip
> +         * disabling them again.
> +         */
> +	if (ret >=3D 0) {
> +		clk_disable_unprepare(fep->clk_ahb);
> +		clk_disable_unprepare(fep->clk_ipg);
> +	}
>  	pm_runtime_put_noidle(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
> =20
>  	free_netdev(ndev);
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(6,11,0)
>  	return 0;
> +#endif
>  }
> =20
>  static int __maybe_unused fec_suspend(struct device *dev)
> diff --git a/kernel/drivers/net/drivers/macb.c b/kernel/drivers/net/drive=
rs/macb.c
> index 77957d9062..6da5761479 100644
> --- a/kernel/drivers/net/drivers/macb.c
> +++ b/kernel/drivers/net/drivers/macb.c
> @@ -1769,7 +1769,11 @@ err_out:
>  	return err;
>  }
> =20
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(6,11,0)
>  static int __exit macb_remove(struct platform_device *pdev)
> +#else
> +static void __exit macb_remove(struct platform_device *pdev)
> +#endif
>  {
>  	struct rtnet_device *dev;
>  	struct macb *bp;
> @@ -1795,7 +1799,9 @@ static int __exit macb_remove(struct platform_devic=
e *pdev)
>  		rtdev_free(dev);
>  	}
> =20
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(6,11,0)
>  	return 0;
> +#endif
>  }
> =20
>  static struct platform_driver macb_driver =3D {
> diff --git a/kernel/drivers/serial/mpc52xx_uart.c b/kernel/drivers/serial=
/mpc52xx_uart.c
> index 68d1a4cbda..1347ac0b38 100644
> --- a/kernel/drivers/serial/mpc52xx_uart.c
> +++ b/kernel/drivers/serial/mpc52xx_uart.c
> @@ -1360,7 +1360,11 @@ out_kfree_port:
>  	return ret;
>  }
> =20
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(6,11,0)
>  static int rt_mpc52xx_uart_of_remove(struct platform_device *op)
> +#else
> +static void rt_mpc52xx_uart_of_remove(struct platform_device *op)
> +#endif
>  {
>  	struct rtdm_device *dev =3D dev_get_drvdata(&op->dev);
>  	struct rt_mpc52xx_uart_port *port =3D dev->device_data;
> @@ -1376,7 +1380,9 @@ static int rt_mpc52xx_uart_of_remove(struct platfor=
m_device *op)
>  	kfree(port);
>  	kfree(dev);
> =20
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(6,11,0)
>  	return 0;
> +#endif
>  }
> =20
>  static struct of_device_id rt_mpc52xx_uart_of_match[] =3D {
> diff --git a/kernel/drivers/serial/rt_imx_uart.c b/kernel/drivers/serial/=
rt_imx_uart.c
> index 2b2dbeeb72..bc5f4a8ed7 100644
> --- a/kernel/drivers/serial/rt_imx_uart.c
> +++ b/kernel/drivers/serial/rt_imx_uart.c
> @@ -1597,7 +1597,11 @@ static int rt_imx_uart_probe(struct platform_devic=
e *pdev)
>  	return 0;
>  }
> =20
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(6,11,0)
>  static int rt_imx_uart_remove(struct platform_device *pdev)
> +#else
> +static void rt_imx_uart_remove(struct platform_device *pdev)
> +#endif
>  {
>  	struct imxuart_platform_data *pdata;
>  	struct rt_imx_uart_port *port =3D platform_get_drvdata(pdev);
> @@ -1610,7 +1614,9 @@ static int rt_imx_uart_remove(struct platform_devic=
e *pdev)
>  	clk_disable_unprepare(port->clk_per);
>  	rtdm_dev_unregister(dev);
> =20
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(6,11,0)
>  	return 0;
> +#endif
>  }
> =20
>  static struct platform_driver rt_imx_uart_driver =3D {
> diff --git a/kernel/drivers/spi/spi-bcm2835.c b/kernel/drivers/spi/spi-bc=
m2835.c
> index fabfd4a59c..4a1a6f201c 100644
> --- a/kernel/drivers/spi/spi-bcm2835.c
> +++ b/kernel/drivers/spi/spi-bcm2835.c
> @@ -670,7 +670,11 @@ fail:
>  	return ret;
>  }
> =20
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(6,11,0)
>  static int bcm2835_spi_remove(struct platform_device *pdev)
> +#else
> +static void bcm2835_spi_remove(struct platform_device *pdev)
> +#endif
>  {
>  	struct rtdm_spi_master *master =3D platform_get_drvdata(pdev);
>  	struct spi_master_bcm2835 *spim;
> @@ -689,7 +693,9 @@ static int bcm2835_spi_remove(struct platform_device =
*pdev)
> =20
>  	rtdm_spi_remove_master(master);
> =20
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(6,11,0)
>  	return 0;
> +#endif
>  }
> =20
>  static const struct of_device_id bcm2835_spi_match[] =3D {
> diff --git a/kernel/drivers/spi/spi-omap2-mcspi-rt.c b/kernel/drivers/spi=
/spi-omap2-mcspi-rt.c
> index 976d28dc5d..6b5c11b71d 100644
> --- a/kernel/drivers/spi/spi-omap2-mcspi-rt.c
> +++ b/kernel/drivers/spi/spi-omap2-mcspi-rt.c
> @@ -993,7 +993,11 @@ fail:
>  	return ret;
>  }
> =20
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(6,11,0)
>  static int omap2_mcspi_remove(struct platform_device *pdev)
> +#else
> +static void omap2_mcspi_remove(struct platform_device *pdev)
> +#endif
>  {
>  	struct rtdm_spi_master *master =3D platform_get_drvdata(pdev);
>  	struct spi_master_omap2_mcspi *spim;
> @@ -1010,7 +1014,9 @@ static int omap2_mcspi_remove(struct platform_devic=
e *pdev)
> =20
>  	rtdm_spi_remove_master(master);
> =20
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(6,11,0)
>  	return 0;
> +#endif
>  }
> =20
>  static struct platform_driver omap2_mcspi_spi_driver =3D {
> diff --git a/kernel/drivers/spi/spi-sun6i.c b/kernel/drivers/spi/spi-sun6=
i.c
> index 72a4abd0d7..13dd325c91 100644
> --- a/kernel/drivers/spi/spi-sun6i.c
> +++ b/kernel/drivers/spi/spi-sun6i.c
> @@ -629,7 +629,11 @@ fail:
>  	return ret;
>  }
> =20
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(6,11,0)
>  static int sun6i_spi_remove(struct platform_device *pdev)
> +#else
> +static void sun6i_spi_remove(struct platform_device *pdev)
> +#endif
>  {
>  	struct rtdm_spi_master *master =3D platform_get_drvdata(pdev);
>  	struct spi_master_sun6i *spim;
> @@ -645,7 +649,9 @@ static int sun6i_spi_remove(struct platform_device *p=
dev)
> =20
>  	rtdm_spi_remove_master(master);
> =20
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(6,11,0)
>  	return 0;
> +#endif
>  }
> =20
>  static const struct of_device_id sun6i_spi_match[] =3D {
> --=20
> 2.43.0

