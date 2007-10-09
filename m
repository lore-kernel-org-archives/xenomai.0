From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <44D6D942646F9E43B7CFFFD3F250EDCD08E9A5@domain.hid>
References: <44D6D942646F9E43B7CFFFD3F250EDCD08E9A5@domain.hid>
Content-Type: text/plain
Date: Tue, 09 Oct 2007 15:33:25 +0200
Message-Id: <1191936805.22917.104.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Semaphore creation problem in user-space
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
To: MEYLAN Jean-philippe <Jean-philippe.Meylan@domain.hid>
Cc: xenomai@xenomai.org

On Tue, 2007-10-09 at 15:10 +0200, MEYLAN Jean-philippe wrote:
> Hi,
> 
> I'm trying to make a Xenomai target for Mathwork's Real Time Workshop
> Embedded Coder and I need to embed the generated code in an user-space
> application. My problem is that I cannot create semaphores correctly.
> rt_sem_create() returns me the -17 value instead of 0 or one of the
> error codes described in the documentation. I cannot figure what is
> the cause of the problem.
> 
> This problem appears in the small code I've put in attachment.
> 
> Have you any idea of what I'm doing wrong ?

-17 is -EEXIST. We use (negative) standard POSIX code to report all
error statuses (i.e. see asm-generic/errno-base.h).

Your sema4 has already been registered. Either your app mis-generates
semaphore names, or you more likely restarted the application which
tried to register the same semaphores anew, with a pre-2.4 Xenomai
version. i.e. Xenomai automatically removes real-time objects created by
exited applications only since 2.4-rc1.

A quick hack to work around the auto-cleanup issue with 2.3.x is to use
a pattern like this:

	RT_SEM desc;

	if (rt_bind_sem(&desc, some_name, TM_NONBLOCK) == 0) {
	    rt_delete_sem(&desc);

	err = rt_sem_create(&desc, some_name, ...)

Not pretty, but works.

> 
> Thanks in advance for your reply.
> 
> Best regards,
> 
> Jean-Philippe
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



