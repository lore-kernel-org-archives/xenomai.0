Message-ID: <4774DA7B.4080903@domain.hid>
Date: Fri, 28 Dec 2007 12:14:03 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4774D852.2040406@domain.hid>
In-Reply-To: <4774D852.2040406@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [PATCH] fix prepare-kernel.sh for x86 build
Reply-To: rpm@xenomai.org
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
Cc: Xenomai-core@domain.hid

Jan Kiszka wrote:
> Index: xenomai/scripts/prepare-kernel.sh
> ===================================================================
> --- xenomai/scripts/prepare-kernel.sh	(Revision 3329)
> +++ xenomai/scripts/prepare-kernel.sh	(Arbeitskopie)
> @@ -428,9 +428,9 @@
>              patch_append init/Kconfig
>      fi
>  
> -    if ! grep -q CONFIG_XENOMAI $linux_tree/arch/$linux_arch/Makefile; then
> +    if ! grep -q CONFIG_XENOMAI $linux_tree/arch/$linux_archsrc/Makefile; then
>  	p="drivers-\$(CONFIG_XENOMAI)		+= arch/$linux_archsrc/xenomai/"
> -	( echo ; echo $p ) | patch_append arch/$linux_arch/Makefile
> +	( echo ; echo $p ) | patch_append arch/$linux_archsrc/Makefile
>      fi
>  
>      patch_architecture_specific="n"
>

This won't work for newer x86 patches. Which kernel/patch combo have you
been using?

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

