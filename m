Message-ID: <450113E7.6000907@domain.hid>
Date: Fri, 08 Sep 2006 08:55:35 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] max size for pipes and rt-fifos?
References: <44FF3A22.5060901@domain.hid> <44FFE509.3090009@domain.hid>
	<4500789C.9070804@domain.hid>
In-Reply-To: <4500789C.9070804@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD6BD61B0F1903FF90F7F8EAB"
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
To: Jeff Webb <jeff.webb@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD6BD61B0F1903FF90F7F8EAB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jeff Webb wrote:
> Thanks for your input, Jan.
>=20
> Jan Kiszka wrote:
>> Jeff Webb wrote:
>>> It appears that the maximum pipe size that can be created using
>>> rt_pipe_create() is 16 MB.  Is this correct?  If so, what is the caus=
e
>>> of this limitation, and are there any work-arounds?  I am using a 128=
 MB
>>> FIFO in my rtlinux simulation.  Any ideas on how I can port this?
>>
>> Maybe it's a 2.4-related issue (my 2.4 setup is broken, can't test). O=
n
>> a 2.6.17 kernel I face no problems allocating far larger rt_pipes.
>=20
> I have discovered the source of the inconsistency:
>=20
>  xenomai-2.1-rc4: include/nucleus/heap.h:
>    #define XNHEAP_MAXEXTSZ   (1 << 24) /* i.e. 16Mb */
>=20
>  xenomai-2.2.1: include/nucleus/heap.h:
>    #define XNHEAP_MAXEXTSZ   (1 << 31) /* i.e. 2Gb */
>=20
>  Changelog:     2006-07-15  Philippe Gerum  <rpm@xenomai.org>
>        * include/nucleus/heap.h (XNHEAP_MAXEXTSZ): Raise maximum extent=

> size to 2Gb.

This explains a lot.

>=20
> I can now create a 128 MB rt-pipe on my xenomai-2.2.1 / kernel 2.6
> dual-core machine, if I boot with vmalloc=3D256M and add "uppermem 5242=
88"
> to my grub config.  I have not built an updated 2.4 kernel to test on m=
y
> Fedora Core I machine yet, but I will do this soon.
>=20
>> RTAI FIFO allocate their buffers from the real-time system heap, and
>> that on is 128 KB by default (see kernel config).
>=20
> Ah, I see.
>=20
> I know this is not the ideal solution, but could the system heap be mad=
e
> something big, like 256 MB?  That might solve my problem, for the short=


CONFIG_XENO_OPT_SYS_HEAPSZ?

> term.  Of course, if there is a memory leak in the FIFO
> creation/deletion, I will have BIG problems... ;)
>=20
>> Allocation in Xenomai pipes works differently...
>=20
> Is there some reason the RTAI FIFO emulation is not handled the same
> way?  I believe the real RTL and RTAI FIFOs are handled like the Xenoma=
i
> pipes are done now -- using kmalloc or vmalloc:
>=20
>  https://www.rtai.org/documentation/magma/html/api/group__fifos__ipc.ht=
ml#ga8
>=20
>=20
> I know my FIFOs are on the huge side, but I know I'm not the only one
> using more than 128KB total for all their FIFOs...

I agree that allocating a dedicated FIFO heap on creation and then
working on that heap for data exchange would be more flexible. I guess
this RTAI skin is not widely used, thus this issue did not pop up
earlier (most users migrate to native or posix).

>=20
>> The potential leak you found needs to be examined. Could you post a
>> simple test that demonstrate it?
>=20
> I'm attaching a sample kernel module that creates a 100KB FIFO on modul=
e
> insertion, and destroys it on module removal.  I can only run this one
> time.  The write fails on subsequent runs because the memory cannot be
> allocated.  Is there something I am not cleaning up properly?
>=20
> Thanks!
>=20
> -Jeff
>=20
>=20
>=20
> -----------------------------------------------------------------------=
-
>=20
>=20
> /* Linux kernel includes */
> #include <linux/module.h>
>=20
> /* Xenomai includes */
> #include <pthread.h>
> #include <rtai/fifo.h>
>=20
> /* Global variables */
> pthread_t fifotest_task =3D NULL;
>=20
> /* Real-time task */
> void * fifotest_routine (void *cookie)
> { =20
>   int err;
>=20
>   err =3D rtf_put(1, "hello ", 6);
>   printk("rtf_put: %d\n", err);
>   return NULL;
> }
>=20
> static int fifotest_init(void)
> {
>   int err;
>   pthread_attr_t attr;
> =20
>   printk("fifotest_init\n");
>=20
>   /* Create a FIFO */
>   err =3D rtf_create(1, 1024*100);
>   printk("rtf_create returned: %d\n", err);
>=20
>   /* Create a real-time task */
>   pthread_attr_init(&attr);
>   pthread_attr_setfp_np(&attr, 1);
>   err =3D pthread_create(&fifotest_task, &attr, &fifotest_routine, NULL=
);
>   if (err)
>     {
>       printk("could not create thread (error code: %d)\n", err);
>       err =3D rtf_destroy(1);
>       printk("rtf_destroy returned: %d\n", err);
>       return -1;
>     }
>=20
>   return 0;
> }
> static void fifotest_cleanup(void)
> {
>   int err;
>=20
>   printk("fifotest_cleanup\n");
>  =20
>   /* Shut down the real-time thread */
>   pthread_cancel (fifotest_task);
>   pthread_join (fifotest_task, NULL); =20

pthread_join requires RT context and will not work as expected. But
that's unrelated to this problem.

>=20
>   /* Destroy the fifo */
>   err =3D rtf_destroy(1);
>   printk("rtf_destroy returned: %d\n", err);
>  =20
> }
>=20
> module_init(fifotest_init);
> module_exit(fifotest_cleanup);
>=20

Ok, there is a real problem, actually two: Queuing messages only works
if both sides are connected, which is not the case in your scenario. And
when this attempt to send some data fails, the related buffer leaks.

But when comparing with RTAI FIFOs (I guess this is true for RTLinux as
well), this strict queuing rule is not correct and should be rethought.
Moreover, the RTAI skin contains its own deferring mechanism to call
xnpipe_send over Linux instead of RT. I don't see any reason for this,
the pipe service is RT-safe and does deferred wakeup of Linux readers on
its own. Looks like some redesign is required here...

Jan



--------------enigD6BD61B0F1903FF90F7F8EAB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFARPnniDOoMHTA+kRAnUgAJ4zjyCTflTwXAhdbuK1Xi2VR34y0gCfWTLI
f+llMjPdcIvwrKb/9Z0e1tE=
=Taom
-----END PGP SIGNATURE-----

--------------enigD6BD61B0F1903FF90F7F8EAB--

