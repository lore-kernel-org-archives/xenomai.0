Message-ID: <487B91F6.3070909@domain.hid>
Date: Mon, 14 Jul 2008 19:50:46 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <487B8B3E.8020805@domain.hid>
In-Reply-To: <487B8B3E.8020805@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rt_task_bind() and timeout values
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
To: Stefan Kisdaroczi <kisda@domain.hid>
Cc: xenomai@xenomai.org

Stefan Kisdaroczi wrote:
> Hi all,
> 
> If I call rt_task_bind() with a timeout value other than TM_NONBLOCK or
> TM_INFINITE
> it works not as expected (by me).
> 
> System: Debian Lenny with Xenomai 2.4.3 and Kernel 2.6.24.
> 
> The attached example calls 3 times rt_task_bind() for a nonexistent task:
> 
> 1. dont wait: rt_task_bind(&task,"SomeTaskName",TM_NONBLOCK)
>   -> returns -11 (EWOULDBLOCK) -> OK
> 
> 2. wait 5 secs: rt_task_bind(&task,"SomeTaskName",5000000000LL);
>   -> returns immediately -13 (EACCES) without waiting -> ?
>   -> I expected ETIMEDOUT after 5 seconds
> 

"SomeTaskName" was found in the registry, but suddenly disappeared while in the
process of returning its handle (we do post-validation after binding). That task
has probably exited prematurely.

> 3. wait forever: rt_task_bind(&task,"SomeTaskName",TM_INFINITE);
>   -> blocks a expected -> OK
> 
> I have the same problem with rt_queue_bind() calls.
> 
> Do i expect something wrong?
> 
> Thanks for your help!
> 
> kisda
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

