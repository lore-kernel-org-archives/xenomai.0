MIME-Version: 1.0
References: <20211217073655.56036-1-ksmola51@gmail.com>
In-Reply-To: <20211217073655.56036-1-ksmola51@gmail.com>
From: k smo <ksmola51@gmail.com>
Date: Thu, 16 Dec 2021 23:41:22 -0800
Message-ID: <CAC2JQeiute4x2hDno72pL9P5JNGZbRBVbGT17g-mz5s4rmv+Qg@mail.gmail.com>
Subject: Re: [PATCH 2/2] Added verbosity to 16550A serial driver.
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@siemens.com>

Oh sorry, that patch is based off my previous commit. Ignore it. I'll
re-generate it from master.
-Konstantin

On Thu, Dec 16, 2021 at 11:37 PM Konstantin Smola <ksmola51@gmail.com>
wrote:

> Added verbosity to 16550A serial driver. dmesg shows
>  driver version, ports, irqs, baudbase.
> Signed-off-by: Konstantin Smola <ksmola51@gmail.com>
> ---
>  kernel/drivers/serial/16550A.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/drivers/serial/16550A.c
> b/kernel/drivers/serial/16550A.c
> index 9881ba66c..4e896c6ff 100644
> --- a/kernel/drivers/serial/16550A.c
> +++ b/kernel/drivers/serial/16550A.c
> @@ -28,13 +28,11 @@
>
>  #define MOD_DESCR "RTDM-based driver for 16550A UARTs"
>  static char mod_descr[64] = MOD_DESCR;
> -#define MOD_AUTH "Jan Kiszka <jan.kiszka@web.de>"
> -static char mod_auth[64]=MOD_AUTH;
>  #define MOD_VER "1.5.2"
>  static char mod_ver[32]=MOD_VER;
>
>  MODULE_DESCRIPTION(MOD_DESCR);
> -MODULE_AUTHOR(MOD_AUTH);
> +MODULE_AUTHOR("Jan Kiszka <jan.kiszka@web.de>");
>  MODULE_VERSION(MOD_VER);
>  MODULE_LICENSE("GPL");
>
> @@ -1115,7 +1113,7 @@ int __init rt_16550_init(void)
>         if (!rtdm_available())
>                 return -ENODEV;
>
> -       rtdm_printk("%s: %s rev %s, %s\n", mod_name, mod_descr, mod_ver,
> mod_auth);
> +       rtdm_printk("%s: %s rev %s\n", mod_name, mod_descr, mod_ver);
>
>         rt_16550_pnp_init();
>         rt_16550_pci_init();
> @@ -1139,7 +1137,7 @@ int __init rt_16550_init(void)
>                 name = (char *)(dev + 1);
>                 ksformat(name, RTDM_MAX_DEVNAME_LEN, dev->label, i);
>
> -               rtdm_printk("%s: %s io=0x%x irq=%d\n", mod_name, name,
> (unsigned)rt_16550_base_addr(i),irq[i]);
> +               rtdm_printk("%s: %s io=0x%x irq=%d baud_base=%d\n",
> mod_name, name, (unsigned)rt_16550_base_addr(i),irq[i],baud_base[i]);
>
>                 err = rt_16550_init_io(i, name);
>                 if (err)
> --
> 2.27.0
>
>
