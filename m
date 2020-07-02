From: Josh Karch <jkarch@FirstMode.com>
Subject: Re: Receiving "Operation Not Permitted" when setting
 RTCAN_RTIOC_RCV_TIMEOUT and reading from CAN over cobalt pthread
Date: Thu, 2 Jul 2020 16:49:04 +0000
Message-ID: <MN2PR19MB39675C1591259A373C4A6F09D56D0@MN2PR19MB3967.namprd19.prod.outlook.com>
References: <MN2PR19MB39672146FC17172A042EECFED56C0@MN2PR19MB3967.namprd19.prod.outlook.com>,
 <e4369869-59d5-742b-ff4b-a89d4f9f5328@siemens.com>
In-Reply-To: <e4369869-59d5-742b-ff4b-a89d4f9f5328@siemens.com>
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
To: Jan Kiszka <jan.kiszka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>



________________________________
From: Jan Kiszka <jan.kiszka@siemens.com>
Sent: Wednesday, July 1, 2020 9:43 PM
To: Josh Karch <jkarch@FirstMode.com>; xenomai@xenomai.org <xenomai@xenomai=
.org>
Subject: Re: Receiving "Operation Not Permitted" when setting RTCAN_RTIOC_R=
CV_TIMEOUT and reading from CAN over cobalt pthread

On 01.07.20 16:55, Josh Karch via Xenomai wrote:
> Hello,
>
> So a quick update, I was able to get the CAN drivers working, the issue a=
s was suggested is that Linux did not register the interrupts for the Zynq,=
 and I had to make a fake "generic-uio" module in the device tree to receiv=
e a valid IRQ number, and now the CAN core registers properly.
>
> Now, I'm trying to create an application using the POSIX skin, based on t=
he rtcanrecv.c example.  Rather than using rt_task_shadow, I'm using pthrea=
d_create.  My Makefile uses xeno-config with --skin=3Dposix and sets --cfla=
gs and --ldflags, while wrap-link uses the POSIX ldflags. We are using libc=
obalt.
>
> When I don't set the timeout IOCTL, my application runs, but it blocks in=
definitely until messages are received, however when I set the IOCTL (0.1 s=
ec)
> ret =3D ioctl(can_fd, RTCAN_RTIOC_RCV_TIMEOUT, &timeout);
> then make the read in my pthread
>
> ret =3D recvfrom(can_fd, (void *)&can_msg_frame, sizeof(can_frame_t), 0,
>                                   (struct sockaddr *)&can_address, &addre=
ss_length);
>
> I receive -EPERM rather than -ETIMEDOUT as a return.  The application is =
run as root, and works normally unless the TIMEOUT ioctl above is triggered=
;  thoughts on where to look?
>
> Here are the lines of interest for the Makefile:
> CFLAGS :=3D $(shell $(DESTDIR)$(XENO_DIR)/$(XENO_CONFIG) --skin=3Dposix -=
-cflags)
> LDFLAGS :=3D $(shell $(DESTDIR)$(XENO_DIR)/$(XENO_CONFIG) --skin=3Dposix =
--ldflags)
>
> $(PROGNAME):
> $(CC) -c  $(PROGNAME).c $(CFLAGS)
> $(DESTDIR)$(XENO_DIR)/$(WRAP_LINK) -v $(CC) -o $(PROGNAME) $(PROGNAME).o =
$(LDFLAGS)
>
> My guess is if I make the application run as an rt_task it would work.
> Are there any special parameters needed to be set for pthread_create in o=
rder to run in RT mode?
>

If wrapping is worked fine (check the symbols that your application is
actually calling: __wrap_ioctl? Also __wrap_socket?), you do not need
special parameters to the thread creation, also SCHED_OTHER threads will
be able to RTDM drivers then.

Besides that offline check, you can also look if that thread shows up
/proc/xenomai/sched/threads while it is existing.

Jan

--
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

Hi Jan,  looks like two things were going on:  (1) I did not set the pthrea=
d to operate in the primary domain.  I went back and looked at the xddp exa=
mple.  (2) this is a fat fingered mistake, I was looking at ret vs errno.  =
The timeout was actually occuring, but since I looked at ret rather than er=
rno I misinterpreted it as "operation not permitted!"

Thank you!
-Josh
