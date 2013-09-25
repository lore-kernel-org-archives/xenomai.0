Message-ID: <524290CC.8000705@xenomai.org>
Date: Wed, 25 Sep 2013 09:29:16 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <5241DAB0.8000604@siemens.com>
In-Reply-To: <5241DAB0.8000604@siemens.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] libalchemy: failing test case task-5
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On 09/24/2013 08:32 PM, Jan Kiszka wrote:
> Hi,
>
> I played a bit with the native skin emulation in Xenomai 3. The shipped
> test cases in lib/alchemy/testsuite point a problem:
> rt_task_set_priority is no longer a pure real-time services. As it calls
> libc's pthread_setschedparam internally, it will - at least briefly -
> switch the caller to secondary mode. This break the task-5 test which
> assumes a different behaviour.
>
> Are there ideas/plans to address this issues?

The switch to secondary mode will remain, the 2.6 implementation is even 
worse actually. We have to keep both schedulers in sync, and for that, 
the glibc has to be notified about the policy/priority change as well. 
In 2.6, the target thread would receive a SIGSHADOW notification, 
causing it to switch to secondary mode, while the setschedparam caller 
would remain in primary mode. With 3.x, this is reversed: the thread 
which issues the request does the switch, but the target thread whose 
priority/policy was changed does not.

At the very least, this behavior is much saner, since the issuer has to 
be aware of the consequences of its request, and the target thread won't 
move to secondary in a random fashion with respect to its code flow. In 
addition, this lifts a potential deadlock situation, as 
pthread_setschedparm is not async-safe, so running it over a SHIGSHADOW 
handler is not that safe.

Are there more case known
> where the new architecture provides some challenges when trying to
> preserve original API semantics?
>

All user-visible changes are tracked in an internal document here. I'll 
publish it right after the Cobalt/POSIX extension model with Xenomai 3 
is fully validated, since this might have a few implications more.

-- 
Philippe.

