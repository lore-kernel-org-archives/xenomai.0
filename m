Message-ID: <497877B4.6060000@domain.hid>
Date: Thu, 22 Jan 2009 13:42:12 +0000
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5D63919D95F87E4D9D34FF7748CE2C2A01776C87@domain.hid>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A01776C87@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] How to use Xenomai libraries with "normal" (non
 Xenomai) linux processes ?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: roderik.wildenburg@domain.hid
Cc: xenomai@xenomai.org

roderik.wildenburg@domain.hid wrote:
> Sorry for the delayed answer, but I am fighting with an other Xenomai
> problem too (PPC switchtest FPU problem, you probably heard about
> it).
>=20
>>> I don=B4t understand this. Isn=B4t this a contradiction to your
>> answer in
>>> 2.) ? I thought sched_setscheduler does not work for Xenomai
>>> tasks and in our testcase we could see that scheduling policy
>>> isn=B4t set as expected (to SCHED_FIFO).
>> Currently the posix skin library does, in init.c:=20
>> parm.sched_priority =3D 0; err =3D
>> __wrap_pthread_setschedparam(pthread_self(), SCHED_OTHER, &parm);
>>=20
>> We could replace this with: err =3D
>> pthread_getschedparam(pthread_self(), &policy, &parm); if (err) ...
>>  err =3D __wrap_pthread_setschedparam(pthread_self(), policy, &parm);
>>=20
>>=20
>> But sched_setscheduler could be called after that, so this is racy.
>>=20
>=20
> Please correct me if I am wrong: In your replacement
> pthread_getschedparam would read scheduling parameters which should
> have been set with sched_setscheduler before(!) your replacement gets
> active. Is this possible at all ? Wouldn=B4t I have to call
> sched_setscheduler (in "sysup") before I fork? And if calling after
> the fork it realy would be racy. So this isn=B4t a very feasible
> solution, isn=B4t it? Changing the scheduling paramters of a running
> Xenoami task probably isn=B4t possible (probably there is nothing to
> recognize the change ?)?

You can also call sched_setscheduler after fork but before exec. In case
you want to do that, here is the (untested) patch, to let the xenomai
posix skin use this priority.

Index: src/skins/posix/init.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/skins/posix/init.c	(revision 4572)
+++ src/skins/posix/init.c	(working copy)
@@ -48,7 +48,7 @@ static __attribute__ ((constructor))
 void __init_posix_interface(void)
 {
 	struct sched_param parm;
-	int muxid, err;
+	int muxid, err, policy;

 	muxid =3D
 	    xeno_bind_skin(PSE51_SKIN_MAGIC, "POSIX", "xeno_posix");
@@ -74,9 +74,14 @@ void __init_posix_interface(void)
 		exit(EXIT_FAILURE);
 	}

-	parm.sched_priority =3D 0;
-	err =3D __wrap_pthread_setschedparam(pthread_self(), SCHED_OTHER,
-					   &parm);
+	err =3D __real_pthread_getschedparam(pthread_self(), &policy, &parm);
+	if (err) {
+		fprintf(stderr, "Xenomai Posix skin init: "
+			"pthread_getschedparam: %s\n", strerror(err));
+		exit(EXIT_FAILURE);
+	}
+
+	err =3D __wrap_pthread_setschedparam(pthread_self(), policy, &parm);
 	if (err) {
 		fprintf(stderr, "Xenomai Posix skin init: "
 			"pthread_setschedparam: %s\n", strerror(err));


--=20
                                                 Gilles.


