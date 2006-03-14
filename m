Message-ID: <4416D320.5050500@domain.hid>
Date: Tue, 14 Mar 2006 15:28:48 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] the same error
References: <4416CC6A.8030605@domain.hid>
In-Reply-To: <4416CC6A.8030605@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig07C163C0CE68BD015C03553E"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: marcellin <marcellin.fotze@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig07C163C0CE68BD015C03553E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

marcellin wrote:
> well, I've made some little modifications, now i use the
> "rt_task_shadow()  function", but  from  the  "rt_intr_wait() function"=
=20
> the  numerical  error is  "-1".  To answer to Gilles, i use the RTC irq=

> because i work on a (slow) acquisition system wich works continuously,
> and don't allow time drifts. The use of xenomai is to have tiny latenci=
es.
>=20
> the modified test program :
>=20
> #include <sys/mman.h>
> #include <sys/time.h>
> #include <unistd.h>
> #include <stdlib.h>
> #include <stdio.h>
> #include <string.h>
> #include <signal.h>
> #include <getopt.h>
> #include <time.h>
> #include <native/task.h>
> #include <native/mutex.h>
> #include <native/timer.h>
> #include <native/sem.h>
> #include <native/intr.h>
> #include <native/cond.h>
> #include <rtdm/rtbenchmark.h>
> #include <linux/rtc.h>
> #include <sys/ioctl.h>
> //#include <sys/time.h>
> //#include <sys/types.h>
> #include <fcntl.h>
> #include <errno.h>
>=20
>=20
> RT_TASK task;
>=20
> RT_TASK main_task;
>=20
>=20
> RT_INTR intr_desc;
>=20
> RT_COND cond;
>=20
> RT_MUTEX mutextest;
>=20
> int err,fd,retval,i,irqcount =3D 0;
> unsigned long data;
> char err_message[80];
> const int TIMER_IRQ =3D 8;
>=20
> void mytask(void * cookie)
> {
>  sleep(1);
>  err =3D rt_cond_signal(&cond);
>  if(err !=3D 0){
>    printf("\nrt_cond_signal : %i\n",err);
>  }
>       =20
> }
>=20
> int main (int argc, char **argv)
> {
>=20
>  mlockall(MCL_CURRENT | MCL_FUTURE);
>    rt_timer_set_mode(TM_ONESHOT);
>=20
>  err =3D rt_task_shadow(&main_task,"main_task",11,0);  if(err !=3D
> 0){                                                                    =
=20
> printf("\nrt_task_shadow : %i",err);
>  }
>=20
>  err =3D rt_cond_create(&cond,"condition");
>  if(err !=3D 0){
>    printf("\nrt_cond_create : %i",err);
>  }
>  err =3D rt_mutex_create(&mutextest,"mut");
>  if(err !=3D 0){
>    printf("\nrt_mutex_create : %i",err);
>  }
>=20
>  err =3D rt_task_create(&task,"SecondTask",0,99,0);
>  if(err !=3D 0){
>    printf("\nrt_task_create : %i",err);
>  }
>  err =3D rt_task_start(&task,&mytask,NULL);
>  if(err !=3D 0){
>    printf("\nrt_task_start : %i",err);
>  }
>=20
>  err =3D rt_cond_wait(&cond,&mutextest,20000000);

This service is very similar to POSIX condition variables: you have to
acquire the mutex before you can wait on the condition.

>  if(err !=3D 0){
>    printf("\nrt_cond_wait : %i",err);
>  }
>  printf("\nend \n");
>=20
>  rt_mutex_delete(&mutextest);
>  rt_cond_delete(&cond);
>  rt_task_delete(&main_task);
>  rt_task_delete(&task);
>=20
> return(0);
>=20
> }
>=20
>=20
> regards
>=20
> Marcell1
>=20

Jan


--------------enig07C163C0CE68BD015C03553E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEFtMgniDOoMHTA+kRAsasAJ9gJMXb9TXRRvrQpR1NZbYjjgSyawCfUzQY
oe1Mhwc5j7QS3TomM/Z8qX8=
=par9
-----END PGP SIGNATURE-----

--------------enig07C163C0CE68BD015C03553E--

