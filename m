Message-ID: <45CAE1C2.5040207@domain.hid>
Date: Thu, 08 Feb 2007 08:39:30 +0000
From: =?ISO-8859-1?Q?St=E9phane_ANCELOT?= <sancelot@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] system() question
References: <45C9F9CD.6000101@domain.hid> <45C9F2F9.3020204@domain.hid>
In-Reply-To: <45C9F2F9.3020204@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

my linux user task uses a system() call in order to call a bash script=20
to restart the realtime task as follow :

user interface C call :
system("restart_task.sh");
give back hand to user interface
....




bash script restart_task.sh :
killall -15 mytask
sleep 2
mytask &


system call dies because sh script has been launched

Gilles Chanteperdrix wrote:
> St=E9phane ANCELOT wrote:
>> Is there a way to launch my realtime task from another linux program=20
>> using system() C call ?
>>
>> I have tried it , but when system call dies my rt task dies too ...
>> any idea ?
>=20
> Why does the system call die ? Do you observe the same behaviour with
> non xenomai applications ?
>=20


