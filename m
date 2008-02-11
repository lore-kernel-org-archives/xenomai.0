Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 11 Feb 2008 08:20:32 -0700
Message-ID: <51CAD0CE1504444DBE77CBBE51A0135D376ADB@slcmail.slc.mew.int>
In-Reply-To: <47B053A2.9010503@domain.hid>
References: <51CAD0CE1504444DBE77CBBE51A0135D376AD7@domain.hid>
	<47B053A2.9010503@domain.hid>
From: "Steven Seeger" <sseeger@domain.hid>
Subject: Re: [Xenomai-help] overhead
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

The overhead was measured by only comparing cpu usage between tasks from
the statistics collection stuff. There are some userland tasks running
at 8khz, so apparently this is a problem for Xenomai on this board. I
had no problem at all with these tasks in kernel space under rtai.=20

There are no faults at all under /proc/xenomai/faults.

The main way I can tell something is wrong is that if my three fast
tasks are running (8 khz in kernel space, 8 khz in userspace, and 50 hz
in userspace) then a lower priority task will timeout and trip a
watchdog. If I remove the IO routines from the 50hz task, then the
others can still run.

Steven


> -----Original Message-----
> From: Jan Kiszka [mailto:jan.kiszka@domain.hid]
> Sent: Monday, February 11, 2008 6:55 AM
> To: Steven Seeger
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai-help] overhead
>=20
> Steven Seeger wrote:
> > Is it normal for Xenomai to have significant overhead in userspace
> > compared to older software running RTAI with all realtime threads in
> > kernel modules? My application makes heavy use of inb/outb with
iopl().
>=20
> Significant overhead in user land can come from significant task
> switches or a significant number of syscalls. But direct I/O should
not
> bite you. Any suspicious number of faults under /proc/xenomai/faults?
>=20
> How did you measure the overhead in both systems?
>=20
> Jan
>=20
> --
> Siemens AG, Corporate Technology, CT SE 2
> Corporate Competence Center Embedded Linux

