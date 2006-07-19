Message-ID: <44BEA8FB.5070800@domain.hid>
Date: Wed, 19 Jul 2006 23:49:47 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Xenomai v2.2
References: <1153227929.5029.25.camel@domain.hid> <44BE8ECF.2050608@domain.hid>
In-Reply-To: <44BE8ECF.2050608@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF569774175CED3C171A52E55"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Hannes Mayer <h.mayer@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF569774175CED3C171A52E55
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hannes Mayer wrote:
> Ciao Philippe et al.!
>=20
> Philippe Gerum wrote:
> [...]
>> http://download.gna.org/xenomai/stable/xenomai-2.2.0.tar.bz2
>=20
> Congratulations on the newest release! :-)
>=20
> I've encountered a probably minor problem:
> I compiled the 16550A driver as module (everything else into
> the kernel), but when modprobing it said:
> couldn't find the kernel version the module was compiled for
>=20
> I then recompiled the module with an own makefile, then it
> worked.

When you THEN try compiling the driver within the kernel build again,
does it still work? I bet it will, because this was likely some issue of
a half-baked kernel. I also re-checked this and noticed no problems
loading the driver.

>=20
> Jan, I also updated the serial port example (I got my devel
> machine working again, so I tested on 2.2.0 today :-).
> Re. "mode-change explanation in your original email":
> I read thru them again and couldn't find what important
> stuff I left out. Please enlighten. Thanks :-)

Ok, let's go through the code I just collected from your side:

> void write_task_proc(void *arg) {
>   int ret;
>   ssize_t sz =3D sizeof(RTIME);
>   ssize_t written =3D 0;
>   unsigned char buf[17] =3D "CAPTAIN WAS HERE\0";
>   unsigned long overrun;
>=20
>   ret =3D rt_task_set_periodic(NULL, TM_NOW, rt_timer_ns2ticks(write_ta=
sk_period_ns));
>   if (ret) {
>     printf(WTASK_PREFIX "error while set periodic, code %d\n",ret);
>     goto exit_write_task;
>   }
>=20
>   while (1) {
>     /* switch to primary mode */
>     ret =3D rt_task_set_mode(0, T_PRIMARY, NULL);

Not needed because...

>     if (ret) {
>       printf(WTASK_PREFIX "error while rt_task_set_mode, code %d\n",ret=
);
>       goto exit_write_task;
>     }
>     ret =3D rt_task_wait_period(&overrun);

=2E..this call requires primary mode anyway and will take care for a
switch back.

>     if (ret) {
>       printf(WTASK_PREFIX "error while rt_task_wait_period, code %d\n",=
ret);
>       goto exit_write_task;
>     }
>     sz =3D sizeof(buf);
>     written =3D rt_dev_write(my_fd, &buf, sizeof(buf));
>     printf(WTASK_PREFIX "rt_dev_write written=3D%d sz=3D%d\n", written,=
 sz);
>     if (written !=3D sz ) {
>       if (written < 0 ) {
>         printf(WTASK_PREFIX "error while rt_dev_write, code %d\n",writt=
en);
>       } else {
>         printf(WTASK_PREFIX "only %d / %d byte transmitted\n",written, =
sz);
>       }
>       goto exit_write_task;
>     }
>   }
> exit_write_task:
>   if (my_state & STATE_FILE_OPENED) {
>     if (!close_file( my_fd, RTSER_FILE " (write)")) {
>       my_state &=3D ~STATE_FILE_OPENED;
>     }
>   }
>   printf(WTASK_PREFIX "exit\n");
> }
>
> void read_task_proc(void *arg) {
>   int ret;
> //  RTIME irq_time   =3D 0;
>   ssize_t sz =3D sizeof(RTIME);
>   ssize_t red =3D 0;
>   struct rtser_event rx_event;
>   unsigned char buf[17];
>=20
>   // we are in secondary mode now

Why? I suspect this comment is some kind of left-over of older code
(also given the dead variable irq_time above).

Keep in mind that real-time tasks always start in primary mode (I once
suggested to invert this for SCHED_OTHER / prio-0 tasks, but that's only
a concept yet).

>   while (1) {
>     /* switch to primary mode */
>     ret =3D rt_task_set_mode(0, T_PRIMARY, NULL);
>     if (ret) {
>       printf(RTASK_PREFIX "error while rt_task_set_mode, code %d\n",ret=
);
>       goto exit_read_task;
>     }
>     /* waiting for event */
>     // be careful not to do printf or so here. Otherwise rt_dev_ioctl
>     //    returns with an error, because we're not in hard real time
>     //    anymore (primary mode)

Partially true. Older revisions of Xenomai and this particular driver
(16550A) did fail this way. But now we simply switch over automatically
if some service is called from the "wrong" context.

The only still existing exception are (very rare!) services that are
provided for both contexts. In the 16550A driver: RTSER_RTIOC_SET_CONFIG
with RTSER_SET_TIMESTAMP_HISTORY set in the config mask must run in
non-RT context if the open call did so as well - consistent buffer
allocation from the same type of memory pool.

So, this means you can kill the set_mode, just like in my version I
suggested to cross-check. :)

>     ret =3D rt_dev_ioctl(my_fd, RTSER_RTIOC_WAIT_EVENT, &rx_event );
>     if (ret) {
>       printf(RTASK_PREFIX "error while RTSER_RTIOC_WAIT_EVENT, code %d\=
n",ret);
>       goto exit_read_task;
>     }
>     //irq_time =3D rx_event.rxpend_timestamp;
>     sz =3D sizeof(buf);
>     red =3D rt_dev_read(my_fd, &buf, sizeof(buf));
>     if (red =3D=3D sz ) {
> 		printf(RTASK_PREFIX "rt_dev_read=3D%s\n",buf);
>     } else {
>       if (red < 0 ) {
>         printf(RTASK_PREFIX "error while rt_dev_read, code %d\n",red);
>       } else {
>         printf(RTASK_PREFIX "only %d / %d byte received \n",red,sz);
>       }
>       goto exit_read_task;
>     }
>   }
> exit_read_task:
>   if (my_state & STATE_FILE_OPENED) {
>     if (!close_file( my_fd, READ_FILE " (rtser)")) {
>       my_state &=3D ~STATE_FILE_OPENED;
>     }
>   }
>   printf(RTASK_PREFIX "exit\n");
> }

Jan



--------------enigF569774175CED3C171A52E55
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEvqkAniDOoMHTA+kRAhORAJ9uA6bSutG2mGyD2l6egV+0ioPILgCcCnSG
knmQL0FYcLM9tjGFNOtbosM=
=oDXT
-----END PGP SIGNATURE-----

--------------enigF569774175CED3C171A52E55--

