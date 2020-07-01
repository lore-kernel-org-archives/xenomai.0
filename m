From: Josh Karch <jkarch@FirstMode.com>
Subject: Receiving "Operation Not Permitted" when setting
 RTCAN_RTIOC_RCV_TIMEOUT and reading from CAN over cobalt pthread
Date: Wed, 1 Jul 2020 14:55:35 +0000
Message-ID: <MN2PR19MB39672146FC17172A042EECFED56C0@MN2PR19MB3967.namprd19.prod.outlook.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello,

So a quick update, I was able to get the CAN drivers working, the issue as =
was suggested is that Linux did not register the interrupts for the Zynq, a=
nd I had to make a fake "generic-uio" module in the device tree to receive =
a valid IRQ number, and now the CAN core registers properly.

Now, I'm trying to create an application using the POSIX skin, based on the=
 rtcanrecv.c example.  Rather than using rt_task_shadow, I'm using pthread_=
create.  My Makefile uses xeno-config with --skin=3Dposix and sets --cflags=
 and --ldflags, while wrap-link uses the POSIX ldflags. We are using libcob=
alt.

When I don't set the timeout IOCTL, my application runs, but it blocks inde=
finitely until messages are received, however when I set the IOCTL (0.1 sec=
)
ret =3D ioctl(can_fd, RTCAN_RTIOC_RCV_TIMEOUT, &timeout);
then make the read in my pthread

ret =3D recvfrom(can_fd, (void *)&can_msg_frame, sizeof(can_frame_t), 0,
                                  (struct sockaddr *)&can_address, &address=
_length);

I receive -EPERM rather than -ETIMEDOUT as a return.  The application is ru=
n as root, and works normally unless the TIMEOUT ioctl above is triggered; =
 thoughts on where to look?

Here are the lines of interest for the Makefile:
CFLAGS :=3D $(shell $(DESTDIR)$(XENO_DIR)/$(XENO_CONFIG) --skin=3Dposix --c=
flags)
LDFLAGS :=3D $(shell $(DESTDIR)$(XENO_DIR)/$(XENO_CONFIG) --skin=3Dposix --=
ldflags)

$(PROGNAME):
$(CC) -c  $(PROGNAME).c $(CFLAGS)
$(DESTDIR)$(XENO_DIR)/$(WRAP_LINK) -v $(CC) -o $(PROGNAME) $(PROGNAME).o $(=
LDFLAGS)

My guess is if I make the application run as an rt_task it would work.
Are there any special parameters needed to be set for pthread_create in ord=
er to run in RT mode?


Best,

Josh Karch

