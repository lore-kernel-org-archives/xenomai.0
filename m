Message-ID: <b647ffbd0605100216p7ba1d67eu7afc8df4fb29d828@domain.hid>
Date: Wed, 10 May 2006 11:16:44 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-core] [bug] zombie mutex owners
In-Reply-To: <44619D0B.1080402@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
References: <44619D0B.1080402@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Hi Jan,

>
> running the attached test case for the native skin, you will get an ugly
> lock-up on probably all Xenomai versions. Granted, this code is a bit
> synthetic. I originally thought I could trigger the bug also via
> timeouts when waiting on mutexes, but this scenario is safe (the timeout
> is cleared before being able to cause harm).
>

just in order to educate me as probably I might have got something
wrong at the first glance :)

if we take this one:

--- mutex.c=092006-02-27 15:34:58.000000000 +0100
+++ mutex-NEW.c=092006-05-10 11:55:25.000000000 +0200
@@ -391,7 +391,7 @@ int rt_mutex_lock (RT_MUTEX *mutex,
 =09err =3D -EIDRM; /* Mutex deleted while pending. */
     else if (xnthread_test_flags(&task->thread_base,XNTIMEO))
 =09err =3D -ETIMEDOUT; /* Timeout.*/
-    else if (xnthread_test_flags(&task->thread_base,XNBREAK))
+    else if (xnthread_test_flags(&task->thread_base,XNBREAK) &&
mutex->owner !=3D task)
 =09err =3D -EINTR; /* Unblocked.*/

  unlock_and_exit:

As I understand task2 has a lower prio and that's why

[task1] rt_mutex_unlock
[task 1] rt_task_unblock(task1)

are called in a row.

ok, task2 wakes up in rt_mutex_unlock() (when task1 is blocked on
rt_mutex_lock()) and finds XNBREAK flag but,

[doc] -EINTR is returned if rt_task_unblock() has been called for the
waiting task (1) before the mutex has become available (2).

(1) it's true, task2 was still waiting at that time;
(2) it's wrong, task2 was already the owner.

So why just not to bail out XNBREAK and continue task2 as it has a
mutex (as shown above) ?

--
Best regards,
Dmitry Adamushko

