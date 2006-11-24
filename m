Subject: Re: [Xenomai-help] Strange SIGXCPU signal at rt_task_trampoline
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <29451992.1164376099993.JavaMail.ngmail@domain.hid>
References: <29451992.1164376099993.JavaMail.ngmail@domain.hid>
Content-Type: text/plain
Date: Fri, 24 Nov 2006 15:07:53 +0100
Message-Id: <1164377274.4973.62.camel@domain.hid>
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
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org

On Fri, 2006-11-24 at 14:48 +0100, M. Koehrer wrote:
> Hi all,
> 
> I have the strange effect, that I get a reproducable SIGXCPU signal in gdb 
> when running my Xenomai (native skin) application.
> It occurs in rt_task_trampoline() within the do..while loop.
> The situation is that I am re-creating and starting a task that has been 
> terminated before.
> Unfortunately I was not able to create a very simple application that shows this
> effect.
> I am using xenomai (SVN 1882), Pentium 4, gcc 4.1.2
> I have enclosed the output of the gdb session:
> 

Could you try this? TIA,

--- ksrc/nucleus/shadow.c	(revision 1890)
+++ ksrc/nucleus/shadow.c	(working copy)
@@ -733,7 +733,7 @@
 
 	xnstat_counter_inc(&thread->stat.ssw);	/* Account for secondary mode switch. */
 
-	if (notify && testbits(thread->status, XNTRAPSW))
+	if (notify && testbits(thread->status, XNTRAPSW | XNSTARTED) == XNTRAPSW | XNSTARTED)
 		/* Help debugging spurious relaxes. */
 		send_sig(SIGXCPU, current, 1);
 
-- 
Philippe.



