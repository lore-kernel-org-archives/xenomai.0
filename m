Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=us-ascii
From: Michael Haberler <haberlerm@gmail.com>
In-Reply-To: <1443187370-3361-1-git-send-email-thierry.bultel@basystemes.fr>
Date: Fri, 25 Sep 2015 18:16:13 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <110BEC51-53FC-40C6-9840-EEF64E7F1342@gmail.com>
References: <1443187370-3361-1-git-send-email-thierry.bultel@basystemes.fr>
Subject: Re: [Xenomai] [PATCH 1/1] rtcan_flexcan: with open firmware,
	use devm_clk_put instead of clk_put
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Thierry Bultel <thierry.bultel@basystemes.fr>
Cc: xenomai <xenomai@xenomai.org>

Hi Thiery,

could you give a bit of context about this patch?

what problem does the patch resolve?
what is 'open firmware'
which kernel version did you apply this?
which platform?

- Michael

> Am 25.09.2015 um 15:22 schrieb Thierry Bultel =
<thierry.bultel@basystemes.fr>:
>=20
> Signed-off-by: Thierry Bultel <thierry.bultel@basystemes.fr>
> ---
> ksrc/drivers/can/rtcan_flexcan.c | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/ksrc/drivers/can/rtcan_flexcan.c =
b/ksrc/drivers/can/rtcan_flexcan.c
> index f5477db..91c5ebf 100644
> --- a/ksrc/drivers/can/rtcan_flexcan.c
> +++ b/ksrc/drivers/can/rtcan_flexcan.c
> @@ -235,6 +235,7 @@ struct flexcan_priv {
> 	struct regulator *reg_xceiver;
> 	struct clk *clk_ipg;
> 	struct clk *clk_per;
> +	struct platform_device *pdev;
> #endif
> };
>=20
> @@ -1054,8 +1055,8 @@ static void put_clocks(struct flexcan_priv =
*priv)
> #if LINUX_VERSION_CODE < KERNEL_VERSION(3,11,0)
> 	clk_put(priv->clk);
> #else
> -	clk_put(priv->clk_per);
> -	clk_put(priv->clk_ipg);
> +	devm_clk_put(&priv->pdev->dev,priv->clk_per);
> +	devm_clk_put(&priv->pdev->dev,priv->clk_ipg);
> #endif
> }
>=20
> @@ -1132,6 +1133,7 @@ static int flexcan_probe(struct platform_device =
*pdev)
> 		}
> 		clock_freq =3D clk_get_rate(priv->clk_per);
> 	}
> +	priv->pdev =3D pdev;
> #endif
>=20
> 	mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> --=20
> 1.9.1
>=20
>=20
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://xenomai.org/mailman/listinfo/xenomai


