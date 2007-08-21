Message-ID: <2ff1a98a0708210150g556b84dcqe640eb03d23d408d@domain.hid>
Date: Tue, 21 Aug 2007 10:50:34 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <8b3b30860708210039n1e8d9eaaxe5d9f933cea816fc@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <8b3b30860708192302s906f0e0nfbb5ce9152ac8d@domain.hid>
	<18121.36630.239612.20521@domain.hid>
	<8b3b30860708210039n1e8d9eaaxe5d9f933cea816fc@domain.hid>
Subject: Re: [Xenomai-help] old version's bug
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Racconico Lambrati <racconico.lambrati@domain.hid>
Cc: xenomai@xenomai.org

On 8/21/07, Racconico Lambrati <racconico.lambrati@domain.hid> wrote:
> Because I'm having some problem with the compilation for a xenomai's kernel

If you have some problems getting a configuration that works, I
suggest you first try to compile a kernel for your machine, not
patched with Adeos/Xenomai, then once you have the configuration that
works, run prepare-kernel.sh, run make oldconfig to reuse the same
configuration, and configure the Xenomai support.

Note that a lot of things evolved since fusion 0.9.1. Most notably,
the vxworks skin got a real user-space system call interface, which
should work better than the UVM based interface. So, I strongly
recommend you to move to a recent release.

> (why don't you create a .conf for a standard kernel, or make a live distro
> with xen?)

There used to be a live-cd, but the build system changed, and nobody
volunteered to make a live-cd for the new build system. So, it is a
simple matter of human ressources. As for a .config for a standard
kernel, it would change for every kernel release, but if you want one,
you can use the one of the distribution you use.

> I have take the decision to port my program under native API.

It may be a good idea, but I would go for it with a working vxworks
emulator so as to be able to port gradually the program.

>
>  I'm searching without succes the corrisponding for these vxworks function.
>
>  intLock, intUnLock,

These ones have no equivalent. They are not even available in the
user-space emulator, because there is no portable way to implement
them in user-space.

> sysClkConnect

We should not have implemented this one in the first place. You can
easily get rid of it by using timers.

A code where you need intLock, intUnlock or sysClkConnect really look
like driver code, so I recommend porting this code to RTDM while
porting your application to the native skin.

> and tickGet

rt_timer_read is the native equivalent to tickGet.

-- 
                                               Gilles Chanteperdrix

