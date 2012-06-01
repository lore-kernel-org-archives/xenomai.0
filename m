Message-ID: <4FC875FB.1070805@xenomai.org>
Date: Fri, 01 Jun 2012 09:57:47 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <DUB114-W7121A0DDCD5D2E2B7CD801AF3B0@phx.gbl>
In-Reply-To: <DUB114-W7121A0DDCD5D2E2B7CD801AF3B0@phx.gbl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rt_event_wait makes linux crash if executed while
 debugging with gdbserver
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Fabio Visona <fabioviso@hotmail.com>
Cc: Xenomai@xenomai.org

On 04/13/2012 04:49 PM, Fabio Visona wrote:
> Hello,
>
> I am trying to debug a Xenomai task through gdbserver over ethernet, with:
>
> gdbserver host:12345 --attach 240
>
> where 240 is the PID of the Xenomai real-time task I want to debug.
>
> After connecting with the gdb client, running continuosly is fine, but
> if I put a breakpoint and afterwards make the software execute an
> rt_event_wait call, the system crashes (gdb client stuck, no more
> ethernet connection, no panic message on the debug console serial port).
>

[...]

> Xenomai version is 2.5.3, Linux 2.6.34.7, running on a Blackfin BF518
> processor.

Several issues with GDB support on the blackfin:

- Xenomai 2.5.3 -> 2.5.6 (included) have a leaking SIGTRAP when 
debugging, which is fishy, and may lead to the issue you described. This 
has been fixed in the 2.6.x maintenance tree as a side-effect of 
plugging races in signal management.

- I-pipe 2.6.34.7/blackfin and later do not always handle return from 
exception properly when the current task is being ptraced. The patch 
below for 2.6.34.7-1.15-01 fixes this.

- The blackfin support for the newest pipeline core architecture 
(core-3.2) had an additional bug making the debuggee crash badly, this 
is now fixed by
http://git.denx.de/?p=ipipe-2.6.git;a=commit;h=92dd9aa478f72ed32610d23f943bbfb008a8fb60

I would recommend to try one of the options below that best fits your 
requirements:

- moving to Xenomai 2.6.x HEAD (upcoming 2.6.1), applying the patch 
below to your 2.6.34.7 kernel. At any rate, Xenomai 2.5.3 has a number 
of nasty issues you don't want to live with.

- moving to Xenomai 2.6.x HEAD, kernel 3.2.18, using the newest pipeline 
core at git://git.denx.de/ipipe.git, branch core-3.2.

HTH,

diff --git a/arch/blackfin/mach-common/entry.S 
b/arch/blackfin/mach-common/entry.S
index a5847f5..4cf49a6 100644
--- a/arch/blackfin/mach-common/entry.S
+++ b/arch/blackfin/mach-common/entry.S
@@ -824,15 +824,6 @@ _new_old_task:
  ENDPROC(_resume)

  ENTRY(_ret_from_exception)
-#ifdef CONFIG_IPIPE
-	p2.l = _ipipe_percpu_domain;
-	p2.h = _ipipe_percpu_domain;
-	r0.l = _ipipe_root;
-	r0.h = _ipipe_root;
-	r2 = [p2];
-	cc = r0 == r2;
-	if !cc jump 4f;  /* not on behalf of the root domain, get out */
-#endif /* CONFIG_IPIPE */
  	p2.l = lo(IPEND);
  	p2.h = hi(IPEND);

@@ -861,6 +852,16 @@ ENTRY(_ret_from_exception)
  	cc = r0 == 0;
  	if !cc jump 5f;

+#ifdef CONFIG_IPIPE
+	p2.l = _ipipe_percpu_domain;
+	p2.h = _ipipe_percpu_domain;
+	r0.l = _ipipe_root;
+	r0.h = _ipipe_root;
+	r2 = [p2];
+	cc = r0 == r2;
+	if !cc jump 5f;  /* not on behalf of the root domain, get out */
+#endif /* CONFIG_IPIPE */
+
  	/* Set the stack for the current process */
  	r7 = sp;
  	r4.l = lo(ALIGN_PAGE_MASK);

-- 
Philippe.

