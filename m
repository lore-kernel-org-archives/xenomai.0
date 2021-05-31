From: MONTET Julien <julien.montet@reseau.eseo.fr>
Subject: RE: Xenomai - VxWorks Emulator - Implementation of taskWait()
Date: Mon, 31 May 2021 07:11:55 +0000
Message-ID: <PR3PR02MB6202099DD43BB1D587B19DFDD13F9@PR3PR02MB6202.eurprd02.prod.outlook.com>
References: <PR3PR02MB6202889054902C3CC902EF15D1229@PR3PR02MB6202.eurprd02.prod.outlook.com>,
 <87fsy4k5vp.fsf@xenomai.org>
In-Reply-To: <87fsy4k5vp.fsf@xenomai.org>
Content-Language: fr-FR
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello Philippe,

Thank you for your answer and all of your explainations !

I understand now the next steps I need to follow.

Regards,

Julien
________________________________
De : Philippe Gerum <rpm@xenomai.org>
Envoy=E9 : dimanche 30 mai 2021 10:00
=C0 : MONTET Julien <julien.montet@reseau.eseo.fr>
Cc : xenomai@xenomai.org <xenomai@xenomai.org>
Objet : Re: Xenomai - VxWorks Emulator - Implementation of taskWait()


MONTET Julien via Xenomai <xenomai@xenomai.org> writes:

> Hi the developers,
>
> I already succeeded to use Xenomai with API/libraires such as Alchemy and=
 Posix.
> My goal is now to use the VxWorks API.
> I don't have any issue to include path/librairies but I am trying to use =
the function "taskWait" (used by VxWorks) that is not present in Xenomai-Vx=
Works.
> https://eur02.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fdocs.=
windriver.com%2Ffr-FR%2Fbundle%2Fvxworks_7_application_core_os_sr0630-enus%=
2Fpage%2FCORE%2FtaskLib.html%23taskWait&amp;data=3D04%7C01%7Cjulien.montet%=
40reseau.eseo.fr%7Cf85369ae235840b9093a08d9234113bb%7C4d7ad1591265437ab9f62=
946247d5bf9%7C0%7C0%7C637579584692348260%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC=
4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=
=3D12Vr5F7HQUaNjI2PUH%2FjGiVmLCQDCTuJgjnrzvQ370o%3D&amp;reserved=3D0
> https://eur02.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fxenom=
ai.org%2Fdocumentation%2Fxenomai-3%2Fhtml%2Fxeno3prm%2Finclude_2vxworks_2ta=
skLib_8h_source.html&amp;data=3D04%7C01%7Cjulien.montet%40reseau.eseo.fr%7C=
f85369ae235840b9093a08d9234113bb%7C4d7ad1591265437ab9f62946247d5bf9%7C0%7C0=
%7C637579584692358215%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV=
2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3Dom%2B3dyMdJMqMt%2F=
srXdtBCXARoa7dPIkd0TWLx3hmVwI%3D&amp;reserved=3D0
>
> I don't really know if this function is obvious or if a similar code coul=
d run on Xenomai.

taskWait() is roughly equivalent to pthread_join() with WAIT_FOREVER as
a timeout. Dealing with a valid timeout would be tricky though, since
POSIX does not provide support for this, neither does libcobalt for this
reason.

[Cobalt core]     <- kernel, implements syscalls from libcobalt.so
    ^
[libcobalt]       <- POSIX API (lib/cobalt)
    ^
[libcopperplate]  <- building blocks for non-POSIX APIs (common RTOS API pa=
tterns)
    ^
[VxWorks]         <- VxWorks emulation

There is no provision for join-with-timeout in either libcopperplate or
libcobalt at the moment. If your *libc is recent enough, you could
implement pthread_tryjoin() in libcobalt (lib/cobalt/thread.c) as a
variation of the existing pthread_join(), which would use the native
pthread_tryjoin(3) instead of pthread_join(3) to have the caller wait
for the thread to exit, finalizing the operation by a call to
cobalt_thread_join().

> Could you advise a way to implement something that looks like taskWait ?
> Could rt_task_wait_period<https://eur02.safelinks.protection.outlook.com/=
?url=3Dhttps%3A%2F%2Fxenomai.org%2Fdocumentation%2Fxenomai-3%2Fhtml%2Fxeno3=
prm%2Fgroup__alchemy__task.html%23ga1645d3a072ef3cefeed3bcbb27dcf108&amp;da=
ta=3D04%7C01%7Cjulien.montet%40reseau.eseo.fr%7Cf85369ae235840b9093a08d9234=
113bb%7C4d7ad1591265437ab9f62946247d5bf9%7C0%7C0%7C637579584692358215%7CUnk=
nown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJX=
VCI6Mn0%3D%7C1000&amp;sdata=3DBZNXcdami%2BxdXZ5kpOuSGA4jQlVwu6CxKIXPjNsVz30=
%3D&amp;reserved=3D0> from Alchemy (task.h) be an interesting solution ?
>

No, this is not related. rt_task_wait_period() waits for the next wakeup
in a periodic timeline started by rt_task_set_periodic().

--
Philippe.
