MIME-Version: 1.0
In-Reply-To: <CAOiXNkDcq6dKgJrVm4-8F1SjpUudbVNn6xx9yiACKWOLe0cAJw@mail.gmail.com>
References: <CAOiXNkBzov-hrEOECeqPNgMw-peUmMcx55N8CcL3Ue66H-xwMA@mail.gmail.com>
	<5069BD62.5030706@xenomai.org>
	<CAOiXNkAWhi2-ZMJUx53-Lfh9EG7RP52QX5RK9KBnhjw0w6qKow@mail.gmail.com>
	<5069BF3F.1010900@xenomai.org>
	<CAOiXNkDcq6dKgJrVm4-8F1SjpUudbVNn6xx9yiACKWOLe0cAJw@mail.gmail.com>
Date: Mon, 1 Oct 2012 18:13:54 +0200
Message-ID: <CAOiXNkCF950997tST8T4VJQHxTT=2eh+GwcwRPsgfmZu3oq=Rw@mail.gmail.com>
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

>> Also note that rtdm_event_wait works like a semaphore, not like a
>> condition variable: it has a counter, rtdm_event_wait will return
>> immediately as many times as rtdm_event_signal was called.

In this case event_pulse will be then the closest match to condition
variable. Right?

