Date: Fri, 28 Nov 2014 12:13:25 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141128111325.GD5069@hermes>
References: <CAPozGf=zAFgV=fbinambu1_xEiR3qD7Affppw-i6ZbD4nvJsRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPozGf=zAFgV=fbinambu1_xEiR3qD7Affppw-i6ZbD4nvJsRw@mail.gmail.com>
Subject: Re: [Xenomai] Section mismatch - Porting Xenomai to
 linux-xlnx-V14.5 zynq SoC
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: John Sini <jhnsini@gmail.com>
Cc: xenomai@xenomai.org

On Fri, Nov 28, 2014 at 12:03:09PM +0100, John Sini wrote:
> Hello,
> 
> I am new with Xenomai and I am trying to port it to linux-xlnx-V14.5 zynq
> as suggested on the following site:
> 
> http://www.wiki.xilinx.com/Xenomai+for+Zynq
> 
> Patches that I have applied(in the following order)
> 
> 
> *ipipe-core-3.8-zynq-pre.patch*
> *ipipe-core-3.8-arm-1.patch*
> *ipipe-core-3.8-zynq-post.patch*
> 
> 
> I have disabled the support of RPMsg ((remoteproc) and of CPU_HOTPLUG
> prior to compiling the kernel(I configured the kernel as suggested on
> the aforementioned website). I get getting the following warnings:
> 
> WARNING: vmlinux.o(.text+0x106b4): Section mismatch in reference from
> the function __ipipe_tsc_register() to the variable
> .init.text:__kuser_helper_end
> The function __ipipe_tsc_register() references
> the variable __init __kuser_helper_end.
> This is often because __ipipe_tsc_register lacks a __init
> annotation or the annotation of __kuser_helper_end is wrong.
> 
> WARNING: vmlinux.o(.text+0x106b8): Section mismatch in reference from
> the function __ipipe_tsc_register() to the variable
> .init.text:__ipipe_tsc_area_start
> The function __ipipe_tsc_register() references
> the variable __init __ipipe_tsc_area_start.
> This is often because __ipipe_tsc_register lacks a __init
> annotation or the annotation of __ipipe_tsc_area_start is wrong.

For this, you can do what the warning says, add the __init attribute
to the __ipipe_tsc_register function. This has been made in later
patches. 3.8 is old, we do not have the necessary resources to
maintain all past versions of the I-pipe patch at all times.

> 
> WARNING: vmlinux.o(.text+0x2ea760): Section mismatch in reference from
> the function vexpress_sysreg_probe() to the function
> .init.text:vexpress_sysreg_setup()
> The function vexpress_sysreg_probe() references
> the function __init vexpress_sysreg_setup().
> This is often because vexpress_sysreg_probe lacks a __init
> annotation or the annotation of vexpress_sysreg_setup is wrong.

This probably has nothing to do with Xenomai.

> 
> 
> Can any of you help me how to fix these warnings? I have seen the same
> problem here:
> 
> http://www.xenomai.org/pipermail/xenomai/2013-October/029390.html
> 
> But I have disabled all necessary options in the kernel config and
> still get these warnings.

what necessary option?

-- 
					    Gilles.

