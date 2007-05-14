Message-ID: <b647ffbd0705140514w676ccca7hfbd70933cd1c7493@domain.hid>
Date: Mon, 14 May 2007 14:14:12 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
In-Reply-To: <9958525.1179143870179.JavaMail.ngmail@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <19756477.1179132019857.JavaMail.ngmail@domain.hid>
	<1179136852.5045.76.camel@domain.hid>
	<9958525.1179143870179.JavaMail.ngmail@domain.hid>
Subject: Re: [Xenomai-help] Scheduler: Strange priority handling
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
Cc: Xenomai help <xenomai@xenomai.org>

On 14/05/07, M. Koehrer <mathias_koehrer@domain.hid> wrote:
> HI all,
>
> thanks for all the responses.
> Using mutexes instead of semaphores actually solves the issue.
> However, the API documentation of rt_sem_create() is a little bit confusing here.
> The "mode" parameter of rt_sem_create() may contain "S_PRIO" which
> "makes tasks pend in priority order on the semaphore".
> I interpret this that it works actually the very same as with mutexes. However, it
> is implemented that sem_v directly triggers a waiting task (even if it is low prio).

So what's wrong here? It triggers a waiter with the highest priority
amongst _other waiters_ and in your case it's "L" (if I remember
abreviations correctly) - there are no other waiters in your case btw.
Waking up a sleeper really means - a resource is now yours.

How would the system know that your high-priority task which calls
rt_sem_v() / which means - I'm finished with a resource) / will call
rt_sem_p() as the very next step :o)


-- 
Best regards,
Dmitry Adamushko

