Message-ID: <43F20E47.1070908@domain.hid>
Date: Tue, 14 Feb 2006 18:07:19 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Kconfig inconsistencies
References: <43F08392.3000403@domain.hid>
In-Reply-To: <43F08392.3000403@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Hi,
> 
> here are some build screw-ups one can create by switching off the wrong
> options:
> 
>  o CONFIG_XENO_OPT_NATIVE_REGISTRY (but CONFIG_XENO_OPT_PERVASIVE
>    remains on): unresolved symbols rt_registry_bind and
>    rt_registry_fetch, several warnings due to "#[el]if CONFIG_XENO_..."
>    instead of "#[el]if defined(CONFIG_XENO_...)"
> 
>  o CONFIG_XENO_OPT_PERVASIVE: xnheap_init_mapped and
>    xnheap_destroy_mapped become unresolved
> 

Ok, will fix.

> The first issue reminds me of my unanswered question if
> (CONFIG_XENO_OPT_PERVASIVE && CONFIG_XENO_SKIN_NATIVE &&
> !CONFIG_XENO_OPT_NATIVE_REGISTRY) makes any sense at all (kernel objects
> created from user space are looked up via the registry, right?).
> 

Right, it doesn't make sense.

> 
> I haven't worked out any patch for those issues. Actually, I only wanted
> to put this patch forward when stumbling over the other:
> 
> --- ksrc/skins/native/Kconfig   (revision 564)
> +++ ksrc/skins/native/Kconfig   (working copy)
> @@ -127,7 +127,6 @@
> 
>  config XENO_OPT_NATIVE_INTR
>  	bool "Interrupts"
> -	default y
>  	help
> 
>  	This option provides a simple API to deal with interrupts,
> 
> Rationale: the /default/ way of handling IRQs should be via RTDM-based
> drivers. Only users who know what they are doing should leave this path
> and will have to switch on this feature explicitly. If this view can be
> commonly accepted, I will add some lines to the feature's help text as well.
> 

Agreed.

> Jan
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


-- 

Philippe.

