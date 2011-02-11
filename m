Message-ID: <4D5507C8.5070400@domain.hid>
Date: Fri, 11 Feb 2011 10:56:24 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <15658959.21297411846156.JavaMail.SYSTEM@pc-msalvini>
In-Reply-To: <15658959.21297411846156.JavaMail.SYSTEM@pc-msalvini>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problems with rt_task_create and rt_task_join
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Mauro Salvini <mauro.salvini@domain.hid>
Cc: xenomai@xenomai.org

Mauro Salvini wrote:
>> Well, looking at the code, this should not happen. The question is:
>> how do you ensure, in the code that calls rt_task_join, that the
>> thread being created had the time to call rt_task_shadow? In other
>> words, are you sure that you are not passing rt_task_join an
>> uninitialized RT_TASK?
> 
>> So, as usual, we are missing a simple standalone test showing the
>> issue you have.
> 
> There was a subtle bug that realizes exactly what you explained,
> thank you!

This is not exactly a subtle bug.

> Question is: after a successful rt_task_shadow() call done
> by a pthread, we can forget that this rt-task was created as pthread
> and then we must handle it with rt_task_* procedures, is it right? In
> other words, does pthread become a RT_TASK at all, as if it was
> created with rt_task_create()?

No, an RT_TASK is also a pthread, whether created with rt_task_shadow or
rt_task_create (if you look at src/skins/native/task.c, you will see
that rt_task_create creates a thread with pthread_create which does the
same thing as rt_task_shadow). You saw that rt_task_join was using
pthread_join under the hood. And by the way, rt_task_shadow by itself is
mainly useful for turning the main thread into an RT_TASK, it is simpler
to create other RT_TASKs with rt_task_create.

-- 
					    Gilles.

