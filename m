From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Subject: Re: [Xenomai-core] rt-video interface
Date: Mon, 20 Mar 2006 22:33:32 -0300
References: <200603201715.08482.lbocseg@domain.hid> <441F47C6.9080108@domain.hid>
In-Reply-To: <441F47C6.9080108@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200603202233.32660.lbocseg@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Em Segunda 20 Mar=3DE7o 2006 21:24, Jan Kiszka escreveu:
>...
>You may want to have a look at this thread regarding poll/select and RT:
>http://www.mail-archive.com/rtnet-users%40lists.sourceforge.net/msg00968.h=
=3D
tm

I tried to. Not found. But I didn't give up so quicky. It was missing the=
=3D20
final 'l':
http://www.mail-archive.com/rtnet-users%40lists.sourceforge.net/msg00968.ht=
=3D
ml

>Do video capturing applications tend to have to observe multiple
>channels asynchronously via a single thread? If so, my statement about
>how often poll/select is actually required in RT-applications may have
>to be reconsidered.

Actually, I don't see any reasonable reason for using select/poll in rt=3D20
applications. But, while trying to keep the API similar to V4L2, I would=3D=
20
implement them by IOCTL and think it is OK, since it was already done for=
=3D20
MMAP/MUNMAP. I don't think it worths writing the poll/select rt like=3D20
functions...

What could be discussed here is if it will be required or not to have those=
=3D
=3D20
calls needed when using streaming (most designs will use streaming). I don'=
=3D
t=3D20
think it should be required as it is on V4L2, but could be implemented=3D20
optionally, as IOCTL calls. But I would need to investigate more this topic=
=3D
=3D2E=3D20
I'll do it tomorrow... I'm the last man in the lab and they are calling me=
=3D
=3D20
out for closing the lab...

>...
>Does your time allow to list the minimal generic services a RTDM video
>capturing driver has to provide in a similar fashion like the serial or
>the CAN profile? If it's mostly about copying existing Linux API specs,
>feel free to just reference them. But the differences should certainly
>fill up a RT-video (or so) profile, and that would be great!

I'll think about it and will answer tomorrow.

Regards,

Rodrigo

=09

=09
	=09
_______________________________________________________=20
Yahoo! doce lar. Fa=E7a do Yahoo! sua homepage.=20
http://br.yahoo.com/homepageset.html=20



