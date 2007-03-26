Message-ID: <4607FE64.4000803@domain.hid>
Date: Mon, 26 Mar 2007 19:09:56 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Flattened linux tree and CVS
References: <0B45E93C5FF65740AEAE690BF3848B7A4AB010@domain.hid>
In-Reply-To: <0B45E93C5FF65740AEAE690BF3848B7A4AB010@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Fillod Stephane <stephane.fillod@domain.hid>
Cc: xenomai@xenomai.org

Fillod Stephane wrote:
> Hi,
> 
> For those who have to cope with flat handling of a linux tree in CVS,
> and thus never really liked the prepare-kernel.sh approach (which is
> fine in other cases), here is some linux/Makefile sugar that can
> certainly
> be improved:
> 
> ifdef XENO_TAG
>   xenotagspec = -r $(XENO_TAG)
> endif
> 
> xeno_checkout:
> 	@cd $(srctree)/drivers && cvs checkout $(xenotagspec) -P \
> 				-d xenomai $(XENO_CVS_PATH)/ksrc/drivers
> 	@cd $(srctree)/include && cvs checkout $(xenotagspec) -P \
> 				-d xenomai $(XENO_CVS_PATH)/include
> 	@cd $(srctree)/include/asm-generic && cvs checkout
> $(xenotagspec) -P \
> 				-d xenomai
> $(XENO_CVS_PATH)/include/asm-generic
> 	@cd $(srctree)/include/asm-$(ARCH) && cvs checkout
> $(xenotagspec) -P \
> 				-d xenomai
> $(XENO_CVS_PATH)/include/asm-powerpc
> 	@cd $(srctree)/kernel && cvs checkout $(xenotagspec) -P \
> 				-d xenomai $(XENO_CVS_PATH)/ksrc
> 	@cd $(srctree)/arch/$(ARCH) && cvs checkout $(xenotagspec) -P \
> 				-d xenomai
> $(XENO_CVS_PATH)/ksrc/arch/powerpc
> 
> 
> Rem: replace powerpc by whatever you see fit.
> 
> The variable XENO_CVS_PATH *must* be defined for this work:
> 
>   make xeno_checkout XENO_CVS_PATH=some/where/over/the/rainbow/xenomai
> 
> This will mix linux and xenomai CVS trees, without links, and let you
> do any cvs action like update, commit, tag, etc. against appropriate
> CVS modules.
> 
> Of course, the "flat" kernel must have been patched beforehand with 
> adeos-ipipe patch, and also with the following fragments:
> 
> cat xenomai/scripts/Kconfig.frag >> init/Kconfig	# + edit
> echo "drivers-\$(CONFIG_XENOMAI) += arch/$linux_arch/xenomai/" >>
> arch/$linux_arch/Makefile
> echo "obj-\$(CONFIG_XENOMAI) += xenomai/" >> drivers/Makefile
> echo "obj-\$(CONFIG_XENOMAI) += xenomai/" >> kernel/Makefile
> 
> Rem: this is for linux kernel 2.6, and not for the faint of heart.
> Maybe a "prepare-kernel.sh --patch-only-for-those-pesky-cvs-users" 
> would come handy :-)
> 
> Comments are welcome.

I guess everyone has his recipe, mine is to use the --enable-linux-build
option of Xenomai configure script.

-- 
                                                 Gilles Chanteperdrix

