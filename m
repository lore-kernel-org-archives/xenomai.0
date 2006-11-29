Message-ID: <456E122F.5030406@domain.hid>
Date: Thu, 30 Nov 2006 00:05:19 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [RFC] Xenomai examples repository
References: <456D6451.3030705@domain.hid> <1164824900.4973.262.camel@domain.hid>
In-Reply-To: <1164824900.4973.262.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigED09A9628A98733A15B64EAA"
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
To: rpm@xenomai.org
Cc: xenomai-help <xenomai@xenomai.org>, xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigED09A9628A98733A15B64EAA
Content-Type: multipart/mixed; boundary="------------080801050705040108020904"

This is a multi-part message in MIME format.
--------------080801050705040108020904
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Wed, 2006-11-29 at 11:43 +0100, Jan Kiszka wrote:
>> Hi,
>>
>> we had this topic a few times before, but it's getting more and more
>> urgent now: How to establish a repository for Xenomai example code?
>>
>> I think we have basically two options:
>>
>>  A) create /examples/<skin>, including /examples/rtdm/<profile> in the=

>>     SVN
>>
>>  B) create corresponding pages in the wiki
>>
>> Option A) has the advantage that we could easily integrate the example=

>> build in the regular build process (when building SVN check-outs), tra=
ck
>> API changes, and keep the examples in sync that way.
>>
>> Option B) would be easier to maintain by non-core developers as the wi=
ki
>> is open for anyone. Both options require some review of the examples
>> anyway, but B) would allow to relax the process a bit.
>>
>=20
> Nothing prevents to have both. A set of canonical examples carefully
> maintained with the core, and a Wiki area for keeping a slew of hands-o=
n
> examples.
>=20

To give it a start (and finally establish the infrastructure), I
copied/reformatted some existing examples and created a simple,
self-contained build system around them. The directory structure would
be as I suggested:

/examples/native/...
/examples/posix/...
/examples/...
/examples/rtdm/generic/...
/examples/rtdm/serial/...
/examples/rtdm/...

I derived a generic Makefiles from my own one for tests (which was in
turn derived from previous work by Hannes Mayer). It can compile a given
list of user space applications and kernel modules (2.4 and 2.6) against
some Xenomai installation (make XENO=3D..., unless xeno-config is already=

in $PATH) or a Xenomai-kernel (make KSRC=3D...). Moreover, there is simpl=
e
Makefile under /examples just to kick building/cleaning of all subdirs
at once.

If it's OK for everyone, I would check this into trunk. We could then
migrate existing demo code and snippets over and add new stuff as it
pops up, both hopefully with the help of interested users.

Jan

--------------080801050705040108020904
Content-Type: text/plain;
 name="examples.repos"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="examples.repos"

Index: examples/rtdm/serial/cross-link.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- examples/rtdm/serial/cross-link.c	(Revision 0)
+++ examples/rtdm/serial/cross-link.c	(Revision 0)
@@ -0,0 +1,336 @@
+/*
+ * cross-link.c
+ *
+ * Userspace test program (Xenomai native skin) for RTDM-based UART driv=
ers
+ * Copyright 2005 by Joerg Langenberg <joergel75@domain.hid>
+ *
+ * Updates by Jan Kiszka <jan.kiszka@domain.hid>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+#include <stdio.h>
+#include <signal.h>
+#include <unistd.h>
+#include <sys/mman.h>
+
+#include <native/task.h>
+#include <native/timer.h>
+
+#include <rtdm/rtserial.h>
+
+#define MAIN_PREFIX   "main : "
+#define WTASK_PREFIX  "write_task: "
+#define RTASK_PREFIX  "read_task: "
+
+#define WRITE_FILE    "rtser0"
+#define READ_FILE     "rtser1"
+
+int read_fd  =3D -1;
+int write_fd =3D -1;
+
+#define STATE_FILE_OPENED         1
+#define STATE_TASK_CREATED        2
+
+unsigned int read_state =3D 0;
+unsigned int write_state =3D 0;
+
+/*                           --s-ms-us-ns */
+RTIME write_task_period_ns =3D    100000000llu;
+RT_TASK write_task;
+RT_TASK read_task;
+
+static const struct rtser_config read_config =3D {
+	0xFFFF,                     /* config_mask */
+	115200,                     /* baud_rate */
+	RTSER_DEF_PARITY,           /* parity */
+	RTSER_DEF_BITS,             /* data_bits */
+	RTSER_DEF_STOPB,            /* stop_bits */
+	RTSER_DEF_HAND,             /* handshake */
+	RTSER_DEF_FIFO_DEPTH,       /* fifo_depth*/
+	RTSER_DEF_TIMEOUT,          /* rx_timeout */
+	RTSER_DEF_TIMEOUT,          /* tx_timeout */
+	RTSER_DEF_TIMEOUT,          /* event_timeout */
+	RTSER_RX_TIMESTAMP_HISTORY, /* timestamp_history */
+	RTSER_EVENT_RXPEND          /* event mask */
+};
+
+static const struct rtser_config write_config =3D {
+	0xFFFF,                     /* config_mask */
+	115200,                     /* baud_rate */
+	RTSER_DEF_PARITY,           /* parity */
+	RTSER_DEF_BITS,             /* data_bits */
+	RTSER_DEF_STOPB,            /* stop_bits */
+	RTSER_DEF_HAND,             /* handshake */
+	RTSER_DEF_FIFO_DEPTH,       /* fifo_depth*/
+	RTSER_DEF_TIMEOUT,          /* rx_timeout */
+	RTSER_DEF_TIMEOUT,          /* tx_timeout */
+	RTSER_DEF_TIMEOUT,          /* event_timeout */
+	RTSER_DEF_TIMESTAMP_HISTORY /* timestamp_history */
+};
+
+static int close_file( int fd, char *name)
+{
+	int err, i=3D0;
+=09
+	do {
+		i++;
+		err =3D rt_dev_close(fd);
+		switch (err) {
+		case -EAGAIN:
+			printf(MAIN_PREFIX "%s -> EAGAIN (%d times)\n",
+			       name, i);
+			rt_task_sleep(50000); /* wait 50us */
+			break;
+		case 0:
+			printf(MAIN_PREFIX "%s -> closed\n", name);
+			break;
+		default:
+			printf(MAIN_PREFIX "%s -> %s\n", name,
+			       strerror(-err));
+			break;
+		}
+	} while (err =3D=3D -EAGAIN && i < 10);
+
+	return err;
+}
+
+void cleanup_all(void)
+{
+	if (read_state & STATE_FILE_OPENED) {
+		close_file(read_fd, READ_FILE" (read)");
+		read_state &=3D ~STATE_FILE_OPENED;
+	}
+=09
+	if (write_state & STATE_FILE_OPENED) {
+		close_file(write_fd, WRITE_FILE " (write)");
+		write_state &=3D ~STATE_FILE_OPENED;
+	}
+=09
+	if (write_state & STATE_TASK_CREATED) {
+		printf(MAIN_PREFIX "delete write_task\n");
+		rt_task_delete(&write_task);
+		write_state &=3D ~STATE_TASK_CREATED;
+	}
+=09
+	if (read_state & STATE_TASK_CREATED) {
+		printf(MAIN_PREFIX "delete read_task\n");
+		rt_task_delete(&read_task);
+		read_state &=3D ~STATE_TASK_CREATED;
+	}
+}
+
+void catch_signal(int sig)
+{
+	cleanup_all();
+	printf(MAIN_PREFIX "exit\n");
+	return;
+}
+
+void write_task_proc(void *arg)
+{
+	int err;
+	RTIME write_time;
+	ssize_t sz =3D sizeof(RTIME);
+	ssize_t written =3D 0;
+
+	err =3D rt_task_set_periodic(NULL, TM_NOW,
+				   rt_timer_ns2ticks(write_task_period_ns));
+	if (err) {
+		printf(WTASK_PREFIX "error on set periodic, %s\n",
+		       strerror(-err));
+		goto exit_write_task;
+	}
+
+	while (1) {
+		err =3D rt_task_wait_period(NULL);
+		if (err) {
+			printf(WTASK_PREFIX
+			       "error on rt_task_wait_period, %s\n",
+			       strerror(-err));
+			break;
+		}
+=09
+		write_time =3D rt_timer_read();
+
+		written =3D rt_dev_write(write_fd, &write_time, sz);
+		if (written < 0 ) {
+			printf(WTASK_PREFIX "error on rt_dev_write, %s\n",
+			       strerror(-err));
+			break;
+		} else if (written !=3D sz) {
+			printf(WTASK_PREFIX "only %d / %d byte transmitted\n",
+			       written, sz);
+			break;
+		}
+	}
+
+ exit_write_task:
+	if ((write_state & STATE_FILE_OPENED) &&
+	    close_file(write_fd, WRITE_FILE " (write)") =3D=3D 0)
+		write_state &=3D ~STATE_FILE_OPENED;
+
+	printf(WTASK_PREFIX "exit\n");
+}
+
+void read_task_proc(void *arg)
+{
+	int err;
+	int nr =3D 0;
+	RTIME read_time  =3D 0;
+	RTIME write_time =3D 0;
+	RTIME irq_time   =3D 0;
+	ssize_t sz =3D sizeof(RTIME);
+	ssize_t read =3D 0;
+	struct rtser_event rx_event;
+=09
+	printf(" Nr |   write->irq    |    irq->read    |   write->read   |\n")=
;
+	printf("-----------------------------------------------------------\n")=
;
+
+	/*
+	 * We are in secondary mode now due to printf, the next
+	 * blocking Xenomai or driver call will switch us back
+	 * (here: RTSER_RTIOC_WAIT_EVENT).
+	 */
+
+	while (1) {
+		/* waiting for event */
+		err =3D rt_dev_ioctl(read_fd, RTSER_RTIOC_WAIT_EVENT, &rx_event);
+		if (err) {
+			printf(RTASK_PREFIX
+			       "error on RTSER_RTIOC_WAIT_EVENT, %s\n",
+			       strerror(-err));
+			break;
+		}
+=09
+		irq_time =3D rx_event.rxpend_timestamp;
+		read =3D rt_dev_read(read_fd, &write_time, sz);
+		if (read =3D=3D sz) {
+			read_time =3D rt_timer_read();
+			printf("%3d |%16llu |%16llu |%16llu\n", nr,
+			       irq_time  - write_time,
+			       read_time - irq_time,
+			       read_time - write_time);
+			nr++;
+		} if (read < 0 ) {
+			printf(RTASK_PREFIX "error on rt_dev_read, code %s\n",
+			       strerror(-err));
+			break;
+		} else {
+			printf(RTASK_PREFIX "only %d / %d byte received \n",
+			       read, sz);
+			break;
+		}
+	}
+
+	if ((read_state & STATE_FILE_OPENED) &&
+	    close_file(read_fd, READ_FILE " (read)") =3D=3D 0)
+		read_state &=3D ~STATE_FILE_OPENED;
+
+	printf(RTASK_PREFIX "exit\n");
+}
+
+int main(int argc, char* argv[])
+{
+	int err =3D 0;
+
+	signal(SIGTERM, catch_signal);
+	signal(SIGINT, catch_signal);
+
+	/* no memory-swapping for this programm */
+	mlockall(MCL_CURRENT | MCL_FUTURE);
+
+	/* open rtser0 */
+	write_fd =3D rt_dev_open( WRITE_FILE, 0);
+	if (write_fd < 0) {
+		printf(MAIN_PREFIX "can't open %s (write), %s\n", WRITE_FILE,
+		       strerror(-err));
+		goto error;
+	}
+	write_state |=3D STATE_FILE_OPENED;
+	printf(MAIN_PREFIX "write-file opened\n");
+
+	/* writing write-config */
+	err =3D rt_dev_ioctl(write_fd, RTSER_RTIOC_SET_CONFIG, &write_config);
+	if (err) {
+		printf(MAIN_PREFIX "error while RTSER_RTIOC_SET_CONFIG, %s\n",
+		       strerror(-err));
+		goto error;
+	}
+	printf(MAIN_PREFIX "write-config written\n");
+
+	/* open rtser1 */
+	read_fd =3D rt_dev_open( READ_FILE, 0 );
+	if (read_fd < 0) {
+		printf(MAIN_PREFIX "can't open %s (read), %s\n", READ_FILE,
+		       strerror(-err));
+		goto error;
+	}
+	read_state |=3D STATE_FILE_OPENED;
+	printf(MAIN_PREFIX "read-file opened\n");
+
+	/* writing read-config */
+	err =3D rt_dev_ioctl(read_fd, RTSER_RTIOC_SET_CONFIG, &read_config);
+	if (err) {
+		printf(MAIN_PREFIX "error while rt_dev_ioctl, %s\n",
+		       strerror(-err));
+		goto error;
+	}
+	printf(MAIN_PREFIX "read-config written\n");
+
+	/* create write_task */
+	err =3D rt_task_create(&write_task, "write_task", 0, 50, 0);
+	if (err) {
+		printf(MAIN_PREFIX "failed to create write_task, %s\n",
+		       strerror(-err));
+		goto error;
+	}
+	write_state |=3D STATE_TASK_CREATED;
+	printf(MAIN_PREFIX "write-task created\n");
+
+	/* create read_task */
+	err =3D rt_task_create(&read_task, "read_task", 0, 51, 0);
+	if (err) {
+		printf(MAIN_PREFIX "failed to create read_task, %s\n",
+		       strerror(-err));
+		goto error;
+	}
+	read_state |=3D STATE_TASK_CREATED;
+	printf(MAIN_PREFIX "read-task created\n");
+
+	/* start write_task */
+	printf(MAIN_PREFIX "starting write-task\n");
+	err =3D rt_task_start(&write_task, &write_task_proc, NULL);
+	if (err) {
+		printf(MAIN_PREFIX "failed to start write_task, %s\n",
+		       strerror(-err));
+		goto error;
+	}
+
+	/* start read_task */
+	printf(MAIN_PREFIX "starting read-task\n");
+	err =3D rt_task_start(&read_task,&read_task_proc,NULL);
+	if (err) {
+		printf(MAIN_PREFIX "failed to start read_task, %s\n",
+		       strerror(-err));
+		goto error;
+	}
+
+	pause();
+	return 0;
+
+ error:
+	cleanup_all();
+	return err;
+}
Index: examples/rtdm/serial/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- examples/rtdm/serial/Makefile	(Revision 0)
+++ examples/rtdm/serial/Makefile	(Revision 0)
@@ -0,0 +1,76 @@
+###### CONFIGURATION ######
+
+### List of applications to be build
+APPLICATIONS =3D cross-link
+
+### Note: to override the search path for the xeno-config script, use "m=
ake XENO=3D..."
+
+
+### List of modules to be build
+MODULES =3D
+
+### Default to sources of currently running kernel
+KSRC ?=3D /lib/modules/$(shell uname -r)/build
+
+### Note: to override the kernel source path, use "make KSRC=3D..."
+
+
+
+###### USER SPACE BUILD (no change required normally) ######
+ifneq ($(APPLICATIONS),)
+
+XENOCONFIG=3D$(shell PATH=3D$(XENO):$(XENO)/bin:$(PATH) which xeno-confi=
g 2>/dev/null)
+
+### Sanity check
+ifeq ($(XENOCONFIG),)
+all::
+	@echo ">>> Invoke make like this: \"make XENO=3D/path/to/xeno-config\" =
<<<"
+	@echo
+endif
+
+
+CFLAGS=3D$(shell $(XENOCONFIG) --xeno-cflags) $(MY_CFLAGS)
+
+LDFLAGS=3D$(shell $(XENOCONFIG) --xeno-ldflags) $(MY_LDFLAGS) -lnative -=
lrtdm
+
+all:: $(APPLICATIONS)
+
+clean::
+	$(RM) $(APPLICATIONS) *.o
+
+endif
+
+
+
+###### KERNEL MODULE BUILD (no change required normally) ######
+ifneq ($(MODULES),)
+
+OBJS     :=3D ${patsubst %, %.o, $(MODULES)}
+CLEANMOD :=3D ${patsubst %, .%*, $(MODULES)}
+
+# Kernel 2.6
+ifeq ($(findstring 2.6,$(KSRC)),2.6)
+
+obj-m        :=3D $(OBJS)
+EXTRA_CFLAGS :=3D -I$(KSRC)/include/xenomai -I$(KSRC)/include/xenomai/po=
six $(ADD_CFLAGS)
+PWD          :=3D $(shell pwd)
+
+all::
+	$(MAKE) -C $(KSRC) SUBDIRS=3D$(PWD) modules
+
+# Kernel 2.4
+else
+
+INCLUDE :=3D -I$(KSRC)/include -I$(KSRC)/include/xenomai -I$(KSRC)/inclu=
de/xenomai/compat -I$(KSRC)/include/xenomai/posix
+CFLAGS  +=3D -O2 -Wall -Wstrict-prototypes -Wno-trigraphs -DMODULE -D__K=
ERNEL__ -DLINUX \
+           -fno-strict-aliasing -fno-common $(INCLUDE) $(ADD_CFLAGS)
+
+all:: $(OBJS)
+
+endif
+
+clean::
+	$(RM) $(CLEANMOD) *.cmd *.o *.ko *.mod.c Module*.symvers
+	$(RM) -R .tmp*
+
+endif
Index: examples/rtdm/generic/heartbeat.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- examples/rtdm/generic/heartbeat.c	(Revision 0)
+++ examples/rtdm/generic/heartbeat.c	(Revision 0)
@@ -0,0 +1,69 @@
+/*
+ * Simple RTDM demo that generates a running light on your PC keyboard.
+ * Copyright (C) 2005 Jan Kiszka <jan.kiszka-at-web.de>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with rtaisec-reloaded; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
+ * 02111-1307, USA.
+ */
+
+#include <rtdm/rtdm_driver.h>
+
+MODULE_LICENSE("GPL");
+
+rtdm_task_t heartbeat_task;
+int         end =3D 0;
+
+#define HEARTBEAT_PERIOD    100000000   /* 100 ms */
+
+void set_leds(int mask)
+{
+	while (inb(0x64) & 2);
+	outb(0xED, 0x60);
+	while (!(inb(0x64) & 1));
+	inb(0x60);
+	while (inb(0x64) & 2);
+	outb(mask, 0x60);
+	while (!(inb(0x64) & 1));
+	inb(0x60);
+}
+
+void heartbeat(void *cookie)
+{
+	int state =3D 0;
+	int led_state[] =3D { 0x00, 0x01, 0x05, 0x07, 0x06, 0x02, 0x00 };
+
+
+	while (!end) {
+		rtdm_task_wait_period();
+=09
+		set_leds(led_state[state++]);
+=09
+		if (state > 6)
+			state =3D 0;
+	}
+}
+
+int init_module(void)
+{
+	return rtdm_task_init(&heartbeat_task, "heartbeat", heartbeat, NULL,
+			      99, HEARTBEAT_PERIOD);
+}
+
+void cleanup_module(void)
+{
+	end =3D 1;
+	rtdm_task_join_nrt(&heartbeat_task, 100);
+	set_leds(0);
+}
Index: examples/rtdm/generic/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- examples/rtdm/generic/Makefile	(Revision 0)
+++ examples/rtdm/generic/Makefile	(Revision 0)
@@ -0,0 +1,76 @@
+###### CONFIGURATION ######
+
+### List of applications to be build
+APPLICATIONS =3D
+
+### Note: to override the search path for the xeno-config script, use "m=
ake XENO=3D..."
+
+
+### List of modules to be build
+MODULES =3D heartbeat
+
+### Default to sources of currently running kernel
+KSRC ?=3D /lib/modules/$(shell uname -r)/build
+
+### Note: to override the kernel source path, use "make KSRC=3D..."
+
+
+
+###### USER SPACE BUILD (no change required normally) ######
+ifneq ($(APPLICATIONS),)
+
+XENOCONFIG=3D$(shell PATH=3D$(XENO):$(XENO)/bin:$(PATH) which xeno-confi=
g 2>/dev/null)
+
+### Sanity check
+ifeq ($(XENOCONFIG),)
+all::
+	@echo ">>> Invoke make like this: \"make XENO=3D/path/to/xeno-config\" =
<<<"
+	@echo
+endif
+
+
+CFLAGS=3D$(shell $(XENOCONFIG) --xeno-cflags) $(MY_CFLAGS)
+
+LDFLAGS=3D$(shell $(XENOCONFIG) --xeno-ldflags) $(MY_LDFLAGS) -lnative -=
lrtdm
+
+all:: $(APPLICATIONS)
+
+clean::
+	$(RM) $(APPLICATIONS) *.o
+
+endif
+
+
+
+###### KERNEL MODULE BUILD (no change required normally) ######
+ifneq ($(MODULES),)
+
+OBJS     :=3D ${patsubst %, %.o, $(MODULES)}
+CLEANMOD :=3D ${patsubst %, .%*, $(MODULES)}
+
+# Kernel 2.6
+ifeq ($(findstring 2.6,$(KSRC)),2.6)
+
+obj-m        :=3D $(OBJS)
+EXTRA_CFLAGS :=3D -I$(KSRC)/include/xenomai -I$(KSRC)/include/xenomai/po=
six $(ADD_CFLAGS)
+PWD          :=3D $(shell pwd)
+
+all::
+	$(MAKE) -C $(KSRC) SUBDIRS=3D$(PWD) modules
+
+# Kernel 2.4
+else
+
+INCLUDE :=3D -I$(KSRC)/include -I$(KSRC)/include/xenomai -I$(KSRC)/inclu=
de/xenomai/compat -I$(KSRC)/include/xenomai/posix
+CFLAGS  +=3D -O2 -Wall -Wstrict-prototypes -Wno-trigraphs -DMODULE -D__K=
ERNEL__ -DLINUX \
+           -fno-strict-aliasing -fno-common $(INCLUDE) $(ADD_CFLAGS)
+
+all:: $(OBJS)
+
+endif
+
+clean::
+	$(RM) $(CLEANMOD) *.cmd *.o *.ko *.mod.c Module*.symvers
+	$(RM) -R .tmp*
+
+endif
Index: examples/native/sigxcpu.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- examples/native/sigxcpu.c	(Revision 0)
+++ examples/native/sigxcpu.c	(Revision 0)
@@ -0,0 +1,67 @@
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include <signal.h>
+#include <getopt.h>
+#include <execinfo.h>
+#include <native/task.h>
+
+RT_TASK task;
+
+void task_body (void *cookie)
+
+{
+    /* Ask Xenomai to warn us upon switches to secondary mode. */
+    rt_task_set_mode(0, T_WARNSW, NULL);
+
+    /* A real-time task always starts in primary mode. */
+
+    for (;;) {
+	rt_task_sleep(1000000000);
+        /* Running in primary mode... */
+	printf("Switched to secondary mode\n");
+        /* ...printf() =3D> write(2): we have just switched to secondary=

+	   mode: SIGXCPU should have been sent to us by now. */
+    }
+}
+
+void warn_upon_switch(int sig __attribute__((unused)))
+
+{
+    void *bt[32];
+    int nentries;
+
+    /* Dump a backtrace of the frame which caused the switch to
+       secondary mode: */
+    nentries =3D backtrace(bt,sizeof(bt) / sizeof(bt[0]));
+    backtrace_symbols_fd(bt,nentries,fileno(stdout));
+}
+
+int main (int argc, char **argv)
+
+{
+    int err;
+
+    signal(SIGXCPU, warn_upon_switch);
+
+    err =3D rt_task_create(&task,"mytask",0,1,T_FPU);
+
+    if (err)
+	{
+	fprintf(stderr,"failed to create task, code %d\n",err);
+	return 0;
+	}
+
+    err =3D rt_task_start(&task,&task_body,NULL);
+
+    if (err)
+	{
+	fprintf(stderr,"failed to start task, code %d\n",err);
+	return 0;
+	}
+
+    pause();
+
+    return 0;
+}
Index: examples/native/trivial-periodic.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- examples/native/trivial-periodic.c	(Revision 0)
+++ examples/native/trivial-periodic.c	(Revision 0)
@@ -0,0 +1,72 @@
+#include <stdio.h>
+#include <signal.h>
+#include <unistd.h>
+#include <sys/mman.h>
+
+#include <native/task.h>
+#include <native/timer.h>
+
+RT_TASK demo_task;
+
+/* NOTE: error handling omitted. */
+
+void demo(void *arg)
+{
+	RTIME now, previous;
+
+	/*
+	 * Arguments: &task (NULL=3Dself),
+	 *            start time,
+	 *            period (here: 1 s)
+	 */
+	rt_task_set_periodic(NULL, TM_NOW, 1000000000);
+	previous =3D rt_timer_read();
+
+	while (1) {
+		rt_task_wait_period(NULL);
+		now =3D rt_timer_read();
+
+		/*
+		 * NOTE: printf may have unexpected impact on the timing of
+		 *       your program. It is used here in the critical loop
+		 *       only for demonstration purposes.
+		 */
+		printf("Time since last turn: %ld.%06ld ms\n",
+		       (long)(now - previous) / 1000000,
+		       (long)(now - previous) % 1000000);
+		       previous =3D now;
+	}
+}
+
+void catch_signal(int sig)
+{
+}
+
+int main(int argc, char* argv[])
+{
+	signal(SIGTERM, catch_signal);
+	signal(SIGINT, catch_signal);
+
+	/* Avoids memory swapping for this program */
+	mlockall(MCL_CURRENT|MCL_FUTURE);
+
+	/*
+	 * Arguments: &task,
+	 *            name,
+	 *            stack size (0=3Ddefault),
+	 *            priority,
+	 *            mode (FPU, start suspended, ...)
+	 */
+	rt_task_create(&demo_task, "trivial", 0, 99, 0);
+
+	/*
+	 * Arguments: &task,
+	 *            task function,
+	 *            function argument
+	 */
+	rt_task_start(&demo_task, &demo, NULL);
+
+	pause();
+
+	rt_task_delete(&demo_task);
+}
Index: examples/native/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- examples/native/Makefile	(Revision 0)
+++ examples/native/Makefile	(Revision 0)
@@ -0,0 +1,76 @@
+###### CONFIGURATION ######
+
+### List of applications to be build
+APPLICATIONS =3D trivial-periodic sigxcpu
+
+### Note: to override the search path for the xeno-config script, use "m=
ake XENO=3D..."
+
+
+### List of modules to be build
+MODULES =3D
+
+### Default to sources of currently running kernel
+KSRC ?=3D /lib/modules/$(shell uname -r)/build
+
+### Note: to override the kernel source path, use "make KSRC=3D..."
+
+
+
+###### USER SPACE BUILD (no change required normally) ######
+ifneq ($(APPLICATIONS),)
+
+XENOCONFIG=3D$(shell PATH=3D$(XENO):$(XENO)/bin:$(PATH) which xeno-confi=
g 2>/dev/null)
+
+### Sanity check
+ifeq ($(XENOCONFIG),)
+all::
+	@echo ">>> Invoke make like this: \"make XENO=3D/path/to/xeno-config\" =
<<<"
+	@echo
+endif
+
+
+CFLAGS=3D$(shell $(XENOCONFIG) --xeno-cflags) $(MY_CFLAGS)
+
+LDFLAGS=3D$(shell $(XENOCONFIG) --xeno-ldflags) $(MY_LDFLAGS) -lnative
+
+all:: $(APPLICATIONS)
+
+clean::
+	$(RM) $(APPLICATIONS) *.o
+
+endif
+
+
+
+###### KERNEL MODULE BUILD (no change required normally) ######
+ifneq ($(MODULES),)
+
+OBJS     :=3D ${patsubst %, %.o, $(MODULES)}
+CLEANMOD :=3D ${patsubst %, .%*, $(MODULES)}
+
+# Kernel 2.6
+ifeq ($(findstring 2.6,$(KSRC)),2.6)
+
+obj-m        :=3D $(OBJS)
+EXTRA_CFLAGS :=3D -I$(KSRC)/include/xenomai -I$(KSRC)/include/xenomai/po=
six $(ADD_CFLAGS)
+PWD          :=3D $(shell pwd)
+
+all::
+	$(MAKE) -C $(KSRC) SUBDIRS=3D$(PWD) modules
+
+# Kernel 2.4
+else
+
+INCLUDE :=3D -I$(KSRC)/include -I$(KSRC)/include/xenomai -I$(KSRC)/inclu=
de/xenomai/compat -I$(KSRC)/include/xenomai/posix
+CFLAGS  +=3D -O2 -Wall -Wstrict-prototypes -Wno-trigraphs -DMODULE -D__K=
ERNEL__ -DLINUX \
+           -fno-strict-aliasing -fno-common $(INCLUDE) $(ADD_CFLAGS)
+
+all:: $(OBJS)
+
+endif
+
+clean::
+	$(RM) $(CLEANMOD) *.cmd *.o *.ko *.mod.c Module*.symvers
+	$(RM) -R .tmp*
+
+endif
Index: examples/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- examples/Makefile	(Revision 0)
+++ examples/Makefile	(Revision 0)
@@ -0,0 +1,5 @@
+all:
+	@find -mindepth 2 -name Makefile -execdir make \;
+
+clean:
+	@find -mindepth 2 -name Makefile -execdir make clean \;

--------------080801050705040108020904--

--------------enigED09A9628A98733A15B64EAA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFbhIvniDOoMHTA+kRAoE4AJ4/rzGcJYRS0YFwgEoSHVSzd/eXkACgg4l+
Uhz3jekwfnfMsMiKltxL/qk=
=x3oJ
-----END PGP SIGNATURE-----

--------------enigED09A9628A98733A15B64EAA--

