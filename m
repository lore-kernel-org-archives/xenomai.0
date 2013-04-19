Message-ID: <51713A81.7030704@arcor.de>
Date: Fri, 19 Apr 2013 14:37:21 +0200
From: Christopher Hahn <hahnchristopher@arcor.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-15"; Format="flowed"
Subject: [Xenomai] xeno_16550A: only 115200 Baud possible
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

I tried to send a message over a rt serial interface. Without the =

xeno_16550A module loaded everything works fine.

My steps are:

# deactive default serial port
setserial /dev/ttyS1 uart none

# load real-time serial driver module
modprobe xeno_16550A io=3D0x2f8 irq=3D3 baud_base=3D9600

then I get my rtser0 interface.

Then I try to configure the serial interface with:

static const struct rtser_config serial_config =3D {
         .config_mask       =3D 0xFFFF,
         .baud_rate         =3D 9600,
         .parity            =3D RTSER_NO_PARITY,
         .data_bits         =3D RTSER_8_BITS,
         .stop_bits         =3D RTSER_1_STOPB,
         .handshake         =3D RTSER_DEF_HAND,
         .fifo_depth        =3D RTSER_DEF_FIFO_DEPTH,
         .rx_timeout        =3D RTSER_DEF_TIMEOUT,
         .tx_timeout        =3D RTSER_DEF_TIMEOUT,
         .event_timeout     =3D RTSER_DEF_TIMEOUT,
         .timestamp_history =3D RTSER_DEF_TIMESTAMP_HISTORY,
         .event_mask        =3D RTSER_EVENT_RXPEND,
     };


and send a message with

written =3D rt_dev_write(serial_fd, sendmsg, sizeof(sendmsg));


Now I connect the other end of my serial cable to my notebook, start =

putty with COM1 9600-8-N-1 and only get rubbish. I have to change the =

baudrate in putty to 115200 to receive the correct message!

So far, so bad, BUT now I reset everything... unload xeno_16550A module =

and configure the serial port again:
#unload xeno_16550A module
rmmod xeno_16550A

#configure ttyS1
setserial /dev/ttyS1 uart 16550A base_baud 9600

and try to send again with 9600 baud and with the ordinary serial driver =

-> only rubbish on the other side (9600 Baud)

I also have to configure putty to 115200 baud to receive the message.

Do you have any idea?







-------------- next part --------------
#include <stdio.h>
#include <signal.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/mman.h>


#include <rtdk.h>
#include <rtdm/rtserial.h>
#include <native/task.h>


static const struct rtser_config serial_config =3D {
		.config_mask       =3D 0xFFFF,
		.baud_rate         =3D 9600,
		.parity            =3D RTSER_NO_PARITY,
		.data_bits         =3D RTSER_8_BITS,
		.stop_bits         =3D RTSER_1_STOPB,
		.handshake         =3D RTSER_DEF_HAND,
		.fifo_depth        =3D RTSER_DEF_FIFO_DEPTH,
		.rx_timeout        =3D RTSER_DEF_TIMEOUT,
		.tx_timeout        =3D RTSER_DEF_TIMEOUT,
		.event_timeout     =3D RTSER_DEF_TIMEOUT, /* 1 s */
		.timestamp_history =3D RTSER_DEF_TIMESTAMP_HISTORY,
		.event_mask        =3D RTSER_EVENT_RXPEND,
	};

#define WRITE_FILE     "rtser0"

#define DEBUG 1
#define TASK_PREFIX "Serial_write: "

int serial_fd =3D -1;

RT_TASK write_task;

void catch_signal(int sig) {
	rt_printf("exit\n");
	exit(0);
}

void write_task_proc(void *arg) {
	int err;
	unsigned long ov;
	char sendmsg[5] =3D "G3\r";
	ssize_t written =3D 0;

	/*
	 * make this task periodic
	 */
	rt_task_set_periodic(NULL, TM_NOW, (1000 * 1e6)); // 1000ms

	while (1) {

		written =3D rt_dev_write(serial_fd, sendmsg, sizeof(sendmsg));
		if (written < 0) {
			rt_printf(TASK_PREFIX "error on rt_dev_write, %s\n", strerror(-err));
			break;
		} else if (written !=3D sizeof(sendmsg)) {
			rt_printf(TASK_PREFIX "only %d / %d byte transmitted\n", written, sizeof=
(sendmsg));
			break;
		}

		if (DEBUG)
			rt_printf("send: '%s'\n", sendmsg);

		err =3D rt_task_wait_period(&ov);
		if (err) {
			rt_fprintf(stderr, TASK_PREFIX "rt_task_wait_period: %s\n", strerror(-er=
r));
		}

		if (ov >=3D 1) {
			rt_printf(TASK_PREFIX "OVERRUN!\n");
			break;
		}

	}

	rt_printf(TASK_PREFIX "exit\n");
}

int initSerial(void) {
	int err =3D 0;

	/* open rtser0 */
	serial_fd =3D rt_dev_open(WRITE_FILE, 0);
	if (serial_fd < 0) {

		rt_printf(TASK_PREFIX "can't open %s (read), %s\n", WRITE_FILE, strerror(=
-serial_fd));

		return -serial_fd;
	}

	if (DEBUG)
		rt_printf(TASK_PREFIX "read-file opened\n");

	/* writing serial-config */
	err =3D rt_dev_ioctl(serial_fd, RTSER_RTIOC_SET_CONFIG, &serial_config);
	if (err) {

		rt_printf(TASK_PREFIX "error while rt_dev_ioctl, %s\n", strerror(-err));

		return err;
	}

	if (DEBUG)
		rt_printf(TASK_PREFIX "serial_config_init written\n");

	return 0;
}

int main(void) {
    int err =3D 0;

    signal(SIGTERM, catch_signal);
	signal(SIGINT, catch_signal);

	/* Perform auto-init of rt_print buffers if the task doesn't do so */
	rt_print_auto_init(1);

	/* no memory-swapping for this programm */
	mlockall(MCL_CURRENT | MCL_FUTURE);

	/*
	 * initalize serial device
	 */
	err =3D initSerial();
	if (err) {
		rt_printf(TASK_PREFIX "failed to initialize serial port, %s\n", strerror(=
-err));
		return 0;
	}

	/* create write_task */
	err =3D rt_task_create(&write_task, "write_task", 0, 99, 0);
	if (err) {
		rt_printf(TASK_PREFIX "failed to create read_task, %s\n", strerror(-err));
		return 0;
	}
	if (DEBUG) rt_printf(TASK_PREFIX "write-task created\n");

	/* start write_task */
	if (DEBUG) rt_printf(TASK_PREFIX "starting write-task\n");
	err =3D rt_task_start(&write_task, &write_task_proc, NULL );
	if (err) {
		rt_printf(TASK_PREFIX "failed to start write_task, %s\n", strerror(-err));
		return 0;
	}
	if (DEBUG) rt_printf(TASK_PREFIX "write-task started\n");

	pause();
	return 0;

}




