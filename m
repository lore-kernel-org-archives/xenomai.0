References: <1443187370-3361-1-git-send-email-thierry.bultel@basystemes.fr>
 <110BEC51-53FC-40C6-9840-EEF64E7F1342@gmail.com>
From: Thierry Bultel <thierry.bultel@basystemes.fr>
Message-ID: <56058214.8010703@basystemes.fr>
Date: Fri, 25 Sep 2015 19:19:16 +0200
MIME-Version: 1.0
In-Reply-To: <110BEC51-53FC-40C6-9840-EEF64E7F1342@gmail.com>
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
To: Michael Haberler <haberlerm@gmail.com>
Cc: xenomai <xenomai@xenomai.org>



Le 25/09/2015 18:16, Michael Haberler a =E9crit :
> Hi Thiery,
Hi Michael,
>
> could you give a bit of context about this patch?
>
> what problem does the patch resolve?

When the rtcan_flexcan driver is loaded as a module, the module=20
unloading does not perform all the mandatory cleanup.

The symptom is that when loading the module again thereafter,
the kernel complains about the clocks:

root@CF_thierry:~>insmod /boot/xeno_can_flexcan.ko
root@CF_thierry:~>dmesg -c
[ 86.611247] ------------[ cut here ]------------
[ 86.611276] WARNING: CPU: 1 PID: 2805 at include/linux/kref.h:47=20
__clk_get+0x80/0x90()
[ 86.611282] Modules linked in: xeno_can_flexcan(+) [last unloaded:=20
xeno_can_flexcan]
[ 86.611304] CPU: 1 PID: 2805 Comm: insmod Not tainted 3.18.12_4.1.0 #2
[ 86.611338] [<80016550>] (unwind_backtrace) from [<80012194>]=20
(show_stack+0x10/0x14)
[ 86.611362] [<80012194>] (show_stack) from [<806fba78>]=20
(dump_stack+0x84/0xc4)
[ 86.611377] [<806fba78>] (dump_stack) from [<80022a90>]=20
(warn_slowpath_common+0x74/0x90)
[ 86.611389] [<80022a90>] (warn_slowpath_common) from [<80022b48>]=20
(warn_slowpath_null+0x1c/0x24)
[ 86.611402] [<80022b48>] (warn_slowpath_null) from [<80532750>]=20
(__clk_get+0x80/0x90)
[ 86.611417] [<80532750>] (__clk_get) from [<8052f7cc>]=20
(of_clk_get_by_clkspec+0x2c/0x48)
[ 86.611429] [<8052f7cc>] (of_clk_get_by_clkspec) from [<8052f820>]=20
(of_clk_get.part.2+0x38/0x40)
[ 86.611441] [<8052f820>] (of_clk_get.part.2) from [<8052f8cc>]=20
(of_clk_get_by_name+0x90/0xcc)
[ 86.611452] [<8052f8cc>] (of_clk_get_by_name) from [<8052f92c>]=20
(clk_get+0x24/0x54)
[ 86.611464] [<8052f92c>] (clk_get) from [<8052f508>]=20
(devm_clk_get+0x34/0x70)
[ 86.611485] [<8052f508>] (devm_clk_get) from [<7f007a20>]=20
(flexcan_probe+0xcc/0x548 [xeno_can_flexcan])
[ 86.611511] [<7f007a20>] (flexcan_probe [xeno_can_flexcan]) from=20
[<803e993c>] (platform_drv_probe+0x44/0xa4)
[ 86.611526] [<803e993c>] (platform_drv_probe) from [<803e7f80>]=20
(driver_probe_device+0x108/0x23c)
[ 86.611538] [<803e7f80>] (driver_probe_device) from [<803e8184>]=20
(__driver_attach+0x8c/0x90)
[ 86.611549] [<803e8184>] (__driver_attach) from [<803e6534>]=20
(bus_for_each_dev+0x6c/0xa0)
[ 86.611560] [<803e6534>] (bus_for_each_dev) from [<803e77a8>]=20
(bus_add_driver+0x14c/0x1f4)
[ 86.611571] [<803e77a8>] (bus_add_driver) from [<803e89e0>]=20
(driver_register+0x78/0xf8)
[ 86.611582] [<803e89e0>] (driver_register) from [<80008cb0>]=20
(do_one_initcall+0x8c/0x1c4)
[ 86.611596] [<80008cb0>] (do_one_initcall) from [<80085c34>]=20
(load_module+0x17f4/0x2034)
[ 86.611607] [<80085c34>] (load_module) from [<800865cc>]=20
(SyS_finit_module+0x68/0x78)
[ 86.611619] [<800865cc>] (SyS_finit_module) from [<8000ebe0>]=20
(ret_fast_syscall+0x0/0x30)
[ 86.611627] ---[ end trace bf01e794993cef27 ]---

> what is 'open firmware'
right. I should probably reword my commit,
this not dependent of CONFIG_OF but just with the kernel
version. The bug happens with version >=3D KERNEL_VERSION(3,11,0)
FYI

> which kernel version did you apply this?
this is a 3.18.12
> which platform?
IMX6q SOC.

Thierry
>
> - Michael
>
>> Am 25.09.2015 um 15:22 schrieb Thierry Bultel <thierry.bultel@basystemes=
.fr>:
>>
>> Signed-off-by: Thierry Bultel <thierry.bultel@basystemes.fr>
>> ---
>> ksrc/drivers/can/rtcan_flexcan.c | 6 ++++--
>> 1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/ksrc/drivers/can/rtcan_flexcan.c b/ksrc/drivers/can/rtcan_f=
lexcan.c
>> index f5477db..91c5ebf 100644
>> --- a/ksrc/drivers/can/rtcan_flexcan.c
>> +++ b/ksrc/drivers/can/rtcan_flexcan.c
>> @@ -235,6 +235,7 @@ struct flexcan_priv {
>> 	struct regulator *reg_xceiver;
>> 	struct clk *clk_ipg;
>> 	struct clk *clk_per;
>> +	struct platform_device *pdev;
>> #endif
>> };
>>
>> @@ -1054,8 +1055,8 @@ static void put_clocks(struct flexcan_priv *priv)
>> #if LINUX_VERSION_CODE < KERNEL_VERSION(3,11,0)
>> 	clk_put(priv->clk);
>> #else
>> -	clk_put(priv->clk_per);
>> -	clk_put(priv->clk_ipg);
>> +	devm_clk_put(&priv->pdev->dev,priv->clk_per);
>> +	devm_clk_put(&priv->pdev->dev,priv->clk_ipg);
>> #endif
>> }
>>
>> @@ -1132,6 +1133,7 @@ static int flexcan_probe(struct platform_device *p=
dev)
>> 		}
>> 		clock_freq =3D clk_get_rate(priv->clk_per);
>> 	}
>> +	priv->pdev =3D pdev;
>> #endif
>>
>> 	mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> --
>> 1.9.1
>>
>>
>> _______________________________________________
>> Xenomai mailing list
>> Xenomai@xenomai.org
>> http://xenomai.org/mailman/listinfo/xenomai
>

