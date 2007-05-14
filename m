From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <9958525.1179143870179.JavaMail.ngmail@domain.hid>
References: <1179136852.5045.76.camel@domain.hid>
	<19756477.1179132019857.JavaMail.ngmail@domain.hid>
	<9958525.1179143870179.JavaMail.ngmail@domain.hid>
Content-Type: text/plain
Date: Mon, 14 May 2007 14:17:56 +0200
Message-Id: <1179145077.5045.98.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Scheduler: Strange priority handling
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

On Mon, 2007-05-14 at 13:57 +0200, M. Koehrer wrote:
> HI all,
> 
> thanks for all the responses.
> Using mutexes instead of semaphores actually solves the issue.
> However, the API documentation of rt_sem_create() is a little bit confusing here.
> The "mode" parameter of rt_sem_create() may contain "S_PRIO" which 
> "makes tasks pend in priority order on the semaphore".
> I interpret this that it works actually the very same as with mutexes. 

No, absolutely not. Please reread the detailed explanations. This is
_not_ a matter of priority management wrt sema4, but the ability for the
nucleus to steal the resource depending on the respective priority of
_threads_ that want to consume it. S_PRIO is about setting the sema4
behaviour when it comes to enqueue pending threads for _sleeping_ on a
resource; this has nothing to do with how a running thread might steal a
sema4 resource from another one due to its priority being higher
combined to the fact that the current owner of the resource did not wake
up yet in the meantime.

> However, it
> is implemented that sem_v directly triggers a waiting task (even if it is low prio).
> As the semaphore has nothing to do with the scheduler, this makes sense.
> However, this cannot be found within the API documentation.

The sema4 does have something to do with the scheduler: it calls its
services to operate on the thread runstates. But there is nothing else
to document, aside of "semaphores do work as expected", in this case.

> 
> Regards
> 
> Mathias
> 
-- 
Philippe.



