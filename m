Message-ID: <4995B6DF.1070102@domain.hid>
Date: Fri, 13 Feb 2009 18:07:27 +0000
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <57e813c90902130946p362eeb18m3141b31fc6aee873@domain.hid>
In-Reply-To: <57e813c90902130946p362eeb18m3141b31fc6aee873@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Confusion regarding linux/xenomai tasks
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Zara Tustra <zarawesome@domain.hid>
Cc: xenomai@xenomai.org

Zara Tustra wrote:
> I've read some information regarding the difficulty of communication between
> Linux threads and Xenomai tasks, and I've had some misinformation fired at
> me from co-workers. I just want to make some points clear:
> 
> 1) Can a Linux application launch Xenomai tasks, or I've horribly misread
> things somewhere? My understanding is that Xenomai tasks are commonly
> activated by a Linux process.

Yes.

> 
> 2) Can real-time Xenomai tasks started by a Linux application communicate
> with it through the global variables of that application?

Task is vague. We usually talk about threads or processes and task may
mean either. I guess you mean threads. Yes, Xenomai threads and Linux
threads share the same address space if they are part of the same
process. But beware to locking. If you want to protect the shared
variables with a mutex for instance. If it is a Linux mutex, using it
from a Xenomai thread will cause it to be "demoted". If it is a Xenomai
mutex, then all threads that use it will need to be Xenomai threads,
this is the way this issue is usually solved, which means that there are
som Xenomai threads which have lower priorites.

> 
> 3) What happens if I make a syscall or similar non-real-time call from a
> Xenomai task? Is the task automatically 'demoted' to non-real-time?

yes.

> How can I tell?

You can ask to be notified by using a signal, see rt_task_mode or
pthread_set_mode_np.

-- 
                                                 Gilles.

