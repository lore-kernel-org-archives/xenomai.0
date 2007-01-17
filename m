Subject: Re: [Adeos-main] Porting IPIPE on MIPS Architecture, User Process
	running error, Kernel hangs.
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <25dd9bf10701170700r7a19c651wbf191bb01925fb58@domain.hid>
References: <25dd9bf10701160219w72c8e522l33f4eb9cec59b869@domain.hid>
	<1168943855.17557.45.camel@domain.hid>
	<25dd9bf10701170253v1f1296e3i265264b6b0e83c83@domain.hid>
	<1169032761.17493.25.camel@domain.hid>
	<25dd9bf10701170700r7a19c651wbf191bb01925fb58@domain.hid>
Content-Type: text/plain
Date: Wed, 17 Jan 2007 16:27:58 +0100
Message-Id: <1169047678.17493.53.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Reply-To: rpm@xenomai.org
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Subramani Venkatesh <subbu31mani@domain.hid>
Cc: adeos-main@gna.org

On Wed, 2007-01-17 at 20:30 +0530, Subramani Venkatesh wrote:
> Phillipe,
> I will surely look into this, so far local_irq_enable/disable i.e
> unstall and stall routines did not cause  problem in my assembly code.
> But I was facing this particular system call issue due to use of stack
> as arguments to the __ipipe_syscall_root  and also in my case the
> venilla kernel is using the same register for syscall number and
> return value, during this case when Iam  trying to save intial system
> call number on stack and once __ipipe_syscall_root is done I am
> reading it back, this may be corrupting stack, so I think I need to
> put more effort to resolve this and oragnize it. 
> BTW  phillipe at this stage can I go testing timer interrupts using by
> other domain, which registers as priority domain than linux ? 

If the interrupt exit path does not suffer from unexpected register
cloberring, yes.

> 
> Regards
> Subbu
> 
> 
> On 1/17/07, Philippe Gerum <rpm@xenomai.org> wrote:
>         On Wed, 2007-01-17 at 16:23 +0530, Subramani Venkatesh wrote:
>         > Hello Philippe,
>         > I would like to thank you once again for the HINT.
>         > Now I avoided changes to system call calling
>         __ipipe_syscall_root from 
>         > my assembly code and tested the same, well it not giving any
>         errors as
>         > sent you yesterday, this concludes there is a problem in a
>         way of
>         > calling __ipipe_syscall_root, I guess my stack is getting
>         corrupted, i 
>         > will make sure my stack is saved before calling
>         __ipipe_syscall_root
>         > and resolve the issues.
>         
>         You should also check whether substituting inline code from
>         asmmacro.h
>         like local_irq_enable/disable with the I-pipe stall/unstall
>         calls had 
>         any bad side-effect on the register set. Maybe t0 is not the
>         only
>         register affected by such operations anymore.
>         
>         > I thank you once again.
>         >
>         > Cheers
>         > Subbu
>         >
>         > On 1/16/07, Philippe Gerum < rpm@xenomai.org> wrote:
>         >         On Tue, 2007-01-16 at 15:49 +0530, Subramani
>         Venkatesh wrote:
>         >         > Hello All,
>         >         > I am currently porting Adeos-ipipe on one of my
>         MIPS 
>         >         architecture. I
>         >         > am using I-Pipe 1.5-01, X86 as reference to my
>         porting. So
>         >         Far I did
>         >         > relevant changes in
>         >         > 1.Interrupts handlers 
>         >         > 2. System calls
>         >         > 3. Pagefault Handler
>         >         > Except Exception handling, I mean critcial bug
>         events.
>         >         > With this changes I am able to Boot Linux kernel
>         and also 
>         >         able to
>         >         > mount Ramdisk successfully.
>         >         >
>         >
>         >         [...]
>         >
>         >         > Opening console is successfull and
>         executing /sbin/init
>         >         > Algorithmics/MIPS FPU Emulator v1.5
>         >         > INIT: version 2.85 booting
>         >         > grep: error while loading shared libraries:
>         libc.so.6:
>         >         failed to map
>         >         > segment from shared object: Error 4090
>         >
>         >         There is likely something fishy in the syscall
>         interception
>         >         path from
>         >         arch/mips/kernel/entry.S; all the syscalls seem to
>         return
>         >         error values
>         >         mistakenly once the pipelining is in effect. You may
>         want to 
>         >         check your
>         >         changes in this area.
>         >
>         >         Btw, it would be nice to work in an open manner and
>         post your
>         >         code on
>         >         this list if you want to ask for help about it
>         here. 
>         >         Contribution has to
>         >         work both ways. TIA,
>         >
>         >         --
>         >         Philippe.
>         >
>         >
>         >
>         --
>         Philippe.
>         
>         
> 
-- 
Philippe.



