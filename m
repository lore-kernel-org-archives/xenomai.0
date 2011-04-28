Message-ID: <4DB94A3E.9070906@domain.hid>
Date: Thu, 28 Apr 2011 13:06:38 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <3161507.241303982782859.JavaMail.SYSTEM@pc-msalvini>
In-Reply-To: <3161507.241303982782859.JavaMail.SYSTEM@pc-msalvini>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rt_task_join() call hangs in shared lib
	destructor
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Mauro Salvini <mauro.salvini@domain.hid>
Cc: xenomai@xenomai.org

Mauro Salvini wrote:
> 
>> It looks like a typical pthread_join deadlock. The thread you are 
>> joining is locked on a pthread mutex, that some other thread (I
>> would say, the one calling pthread_join) has. It can not work. You
>> should not call pthread_join while holding a mutex.
> 
> Yes, it looks like this, but I don't use any mutex in my task. It
> looks like dlclose() locks a mutex used also by pthread_join() (that
> was called into shared object destructor), and here is deadlock. But
> executing realtime task as normal thread does not raise this issue.

The trace you sent clearly shows that the problem happens because
rt_task_trampoline calls pthread_exit. In your tests with
rt_task_shadow/pthread_create, did you try to use pthread_exit? Or could
you try replacing the call to pthread_exit in rt_task_trampoline with a
return?


-- 
                                                                Gilles.

