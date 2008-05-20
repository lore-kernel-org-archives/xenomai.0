MIME-Version: 1.0
Date: Tue, 20 May 2008 07:47:50 +0200
From: Matthieu <matthieu.connaulte_xenomai@domain.hid>
In-Reply-To: <728e254ea628725216c983d66e391cb5@domain.hid>
References: <728e254ea628725216c983d66e391cb5@domain.hid>
Message-ID: <a42b680918d4f3fc74642083e5fbf192@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] Re: VxWorks mode switching signal SIGXCPU and switch
 operation
Reply-To: matthieu.connaulte_xenomai@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org



On Mon, 19 May 2008 10:11:26 +0200, Matthieu
<matthieu.connaulte_xenomai@domain.hid> wrote:
> Hi
>=20
> I'm using vxwork's API.
> Is SIGXCPU signal sent when primary to seconday VxWorks task's mode
switch
> ? If it's the case, which implementation would work ?
>=20
> Use of signal (native Xenomai API) :
>=20
>      void vx_task_create(...)
>      {
>      ...
>      signal(SIGXCPU, xe_signal_thread);
>      ...
>      }
>=20
>      void *xe_signal_thread (void *sig_caught)
>      {
>        /* Mode switching warning */
>      }
>=20
>      There is missing rt_task_set_mode(0, T_WARNSW, NULL); which I don'=
t
> know where I have to put it because I want all the task to warn in case
of
> a mode switch and I don't what to write this sentense in each task's bo=
dy
> routine.
>=20
>=20
>=20
> Use of  pthread_sigmask
>=20
>      static sigset_t sigusr1Mask;
>=20
>      void vx_task_create(...)
>      {
>      ...
>      sigemptyset(&sigusr1Mask);
>      sigaddset(&sigusr1Mask,SIGXCPU);
>      ...
>      }
>=20
>      void vx_task_start(...) {
>      ...
>      pthread_sigmask (SIG_BLOCK, &sigusr1Mask, NULL);
>      pthread_create (&sig_thr_id, NULL, xe_signal_thread, NULL);
>      ...
>      }
>=20
>      void *xe_signal_thread (void *arg)
>      {
>        int       sig_caught;    /* signal caught       */
>        sigwait (&signal_mask, &sig_caught);
>        switch (sig_caught)
>        {
>           case SIGXCPU:     /* process SIGXCPU  */
>             /* Mode switching warning */
>             fprintf (stderr, "\nPrimary to secondary mode switch %d\n",
> sig_caught);
>             break;
>           default:         /* should normally not happen */
>             fprintf (stderr, "\nUnexpected signal %d\n", sig_caught);
>             break;
>        }
>      }
>=20
>      In this case, a thread waiting for the signal will be created with
> each task, I don't thing it's necessary !!
>=20
> On last thing, how can I force a vxworks task switching in primary mode=
,
> like in the native API rt_task_set_mode(0, T_PRIMARY, NULL);
>=20
> Thank's in advance
>=20
> Matthieu
>=20
>=20

I found out that it is possible to mix API since SIGXCPU signal, sent whe=
n
swiching in secondary mode, is obviously only used by Xenomai Native API.
Well, I tried to implement it in a vxworks context, but I don't have test
it yet. I have some problems remaining with rt_task_set_mode(0, T_WARNSW,
NULL) that I don't know where to use.
Do you have any solution ?

Matthieu



