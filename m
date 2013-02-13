Message-ID: <511B9901.7040104@xenomai.org>
Date: Wed, 13 Feb 2013 14:45:37 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <511B94E4.2070708@mediso.hu>
In-Reply-To: <511B94E4.2070708@mediso.hu>
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

On 02/13/2013 02:28 PM, Norbert Bukuli wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Dear List Members,
>
> First of all, this will be a newbie question, sorry for it.
> Shortly, I have to port an old RTAI based kernelspace application to
> Xenomai userpace. This application uses FPU so we compile it hard
> float support. First step of the porting is switching the real-time
> extension. I am done with this, however I have some compilation warnings:
> WARNING: "_restfpr_22_x" [app.ko] undefined!
> WARNING: "_restfpr_29_x" [app.ko] undefined!
> WARNING: "_savefpr_22" [app.ko] undefined!
> WARNING: "_savefpr_29" [app.ko] undefined!
>
> I reproduced these warnings with the following example kernel module:
> http://pastebin.com/AAehcivx
>
> The corresponding Kbuild is:
>
> obj-m := fpu_test.o
> ccflags-y += -Iinclude/xenomai -Iinclude/xenomai/posix -mhard-float
>
> As I see, the missing functions should be in the C runtime library,
> however the kernel library (arch/powerpc/lib/crtsavres.S) contains
> only save/restore macros for general purpose registers. On the other
> hand, the Xenomai extensions provides kernelspace FPU facility and the
> T_FPU flag was turned on rt_task_create().
> So, my question is, how can I eliminate this problem?
>

Xenomai's context switching code does the necessary housekeeping to 
save/restore fprs. You don't have to call these routines.

-- 
Philippe.

