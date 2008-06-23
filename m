MIME-Version: 1.0
Date: Mon, 23 Jun 2008 19:52:12 +0200
From: Matthieu <matthieu.connaulte_xenomai@domain.hid>
In-Reply-To: <485FDADB.60705@domain.hid>
References: <485FDADB.60705@domain.hid>
Message-ID: <79d394791426e089eda84f208d108ce1@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] xenomai scheduler's ticks period
Reply-To: matthieu.connaulte_xenomai@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

On Mon, 23 Jun 2008 19:18:19 +0200, Philippe Gerum <rpm@xenomai.org> wrot=
e:
> Gilles Chanteperdrix wrote:
>> Philippe Gerum wrote:
>>> Gilles Chanteperdrix wrote:
>>>> Philippe Gerum wrote:
>>>>> Matthieu wrote:
>>>>>
>>>>>> I have a segmentation fault error when I use modprobe xeno_vxworks
>>>>>> tick_arg=3D0 (tick_arg=3D1000 works)
>>>>>>
>>>>> Any kernel log?
>>>>>
>>>> wind_sysclk_init uses its argument for a division.
>>>>
>>> --- ksrc/skins/vxworks/sysLib.c	(revision 3975)
>>> +++ ksrc/skins/vxworks/sysLib.c	(working copy)
>>> @@ -39,12 +39,12 @@
>>>  int wind_sysclk_init(u_long period)
>>>  {
>>>  	extern u_long sync_time;
>>> -	u_long init_rate =3D ONE_BILLION / period;
>>> +	u_long init_rate =3D period ? ONE_BILLION / period : XN_APERIODIC_T=
ICK;
>>>  	int err;
>>>
>>>  	err =3D xntbase_alloc("vxworks", period, sync_time ? 0 : XNTBISO,
>>>  			    &wind_tbase);
>>> -	if (err)
>>> +	if (err || period =3D=3D 0)
>>>  		return err;
>>>
>>>  	err =3D sysClkRateSet(init_rate);
>>
>> Ok, but what about sysClkRateGet then ? It is needed for conversion
>> between durations and ticks count. It will not work since sysClkRateSe=
t
>> was not called, and we can not call sysClkRateSet since it would start
>> the timer.
>>
>>
>=20
> We don't have to care about this. If people want to override the system
> timer,
> then they should deal with the xntbase interface themselves. What is
> provided is
> a mean to disable internal timing so that it does not conflict with the
> user-provided stuff, nothing more.
>=20
> --
> Philippe.
>=20

Thank you for all, I'll test it tomorrow. I understand that these
modifications are sufficient and I will have no problem with "modprobe
xeno_vxworks tick_arg=3D0" command and with tickAnnounce vxworks schedule=
r in
my own rtdm linux module driver. (I'm about using a rtdm driver as Philip=
pe
suggest me, directly in a rtdm_irq_handler_t interrupt handler).

Matthieu



