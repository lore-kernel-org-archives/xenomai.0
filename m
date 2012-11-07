Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Apple Message framework v1283)
From: Michael Haberler <mail17@mah.priv.at>
In-Reply-To: <509ABA2F.3070507@xenomai.org>
Date: Wed, 7 Nov 2012 21:17:14 +0100
Content-Transfer-Encoding: quoted-printable
Message-Id: <79291449-2780-432F-AD58-BED661299EC6@mah.priv.at>
References: <9A40FDD0-65C2-470A-ACB7-AB556CF62501@mah.priv.at>	<509AB38E.1060802@grandegger.com>
	<39DEC9F1-236E-481A-A685-E3EFE883BCFA@mah.priv.at>
	<509ABA2F.3070507@xenomai.org>
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
To: xenomai@xenomai.org


Am 07.11.2012 um 20:44 schrieb Gilles Chanteperdrix:

>>> On 11/07/2012 08:06 PM, Michael Haberler wrote:
>>>> As suggested, I adapted the LinuxCNC kernel support from native
...

> In xenomai 3.0, FPU in kernel-space will not be supported. But it is

that I wasnt aware of, and it is quite a showstopper for me - I wish I =
had known before and saved the time. It puts in question any plans to =
release the kernel mode port of LinuxCNC altogether.

You _do_ want to add that fact to the Xenomai Roadmap _badly_.

what would be a realistic 'useful remaing life expectancy' for Xenomai =
2.x? 1,2,3 years?=20

- Michael

> true that we lack a service to set affinity for RTDM tasks. Though if
> you are creating the task from a linux context (module initialization
> function, or linux kernel threas), you can probably use =
set_cpus_allowed
> before rtdm_task_init to get the task created on the target cpu (set
> call it again after to restore the mask).
>=20
> --=20
>                                                                Gilles.


