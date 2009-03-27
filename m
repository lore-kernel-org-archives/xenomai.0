Message-Id: <943F8CE6-B103-4ED5-99CA-29F84AD90593@domain.hid>
From: Steven Seeger <steven.seeger@domain.hid>
In-Reply-To: <200903271538.10434.pwaechtler@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed; delsp=yes
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Apple Message framework v930.3)
Date: Fri, 27 Mar 2009 10:41:46 -0400
References: <200903271538.10434.pwaechtler@domain.hid>
Subject: Re: [Xenomai-core] use case: possible to boot Posix subsystem in
	<50ms and then Linux?
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: pwaechtler@domain.hid
Cc: xenomai@xenomai.org

Peter,

Please tell us more about your hardware platform. I know this is not =20
possible on convention x86 boards with a PC compatible BIOS.

Thanks,
Steven

On Mar 27, 2009, at 10:38 AM, Peter W=E4chtler wrote:

> Hi Xenomai developers,
>
> for automotive control units the boot time is essential. After power-=20=

> up the
> first status message has to be sent in about 50ms. This is usually =20
> achieved
> by a RTOS with boot times far below.
>
> Is it possible to construct a system with Xenomai that boots the =20
> POSIX (or
> whatever) subsystem first and then start Linux. Or is there a =20
> dependency that
> the subsystem can't run until Linux is up?
>
> That's the question ;)
>
>        Peter
>
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


