MIME-Version: 1.0
Date: Mon, 19 May 2008 10:11:26 +0200
From: Matthieu <matthieu.connaulte_xenomai@domain.hid>
Message-ID: <728e254ea628725216c983d66e391cb5@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] VxWorks mode switching signal SIGXCPU and switch
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

Hi

I'm using vxwork's API.
Is SIGXCPU signal sent when primary to seconday VxWorks task's mode switc=
h
? If it's the case, which implementation would work ?

Use of signal (native Xenomai API) :

     void vx_task_create(...)=20
     {
     ...
     signal(SIGXCPU, xe_signal_thread);
     ...
     }

     void *xe_signal_thread (void *sig_caught)
     {
       /* Mode switching warning */
     }

     There is missing rt_task_set_mode(0, T_WARNSW, NULL); which I don't
know where I have to put it because I want all the task to warn in case o=
f
a mode switch and I don't what to write this sentense in each task's body
routine.



Use of  pthread_sigmask

     static sigset_t sigusr1Mask;

     void vx_task_create(...)=20
     {
     ...
     sigemptyset(&sigusr1Mask);
     sigaddset(&sigusr1Mask,SIGXCPU);
     ...
     }

     void vx_task_start(...) {
     ...
     pthread_sigmask (SIG_BLOCK, &sigusr1Mask, NULL);
     pthread_create (&sig_thr_id, NULL, xe_signal_thread, NULL);
     ...
     }

     void *xe_signal_thread (void *arg)
     {
       int       sig_caught;    /* signal caught       */
       sigwait (&signal_mask, &sig_caught);
       switch (sig_caught)
       {
          case SIGXCPU:     /* process SIGXCPU  */
            /* Mode switching warning */
            fprintf (stderr, "\nPrimary to secondary mode switch %d\n",
sig_caught);
            break;
          default:         /* should normally not happen */
            fprintf (stderr, "\nUnexpected signal %d\n", sig_caught);
            break;
       }
     }

     In this case, a thread waiting for the signal will be created with
each task, I don't thing it's necessary !!

On last thing, how can I force a vxworks task switching in primary mode,
like in the native API rt_task_set_mode(0, T_WARNSW, NULL);

Thank's in advance

Matthieu



