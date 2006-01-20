From: Stephan Zimmermann <s.zimmermann@domain.hid>
Subject: Re: [Xenomai-help] Meassage Queue c++
Date: Fri, 20 Jan 2006 09:48:09 +0100
References: <43CFC6B5.8080308@domain.hid>
	<200601200914.37506.s.zimmermann@domain.hid>
	<43D0A13C.10603@domain.hid>
In-Reply-To: <43D0A13C.10603@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601200948.09127.s.zimmermann@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Jan Kiszka wrote:

> Some further things to try before giving C++ up - and maybe stumbling
> over the same issue with C:
I tryed out xenomai queues in plain C, works perfekt.

>  o Did you mlockall() your program? If not, lazy-mapped pages may cause
>    SEGFAULTS in the RT domain which will kill your program.
I call "mlockall(MCL_CURRENT | MCL_FUTURE);" as one of the first things in 
main();
>  o Does your kernel log contain any hints of Xenomai about what's going
>    on?
No, ist does not contain anything

>  o Try running your program inside a debugger to catch the fault and its
>    location. When your system is head-less, use gdbserver.
I tryed debugging, I singlestepped through it and learned that it crashes when 
calling rt_queue_recv(), but I can not tell why.

maybe it is because I do the "bind-thing" in the constructor, resulting in 
multiple objects of RT_QUEUE referring to the same queue.

Stephan

