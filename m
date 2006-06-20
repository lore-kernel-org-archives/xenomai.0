Subject: Re: [Xenomai-help] Nucleus Documentation
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <d87da8330606201027m19044b68lfa29d352297fa77a@domain.hid>
References: <d87da8330606201027m19044b68lfa29d352297fa77a@domain.hid>
Content-Type: text/plain
Date: Tue, 20 Jun 2006 23:34:08 +0200
Message-Id: <1150839249.4417.59.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Pramode C E <pramode@domain.hid>
Cc: xenomai@xenomai.org

On Tue, 2006-06-20 at 22:57 +0530, Pramode C E wrote:
> Hello,
> 
> Is there some documentation (other than the API reference) which
> describes the Xenomai nucleus?

Nope.

> I am trying to learn how to write an RTOS skin using the Nucleus and
> am finding the going a bit tough .... any help will be greatly
> appreciated.

Aside of the information already given on this list, what's missing is a
step-by-step guide to programming a skin from the ground up. There is no
such marvel, yet. But still, here are a few hints:

- if you want to write a skin callable from user-space, start coding it
as if it was only available to kernel space modules. In any case, you
will mostly have to _add_ support to extend it to be callable from
user-space apps, and not _change_ existing code. uITRON has no
user-space interface yet, you might want to have a look at it since it's
simpler; the same goes for the RTAI emulator (ksrc/skins/uitron,rtai).

- from a pre-existing skin, always start from the module.c file, looking
for the call to xnpod_init(). The initial magic starts there; it defines
the core characteristics of a real-time interface desciptor which is
going to host your RTOS "objects". A single "pod" can be active at any
time; this said, Xenomai provides a core pod you can stack your new
interface over (started by xncore_attach()), which is already shared by
the posix, rtdm, vxworks, vrtx and native interfaces. If you only want
to run your new skin alone, you can register a new active pod through
xnpod_init(). See the initial comment from include/nucleus/core.h.

- as soon as a pod has been registered (or joined, for the core one),
your skin may create threads, manage synchronization objects, receive
interrupts and so on. Albeit slightly outdated, this document gives a
good general overview of the high-level Xenomai "objects" one can use to
implement a skin:
http://download.gna.org/xenomai/documentation/trunk/pdf/xenomai.pdf
There, you've got basic RTOS threads to derive yours, synchronization
objects to implement anything that requires a thread to block for a
resource/event to be available, deterministic memory management,
interrupt abstraction and so on. This is basically what the nucleus
implements.

- looking at an existing skin, you should be able to infere the way some
RTOS implements something similar your interface wants to do. I.e. to
implement mutexes, just have a look at ksrc/skins/native/mutex.c, or
ksrc/skins/vrtx/mx.c. Semantically, this is always the same old story,
just with different "window-dressings". The same goes with semaphores
(*/sem.c), and so on.

When your interface has been validated over the simulator, you can
either stop there, or add the user-space support. Usually, this support
is implemented into two additional files, namely
include/your_skin/syscall.h, and ksrc/skins/your_skin/syscall.c. The
latter declares a syscall table, registers it to the nucleus
(xnshadow_register_interface()), and implements the kernel space
wrappers invoked upon user-space syscalls. Each wrapper collects the
input args passed by the user-space application, usually calls the
normal in-kernel service (you've just developed using the simulator),
and returns the output values to the caller. The valid syscalls are
declared in the first additional file (syscall.h), and fired from
user-space by the XENOMAI_SYSCALL and XENOMAI_SKINCALL macros. The
user-space library which provides the C routines is symmetrically
available under the src/skins root. E.g. src/skins/posix implements the
library (something like your skin's own libc for syscalls) of the
real-time interface implemented by ksrc/skins/posix.

PS: if you go for user-space support, take an extreme care to properly
propagate the -EINTR return code to the user-space caller (see XNBREAK
condition upon return from xnsynch_sleep_on()), signaling that a Linux
signal has hit a blocked real-time thread. Doing this properly
guarantees you a working GDB support for debugging the apps using your
interface, and above all, participates to the overall stability of the
system upon signal receipt. Keeping this in mind will spare you a fair
number of head banging sessions.

-- 
Philippe.



