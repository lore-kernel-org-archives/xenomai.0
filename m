Message-ID: <47CFBE53.4010707@domain.hid>
Date: Thu, 06 Mar 2008 10:50:11 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <47CFBB2E.3010700@domain.hid>
In-Reply-To: <47CFBB2E.3010700@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Need help with pipes
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
To: Laurent BESSARD <laurent.bessard@domain.hid>
Cc: xenomai@xenomai.org

Laurent BESSARD wrote:
> Hello everybody,
> 
> I'm using Xenomai for realtime developments for a couple of time. I have
> written a program using pipes for Xenomai 2.1.0 and a 2.6.15 Linux
> kernel compiled with Xenomai support. All worked or seemed to work fine.
> 
> Recently, I decided to upgrade my system to Xenomai 2.4.1 and a 2.6.23
> Linux kernel. But during my program execution, I get a kernel
> segmentation fault while I try to delete the pipe. After having test any
> possibility of problem while deleting pipe, I finally find that just
> creating and then deleting a pipe causes a kernel segmentation fault.
> 
> Now I don't know where my problem is located:
>   - There is something I'm doing wrong when I use pipes.
>   - I have mis-installed Xenomai on my system.
>   - It is a known problem with the version of Xenomai I installed.
> 
> I attached a sample of code that causes my problem.
> 
> Could anybody help me?

Does this help?

--- ksrc/skins/native/syscall.c	(revision 3534)
+++ ksrc/skins/native/syscall.c	(working copy)
@@ -3987,7 +3987,7 @@
 	[__native_intr_inquire] = {&__rt_intr_inquire, __xn_exec_any},
 	[__native_pipe_create] = {&__rt_pipe_create, __xn_exec_lostage},
 	[__native_pipe_bind] = {&__rt_pipe_bind, __xn_exec_conforming},
-	[__native_pipe_delete] = {&__rt_pipe_delete, __xn_exec_any},
+	[__native_pipe_delete] = {&__rt_pipe_delete, __xn_exec_lostage},
 	[__native_pipe_read] = {&__rt_pipe_read, __xn_exec_primary},
 	[__native_pipe_write] = {&__rt_pipe_write, __xn_exec_any},
 	[__native_pipe_stream] = {&__rt_pipe_stream, __xn_exec_any},

> Thank you in advance.
> 
> Best regards,
> 
> Laurent BESSARD
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 
Philippe.

