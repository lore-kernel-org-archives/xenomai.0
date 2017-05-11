From: =?iso-8859-1?Q?H=E4nel-Baas=2C_Alexander?=
 <alexander.haenel-baas@sieb-meyer.de>
Date: Thu, 11 May 2017 12:45:29 +0000
Message-ID: <9BA84827B30CBE4996725F98F7DC912365414F03@SMExchange01.siebmeyer.org>
Content-Language: de-DE
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] delete a suspend rt_task xeno2<>xeno3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Philippe Gerum (rpm@xenomai.org)" <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

>What can I do to delete a suspend rt_task without the task will running in=
 the loop, because the task descriptor was going invalid from delete() call=
?

I was looking into the xenomai source alchemy/task.c and copperplate/thread=
obj.c

When I call rt_task_delete() for an already  suspend rt_thread  the rt_thre=
ad was unlocked by: rt_task_delete() -> threadobj_cancel() ->cancel_sync() =
 -> request_cancel() ->threadobj_unlock().
So the rt_thread leaves rt_task_suspend() shows my printf() message (in my =
example) and entered rt_task_suspend() again.
But now in rt_task_suspend() the function find_alchemy_task_or_self() retur=
n NULL because the task descriptor is already deleted and we leaves the rt_=
task_suspend() function again.=20
Shows my printf and entered rt_task_suspeng()...

And this loop demonstrate my short test example.
>Example
>rt_thread
>  for(;;){
>       rt_task_suspend(NULL);
>      printf("in loop\n");
>   }
>main:
>rt_task_spawn()
>. other stuff
>rt_task_delete()

My Solution:
In the rt_thread loop I call rt_task_self().=20
When I get NULL I know this thread was delete and I leave the rt_thread.

rt_thread
    for(;;){
        ret =3D rt_task_suspend(&rtTask);
        printf("--- %s in loop a: %d ret:%d -> %s\n",rt_task_info.name,a,re=
t,strerror(-ret));

        myrt =3D rt_task_self();
        if (myrt =3D=3D NULL){
            goto exit;
        }
exit:
}

Any other solution for this?

Regards,
Alexander




