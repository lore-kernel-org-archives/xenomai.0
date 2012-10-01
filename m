Message-ID: <5069C2C5.5080306@xenomai.org>
Date: Mon, 01 Oct 2012 18:20:21 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAOiXNkBzov-hrEOECeqPNgMw-peUmMcx55N8CcL3Ue66H-xwMA@mail.gmail.com>	<5069BD62.5030706@xenomai.org>	<CAOiXNkAWhi2-ZMJUx53-Lfh9EG7RP52QX5RK9KBnhjw0w6qKow@mail.gmail.com>	<5069BF3F.1010900@xenomai.org>	<CAOiXNkDcq6dKgJrVm4-8F1SjpUudbVNn6xx9yiACKWOLe0cAJw@mail.gmail.com>
	<CAOiXNkCF950997tST8T4VJQHxTT=2eh+GwcwRPsgfmZu3oq=Rw@mail.gmail.com>
In-Reply-To: <CAOiXNkCF950997tST8T4VJQHxTT=2eh+GwcwRPsgfmZu3oq=Rw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Qeustion about rtdm_event_timedwait
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Andrey Nechypurenko <andreynech@googlemail.com>
Cc: xenomai@xenomai.org

On 10/01/2012 06:13 PM, Andrey Nechypurenko wrote:
>>> Also note that rtdm_event_wait works like a semaphore, not like a
>>> condition variable: it has a counter, rtdm_event_wait will return
>>> immediately as many times as rtdm_event_signal was called.
> 
> In this case event_pulse will be then the closest match to condition
> variable. Right?

Well, looking at the code, it is not right, rtdm_event_wait works like a
semaphore, but a binary semaphore. So, if rtdm_event_signal was called
before rtdm_event_wait, rtdm_event_wait will return immediately, but if
it was called several times, rtdm_event_wait will return immediately
only once.

rtdm_event_pulse unlocks all threads currently blocked in
rtdm_event_wait, but you are right, it works more like a condvar.

-- 
					    Gilles.

