Date: Thu, 1 Nov 2007 09:38:38 +0100
From: =?iso-8859-1?Q?Carsten_Spie=DF?= <mail@domain.hid>
Message-ID: <753656844.20071101093838@domain.hid>
In-Reply-To: <18216.56022.667006.119955@domain.hid>
References: <1078761341.20071030094041@domain.hid>
	<4726F2B5.5000307@domain.hid>
	<1935435350.20071030105318@domain.hid>
	<47270861.8090500@domain.hid>
	<1963009588.20071031182042@domain.hid>
	<18216.56022.667006.119955@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] how to stop a runaway task
Reply-To: =?iso-8859-1?Q?Carsten_Spie=DF?= <mail@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hello Gilles,

> If you are trying to suspend a task from another task, then
> SIGSTOP is the only solution.
O.k., this will lead me again to use rt_task_* instead of pthread_*
(i don't like signals at all)

> Now, for the problem you have with secondary mode switches,
> it is probably a bug,
Is it a known bug? Can someone confirm it? (I can provide sample code)
Is there already a fix for it?
If not, how to debug such things?
(until now, i'm only working on the user mode side)

> so you should not design  your application around this bug,
> it should work, and actually works on other platforms.

Regards Carsten
--=20
Dipl.-Ing. Carsten Spie=DF
Softwareentwicklung - Beratung - Schulung
Lauterlech 39d
D-86152 Augsburg
Tel.: +49(821)15 999 765
Fax.: +49(821)15 999 767
mailto://mail@domain.hid
http://www.carsten-spiess.de







