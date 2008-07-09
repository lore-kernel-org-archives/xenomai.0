Message-ID: <4874737B.7000905@domain.hid>
Date: Wed, 09 Jul 2008 10:14:51 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <48745B79.7020100@domain.hid>
In-Reply-To: <48745B79.7020100@domain.hid>
Content-Type: multipart/mixed; boundary="------------050202000204010206060205"
Subject: Re: [Xenomai-help] rt_task_set_periodic() question
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-1?Q?Thomas_H=E4berle?= <thomas.haeberle@domain.hid>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------050202000204010206060205
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable

Thomas H=E4berle wrote:
> Hello!
>=20
> I am using Xenomai 2.3.5 with a Linux Kernel 2.4 on an MPC5200.
>=20
> One of my periodic Xenomai tasks has to be rescheduled now and than for
> some -for the question unimportant- reasons.
> To do so I
> 1.) get the next planed release point with "rt_task_inquire(NULL,=20
> &tt_info)"
> 2.) add the desired delay to the sheduling point with "t_start =3D=20
> RTIME(tt_info.relpoint + delay)"
>     (delay is always a positive value)
> 3.) call "rt_task_set_periodict_task_set_periodic( NULL, t_start,=20
> ONE_MS)" to reshedule the task

Could you try the attached patch ?

--=20
                                                  Gilles.

--------------050202000204010206060205
Content-Type: text/plain;
 name="xeno-2.3.x-fix-relpoint.diff"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="xeno-2.3.x-fix-relpoint.diff"

Index: ksrc/skins/native/task.c
===================================================================
--- ksrc/skins/native/task.c	(r������vision 4041)
+++ ksrc/skins/native/task.c	(copie de travail)
@@ -1120,7 +1120,8 @@ int rt_task_inquire(RT_TASK *task, RT_TA
 	info->bprio = xnthread_base_priority(&task->thread_base);
 	info->cprio = xnthread_current_priority(&task->thread_base);
 	info->status = xnthread_state_flags(&task->thread_base);
-	info->relpoint = xntimer_get_date(&task->thread_base.ptimer);
+	info->relpoint = xntimer_get_date(&task->thread_base.ptimer)
+		+ nkpod->wallclock_offset;
 
       unlock_and_exit:
 

--------------050202000204010206060205--

