MIME-Version: 1.0
References: <20211216074829.32236-1-ksmola51@gmail.com>
 <e5126b04-5f04-57bc-8450-e519e251b9a6@siemens.com>
In-Reply-To: <e5126b04-5f04-57bc-8450-e519e251b9a6@siemens.com>
From: k smo <ksmola51@gmail.com>
Date: Thu, 16 Dec 2021 09:40:11 -0800
Message-ID: <CAC2JQehOUsbGFmnfuLxukomvN-vjPLqo9nPk3ws1_7e10yOEZw@mail.gmail.com>
Subject: Re: [PATCH 1/1] Added verbosity to serial driver.
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

I will re-submit patch with a better explanation.  But look at this dmesg
output:

[55025.834492] xeno_16550A: RTDM-based driver for 16550A UARTs rev 1.5.2,
Jan Kiszka <jan.kiszka@web.de>
[55025.834568] xeno_16550A: rtser0 io=0x3f8 irq=4
[55025.834614] xeno_16550A: rtser1 io=0x2f8 irq=3
[55025.834646] xeno_16550A: rtser2 io=0xd000 irq=18
[55025.834680] xeno_16550A: rtser3 io=0xd008 irq=18
[55025.835322] xeno_16550A: rtser4 io=0xd010 irq=18
[55025.836801] xeno_16550A: rtser5 io=0xd018 irq=18
later...
[55044.800713] xeno_16550A: Unloaded.

In our systems the serial driver is loaded by shell scripts and config
files which make decisions as to what to load. so without verbosity the
driver prints nothing and it is not easy to determine (in terms of timing
relative to other drivers as seen in dmesg) if the driver ever got loaded
or what ports it is listening to. This is highly informative verbosity.

-Konstantin

On Thu, Dec 16, 2021 at 12:57 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:

> On 16.12.21 08:48, Konstantin Smola via Xenomai wrote:
> > kernel/drivers/serial: Added verbosity to serial driver.
>
> Thanks for your patch. However, the commit log should motivate why we
> want to merge this change.
>
> Jan
>
> > Signed-off-by: Konstantin Smola <ksmola51@gmail.com>
> > ---
> >  kernel/drivers/serial/16550A.c | 20 +++++++++++++++++---
> >  1 file changed, 17 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/drivers/serial/16550A.c
> b/kernel/drivers/serial/16550A.c
> > index c9274fb19..9881ba66c 100644
> > --- a/kernel/drivers/serial/16550A.c
> > +++ b/kernel/drivers/serial/16550A.c
> > @@ -25,12 +25,21 @@
> >  #include <rtdm/serial.h>
> >  #include <rtdm/driver.h>
> >
> > -MODULE_DESCRIPTION("RTDM-based driver for 16550A UARTs");
> > -MODULE_AUTHOR("Jan Kiszka <jan.kiszka@web.de>");
> > -MODULE_VERSION("1.5.2");
> > +
> > +#define MOD_DESCR "RTDM-based driver for 16550A UARTs"
> > +static char mod_descr[64] = MOD_DESCR;
> > +#define MOD_AUTH "Jan Kiszka <jan.kiszka@web.de>"
> > +static char mod_auth[64]=MOD_AUTH;
> > +#define MOD_VER "1.5.2"
> > +static char mod_ver[32]=MOD_VER;
> > +
> > +MODULE_DESCRIPTION(MOD_DESCR);
> > +MODULE_AUTHOR(MOD_AUTH);
> > +MODULE_VERSION(MOD_VER);
> >  MODULE_LICENSE("GPL");
> >
> >  #define RT_16550_DRIVER_NAME "xeno_16550A"
> > +static char mod_name[64]=RT_16550_DRIVER_NAME;
> >
> >  #define MAX_DEVICES          8
> >
> > @@ -1106,6 +1115,8 @@ int __init rt_16550_init(void)
> >       if (!rtdm_available())
> >               return -ENODEV;
> >
> > +     rtdm_printk("%s: %s rev %s, %s\n", mod_name, mod_descr, mod_ver,
> mod_auth);
> > +
> >       rt_16550_pnp_init();
> >       rt_16550_pci_init();
> >
> > @@ -1128,6 +1139,8 @@ int __init rt_16550_init(void)
> >               name = (char *)(dev + 1);
> >               ksformat(name, RTDM_MAX_DEVNAME_LEN, dev->label, i);
> >
> > +             rtdm_printk("%s: %s io=0x%x irq=%d\n", mod_name, name,
> (unsigned)rt_16550_base_addr(i),irq[i]);
> > +
> >               err = rt_16550_init_io(i, name);
> >               if (err)
> >                       goto kfree_out;
> > @@ -1182,6 +1195,7 @@ void rt_16550_exit(void)
> >
> >       rt_16550_pci_cleanup();
> >       rt_16550_pnp_cleanup();
> > +     rtdm_printk("%s: Unloaded.\n", mod_name);
> >  }
> >
> >  module_init(rt_16550_init);
> >
>
> --
> Siemens AG, T RDA IOT
> Corporate Competence Center Embedded Linux
>
