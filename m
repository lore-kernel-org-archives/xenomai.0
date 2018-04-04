From: Giulio Moro <g.moro@qmul.ac.uk>
Date: Wed, 4 Apr 2018 19:37:12 +0000
Message-ID: <DB6PR0701MB2456B23A97C5A7498981FC29B5A40@DB6PR0701MB2456.eurprd07.prod.outlook.com>
Content-Language: en-GB
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] cobalt equivalent of rt_task_shadow()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Xenomai 2.6, native API, I used to run

  rt_task_shadow(&thisTask, threadName, threadPriority, T_JOINABLE | T_FPU)=
;

Now I am using Cobalt on Xenomai 3 and I am looking for a drop-in replaceme=
nt.

Going through the source of alchemy.c, copperplate/internal.c and cobalt/th=
read.c, it seems that rt_task_shadow() now is implemented by calling=20

  pthread_setschedparam_ex(pthread_self(), SCHED_FIFO, &param_ex)=20

where sched_param_ex param_ex.sched_priorirty =3D threadPriority

Is that all that is needed to turn the current thread into a Xenomai thread=
 of priority threadPriority?
Perhaps followed by=20
  __wrap_pthread_setname_np(pthread_self(), taskName);
?

Thanks,
Giulio=

