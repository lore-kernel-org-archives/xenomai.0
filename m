References: <1443187370-3361-1-git-send-email-thierry.bultel@basystemes.fr>
 <20151002173432.GV31137@hermes.click-hack.org>
From: Thierry Bultel <thierry.bultel@basystemes.fr>
Message-ID: <560FC915.1010209@basystemes.fr>
Date: Sat, 3 Oct 2015 14:24:53 +0200
MIME-Version: 1.0
In-Reply-To: <20151002173432.GV31137@hermes.click-hack.org>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org



Le 02/10/2015 19:34, Gilles Chanteperdrix a =E9crit :
> On Fri, Sep 25, 2015 at 03:22:50PM +0200, Thierry Bultel wrote:
>> Signed-off-by: Thierry Bultel <thierry.bultel@basystemes.fr>
>> ---
>>   ksrc/drivers/can/rtcan_flexcan.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/ksrc/drivers/can/rtcan_flexcan.c b/ksrc/drivers/can/rtcan_f=
lexcan.c
>> index f5477db..91c5ebf 100644
>> --- a/ksrc/drivers/can/rtcan_flexcan.c
>> +++ b/ksrc/drivers/can/rtcan_flexcan.c
>> @@ -235,6 +235,7 @@ struct flexcan_priv {
>>   	struct regulator *reg_xceiver;
>>   	struct clk *clk_ipg;
>>   	struct clk *clk_per;
>> +	struct platform_device *pdev;
>>   #endif
>>   };
>>
>> @@ -1054,8 +1055,8 @@ static void put_clocks(struct flexcan_priv *priv)
>>   #if LINUX_VERSION_CODE < KERNEL_VERSION(3,11,0)
>>   	clk_put(priv->clk);
>>   #else
>> -	clk_put(priv->clk_per);
>> -	clk_put(priv->clk_ipg);
>> +	devm_clk_put(&priv->pdev->dev,priv->clk_per);
>> +	devm_clk_put(&priv->pdev->dev,priv->clk_ipg);
>>   #endif
>>   }
>>
>> @@ -1132,6 +1133,7 @@ static int flexcan_probe(struct platform_device *p=
dev)
>>   		}
>>   		clock_freq =3D clk_get_rate(priv->clk_per);
>>   	}
>> +	priv->pdev =3D pdev;
>>   #endif
>>
>>   	mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>
> I think you can completely drop the calls to clk_put: with
> devm_clk_get, the clocks should be automatically put when the device
> is destroyed. At least, this is what the doc says:
> http://lxr.free-electrons.com/source/include/linux/clk.h#L219
>
> Could you try the following patch, instead?

This is enough indeed, thanks.
Will you commit it ?
Thierry

>
> diff --git a/ksrc/drivers/can/rtcan_flexcan.c b/ksrc/drivers/can/rtcan_fl=
excan.c
> index f5477db..ddc3708 100644
> --- a/ksrc/drivers/can/rtcan_flexcan.c
> +++ b/ksrc/drivers/can/rtcan_flexcan.c
> @@ -1053,9 +1053,6 @@ static void put_clocks(struct flexcan_priv *priv)
>   {
>   #if LINUX_VERSION_CODE < KERNEL_VERSION(3,11,0)
>   	clk_put(priv->clk);
> -#else
> -	clk_put(priv->clk_per);
> -	clk_put(priv->clk_ipg);
>   #endif
>   }
>
>
>

