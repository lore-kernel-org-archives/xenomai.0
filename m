From: Carlos Eduardo de Brito Novaes <carlosnov@domain.hid>
Date: Thu, 11 Aug 2011 19:28:34 -0300
References: <201108101449.54243.carlosnov@domain.hid>
	<201108111512.40209.carlosnov@domain.hid>
	<4E442EB0.7030909@domain.hid>
In-Reply-To: <4E442EB0.7030909@domain.hid>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201108111928.34508.carlosnov@domain.hid>
Subject: Re: [Xenomai-help] Trouble with rtdm timers and events
Reply-To: Carlos Eduardo de Brito Novaes <carlosnov@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Solved,
It really was a bug on my code, in the read_rt. I was referring to device=20
context before get it. Thank you very much for the help, for the code and f=
or=20
the time spent. Also, sorry for not being able to catch this stupid bug=20
before.

Thanks

=2D-
Carlos Novaes.


Em qui 11 ago 2011, =C3=A0s 16:34:08, Gilles Chanteperdrix escreveu:
> On 08/11/2011 08:12 PM, Carlos Eduardo de Brito Novaes wrote:
> > I really did not understand why nor even what exactly it means to
> > overflow the source area, but I forgot to mention that I commented it
> > out, so the copy_to_user is not being called at all.
>=20
> It means that sizeof(sample_number) is 40, and neither the zone you are
> copying from, neither the zone you are copying to is 40 bytes large
> (except for the first call to read).
>=20
> Also, there is no problem starting a timer in open_nrt and close_nrt
> handlers.
>=20
> So, here is a simple self-contained testcase which does what you are
> trying to do. And which works. So, I insist, you should really inspect
> your code carefully, the bugs you have do not seem to come from xenomai.
>=20
> Module code:
> #include <rtdm/rtdm_driver.h>
>=20
> struct device_ctx {
> 	rtdm_event_t event;
> 	rtdm_timer_t timer;
> };
>=20
> MODULE_LICENSE("GPL");
> MODULE_AUTHOR("gch");
>=20
> static void test_timer(rtdm_timer_t *timer)
> {
> 	struct device_ctx *ctx =3D container_of(timer, struct device_ctx, timer);
>=20
> 	rtdm_event_pulse(&ctx->event);
> 	rtdm_timer_start_in_handler(&ctx->timer,
> 			      rtdm_clock_read_monotonic() + 100000000,
> 			      0, RTDM_TIMERMODE_ABSOLUTE);
> }
>=20
> static int test_open(struct rtdm_dev_context *context,
> 		     rtdm_user_info_t *user_info,
> 		     int oflags)
> {
> 	struct device_ctx *ctx =3D (struct device_ctx *)context->dev_private;
> 	int rc;
>=20
> 	rc =3D rtdm_timer_init(&ctx->timer, test_timer, "timer");
> 	if (rc < 0)
> 		return rc;
>=20
> 	rtdm_event_init(&ctx->event, 0);
>=20
> 	rc =3D rtdm_timer_start(&ctx->timer,
> 			      rtdm_clock_read_monotonic() + 100000000,
> 			      0, RTDM_TIMERMODE_ABSOLUTE);
> 	if (rc < 0) {
> 		rtdm_timer_destroy(&ctx->timer);
> 		rtdm_event_destroy(&ctx->event);
> 		return rc;
> 	}
>=20
> 	return 0;
> }
>=20
> static int test_close(struct rtdm_dev_context *context,
> 		      rtdm_user_info_t *user_info)
> {
> 	struct device_ctx *ctx =3D (struct device_ctx *)context->dev_private;
>=20
> 	rtdm_timer_destroy(&ctx->timer);
> 	rtdm_event_destroy(&ctx->event);
>=20
> 	return 0;
> }
>=20
> static ssize_t test_read(struct rtdm_dev_context *context,
> 			 rtdm_user_info_t *user_info, void *buf, size_t size)
> {
> 	struct device_ctx *ctx =3D (struct device_ctx *)context->dev_private;
> 	rtdm_toseq_t to;
> 	ssize_t rc;
>=20
> 	rtdm_toseq_init(&to, 1000000000);
>=20
> 	rc =3D rtdm_event_timedwait(&ctx->event, 1000000000, &to);
> 	printk("rtdm_event_timedwait: %d\n", rc);
>=20
> 	return rc;
> }
>=20
> static struct rtdm_device device =3D {
> 	struct_version: RTDM_DEVICE_STRUCT_VER,
>=20
> 	device_flags: RTDM_NAMED_DEVICE,
> 	context_size: sizeof(struct device_ctx),
> 	device_name:  "test",
>=20
> 	open_rt: NULL,
> 	open_nrt: test_open,
>=20
> 	ops: {
> 		close_rt: NULL,
> 		close_nrt: test_close,
>=20
> 		ioctl_rt: NULL,
> 		ioctl_nrt: NULL,
>=20
> 		read_rt: test_read,
> 		read_nrt: NULL,
>=20
> 		write_rt: NULL,
> 		write_nrt: NULL,
>=20
> 		recvmsg_rt: NULL,
> 		recvmsg_nrt: NULL,
>=20
> 		sendmsg_rt: NULL,
> 		sendmsg_nrt: NULL,
> 	},
>=20
> 	device_class: RTDM_CLASS_EXPERIMENTAL,
> 	device_sub_class: 0,
> 	profile_version: 1,
> 	driver_name: "xeno_switchtest",
> 	driver_version: RTDM_DRIVER_VER(0, 1, 1),
> 	peripheral_name: "Context Switch Test",
> 	provider_name: "Gilles Chanteperdrix",
> 	proc_name: device.device_name,
> };
>=20
> int __init rtdm_test_init(void)
> {
> 	return rtdm_dev_register(&device);
> }
>=20
> void rtdm_test_exit(void)
> {
> 	rtdm_dev_unregister(&device, 1000);
> }
>=20
> module_init(rtdm_test_init);
> module_exit(rtdm_test_exit);
>=20
> Application code:
> #include <stdio.h>
> #include <stdlib.h>
>=20
> #include <unistd.h>
> #include <sys/fcntl.h>
> #include <sys/mman.h>
>=20
> int main(void)
> {
> 	int i, rc, fd;
>=20
> 	mlockall(MCL_CURRENT | MCL_FUTURE);
>=20
> 	fd =3D open("/dev/test", O_RDONLY);
> 	if (fd < 0) {
> 		perror("open(rtdm_test)");
> 		return EXIT_FAILURE;
> 	}
>=20
> 	for (i =3D 0; i < 10; i++) {
> 		char buf[40];
>=20
> 		rc =3D read(fd, buf, sizeof(buf));
> 		if (rc < 0) {
> 			perror("read");
> 			pause();
> 			return EXIT_FAILURE;
> 		}
> 	}
>=20
> 	return EXIT_SUCCESS;
> }

