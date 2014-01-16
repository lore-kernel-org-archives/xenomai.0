MIME-Version: 1.0
Sender: bodgesoc@gmail.com
In-Reply-To: <CAN1+YZVvgPNNHFub5QAkw6SeSUPuf1dv_94kYGqhbjMpNt70Sg@mail.gmail.com>
References: <CAN1+YZVvgPNNHFub5QAkw6SeSUPuf1dv_94kYGqhbjMpNt70Sg@mail.gmail.com>
From: Andy Pugh <andy@bodgesoc.org>
Date: Thu, 16 Jan 2014 15:41:48 +0000
Message-ID: <CAN1+YZWOjxf=s+6LH3Xymzx_mwWa6XmO_Xt7SHF589RzJCANBA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] Fwd: Kernel Compilation Problems
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

By way of introduction, I am one of the LinuxCNC developers, but
pretty new to kernel patching.

Let me first say that what I am trying to do is something I knew would
be difficult.

I am trying to build a Xenomai kernel for the Udoo board. I have
compiled and run the kernel from the Udoo github repository (3.0.35) ,
and I have compiled a  Xenomai kernel based on the tagged archive on
the Freescale archive (3.0.43, if I recall correctly) recommended in
the Xenomai README. This did not
boot the Udoo.

I have been trying to combine the two together.

The xenomai patch for the arm/mxc patch is actually in three parts,
there is a pre-patch which seems to put the kernel in a state where
the main patch can take, and a post patch to put things back as they
were before compilation.

With a bit of hand-fettling I made the pre-patch take, and then the
main xenomai patch took cleanly. I then had to hand-apply a few bits
of the post patch, and then tried to compile.

I think that I am close to a compilable situation, but there are a
couple of persistent compile errors that I simply can't squash.

 CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
drivers/built-in.o: In function `fec_enet_init':
bufp.c:(.text.unlikely+0x209c): undefined reference to `dma_alloc_noncacheable'
sound/built-in.o: In function `imx_pcm_preallocate_dma_buffer.constprop.8':
last.c:(.text+0x37320): undefined reference to `dma_alloc_writethrough'
last.c:(.text+0x37370): undefined reference to `dma_alloc_writethrough'
sound/built-in.o: In function `imx_soc_platform_probe':
last.c:(.devinit.text+0x528): undefined reference to `dma_alloc_noncacheable'
make: *** [.tmp_vmlinux1] Error 1

Note that bufp.c is symlinked out of the kernel tree into the xenomai
tree. (by the xeno patch) and does not contain a fec_enet_init
function, nor a call to dma_alloc_noncacheable.
fec_enet_init exists in drivers/net/fec.c and does have a call to
dma_alloc_noncacheable, but also #includes dma-mapping.h. (though
dma_alloc_noncacheable is actually in
arch/arm/include/asm/dma-mapping.h which is conditionally #included in
<linux/dma-mapping.h>

I am pretty sure that there really isn't any function anywhere called
"`imx_pcm_preallocate_dma_buffer.constprop.8"

I wonder if anyone can point me in the right direction? Help
interpreting the error codes would be a start, for example which code
"bufp.c:(.text.unlikely+0x209c):" is really pointing at.


--
atp
If you can't fix it, you don't own it.
http://www.ifixit.com/Manifesto

-- 
atp

