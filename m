Message-ID: <49098078.7000402@domain.hid>
Date: Thu, 30 Oct 2008 10:38:00 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <939CEF84-66F5-4B05-A491-74091D527EC4@domain.hid>
In-Reply-To: <939CEF84-66F5-4B05-A491-74091D527EC4@domain.hid>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] sock_sendmsg() causes crash
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Alphan Ulusoy <alphan@domain.hid>
Cc: xenomai@xenomai.org

Alphan Ulusoy wrote:
> Hi all,
>=20
> I' am trying to send small UDP datagrams in a real-time system. I can't
> get a satisfactory performance when I send these packets from a
> userspace Xenomai task using sendto() call.
>=20
> That's why I tried to code a small kernel module to make some
> measurements. However; whenever
>     =95 A xenomai task
>     =95 An alarm function
>     =95 A thread created with kthread_run() form a xenomai task
> that includes the sock_sendmsg() call runs, system crashes. However, if
> a write a regular kernel module, the it works just fine...
>=20
> Below you can find the code and the crash dump.
>=20
> Does anyone have any suggestions? Is there any other way that I can sen=
d
> a UDP packet from a kernel Xenomai task?

I think Philippe already suggested that you should start reading a bit
about the co-kernel model and its implications.

Also, you may want to look at RTnet if you have to send UDP packets
under RT constraints.

Jan

--=20
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

