MIME-Version: 1.0
In-Reply-To: <5069BF3F.1010900@xenomai.org>
References: <CAOiXNkBzov-hrEOECeqPNgMw-peUmMcx55N8CcL3Ue66H-xwMA@mail.gmail.com>
	<5069BD62.5030706@xenomai.org>
	<CAOiXNkAWhi2-ZMJUx53-Lfh9EG7RP52QX5RK9KBnhjw0w6qKow@mail.gmail.com>
	<5069BF3F.1010900@xenomai.org>
Date: Mon, 1 Oct 2012 18:10:26 +0200
Message-ID: <CAOiXNkDcq6dKgJrVm4-8F1SjpUudbVNn6xx9yiACKWOLe0cAJw@mail.gmail.com>
From: Andrey Nechypurenko <andreynech@googlemail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] Qeustion about rtdm_event_timedwait
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

> If you want to wake up a regular thread, you should signal an
> rtdm_nrtsig in the interrupt handler, and the nrtsig handler wakes up
> the linux thread using regular linux services such as wake_up(). But in
> that case, of course, do not expect low latencies for this thread.
>
> Also note that rtdm_event_wait works like a semaphore, not like a
> condition variable: it has a counter, rtdm_event_wait will return
> immediately as many times as rtdm_event_signal was called.

Thanks for the hints. It is not really necessary, but also not a
problem for me to start rt process at the client side. So now I have
to decide what is the best strategy for my use case.

Thank you,
Andrey.

