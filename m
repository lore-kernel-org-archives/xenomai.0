Message-ID: <558A590F.5060307@xenomai.org>
Date: Wed, 24 Jun 2015 09:15:27 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <790091D8B6A84455A1DA8F3E5353087C@itd206>
In-Reply-To: <790091D8B6A84455A1DA8F3E5353087C@itd206>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Reg: Linux 3.8.13 64bit xenomai-2.6.4 compilation
	problem
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Sureshvs <sureshvs@datapatterns.co.in>, xenomai@xenomai.org
Cc: "karunakaran.krishnan" <karunakaran.krishnan@industeqsite.com>

On 06/23/2015 04:55 PM, Sureshvs wrote:
> Hi,
> 
> I am using freescale T2080 PowerPC based processor board. we are patched the linux kernel 3.8.13 with xenomai 2.6.4.
> After patched, The following kernel configuration are selected before compiling.
> 
> 1) 64 bit Kernel.
> 2) Processor Type --> Embedded Processor
> 3) CPU Selection --> POWER7
> 4) Symmetric Multiprocessing support
> 5) Max No of CPU 8
> 6) Disabled the CPU Frequency Scaling
> 
> compiling the above configuration with fsl-64 bit freescale cross compiler. It gives the following error.
> 
>   CHK     include/generated/uapi/linux/version.h
>   CHK     include/generated/utsrelease.h
>   CC      arch/powerpc/kernel/asm-offsets.s
> In file included from include/linux/ipipe_debug.h:25:0,
>                  from include/linux/ipipe.h:31,
>                  from include/linux/sched.h:25,
>                  from arch/powerpc/kernel/asm-offsets.c:17:
> include/linux/ipipe_domain.h: In function 'ipipe_current_context':
> include/linux/ipipe_domain.h:252:2: error: implicit declaration of function '__mtmsrd' [-Werror=implicit-function-declaration]
> cc1: some warnings being treated as errors
> make[1]: *** [arch/powerpc/kernel/asm-offsets.s] Error 1
> make: *** [prepare0] Error 2
> 
> Kindly suggest us to resolve this issue.RegardsSuresh 

You should not use base your work on 3.8 for Xenomai/powerpc64,
especially if unfamiliar with Linux over this architecture: this kernel
is obsolete, and the interrupt pipeline port is broken for this release
on powerpc64.

The I-pipe port has been heavily reworked for 3.14 to bring it back in
shape, however no port to the T2080 was ever done here, so this is
unlikely to work out of the box using the official I-pipe patches.

Please note that Xenomai 2.6.x will be EOL by the end of this year. We
are moving to 3.x.

-- 
Philippe.

