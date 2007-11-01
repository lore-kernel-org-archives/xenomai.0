MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-ID: <18217.64851.619168.909923@domain.hid>
Date: Thu, 1 Nov 2007 17:22:43 +0100
In-Reply-To: <753656844.20071101093838@domain.hid>
References: <1078761341.20071030094041@domain.hid>
	<4726F2B5.5000307@domain.hid>
	<1935435350.20071030105318@domain.hid>
	<47270861.8090500@domain.hid>
	<1963009588.20071031182042@domain.hid>
	<18216.56022.667006.119955@domain.hid>
	<753656844.20071101093838@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] how to stop a runaway task
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?iso-8859-1?Q?Carsten_Spie=DF?= <mail@domain.hid>
Cc: xenomai@xenomai.org

Carsten Spie=DF wrote:
 > Hello Gilles,
 >=20
 > > If you are trying to suspend a task from another task, then
 > > SIGSTOP is the only solution.
 > O.k., this will lead me again to use rt_task_* instead of pthread_*
 > (i don't like signals at all)
 >=20
 > > Now, for the problem you have with secondary mode switches,
 > > it is probably a bug,
 > Is it a known bug? Can someone confirm it? (I can provide sample code)
 > Is there already a fix for it?
 > If not, how to debug such things?
 > (until now, i'm only working on the user mode side)

Read Philippe's answer again:
https://mail.gna.org/public/xenomai-help/2007-10/msg00166.html

--=20


					    Gilles Chanteperdrix.

