Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Apple Message framework v1283)
From: Michael Haberler <mail17@mah.priv.at>
In-Reply-To: <50FD9293.4060304@xenomai.org>
Date: Mon, 21 Jan 2013 22:20:03 +0100
Content-Transfer-Encoding: quoted-printable
Message-Id: <A5889380-DB90-428D-BAA3-236632265665@mah.priv.at>
References: <4D4F8D1B-022E-47F8-A579-EBF2A3427C5D@mah.priv.at>	<50F6D940.3040406@xs4all.nl>	<F1ACE4FC-3E71-4498-B683-81F5C40CB6E3@mah.priv.at>	<50F7AF53.2090800@xs4all.nl>	<50F7BC13.50009@xenomai.org>	<50F7FCD8.7020105@xs4all.nl>	<50FA9FA0.7020400@xenomai.org>	<F995AEC4-6B7E-4DB9-9C64-A5ED3F01DCFA@mah.priv.at>	<50FAAE9A.2060705@xenomai.org>	<1C475D27-61D9-41F9-98D8-476556B485C4@mah.priv.at>	<50FD2D03.4090306@xenomai.org>
	<327290E8-7EDA-4ED8-80DC-93ADEB393C9F@mah.priv.at>
	<50FD9293.4060304@xenomai.org>
Subject: Re: [Xenomai] [Emc-developers] "new
	RTOS"	status:	Scheduler	(?)	lockup on ARM
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org


Am 21.01.2013 um 20:10 schrieb Gilles Chanteperdrix:

> On 01/21/2013 02:32 PM, Michael Haberler wrote:
>=20
>>=20
>> Am 21.01.2013 um 12:56 schrieb Gilles Chanteperdrix:


>>>> question: does a RTC time warp have any possible bearing on
>>>> Xenomai operations?
>>>=20
>>>=20
>>> No, it should not, Xenomai uses its own clock, which is set only
>>> once upon boot, so, is unaffected by Linux wallclock time
>>> changes... or should be.
>>=20
>>=20
>> it might not be Xenomai after all. Uhum.
>>=20
>> the bughunt safari tribe has decided to focus on class 'duh' problems
>> and resolves to shut up until red hands are spotted.
>=20
>=20
> I would still put the check in the timer "set_next_event" callback, =
just
> in case...

I assume Bas will give the postmortem shortly - he nailed the issue; the =
RTC boot timewarp makes for a lost DHCP lease midflight and NFS =
freezing, making it look like a kernel hang.

relieved,

- Michael






