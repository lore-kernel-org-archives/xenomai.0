Message-ID: <4E2C3A96.9090804@domain.hid>
Date: Sun, 24 Jul 2011 08:30:30 -0700
From: Thomas Lockhart <Thomas.Lockhart@domain.hid>
MIME-Version: 1.0
References: <003901cc4a03$6676f0d0$3364d270$@de>
In-Reply-To: <003901cc4a03$6676f0d0$3364d270$@de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Process migrieren
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Franz Engel <franz_lambert_engel@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>


> I use a Api called =84KogniMobil RTDB=93. In the documentation the=20
> programmer wrote that the Api runs with Xenomai. I read the make files=20
> of the Api but there is nothing from Xenomai. Furthermore the=20
> programmer wrote that I have to start the Tasks under the GPOS and=20
> after the initialization I have to migrate the tasks to the RTOS and=20
> let them run as a RT-Task. The migration should do by the methods of=20
> Xenomai. Does somebody knows what methods the programmer means?
>
I'm sorry I don't have time to look up the details, but here is a code=20
snippet from our RT app which transitions a Linux thread to a Xenomai RT=20
thread.

hth

                                - Tom

  RT_TASK *mtsk;
  mtsk =3D (RT_TASK*)malloc(sizeof(RT_TASK));
  ...
  int err =3D rt_task_shadow(mtsk, 0, pTask->mPriority, T_FPU);

--=20
Thomas Lockhart
Supervisor, Distributed and Real-time Group
Instrument Software and Science Data Systems
Caltech/JPL


