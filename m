Message-ID: <44354FDB.9060106@domain.hid>
Date: Thu, 06 Apr 2006 19:28:59 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Preventing kernel misconfiguration.
References: <17461.19934.435991.242022@domain.hid>
In-Reply-To: <17461.19934.435991.242022@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> Here is a patch that "selects" the I-pipe option when Xenomai is
> enabled, it should help preventing kernel misconfigurations.
> 

We definitely need this.

> 
> 
> ------------------------------------------------------------------------
> 
> Index: scripts/Kconfig.frag
> ===================================================================
> --- scripts/Kconfig.frag	(revision 895)
> +++ scripts/Kconfig.frag	(working copy)
> @@ -4,7 +4,14 @@
>  config XENOMAI
>  	bool "Xenomai"
>  	default y
> +        select IPIPE
>  
> +        help
> +          Xenomai is a real-time extension to the Linux kernel. Note 
> +          that Xenomai relies on Adeos interrupt pipeline (CONFIG_IPIPE 
> +          option) to be enabled, so enabling this option selects the
> +          CONFIG_IPIPE option.
> +
>  source "arch/@LINUX_ARCH@/xenomai/Kconfig"
>  
>  endmenu
> Index: ksrc/arch/powerpc/Config.in
> ===================================================================
> --- ksrc/arch/powerpc/Config.in	(revision 895)
> +++ ksrc/arch/powerpc/Config.in	(working copy)
> @@ -1,15 +1,19 @@
>  mainmenu_option next_comment
>  comment 'Real-time sub-system'
>  
> -bool 'Xenomai' CONFIG_XENOMAI
> +if [ "$CONFIG_IPIPE" = "n" ]; then
> +    comment "Xenomai depends on Adeos interrupt pipeline"
> +else
> +    bool 'Xenomai' CONFIG_XENOMAI
>  
> -source kernel/xenomai/Config.in
> +    source kernel/xenomai/Config.in
>  
> -if [ "$CONFIG_XENOMAI" = "y" -a "$CONFIG_XENO_OPT_NUCLEUS" != "n" ]; then
> +    if [ "$CONFIG_XENOMAI" = "y" -a "$CONFIG_XENO_OPT_NUCLEUS" != "n" ]; then
>  	mainmenu_option next_comment
>  	comment 'Machine'
>  	bool 'Enable FPU support' CONFIG_XENO_HW_FPU
>  	endmenu
> +    fi
>  fi
>  
>  endmenu
> Index: ksrc/arch/i386/Config.in
> ===================================================================
> --- ksrc/arch/i386/Config.in	(revision 895)
> +++ ksrc/arch/i386/Config.in	(working copy)
> @@ -1,11 +1,14 @@
>  mainmenu_option next_comment
>  comment 'Real-time sub-system'
>  
> -bool 'Xenomai' CONFIG_XENOMAI
> +if [ "$CONFIG_IPIPE" = "n" ]; then
> +    comment "Xenomai depends on Adeos interrupt pipeline"
> +else
> +    bool 'Xenomai' CONFIG_XENOMAI
>  
> -source kernel/xenomai/Config.in
> +    source kernel/xenomai/Config.in
>  
> -if [ "$CONFIG_XENOMAI" = "y" -a "$CONFIG_XENO_OPT_NUCLEUS" != "n" ]; then
> +    if [ "$CONFIG_XENOMAI" = "y" -a "$CONFIG_XENO_OPT_NUCLEUS" != "n" ]; then
>  
>  	mainmenu_option next_comment
>  	comment 'Machine'
> @@ -42,6 +45,7 @@
>  	fi
>  	endmenu
>  	endmenu
> +    fi
>  fi
>  
>  endmenu
> 


-- 

Philippe.

