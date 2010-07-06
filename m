MIME-Version: 1.0
In-Reply-To: <4C2F715C.9050800@domain.hid>
References: <AANLkTimOQfrs56FSp2JQUWtD7wDACYRmCrX6AF-pU3RC@mail.gmail.com>
	<4C2F24CF.7090309@domain.hid> <4C2F715C.9050800@domain.hid>
Date: Tue, 6 Jul 2010 10:03:16 -0700
Message-ID: <AANLkTin_HbP5RrdSZg6xgNKAhr0f9UkqGgHjC6xkH3HX@mail.gmail.com>
From: Jeremy Brown <jhbrown@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] kernel warnings and oopses calling gpiolib
	functions from xenomai kernel space
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-help <xenomai@xenomai.org>

To the best of our ability to tell, this patch resolved our problem
--- thank you!

Jeremy

PS The pipe patch version is whatever prepare-kernel applied by
default, which I think for our xenomai checkout and kernel version is
adeos-ipipe-2.6.33-arm-1.16-01.patch

On Sat, Jul 3, 2010 at 10:20 AM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> Gilles Chanteperdrix wrote:
>> Jeremy Brown wrote:
>>> Thanks in advance for any and all help!
>>
>> Hi,
>>
>> from your post, we can conclude that gpio_set_value is a Linux kernel
>> function which can yet not be used in Xenomai context (you could
>> probably even get more explicit messages by enabling I-pipe debugging).
>> I am going to try and propose a fix for this issue, will send you a
>> patch ASAP.
>>
>> Note that the issue is more an Adeos I-pipe issue than a Xenomai issue,
>> so I am more interested in knowing what version of adeos than what
>> version of Xenomai you are using. But chances that the problem exists
>> with all versions anyway.
>
> Could you try the following patch?
>
> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
> index 589a4bb..f1d85ff 100644
> --- a/arch/arm/plat-omap/gpio.c
> +++ b/arch/arm/plat-omap/gpio.c
> @@ -195,7 +195,7 @@ struct gpio_bank {
> =A0#endif
> =A0 =A0 =A0 =A0u32 level_mask;
> =A0 =A0 =A0 =A0u32 toggle_mask;
> - =A0 =A0 =A0 spinlock_t lock;
> + =A0 =A0 =A0 ipipe_spinlock_t lock;
> =A0 =A0 =A0 =A0struct gpio_chip chip;
> =A0 =A0 =A0 =A0struct clk *dbck;
> =A0 =A0 =A0 =A0u32 mod_usage;
>
> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0Gilles.
>

