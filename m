Message-ID: <511BCA3E.4050705@xenomai.org>
Date: Wed, 13 Feb 2013 18:15:42 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <511B94E4.2070708@mediso.hu> <511B9901.7040104@xenomai.org>
	<511BB60E.7090900@mediso.hu>
In-Reply-To: <511BB60E.7090900@mediso.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Floating point operations in kernel on powerpc
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Norbert Bukuli <norbert.bukuli@mediso.hu>
Cc: xenomai@xenomai.org

On 02/13/2013 04:49 PM, Norbert Bukuli wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Dear Mr Gerum,
>
> thank you for your kind answer.
> As you can see in the example code I do not call explicitly either
> _savefpr_XX or rthal_save_fpu and their restore counterparts. I only
> do some floating point operations in a Xenomai domain kernel thread.
> However the linker misses the routines mentioned earlier.
> Are there linker flags to change this behaviour?
> One important note, in the kernel configuration the hardware FPU
> support is switched on. (CONFIG_XENO_HW_FPU=y)

-msoft-float with hw FPU looks suspicious. I don't understand why you 
mention C runtime libraries when building kernel modules either. 
Building with eldk 5.2.1 for fpu-enabled 6xx cores can be done with
eldk-5.2.1/powerpc/sysroots/i686-eldk-linux/usr/bin/powerpc-linux/powerpc-linux-gcc 
from a stock eldk install.

Actually, running fpu code in kernel space is a bad idea in the first 
place. Xenomai supports this for desperate situations when porting relic 
code absolutely requires it, but this is clearly something that should 
be avoided. You should really consider moving all that stuff to userland 
if the situation is not that desperate.

-- 
Philippe.

