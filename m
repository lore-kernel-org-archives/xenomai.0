Subject: Re: [Xenomai-help] BUG: unable to handle kernel paging request
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <b647ffbd0701261046m52172774lf5a7b4d08e090583@domain.hid>
References: <1169811995.462.13.camel@domain.hid>
	<1169827668.3346.61.camel@domain.hid>
	<b647ffbd0701261046m52172774lf5a7b4d08e090583@domain.hid>
Content-Type: text/plain
Date: Fri, 26 Jan 2007 23:46:46 +0100
Message-Id: <1169851606.3346.75.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
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
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On Fri, 2007-01-26 at 19:46 +0100, Dmitry Adamushko wrote:
> >
> > I guess that you already know what kind of answer you would obtain on
> > the LKML when reporting faults with Nvidia modules loaded, right?
> > However, since there seem to be a clean backtrace, maybe we could give a
> > try anyway. Could you objdump your kernel image, then locate the faulty
> > routine containing eip=0xc7b84d51? TIA,
> 
> But it doesn't point to either some part of the kernel code
> 
> --->   .text : 0xc0100000 - 0xc030a212   (2088 kB)
> 
> or any kernel module (not vmalloc'ed area).
> 
> Unless some code would copy another code at this location (kmalloc'ed)
> and then execute it.
> 
> Let's suppose we can believe in sanity of the call trace, then would
> you, Victor, provide a disassembled code for
> __ipipe_handle_exception() ?
> 

The backtrace is sane, I'm afraid. The following patch should fix the
issue:

--- arch/i386/kernel/entry.S~	2006-12-16 13:32:29.000000000 +0100
+++ arch/i386/kernel/entry.S	2007-01-26 23:44:59.000000000 +0100
@@ -1032,7 +1032,7 @@
 	RING0_INT_FRAME
 	pushl $0			# no error code
 	CFI_ADJUST_CFA_OFFSET 4
-	pushl $do_divide_error
+	PUSH_XVEC(do_divide_error)
 	CFI_ADJUST_CFA_OFFSET 4
 	jmp error_code
 	CFI_ENDPROC

> Call Trace:
>  [<c0112566>] __ipipe_handle_exception+0x58/0x11e
>  [<c01050f4>] do_divide_error+0x0/0xb1
>  [<c0309202>] error_code+0x3e/0x4c
> 
> 
> Memory: 384496k/393152k available (2088k kernel code, 8108k reserved,
> 633k data, 180k init, 0k highmem)
> virtual kernel memory layout:
>     fixmap  : 0xfffb7000 - 0xfffff000   ( 288 kB)
>     vmalloc : 0xd8800000 - 0xfffb5000   ( 631 MB)
>     lowmem  : 0xc0000000 - 0xd7ff0000   ( 383 MB)
>    .init : 0xc03ac000 - 0xc03d9000   ( 180 kB)
>    .data : 0xc030a212 - 0xc03a88f4   ( 633 kB)
>    .text : 0xc0100000 - 0xc030a212   (2088 kB)
> 
> 
-- 
Philippe.



