Date: Wed, 05 Oct 2011 15:01:55 +0200
From: "Petr Cervenka" <grugh@domain.hid>
References: <20110926090226.9C75AD68@domain.hid> <4E8AE5A6.6090306@domain.hid>
In-Reply-To: <4E8AE5A6.6090306@domain.hid>
MIME-Version: 1.0
Message-Id: <20111005150155.76283A3B@centrum.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Frequency downscaling of new intel CPU
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-help <xenomai@xenomai.org>


>Have you tried:
>- enabling SMI workaround (and do not forget to check the boot logs to
>check that it actually works with the chipset you use);
>- if that fails, adding "idle=3Dpoll" to kernel arguments?
>

Enabling SMI workaround didn't make any change. What should I look after =
in boot logs?

Kernel parameter idle=3Dpoll displayed thermal warnings and freq. throttl=
ing after cca 30 sec. of application run.
But when fan speed was selected to Full speed at BIOS, the machine worked=
 fast as it should be. Quite impressive ;-)
Other idle options were same as none, only idle=3Dmwait frezzes during ea=
rly boot stage.

Thank you for your help.

Petr

PS: Do you have any other idea without overheating side-efects

