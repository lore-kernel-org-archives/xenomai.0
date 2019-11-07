Subject: Re: Weird page fault while debugging an application using gdbserver
References: <b7f-5dc43a00-7b-344a2840@235498125>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <554b3972-2cd0-d5a9-95c1-249731e8dbde@xenomai.org>
Date: Thu, 7 Nov 2019 16:54:26 +0100
MIME-Version: 1.0
In-Reply-To: <b7f-5dc43a00-7b-344a2840@235498125>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?Fran=c3=a7ois_Legal?= <devel@thom.fr.eu.org>, xenomai@xenomai.org

On 2019-11-07 16:37, François Legal via Xenomai wrote:
> Hello,
> 
> I'm porting an existing application to xenomai, and trying to debug it using GDBserver.
> I try to set a break to stop at some interesting point in execution. That break is never reached, and each time I get the page fault error with the log copied at the end of the message.
> After that, I get the debug feature of the network driver automatically activated.
> 
> Starngely enought, the backtrace does not point to my application code, rather in linux kernel/drivers.
> 
> The system is an Arm7 Zynq 7000 reference board, being debugged via ethernet.
> Running linux 4.4.189 vanilla + corresponding ipipe patch and xenomai 3.0.9

You likely need the following patch. This issue was fixed in the 4.14 time frame:

commit 8575e8ab404717e3eabafc36920459018bb052a3
Author: Philippe Gerum <rpm@xenomai.org>
Date:   Tue Apr 10 11:34:29 2018 +0200

    arm/ipipe: re-enable user access in DAC after und_user trap handling
    
    Before returning from an und_user fault we have been asked to
    propagate, the client trap handler might have demoted the caller from
    the head -> root stage, which boils down to performing a (double)
    context switch internally. If CONFIG_CPU_SW_DOMAIN_PAN is set, such
    transition would cause the DAC register to reflect a protected USER
    domain state, denying to the kernel access to user memory.
    
    We need to revert this change, restoring the expected domain
    protection settings originally set by usr_entry.
    
    This fixes page domain errors raised by running into breakpoint traps
    poked by GDB into the debuggee's executable image when
    CONFIG_CPU_SW_DOMAIN_PAN is enabled in the kernel configuration.

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index cd2e0b3d8336..3569b3174372 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -524,6 +524,7 @@ __und_usr:
 	bl	__ipipe_notify_trap		@ branch to trap handler
 	cmp	r0, #0
 	bne	ret_from_exception
+	uaccess_enable ip
 #endif /* CONFIG_IPIPE */
 
 	mov	r2, r4

-- 
Philippe.

