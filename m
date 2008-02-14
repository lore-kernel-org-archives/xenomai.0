Message-ID: <47B44693.6070203@domain.hid>
Date: Thu, 14 Feb 2008 14:48:03 +0100
From: Johan Borkhuis <j.borkhuis@domain.hid>
MIME-Version: 1.0
References: <12460.62.39.72.60.1202995942.squirrel@domain.hid>
In-Reply-To: <12460.62.39.72.60.1202995942.squirrel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problem of thread creation with Xenomai Posix
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Fabien MAHOT <fabien.mahot@domain.hid>
Cc: xenomai@xenomai.org

Fabien MAHOT wrote:
> Hi,
>
> I need your help to understand why my application doesn't work correctly.
>
> I use the Xenomai 2.3.4 kernel with its POSIX skin to develop a real time
> application. In this program, I create several threads thanks to a main
> thread which has the highest priority (SCHED_FIFO configuration). The aim
> is that the main thread stays in execution during the creation of all the
> other threads.
>
> However, in my program, when the main thread calls the posix function
> pthread_create to create a new thread, it's preempted by a thread created
> previously. In spite of the main thread has the highest priority.
>
> I would like to know why I ve got this problem with Xenomai. If you ve got
> an idea, please , give me your opinion.
>
>   
This is quite easy to explain: the task you create is a real time task. 
This task will always run before your main task, which is a Linux task.

If you add a call to rt_task_shadow after the mlockall your main task 
will also become a Xenomai task, and you will see the same behavior as 
with Linux.

Kind regards,
    Johan Borkhuis

-- 
Johan Borkhuis                                  Dutch Space BV
email:        j.borkhuis@domain.hid          Newtonweg 1
phone:        071-5245788                       Leiden
fax:          071-5245499                       The Netherlands


