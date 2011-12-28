Message-ID: <4EFB0456.9010409@domain.hid>
Date: Wed, 28 Dec 2011 12:58:14 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <000101ccc4b8$74856eb0$5d904c10$@soterem.fr>	<4EF9F949.5000708@domain.hid>
	<000001ccc541$7fa8d960$7efa8c20$@soterem.fr>
	<4EFAE1BF.4090203@domain.hid>
	<000301ccc556$168472e0$438d58a0$@soterem.fr>
In-Reply-To: <000301ccc556$168472e0$438d58a0$@soterem.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] problem following 'xenomai quick build guide'
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gregory Gosse <gregory.gosse@domain.hid>
Cc: 'xenomai-help' <xenomai@xenomai.org>

On 12/28/2011 12:44 PM, Gregory Gosse wrote:
> Now I use:
> 
> - xenomai 2.6.0   2011-11-05
> 
> - kernel 2.6.38.8
> 
> - patch adeos-ipipe-2.6.38.8-x86-2.10-01.patch
> 
>  
> 
> The following command works well:
> 
> scripts/prepare-kernel.sh --linux=/usr/src/linux-2.6.38.8 --adeos=/usr/src/xenomai-2.6.0/ksrc/arch/x86/patches/adeos-ipipe-2.6.38.8-x86-2.10-01.patch --arch=x86
> 
> Then I enter the configuration menu with
> 
> Make menuconfig
> 
>  
> 
> I apply the changes suggested in 'hard real time linux using xenomai on intel Multi-Core processors'
> 
> Save and exit
> 
>  
> 
> When I try to compile the kernel with 'Make'  , the compilation finishes on:
> 
> CC      kernel/xenomai/nucleus/pod.o
> In file included from /usr/src/linux-2.6.38.8/arch/x86/include/asm/xenomai/switch.h:2:0,
>                  from /usr/src/linux-2.6.38.8/arch/x86/include/asm/xenomai/bits/pod_32.h:27,
>                  from /usr/src/linux-2.6.38.8/arch/x86/include/asm/xenomai/bits/pod.h:2,
>                  from kernel/xenomai/nucleus/pod.c:47:
> /usr/src/linux-2.6.38.8/arch/x86/include/asm/xenomai/switch_32.h:30:2: attention : #warning "Buffer overflow detection not supported in 32bit mode" [-Wcpp]
> /usr/src/linux-2.6.38.8/arch/x86/include/asm/xenomai/switch_32.h:31:2: erreur: #error "Disable CONFIG_CC_STACKPROTECTOR in your kernel configuration"
> make[3]: *** [kernel/xenomai/nucleus/pod.o] Erreur 1
> make[2]: *** [kernel/xenomai/nucleus] Erreur 2
> make[1]: *** [kernel/xenomai] Erreur 2
> make: *** [kernel] Erreur 2

Then do as the message says, disable "CONFIG_CC_STACKPROTECTOR" in the
kernel configuration. But are you sure you want to compile a 32 bits
kernel, not a 64 bits one?

-- 
                                                                Gilles.

