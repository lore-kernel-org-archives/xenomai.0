References: <DB6PR0701MB2456796DCEDA2465D1A7EDF6B5C70@DB6PR0701MB2456.eurprd07.prod.outlook.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <f13f5701-947a-2181-b787-1c5ea60d5564@xenomai.org>
Date: Mon, 3 Jul 2017 18:53:44 +0200
MIME-Version: 1.0
In-Reply-To: <DB6PR0701MB2456796DCEDA2465D1A7EDF6B5C70@DB6PR0701MB2456.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] drivers/gpio/gpio-core.c is broken on 4.4.9
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Giulio Moro <g.moro@qmul.ac.uk>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 06/18/2017 05:09 PM, Giulio Moro wrote:
> the `dev` member of `struct gpio_chip` was replaced by `parent` as of 
> 
> commit 58383c78425e4ee1c077253cf297b641c861c02e
> Author: Linus Walleij <linus.walleij@linaro.org>
> Date:   Wed Nov 4 09:56:26 2015 +0100
> 
>     gpio: change member .dev to .parent
>     
>     The name .dev in a struct is normally reserved for a struct device
>     that is let us say a superclass to the thing described by the struct.
>     struct gpio_chip stands out by confusingly using a struct device *dev
>     to point to the parent device (such as a platform_device) that
>     represents the hardware. As we want to give gpio_chip:s real devices,
>     this is not working. We need to rename this member to parent.
> 
> 
> Therefore the following patch is needed to compile drivers/xenomai/gpio/gpio-core.c. on 4.9.x
> 
> Notes:
> a) Unfortunately I am not able to verify that it works because I am not on one of the devices supported by the gpio drivers
> b) you need ifdefs around the change to make sure you do not break older builds (e.g.: on 4.4.x the original version works fine).
> 
> diff --git a/drivers/xenomai/gpio/gpio-core.c b/drivers/xenomai/gpio/gpio-core.c
> index b8cb044..17d201c 100644
> --- a/drivers/xenomai/gpio/gpio-core.c
> +++ b/drivers/xenomai/gpio/gpio-core.c
> @@ -428,7 +428,7 @@ static int match_gpio_chip(struct gpio_chip *gc, void *data)
>  {
>         struct device *dev = data;
>  
> -       return gc->dev == dev;
> +       return gc->parent == dev;
>  }
> 

Picked, thanks.

-- 
Philippe.

