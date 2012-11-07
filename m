Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=iso-8859-1
From: Michael Haberler <mail17@mah.priv.at>
In-Reply-To: <509AB38E.1060802@grandegger.com>
Date: Wed, 7 Nov 2012 20:26:40 +0100
Content-Transfer-Encoding: quoted-printable
Message-Id: <39DEC9F1-236E-481A-A685-E3EFE883BCFA@mah.priv.at>
References: <9A40FDD0-65C2-470A-ACB7-AB556CF62501@mah.priv.at>
	<509AB38E.1060802@grandegger.com>
Subject: Re: [Xenomai] RTDM API: no CPU binding,
	FPU setting for tasks available?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: xenomai@xenomai.org


Am 07.11.2012 um 20:16 schrieb Wolfgang Grandegger:

> On 11/07/2012 08:06 PM, Michael Haberler wrote:
>> As suggested, I adapted the LinuxCNC kernel support from native to =
RTDM API; my remaining issues are:
>>=20
>> - how do I achieve CPU binding which is available in rt_task_create() =
(T_CPU(cpuid))?
>> - do I need to tell an RTDM task that the thread might use the FPU =
(T_FPU in rt_task_create()) ?
>=20
> =
http://www.xenomai.org/documentation/trunk/html/api/group__task.html#ga033=
87550693c21d0223f739570ccd992
> it pretty clear.

Wolfgang -

I was suggested:

> Also note that if LinuxCNC code runs in kernel-space, you should not =
be
> using the native API, but the RTDM API.

which I translate as 'use rtdm_task_init instead of rt_task_create'

I have the kernel code using the native API just fine. The concern I =
have is for long-term compatibility, which is why I'm attempting to port =
to RTDM.

- Michael


>=20
> Wolfgang.
>=20


