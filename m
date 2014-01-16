Message-ID: <52D8609C.5050903@xenomai.org>
Date: Thu, 16 Jan 2014 23:43:40 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAN1+YZVvgPNNHFub5QAkw6SeSUPuf1dv_94kYGqhbjMpNt70Sg@mail.gmail.com>
 <CAN1+YZWOjxf=s+6LH3Xymzx_mwWa6XmO_Xt7SHF589RzJCANBA@mail.gmail.com>
In-Reply-To: <CAN1+YZWOjxf=s+6LH3Xymzx_mwWa6XmO_Xt7SHF589RzJCANBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Fwd: Kernel Compilation Problems
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Andy Pugh <andy@bodgesoc.org>
Cc: xenomai <xenomai@xenomai.org>

On 01/16/2014 04:41 PM, Andy Pugh wrote:
> By way of introduction, I am one of the LinuxCNC developers, but
> pretty new to kernel patching.
> 
> Let me first say that what I am trying to do is something I knew would
> be difficult.
> 
> I am trying to build a Xenomai kernel for the Udoo board. I have
> compiled and run the kernel from the Udoo github repository (3.0.35) ,
> and I have compiled a  Xenomai kernel based on the tagged archive on
> the Freescale archive (3.0.43, if I recall correctly) recommended in
> the Xenomai README. This did not
> boot the Udoo.
> 
> I have been trying to combine the two together.
> 
> The xenomai patch for the arm/mxc patch is actually in three parts,
> there is a pre-patch which seems to put the kernel in a state where
> the main patch can take, and a post patch to put things back as they
> were before compilation.
> 
> With a bit of hand-fettling I made the pre-patch take, and then the
> main xenomai patch took cleanly. I then had to hand-apply a few bits
> of the post patch, and then tried to compile.
> 
> I think that I am close to a compilable situation, but there are a
> couple of persistent compile errors that I simply can't squash.

The pre- and post- patches are for the freescale tree. If the Udoo tree
is not based on the freescale tree, there is no reason to add the pre
and post patches. You are probably better off following the I-pipe
porting guide, and add support for the imx6 yourself, looking into the
post patch for some details. Unfortunately 3.0 is too recent for the old
porting guide to apply completely, and too old for the new porting
guide, but with some patience, this should work.

The old:
http://www.xenomai.org/index.php/I-pipe:ArmPorting

The new:
http://www.xenomai.org/index.php/I-pipe-core:ArmPorting



> 
>  CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> drivers/built-in.o: In function `fec_enet_init':
> bufp.c:(.text.unlikely+0x209c): undefined reference to `dma_alloc_noncacheable'
> sound/built-in.o: In function `imx_pcm_preallocate_dma_buffer.constprop.8':
> last.c:(.text+0x37320): undefined reference to `dma_alloc_writethrough'
> last.c:(.text+0x37370): undefined reference to `dma_alloc_writethrough'
> sound/built-in.o: In function `imx_soc_platform_probe':
> last.c:(.devinit.text+0x528): undefined reference to `dma_alloc_noncacheable'
> make: *** [.tmp_vmlinux1] Error 1
> 
> Note that bufp.c is symlinked out of the kernel tree into the xenomai
> tree. (by the xeno patch) and does not contain a fec_enet_init
> function, nor a call to dma_alloc_noncacheable.
> fec_enet_init exists in drivers/net/fec.c and does have a call to
> dma_alloc_noncacheable, but also #includes dma-mapping.h. (though
> dma_alloc_noncacheable is actually in
> arch/arm/include/asm/dma-mapping.h which is conditionally #included in
> <linux/dma-mapping.h>
> 
> I am pretty sure that there really isn't any function anywhere called
> "`imx_pcm_preallocate_dma_buffer.constprop.8"

The real function is probably imx_pcm_preallocate_dma_buffer, the
.constprop.8 postfix would be added by the compiler (constant
propagation?). This all looks like a configuration issue. Does the
unpatched kernel, with exactly the same configuration, compile correctly?

Regards.

-- 
                                                                Gilles.

