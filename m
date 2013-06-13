MIME-Version: 1.0
Date: Thu, 13 Jun 2013 23:29:56 +0200
Message-ID: <CAPpP=rNokh_UCevqYNRHDs=Cs87-Nndw5fnWAMZj63YoMqEANg@mail.gmail.com>
From: alex alex <duch.alexandre@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] IgH EtherCAT Master & xenomai posix skin
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

xenomai:2.6.2.1
linux:3.5.7
IgH EtherCAT : latest version
rt ethernet driver:e1000e


Hello everyone,

Are there people who have succeeded in obtaining a real-time behavior with
xenomai posix skin using real-time drivers?
I tried to run the posix skin example, but the implementation is quitestran=
ge
:

     / * Create cyclic RT-thread * /
     param =3D {struct sched_param sched_priority =3D 82.};
     pthread_attr_t =FE=E1ttr;
     pthread_attr_init (& =FE=E1ttr);
     pthread_attr_setdetachstate (& =FE=E1ttr, PTHREAD_CREATE_JOINABLE);
     pthread_attr_setinheritsched (& =FE=E1ttr, PTHREAD_EXPLICIT_SCHED);
     pthread_attr_setschedpolicy (& =FE=E1ttr, SCHED_FIFO);
     pthread_setschedparam (cyclicthread, SCHED_FIFO, & param);
     pthread_set_name_np (cyclicthread, "ec_xenomai_posix_test");
     ret =3D pthread_create (& cyclicthread, & =FE=E1ttr, & my_thread, NULL=
);

The result is that the cyclic task is not real-time because it uses "
pthread_setschedparam" before the thread is created.
After correcting this with :


     / * Create cyclic RT-thread * /
     param =3D {struct sched_param sched_priority =3D 82.};
     pthread_attr_t =FE=E1ttr;
     pthread_attr_init (& =FE=E1ttr);
     pthread_attr_setdetachstate (& =FE=E1ttr, PTHREAD_CREATE_JOINABLE);
     pthread_attr_setinheritsched (& =FE=E1ttr, PTHREAD_EXPLICIT_SCHED);
     pthread_attr_setschedpolicy (& =FE=E1ttr, SCHED_FIFO);
     pthread_attr_setschedparam (& =FE=E1ttr, & param);
     ret =3D pthread_create (& cyclicthread, & =FE=E1ttr, & my_thread, NULL=
);
     pthread_set_name_np (cyclicthread, "ec_xenomai_posix_test");

 Then the thread never starts...


Thanks and regards,

Alexandre
