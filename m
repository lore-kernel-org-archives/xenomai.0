MIME-Version: 1.0
In-Reply-To: <56B9CC36.1020309@xenomai.org>
References: <CAMJ=MEe9k1CS_tY=SxaaWTd+aYY2jAKNL_Ay1Ya0vvp1w5A6iQ@mail.gmail.com>
 <56B9CC36.1020309@xenomai.org>
From: Ronny Meeus <ronny.meeus@gmail.com>
Date: Tue, 9 Feb 2016 21:23:48 +0100
Message-ID: <CAMJ=MEe4vg9+2DF3=4ccss+gfrGnFsvwLL0vsu7rYO4fwBVg6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Mercury / pSOS: messages lost due to bug in q_receive
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On Tue, Feb 9, 2016 at 12:23 PM, Philippe Gerum <rpm@xenomai.org> wrote:
> On 02/05/2016 09:27 AM, Ronny Meeus wrote:
>> Hello
>>
>> we are using the pSOS interface on top of the Mercury core.
>> Under heavy stress conditions we see sporadically that messages are
>> getting lost.
>>
>> Attached you find a test application (multi_queue.c)  that helped me
>> to find the issue and verify that the attached patch actually solves
>> the issue as well.
>> To reproduce the issue I start the test application several times in
>> parallel. The cpuload of the board will reach a value of 100%.
>> Maybe it is not needed to start several application in parallel, but
>> if I do so, I can reproduce the issue in a matter of seconds.
>> As soon as one message is lost, the test stops itself (exit). After
>> some time I observe that all applications have stopped ...
>>
>> What the test basically does is sending messages between a manager and
>> 2 worker threads and verify, by using sequence numbers in the
>> messages, that no message is lost.
>> The test might look too complex but it is basically a simulation of a
>> scenario that we perform in our real application.
>>
>> The patch is ported from an older version of Xenomai.
>> I did not actually run the test with the latest version but by looking
>> to the code I can see that the issue is still present in the latest
>> version as well.
>>
>
> Your analysis is right, but the fix only addresses the symptom, not the r=
oot cause of this issue. The fact that a message might be squeezed in while=
 the receiver resumes from a timeout condition reveals a more general issue=
 with the syncobj_wait_grant/drain() logic in this area.
>
> This is what has to be fixed, since any code checking for the -ETIMEDOUT/=
-EINTR status from those copperplate calls to determine whether the conditi=
on was eventually satisfied is virtually affected by the very same problem.
>
> Could you test the following patch and let me know if that fixes the issu=
e for you as well?

Philippe

I have ported the patch to our version of Xenomai and started the test.
It runs already for several minutes without issues so it looks like
the problem is solved also with the patch below.
I will let it run overnight and update you tomorrow morning.

Thanks.

Best regards,
Ronny

>
> diff --git a/lib/copperplate/syncobj.c b/lib/copperplate/syncobj.c
> index 1b3d545..bf04b29 100644
> --- a/lib/copperplate/syncobj.c
> +++ b/lib/copperplate/syncobj.c
> @@ -453,14 +453,55 @@ struct threadobj *syncobj_peek_drain(struct syncobj=
 *sobj)
>
>  static int wait_epilogue(struct syncobj *sobj,
>                          struct syncstate *syns,
> -                        struct threadobj *current)
> +                        struct threadobj *current,
> +                        int ret)
>  {
>         current->run_state =3D __THREAD_S_RUNNING;
>
> +       /*
> +        * Fixup a potential race upon return from grant/drain_wait
> +        * operations, e.g. given two threads A and B:
> +        *
> +        * A:enqueue_waiter(self)
> +        * A:monitor_wait
> +        *    A:monitor_unlock
> +        *    A:[timed] sleep
> +        *    A:wakeup on timeout/interrupt
> +        *       B:monitor_lock
> +        *       B:look_for_queued_waiter
> +        *          (found A, update A's state)
> +        *       B:monitor_unlock
> +        *    A:dequeue_waiter(self)
> +        *    A:return -ETIMEDOUT/-EINTR
> +        *
> +        * The race may happen anytime between the timeout/interrupt
> +        * event is received by A, and the moment it grabs back the
> +        * monitor lock before unqueuing. When the race happens, B can
> +        * squeeze in a signal before A unqueues after resumption on
> +        * error.
> +        *
> +        * Problem: A's internal state has been updated (e.g. some
> +        * data transferred to it), but it will receive
> +        * -ETIMEDOUT/-EINTR, causing it to miss the update
> +        * eventually.
> +        *
> +        * Solution: fixup the status code upon return from
> +        * wait_grant/drain operations, so that -ETIMEDOUT/-EINTR is
> +        * never returned to the caller if the syncobj was actually
> +        * signaled. We still allow the SYNCOBJ_FLUSHED condition to
> +        * override that success code though.
> +        *
> +        * Whether a condition should be deemed satisfied if it is
> +        * signaled during the race window described above is
> +        * debatable, but this is a simple and straightforward way to
> +        * handle such grey area.
> +        */
> +
>         if (current->wait_sobj) {
>                 dequeue_waiter(sobj, current);
>                 current->wait_sobj =3D NULL;
> -       }
> +       } else if (ret =3D=3D -ETIMEDOUT || ret =3D=3D -EINTR)
> +               ret =3D 0;
>
>         sobj->wait_count--;
>         assert(sobj->wait_count >=3D 0);
> @@ -477,7 +518,7 @@ static int wait_epilogue(struct syncobj *sobj,
>         if (current->wait_status & SYNCOBJ_FLUSHED)
>                 return -EINTR;
>
> -       return 0;
> +       return ret;
>  }
>
>  int syncobj_wait_grant(struct syncobj *sobj, const struct timespec *time=
out,
> @@ -515,7 +556,7 @@ int syncobj_wait_grant(struct syncobj *sobj, const st=
ruct timespec *timeout,
>
>         pthread_setcancelstate(state, NULL);
>
> -       return wait_epilogue(sobj, syns, current) ?: ret;
> +       return wait_epilogue(sobj, syns, current, ret);
>  }
>
>  int syncobj_wait_drain(struct syncobj *sobj, const struct timespec *time=
out,
> @@ -553,7 +594,7 @@ int syncobj_wait_drain(struct syncobj *sobj, const st=
ruct timespec *timeout,
>
>         pthread_setcancelstate(state, NULL);
>
> -       return wait_epilogue(sobj, syns, current) ?: ret;
> +       return wait_epilogue(sobj, syns, current, ret);
>  }
>
>  int syncobj_destroy(struct syncobj *sobj, struct syncstate *syns)
>
> --
> Philippe.

