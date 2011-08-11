Message-ID: <4E442EB0.7030909@domain.hid>
Date: Thu, 11 Aug 2011 21:34:08 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <201108101449.54243.carlosnov@domain.hid>
	<201108111456.24208.carlosnov@domain.hid>
	<4E4418EE.8000005@domain.hid>
	<201108111512.40209.carlosnov@domain.hid>
In-Reply-To: <201108111512.40209.carlosnov@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Trouble with rtdm timers and events
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Carlos Eduardo de Brito Novaes <carlosnov@domain.hid>
Cc: xenomai@xenomai.org

On 08/11/2011 08:12 PM, Carlos Eduardo de Brito Novaes wrote:
> I really did not understand why nor even what exactly it means to overflow the 
> source area, but I forgot to mention that I commented it out, so the 
> copy_to_user is not being called at all.

It means that sizeof(sample_number) is 40, and neither the zone you are
copying from, neither the zone you are copying to is 40 bytes large
(except for the first call to read).

Also, there is no problem starting a timer in open_nrt and close_nrt
handlers.

So, here is a simple self-contained testcase which does what you are
trying to do. And which works. So, I insist, you should really inspect
your code carefully, the bugs you have do not seem to come from xenomai.

Module code:
#include <rtdm/rtdm_driver.h>

struct device_ctx {
	rtdm_event_t event;
	rtdm_timer_t timer;
};

MODULE_LICENSE("GPL");
MODULE_AUTHOR("gch");

static void test_timer(rtdm_timer_t *timer)
{
	struct device_ctx *ctx = container_of(timer, struct device_ctx, timer);

	rtdm_event_pulse(&ctx->event);
	rtdm_timer_start_in_handler(&ctx->timer,
			      rtdm_clock_read_monotonic() + 100000000,
			      0, RTDM_TIMERMODE_ABSOLUTE);
}

static int test_open(struct rtdm_dev_context *context,
		     rtdm_user_info_t *user_info,
		     int oflags)
{
	struct device_ctx *ctx = (struct device_ctx *)context->dev_private;
	int rc;

	rc = rtdm_timer_init(&ctx->timer, test_timer, "timer");
	if (rc < 0)
		return rc;

	rtdm_event_init(&ctx->event, 0);

	rc = rtdm_timer_start(&ctx->timer,
			      rtdm_clock_read_monotonic() + 100000000,
			      0, RTDM_TIMERMODE_ABSOLUTE);
	if (rc < 0) {
		rtdm_timer_destroy(&ctx->timer);
		rtdm_event_destroy(&ctx->event);
		return rc;
	}

	return 0;
}

static int test_close(struct rtdm_dev_context *context,
		      rtdm_user_info_t *user_info)
{
	struct device_ctx *ctx = (struct device_ctx *)context->dev_private;

	rtdm_timer_destroy(&ctx->timer);
	rtdm_event_destroy(&ctx->event);

	return 0;
}

static ssize_t test_read(struct rtdm_dev_context *context,
			 rtdm_user_info_t *user_info, void *buf, size_t size)
{
	struct device_ctx *ctx = (struct device_ctx *)context->dev_private;
	rtdm_toseq_t to;
	ssize_t rc;

	rtdm_toseq_init(&to, 1000000000);

	rc = rtdm_event_timedwait(&ctx->event, 1000000000, &to);
	printk("rtdm_event_timedwait: %d\n", rc);

	return rc;
}

static struct rtdm_device device = {
	struct_version: RTDM_DEVICE_STRUCT_VER,

	device_flags: RTDM_NAMED_DEVICE,
	context_size: sizeof(struct device_ctx),
	device_name:  "test",

	open_rt: NULL,
	open_nrt: test_open,

	ops: {
		close_rt: NULL,
		close_nrt: test_close,

		ioctl_rt: NULL,
		ioctl_nrt: NULL,

		read_rt: test_read,
		read_nrt: NULL,

		write_rt: NULL,
		write_nrt: NULL,

		recvmsg_rt: NULL,
		recvmsg_nrt: NULL,

		sendmsg_rt: NULL,
		sendmsg_nrt: NULL,
	},

	device_class: RTDM_CLASS_EXPERIMENTAL,
	device_sub_class: 0,
	profile_version: 1,
	driver_name: "xeno_switchtest",
	driver_version: RTDM_DRIVER_VER(0, 1, 1),
	peripheral_name: "Context Switch Test",
	provider_name: "Gilles Chanteperdrix",
	proc_name: device.device_name,
};

int __init rtdm_test_init(void)
{
	return rtdm_dev_register(&device);
}

void rtdm_test_exit(void)
{
	rtdm_dev_unregister(&device, 1000);
}

module_init(rtdm_test_init);
module_exit(rtdm_test_exit);

Application code:
#include <stdio.h>
#include <stdlib.h>

#include <unistd.h>
#include <sys/fcntl.h>
#include <sys/mman.h>

int main(void)
{
	int i, rc, fd;

	mlockall(MCL_CURRENT | MCL_FUTURE);

	fd = open("/dev/test", O_RDONLY);
	if (fd < 0) {
		perror("open(rtdm_test)");
		return EXIT_FAILURE;
	}

	for (i = 0; i < 10; i++) {
		char buf[40];

		rc = read(fd, buf, sizeof(buf));
		if (rc < 0) {
			perror("read");
			pause();
			return EXIT_FAILURE;
		}
	}

	return EXIT_SUCCESS;
}

-- 
                                                                Gilles.

