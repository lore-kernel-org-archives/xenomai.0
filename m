Message-ID: <4762A57F.2020909@domain.hid>
Date: Fri, 14 Dec 2007 17:47:11 +0200
From: Maksym Veremeyenko <verem@domain.hid>
MIME-Version: 1.0
References: <0C9896A4B6D338488AD6FFFE58BAEF1001DB8EEF@serveur3.lgm.com>
In-Reply-To: <0C9896A4B6D338488AD6FFFE58BAEF1001DB8EEF@serveur3.lgm.com>
Content-Type: text/plain; charset=KOI8-U; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] CP-118U RTDM Driver
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: DOURNES Guillaume <Guillaume.DOURNES@lgm.fr>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

DOURNES Guillaume =D0=C9=DB=C5=D4:

> I chose a Moxa CP-118U board on my project, to be able to drive this PC=
I=20
> board with the xeno_16550A module.
i had a success with this board and xeno_16550A module.
have a look at: http://www.xenomai.org/index.php/16550A and if lspci -v=20
return the same.

> But when the task is started, my computer become very slow, as a proces=
s=20
> eats a lot of CPU load.

> My question is why the CPU become very loaded, whereas my software do=20
> nothing.

check if *read_task_proc* eat all CPU
check for timeouts setting on serial port.


________________________________________
Maksym Veremeyenko

