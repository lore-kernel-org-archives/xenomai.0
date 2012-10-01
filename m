Message-ID: <5069BD62.5030706@xenomai.org>
Date: Mon, 01 Oct 2012 17:57:22 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAOiXNkBzov-hrEOECeqPNgMw-peUmMcx55N8CcL3Ue66H-xwMA@mail.gmail.com>
In-Reply-To: <CAOiXNkBzov-hrEOECeqPNgMw-peUmMcx55N8CcL3Ue66H-xwMA@mail.gmail.com>
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

On 10/01/2012 05:51 PM, Andrey Nechypurenko wrote:
> driver's read() function is registered as *read_nrt*

That is the problem.

> real-time process. So does it imply that to make
> event_wait/event_signal to work, the "client" must also run Xenomai RT
> task?

Yes

> 
> In fact, in the documentation for rtdm_event_wait(), the following is mentioned:
> This service can be called from:
>  * Kernel-based task
>  * User-space task (RT)
> 
> I thought, that since I am in driver's read() function, the first
> statement "Kernel-based task" is what I am doing and it should be OK.

"Kernel-based task" means RTDM (or Xenomai) kernel based task.

-- 
					    Gilles.

