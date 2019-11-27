Subject: Re: pthread_setschedprio and __SCHED_CURRENT
References: <350537f4-4d38-d2d0-e9fc-4d5e7ffaf97d@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <f26a8196-da96-ef14-4ed7-c0cf3387de42@xenomai.org>
Date: Wed, 27 Nov 2019 17:45:44 +0100
MIME-Version: 1.0
In-Reply-To: <350537f4-4d38-d2d0-e9fc-4d5e7ffaf97d@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

On 11/27/19 5:13 PM, Jan Kiszka wrote:
> Hi Philippe,
> 
> fortunately before we set the new ABI into stone, I just discovered flaw in
> my pthread_setschedparam_ex(__SCHED_CURRENT) approach for modelling
> pthread_setschedprio: It breaks over non-trivial policies like SCHED_QUOTA.
> 
> Userspace would have to query all current policy parameters of the target
> thread first in order to just update the priority in param_ex. Currently,
> it sends down bogus values via the setschedparam_ex call.
> 
> I could work around this by handling __SCHED_CURRENT even more special in
> the kernel or - which I'm leaning to ATM - introduce a real setschedprio
> syscall.
> 
> What do you think?
> 

I would go for a new syscall too, other options may prove to be fragile at
the end of the day.

-- 
Philippe.

