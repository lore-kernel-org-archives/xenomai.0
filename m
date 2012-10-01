Message-ID: <5069BF3F.1010900@xenomai.org>
Date: Mon, 01 Oct 2012 18:05:19 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAOiXNkBzov-hrEOECeqPNgMw-peUmMcx55N8CcL3Ue66H-xwMA@mail.gmail.com>	<5069BD62.5030706@xenomai.org>
	<CAOiXNkAWhi2-ZMJUx53-Lfh9EG7RP52QX5RK9KBnhjw0w6qKow@mail.gmail.com>
In-Reply-To: <CAOiXNkAWhi2-ZMJUx53-Lfh9EG7RP52QX5RK9KBnhjw0w6qKow@mail.gmail.com>
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

On 10/01/2012 06:01 PM, Andrey Nechypurenko wrote:
>> On 10/01/2012 05:51 PM, Andrey Nechypurenko wrote:
>>> driver's read() function is registered as *read_nrt*
>>
>> That is the problem.
> 
> Thank you Gilles!
> 

If you want to wake up a regular thread, you should signal an
rtdm_nrtsig in the interrupt handler, and the nrtsig handler wakes up
the linux thread using regular linux services such as wake_up(). But in
that case, of course, do not expect low latencies for this thread.

Also note that rtdm_event_wait works like a semaphore, not like a
condition variable: it has a counter, rtdm_event_wait will return
immediately as many times as rtdm_event_signal was called.

-- 
					    Gilles.

