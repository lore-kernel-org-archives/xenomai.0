Subject: Re: [Adeos-main] Porting IPIPE on MIPS Architecture, User Process
	running error, Kernel hangs.
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <25dd9bf10701160219w72c8e522l33f4eb9cec59b869@domain.hid>
References: <25dd9bf10701160219w72c8e522l33f4eb9cec59b869@domain.hid>
Content-Type: text/plain
Date: Tue, 16 Jan 2007 11:37:34 +0100
Message-Id: <1168943855.17557.45.camel@domain.hid>
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

On Tue, 2007-01-16 at 15:49 +0530, Subramani Venkatesh wrote:
> Hello All,
> I am currently porting Adeos-ipipe on one of my MIPS architecture. I
> am using I-Pipe 1.5-01, X86 as reference to my porting. So Far I did
> relevant changes in
> 1.Interrupts handlers
> 2. System calls
> 3. Pagefault Handler 
> Except Exception handling, I mean critcial bug events.
> With this changes I am able to Boot Linux kernel and also able to
> mount Ramdisk successfully.
> 

[...]

> Opening console is successfull and executing /sbin/init
> Algorithmics/MIPS FPU Emulator v1.5
> INIT: version 2.85 booting
> grep: error while loading shared libraries: libc.so.6: failed to map
> segment from shared object: Error 4090

There is likely something fishy in the syscall interception path from
arch/mips/kernel/entry.S; all the syscalls seem to return error values
mistakenly once the pipelining is in effect. You may want to check your
changes in this area.

Btw, it would be nice to work in an open manner and post your code on
this list if you want to ask for help about it here. Contribution has to
work both ways. TIA,

-- 
Philippe.



