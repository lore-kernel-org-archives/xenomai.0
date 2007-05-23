Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 May 2007 16:41:42 +0200
Message-ID: <C0662F7F2A8A974FAA140822A2336BF0F173EC@deimsg10.de.net.world>
From: "Stolz, Stefan, PGR2" <Stefan.Stolz@domain.hid>
Subject: [Xenomai-help] scheduling of rtdm-handler
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hello,

i'm developing a rt-driver for the rtdm with Xenomai and i've got one
question.
how are the handler-functions (like rtdm_read_handler,
rtdm_write_handler, ...) scheduled if there are other rt-tasks?
e.g. i've got the rtdm-driver which handles read and write (read and
write have to do some i/o-operations) and a two other rt-tasks. What
happens if the task with the lower priority uses the rtdm-driver to read
and write data and the task with the higher priority want's to run. Are
the i/o-operations peempted by the high priority task? If it is so, is
it possible to give the driver a higher priority or do i have to create
a task with a higher priority in the driver?

Best Regards

Stefan Stolz

