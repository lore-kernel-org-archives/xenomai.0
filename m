From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <t2w95dbcd241004151500ne05d5991q4a8f6463f2b37ba1@domain.hid>
References: <t2w95dbcd241004151500ne05d5991q4a8f6463f2b37ba1@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 16 Apr 2010 09:27:54 +0200
Message-ID: <1271402874.2365.715.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] [Vortx86DX] What's wrong with kernels upper than
 2.6.30.10 ?
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Gilles DOFFE <g.doffe@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

On Fri, 2010-04-16 at 00:00 +0200, Gilles DOFFE wrote:
> Hello,
> 
> I try to install a real-time Linux kernel on a Roboard based on a
> Vortex86DX (a x486 with TSC).
> 
> All works fine with :
> Linux Kernel 2.6.30.10
> Xenomai 2.5.1
> Adeos patch adeos-ipipe-2.6.30.8-x86-2.4-09.patch
> 
> But, for all kernels upper or equal to 2.6.31, I always get a double
> fault when testing WP bit. I have this double fault just after that :
> 
> Checking if this processor honours the WP bit even in supervisor
> mode...
> 
> I traced with some simple printk that the problem occurs in this
> function, at the end or after the call of fix_to_virt  :
> 
> static noinline int do_test_wp_bit(void)
> {
>         char tmp_reg;
>         int flag;
> 
>         __asm__ __volatile__(
>                 "       movb %0, %1     \n"
>                 "1:     movb %1, %0     \n"
>                 "       xorl %2, %2     \n"
>                 "2:                     \n"
>                 _ASM_EXTABLE(1b,2b)
>                 :"=m" (*(char *)fix_to_virt(FIX_WP_TEST)),
>                  "=q" (tmp_reg),
>                  "=r" (flag)
>                 :"2" (1)
>                 :"memory");
> 
>         return flag;
> }
> 
> I'm (quasi) sure that the problem is not that function, due to it
> works when the kernel is not patched.
> But where should I search ?

Try backporting these two 2.6.32 patches to your kernel; this should be
straightforward:
http://git.denx.de/?p=ipipe-2.6.git;a=commit;h=576f57f82dfd6c3ac285b0af76e5e0ce617679ba
http://git.denx.de/?p=ipipe-2.6.git;a=commit;h=a250e984a76fd327a0d8cfada5290b27e99f1e4d


> 
> Can you give me some indications ?
> 
> Thanks,
> Gilles 
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main


-- 
Philippe.



