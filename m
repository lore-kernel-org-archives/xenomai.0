Message-ID: <441949A0.8060100@domain.hid>
Date: Thu, 16 Mar 2006 12:18:56 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] newbie question
References: <0915ad1443edb7af745736fe4aaf3551@domain.hid>
In-Reply-To: <0915ad1443edb7af745736fe4aaf3551@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniele Lugli <daniele.lugli@domain.hid>
Cc: xenomai@xenomai.org

Daniele Lugli wrote:
> Hello all,
> I am new to xenomai although I have already used rtai.
> I see that xenomai has a user mode which looks equivalent to rtai's lxrt.
> What about calling real-time functions implemented in a module 
> (rtai_lxrt call, rt_fun_entry table and so on)?
> Thank you,
> Daniele Lugli
> 
> 

Have a look at the way a simple skin does it, e.g. ksrc/skins/uvm.

The UVM module exports a set of 12 syscalls, from __uvm_thread_shadow to 
__uvm_timer_tsc, as declared in include/asm-uvm/syscalls.h.

To do that, the module registers as a Xenomai skin by calling the 
xnshadow_register_interface() service, during its initialization phase. Some of 
the parameters for this function are the address and the number of entries of the 
module's syscall table.

The table is made of tuples, { <syscall-entry-addr> , <syscall-mode> }
The syscall mode bits define the operations Xenomai will do to 1) check that the 
caller is in the proper context for calling, 2) possibly switch the caller's mode 
so that the operation can be properly carried out. Switching refers to whether the 
caller must run over the real-time thread context (we call it "primary" mode), or 
may or should run over Linux directly (i.e. "secondary" mode). A terse explanation 
of the various syscall mode bits is available in include/asm-generic/syscall.h 
(i.e. __xn_exec_lostage and friends). Messing with the mode bits is the first and 
likely only cause of strange failures; be careful when setting them.

In order to issue the syscalls from user-space that will end up calling the 
routines listed in the syscall table, you will need to use the XENOMAI_SKINCALL 
macros available from include/asm-*/syscall.h depending on your arch. Have a look 
at src/skins/uvm/uvm.c to get an example of implementation. Before those syscalls 
could be invoked, your user-space program must bind to the registered skin in 
kernel space, which means getting back its internal id, so that such id could be 
specified in subsequent syscalls. This work is done in src/skins/uvm/init.c; 
intelligent paste/copy of that file will lead you rather easily to something 
working. Make sure to properly differentiate XENOMAI_SYSCALL and XENOMAI_SKINCALL. 
The former runs internal Xenomai syscalls setting up the environment for your 
application; the latter refers to the syscalls you added by mean of registering a 
new skin module.

There is no much more documentation than that for now, I'm afraid.

HTH,

-- 

Philippe.

