Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 3 Jan 2008 11:59:55 +0100
Message-ID: <0B45E93C5FF65740AEAE690BF3848B7A4AB2FD@rennsmail04.eu.thmulti.com>
From: "Fillod Stephane" <stephane.fillod@domain.hid>
Subject: Re: [Xenomai-core] [PATCH] I see negative faults
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
>Fillod Stephane wrote:
>> Attached is an obvious patch (to me). Part of it is across I-Pipe.
>> Is there a reason why the counter was declared signed?
>>=20
>
>Well, because the number of faults was not expected to increase
>indefinitely... Is it the PF count we are talking about, on a mpc85xx?

Indeed. It's a MPC8541E.=20

$ cat /proc/xenomai/faults
TRAP         CPU0
  0:            4    (Data or instruction access)
  1:            0    (Alignment)
  2:            0    (Altivec unavailable)
  3:            0    (Program check exception)
  4:            0    (Machine check exception)
  5:            0    (Unknown)
  6:            0    (Instruction breakpoint)
  7:            0    (Run mode exception)
  8:            0    (Single-step exception)
  9:            0    (Non-recoverable exception)
 10:            0    (Software emulation)
 11:            0    (Debug)
 12:            0    (SPE)
 13:            0    (Altivec assist)
 14:   3221526824    (Cache-locking exception)
 15:            0    (Kernel FP unavailable)

Any clue?

--=20
Stephane

PS: Happy new year to whoever read this message :-)=20

