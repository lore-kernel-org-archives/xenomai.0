MIME-Version: 1.0
Date: Tue, 3 Apr 2012 12:26:46 +0530
Message-ID: <CAM1yFZ9GKhzvHNDufRQ2aJOH-gJkwv2-FmyhUx3RyS=06DSo4w@domain.hid>
From: Anisha Kaul <born.rebel.83@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] Is it compulsory to apply the PREEMPT_RT patch (to
 Linux) when running Xenomai on the top of it?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Greetings,

>From "Life with Adeos":
http://www.xenomai.org/documentation/branches/v2.3.x/pdf/Life-with-Adeos-re=
v-B.pdf

> Both the real=ADtime nucleus and the Linux kernel should handle the case =
where a high priority thread is kept from running because a low priority on=
e holds a contended resource > for a possibly unbounded amount of time. Xen=
omai provides this support, but only the PREEMPT_RT variant does so for the=
 Linux kernel. For this reason, Xenomai keeps an
> eye and provides support for the current developments of PREEMPT_RT, albe=
it the mainline kernel still remains the system of reference for now.


I don't understand whether the above quote implies that it necessary
to apply the PREEMPT_RT patch (to Linux) when working with Xenomai on
Linux?
Please guide.

-Anisha

