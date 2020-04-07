Subject: Re: rt_task_unblock() POSIX alternative
References: <20200407154117.5D7D71C2@centrum.cz>
 <b9ce43ab-526d-71b8-c761-150dc7c1fd3f@siemens.com>
 <20200407171816.E0B3979D@centrum.cz>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <e934d96a-28d9-1c41-69a3-2d82cd1387f0@siemens.com>
Date: Tue, 7 Apr 2020 17:29:38 +0200
MIME-Version: 1.0
In-Reply-To: <20200407171816.E0B3979D@centrum.cz>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?Petr_=c4=8cervenka?= <grugh@centrum.cz>, Xenomai <xenomai@xenomai.org>

On 07.04.20 17:18, Petr Červenka wrote:
> Hello Jan.
> And if I don't want to totally remove the thread? Only to interrupt the waiting and react according to new events (like reconfiguring something or starting to wait on different resource).
> Is there some pthread_create... or sched_... parameter or flag, that the task's system call can be interruptible?
> And how to use the signals to interrupt it? Call of kill(task_pid, SIGINT) didn't helped.

Use __STD(pthread_kill) to target a specific thread.

But if you want to continue the thread after interruption, you may be 
looking for a RT channel. In that case, poll on the timerfd and a 
messaging channel like an mqueue or an iddp socket is more appropriate.

Jan

> Petr
>   
> ______________________________________________________________
>>  From "Jan Kiszka" <jan.kiszka@siemens.com>
>>
> On 07.04.20 15:41, Petr Červenka via Xenomai wrote:
>   > Hello everyone.
>   > I there a rt_task_unblock() Xenomai POSIX skin alternative?
>   > I created an example of periodic POSIX task, similar to the latency example but with very long period. When I receive a INT signal I set the end flag and I would like to unblock a task that waits on read(timerfd). But all my attempts led to standard wait timeout or worse.
>   
>   Try pthread_cancel(). If you need to run some cleanup code in the target
>   thread, use pthread_cleanup_push. None of that would be with real-time
>   qualities, though. But I assume that the cleanup is not a time-critical
>   path, is it?
>   
>   Sending a Linux signal would be another way to interrupt the target task.
>   
>   Jan
>   
>   --
>   Siemens AG, Corporate Technology, CT RDA IOT SES-DE
>   Corporate Competence Center Embedded Linux
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

