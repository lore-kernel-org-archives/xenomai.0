MIME-Version: 1.0
Date: Mon, 23 Jun 2008 10:14:19 +0200
From: Matthieu <matthieu.connaulte_xenomai@domain.hid>
Message-ID: <b3ff56212c0949c864c7170fd01e8254@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] xenomai scheduler's ticks period
Reply-To: matthieu.connaulte_xenomai@domain.hid
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

Hi

I would like to know if there is a sheduler per CPUs or one scheduler for
all CPUs ? I understand that there is one sheduler per skin for all CPUs,
so it's only to be sure...

Well, my application has two working mode. One with a PCI hardware that
send an interrupt to tickAnnounce the Scheduler ; one with no hardware an=
d
something that will simulate this hardware interrupt (something like a
periodic xenomai real-time task that send this same interrupt). So I need
to use an interrupt to tickAnnounce vxworks scheduler. I think that I hav=
e
to disabe the periodic tick (but I don't know how), and I need an interru=
pt
handler that send a tickAnnounce. It is during the execution that the
presence of the PCI hardware is tested and whether a hardware interrupt o=
r
software interrupt is used. Can somebody explain me if it's possible, and
in that case, how can I disable the automatic vxworks tick ?



