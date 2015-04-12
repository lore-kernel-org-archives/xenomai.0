MIME-Version: 1.0
In-Reply-To: <552698E7.1080501@siemens.com>
References: <552698E7.1080501@siemens.com>
Date: Sun, 12 Apr 2015 21:46:00 +0200
Message-ID: <CAPRPZsD4v7uyka4Prk4LhunC+6PQk6z7cjgsL-vOozH890iV9A@mail.gmail.com>
From: Jeroen Van den Keybus <jeroen.vandenkeybus@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] [PATCH] ipipe: Protect ioremap_page_range also
 against IRQ usage by APEI
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

Jan,


> Jeroen, Niels, this should truly and safely fix the issue. Please give
> it a try!

I've been away for a couple of days. The moment the crash I reported
occurred was right before I left so I didn't have time to look into it
myself at all. But looking at what you found to (hopefully) fix it, I
doubt I could have contributed much...

Anyway, the test rig is now running the patch with nothing else
changed (CONFIG_ACPI_APEI_GHES=y; APEI can't be disabled in BIOS).
We'll let it sit for a week.

Thanks,


Jeroen.




>
>  lib/ioremap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/lib/ioremap.c b/lib/ioremap.c
> index f5331c0..9b8e8d5 100644
> --- a/lib/ioremap.c
> +++ b/lib/ioremap.c
> @@ -88,9 +88,9 @@ int ioremap_page_range(unsigned long addr,
>                         break;
>         } while (pgd++, addr = next, addr != end);
>
> -       /* APEI may invoke this for temporarily remapping pages in NMI
> +       /* APEI may invoke this for temporarily remapping pages in IRQ or NMI
>          * context - nothing we can and need to propagate globally. */
> -       if (!in_nmi()) {
> +       if (!(in_irq() || in_nmi())) {
>                 __ipipe_pin_range_globally(start, end);
>                 flush_cache_vmap(start, end);
>         }
> --
> 2.1.4

