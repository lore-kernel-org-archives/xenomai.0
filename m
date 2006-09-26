Message-ID: <45194E86.4090002@domain.hid>
Date: Tue, 26 Sep 2006 18:00:06 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20060926154124.45256.qmail@domain.hid>
In-Reply-To: <20060926154124.45256.qmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig566D769DCEFB23D1C88C3875"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-help] Re: [Xenomai-core] aperiodic xenomai tasks
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: mani bhatti <imranbashirbhatti@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig566D769DCEFB23D1C88C3875
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

mani bhatti wrote:
> Hi friends
> i want to create two aperiodic tasks .I have made a small example and c=
reated two tasks and set their priority equal.i have removed rt_task_setP=
eriodic function from the code but problem is that the task which is star=
ted first only it works and the second task which is started later never =
shows up.If some one tells me the cause of this problem i would be very g=
rateful.The source code is given below.

First of all, please post such requests for help to the xenomai-help
list (I already changed the address in this reply). Xenomai-core is
intended for discussions about the internals of Xenomai.

>=20
> void zaehler1_task(void *cookie){
>         int ret;
>=20
> // ************************* Xenomai-Krempel **************************=
******************************************
>     //    ret =3D rt_task_set_periodic(NULL, TM_NOW, rt_timer_ns2ticks(=
task_period_ns1));
>     //    if (ret) {
>     //            printf("error while set periodic, code %d\n",ret);
>     //            return;
>     //    }
> // ************************* Ende Xenomai-Krempel *********************=
*******************************************

Well, by commenting out this "Xenomai-Krempel" (be careful, people on
these lists may understand German ;)), your real-time task below enters
an infinite loop without any delays (except for the printing).
rt_task_wait_period always fails if you do not switch periodic mode on.
Therefore, the second task never gets a chance to be started.

What was your motivation behind this? You need some clocking for the
real-time task, either periodical timer-driven or some explicit
rt_task_sleep, or you pend it on an external event (provided by a driver
or whatever).

>=20
>=20
> // ********************** Beginn des wiederholt ausgefuehrten Codes ***=
*******************************************
>         while(!end){
>                 ret =3D rt_task_set_mode(0, T_PRIMARY, NULL);
>                 if (ret) {
>                         printf("error while rt_task_set_mode, code %d\n=
",ret);
>                         return;
>                 }
>                 ret =3D rt_task_wait_period();
>                 printf("T1:Start\n");
>=20
>                 if (ret) {
>                 //        printf("error while rt_task_wait_period, code=
 %d\n",ret);
>                 //        return;
>                 }
>                 count1++;
>=20
>                 printf("T1:Ende:%d\n", count1);
>=20
>                 fflush(NULL);
>         }
> // ********************** Ende des wiederholt ausgefuehrten Codes *****=
******************************************
> }
>=20
> void zaehler2_task(void *cookie){
>         int ret;
>         long ii;
>         long jj;
>         double a;
>=20
> // ************************* Xenomai-Krempel **************************=
******************************************
> //      ret =3D rt_task_set_periodic(NULL, TM_NOW, rt_timer_ns2ticks(ta=
sk_period_ns2));
> //      if (ret) {
> //              printf("error while set periodic, code %d\n",ret);
> //              return;
> //      }
> // ************************* Ende Xenomai-Krempel *********************=
*******************************************
>=20
> // ********************** Beginn des wiederholt ausgefuehrten Codes ***=
*******************************************
>         while(!end){
>                 ret =3D rt_task_set_mode(0, T_PRIMARY, NULL);
>                 if (ret) {
>                         printf("error while rt_task_set_mode, code %d\n=
",ret);
>                         return;
>                 }
>                 ret =3D rt_task_wait_period();
>=20
>                 printf("\t\tT2:Start\n");
>=20
>                 if (ret) {
>                 //      printf("error while rt_task_wait_period, code %=
d\n",ret);
>                 //      return;
>                 }
>=20
>             //    for(ii=3D0; ii<200; ii++) {
>                 //      for(jj=3D0; jj<1000000; jj++) {
>                 //              a =3D (double)ii * (double)jj;
>                 //      }
>         //      }
>=20
>                 count2++;
>                 printf("\t\tT2:Ende:%d\n", count2++);
>=20
>                 fflush(NULL);
>         }
> // ********************** Ende des wiederholt ausgefuehrten Codes **
>=20
>=20
> int main(int argc, char *argv[]) {
>         int err, ret;
>         printf("start\n");
>         // install signal handler
>         signal(SIGTERM, clean_exit);
>         signal(SIGINT, clean_exit);
>         // start timer
>         ret =3D rt_timer_start(TM_ONESHOT);
>         switch (ret) {
>                 case 0:       printf("Mit dem Fahrrad nich inn ersten W=
agen\n\n");
>                               break;
>                 case -EBUSY:  printf("timer is running\n");
>                               break;
>                 case -ENOSYS: printf("can't start timer\n");
>                               return ret;
>         }
>=20
>         /* create zaehler1_task */
>         err =3D rt_task_create(&zaehler1_task_ptr,"Zaehler_1",STACK_SIZ=
E,STD_PRIO1,0);
>         /* create zaehler2_task */
>         err =3D rt_task_create(&zaehler2_task_ptr,"Zaehler_2",STACK_SIZ=
E,STD_PRIO2,0);
>=20
>         /* start zaehler1_task */
>         err =3D rt_task_start(&zaehler1_task_ptr,&zaehler1_task,NULL);
>=20
>         /* start zaehler2_task */
>         err =3D rt_task_start(&zaehler2_task_ptr,&zaehler2_task,NULL);
>=20
>         // wait for signal & return of signal handler
>         pause();
>         fflush(NULL);
> }
>=20

Jan


--------------enig566D769DCEFB23D1C88C3875
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFGU6GniDOoMHTA+kRAgDEAJ9eBk0yR1ZsJ7hOU/w4Xl8w0gDTnwCeIMCN
7HbcrOeesmRh3Q94lwq06JI=
=ibYg
-----END PGP SIGNATURE-----

--------------enig566D769DCEFB23D1C88C3875--

