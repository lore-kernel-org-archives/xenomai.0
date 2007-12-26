Message-ID: <4772D19C.4030506@domain.hid>
Date: Wed, 26 Dec 2007 23:11:40 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <477275E0.7080001@domain.hid>
In-Reply-To: <477275E0.7080001@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Adeos-main] [PATCH 3/3] i386: Cleanup root IRQ trampolines
Reply-To: rpm@xenomai.org
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

Jan Kiszka wrote:
> Simplifies xirq trampoline and applies the xirq refactorings to
> virq_handler too.
> 

--- linux-2.6.23.12-xeno.orig/include/asm-i386/ipipe.h
+++ linux-2.6.23.12-xeno/include/asm-i386/ipipe.h
@@ -141,11 +141,7 @@ __ipipe_call_root_xirq_handler(unsigned
 		"pushl %%ds\n\t"
 		"pushl %%eax\n\t"
 		"pushl %%ebp\n\t"
-		"pushl %%edi\n\t"
-		"pushl %%esi\n\t"
-		"pushl %%edx\n\t"
-		"pushl %%ecx\n\t"
-		"pushl %%ebx\n\t"
+		"subl  $5*4,%%esp	# rest can remain unsaved\n\t"

This won't work. We actually want to save our regs, so that they are
restored when going back to xirq_end through the iret path. If we don't
save them, the registers will remain terminally clobbered.

 		"movl  %[regs],%%eax	# always pass tick regs\n\t"
 		"call *%[handler]\n\t"
@@ -158,33 +154,41 @@ __ipipe_call_root_xirq_handler(unsigned
 		 : "eax");
 }

[snip]

+static inline void
+__ipipe_call_root_virq_handler(unsigned irq,
+			       void (*handler)(unsigned irq, void *cookie),
+			       void *cookie)
+{
+	irq_enter();
+	__asm__ __volatile__ (
+		"pushfl\n\t"
+		"pushl %%cs\n\t"
+		"pushl $virq_end\n\t"
+		"pushl %%eax		# dummy value\n\t"

We do want -1 to be pushed here, not any dummy value, so that the signal
handling code is not going to try restarting some interrupted syscall
when running the Linux epilogue for us. This is consistent with having
negated irq numbers pushed onto interrupt frames (see handle_signal and
friends).

+		"pushl %%fs\n\t"
+		"pushl %%es\n\t"
+		"pushl %%ds\n\t"
+		"pushl %%eax\n\t"
+		"pushl %%ebp\n\t"
+		"subl  $5*4,%%esp	# rest can remain unsaved\n\t"
+

Same problem as above.

+		"pushl %[cookie]\n\t"
+		"pushl %[irq]\n\t"
+		"call *%[handler]\n\t"

We need to conform both to regparm(0) and regparm(3) when passing args
to the interrupt handler (i.e we don't know the convention used,
especially by assembly code grabbing an IRQ), and regparm(3) is missing
now. C-written ones are likely to follow regparm(3) as the rest of the
kernel unless they explicitly fiddle with compiler pragmas. We could get
rid of regparm(0) in x86 code, requiring all handlers to conform to
regparm(3), but not the other way around.

+		"addl $8,%%esp\n\t" \
+		 : /* no output */ \
+		 : [irq] "rm" (irq), [handler] "rm" (handler),
+		   [cookie] "rm" (cookie));
+	irq_exit();
+	__asm__ __volatile__ (
+		"jmp ret_from_intr	# Linux IRQ epilogue\n\t"
+		"virq_end: cli\n\t"
+		 : /* no output */
+		 : /* no input */);
+}

This said, the fix regarding CPU accounting is right, and passing the
tick regs from the trampoline looks definitely saner than tweaking
timer_interrupt() for the same purpose, so I'll merge that part.

-- 
Philippe.

