Message-ID: <4370641D.7010906@domain.hid>
Date: Tue, 08 Nov 2005 09:38:53 +0100
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD2FB813759934B895D0A08AD"
Subject: [Xenomai-core] [BUG] scheduling order of dying shadow threads
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD2FB813759934B895D0A08AD
Content-Type: multipart/mixed; boundary="------------020904000301030606010104"

This is a multi-part message in MIME format.
--------------020904000301030606010104
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hi Philippe,

I think this one is for you: ;)

Sebastian got almost mad with his CAN driver while tracing a strange
scheduling behaviour during shadow thread deletion for several days(!) -
and I was right on the way to follow him yesterday evening. Attached is
a simplified demonstration of the effect, consisting of a RTDM driver
and both a kernel and user space application to trigger it.

Assume two or more user space RT-threads blocking on the same RTDM
semaphore inside a driver (I was not yet able to reproduce this with a
simply native user space application :/). All get then woken up on
rtdm_sem_destroy during device closure. They increment a global counter,
save the current value in a per-thread variable, and then terminate.
They had also passed another per-thread variable to the RTDM driver
which was updated in the kernel using the same(!) counter.

/* application */
void demo(void *arg)
{
    rt_dev_read(dev, &value_k[(int)arg], 0);
    value_u[(int)arg] = ++counter;
}

/* driver */
int demo_read_rt(struct rtdm_dev_context    *context,
                 rtdm_user_info_t           *user_info,
                 void                       *buf,
                 size_t                     nbyte)
{
    struct demodrv_context  *my_context;
    int                     ret;


    my_context = (struct demodrv_context *)context->dev_private;

    ret = rtdm_sem_down(&my_context->read_sem);
    *(int *)buf = ++(*counter);

    return ret;
}


That global counter is also incremented during closure to visualise the
call order:


int demo_close_rt(struct rtdm_dev_context   *context,
                  rtdm_user_info_t          *user_info)
{
    struct demodrv_context  *my_context;


    my_context = (struct demodrv_context *)context->dev_private;

    printk("close 1: %d\n", xnpod_current_thread()->cprio);
    rtdm_sem_destroy(&my_context->read_sem);
    printk("close 2: %d\n", xnpod_current_thread()->cprio);
    (*counter)++;

    return 0;
}


Now one would expect the following content of the involved variables
when running 3 threads e.g.:

           thread 1      (prio 99)
         /   thread 2    (prio 98)
         |  /   thread 3 (prio 97)
         |  |  /
value_k: 1, 3, 5
value_u: 2, 4, 6
counter: 7

This is indeed what we get when the application locates in kernel space,
i.e. does not use shadow threads. But when it is a user space
application, the result looks like this:

           thread 1
         /   thread 2
         |  /   thread 3
         |  |  /
value_k: 1, 4, 6
value_u: 2, 5, 7
counter: 7

Which means that first thread returns from kernel to user space and
terminates, then the close handler gets executed again, and only
afterwards the remaining threads!

The reason is also displayed by demodrv:
close 1: 0	- prio of root thread before rtdm_sem_destroy
close 2: 99	- ... and after rtdm_sem_destroy

Which means that the non-RT thread calling rt_dev_close gets lifted to
prio 99 on calling rtdm_sem_destroy, the prio of the thread first woken
up. It seems to loose this prio quite soon again, but not soon enough to
avoid the inversion - very strange.

Any ideas?

Jan

--------------020904000301030606010104
Content-Type: application/x-bzip2;
 name="cleanup-race.tar.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="cleanup-race.tar.bz2"

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
--------------020904000301030606010104--

--------------enigD2FB813759934B895D0A08AD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDcGQdncNeS9Q0k+IRAimvAJ94D0Vih9GbtfTh802xp947JWG65QCguxNE
0vTP8wWMDHefzpmd9HvFl/0=
=OCtY
-----END PGP SIGNATURE-----

--------------enigD2FB813759934B895D0A08AD--

