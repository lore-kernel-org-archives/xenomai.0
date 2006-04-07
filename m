Message-ID: <4436539E.50906@domain.hid>
Date: Fri, 07 Apr 2006 13:57:18 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Frozen timer IRQ
References: <4432E540.1010108@domain.hid>	<17459.46030.997560.684058@domain.hid>	<4433BA43.7000807@domain.hid>	<4433C087.3020403@domain.hid>
	<44341AE6.5030804@domain.hid>	<44343CF6.4090500@domain.hid>
	<44352E12.1000502@domain.hid> <443533E3.6080305@domain.hid>
	<4435363B.50701@domain.hid> <443537C5.1080801@domain.hid>
	<44354CC5.8080405@domain.hid>
In-Reply-To: <44354CC5.8080405@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD1788BA707C2336AD550D8CC"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD1788BA707C2336AD550D8CC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>
>>> Jan Kiszka wrote:
>>>
>>>> Philippe Gerum wrote:
>>>>
>>>>
>>>>> Jan Kiszka wrote:
>>>>>
>>>>>
>>>>>> Attached is an ipipe-freeze of the frozen system. It's taken at th=
e
>>>>>> time
>>>>>> the main thread of the terminating application has successfully
>>>>>> rt_task_join'ed the last remaining RT-thread. I took 2000 trace
>>>>>> points
>>>>>> before and after that point and additionally instrumented
>>>>>> rthal_timer_program_shot() (special trace 0x01, the argument is th=
e
>>>>>> delay). The interesting stuff happens around 600 us after the
>>>>>> freeze: it
>>>>>> seems the scheduled Linux timer arrives then but doesn't get much
>>>>>> attention beyond from ipipe.
>>>>>>
>>>>>> Any idea what to look for next? I have a "perfect" test system now=
,
>>>>>> though I still see no light at the end of the tunnel how to export=

>>>>>> it to
>>>>>> other boxes.
>>>>>>
>>>>>> Enough for today.
>>>>>>
>>>>>> Jan
>>>>>>
>>>>>>
>>>>>> PS: This trace was taken over 2.6.15 to exclude any issues with
>>>>>> the new
>>>>>> 2.6.16. Both kernels show the same effect.
>>>>>>
>>>>>
>>>>> Does this patch make any difference?
>>>>>
>>>>> --- ipipe-root.c~    2006-01-31 09:55:44.000000000 +0100
>>>>> +++ ipipe-root.c    2006-04-06 17:01:49.000000000 +0200
>>>>> @@ -328,9 +328,8 @@
>>>>>        /* Only sync virtual IRQs here, so that we don't recurse
>>>>>           indefinitely in case of an external interrupt flood. */
>>>>>
>>>>> -        if ((ipipe_root_domain->cpudata[cpuid].
>>>>> -             irq_pending_hi & IPIPE_IRQMASK_VIRT) !=3D 0)
>>>>> -            __ipipe_sync_stage(IPIPE_IRQMASK_VIRT);
>>>>> +        if (ipipe_root_domain->cpudata[cpuid].irq_pending_hi !=3D =
0)
>>>>> +            __ipipe_sync_stage(IPIPE_IRQMASK_ANY);
>>>>>    }
>>>>> #ifdef CONFIG_IPIPE_TRACE_IRQSOFF
>>>>>    ipipe_trace_end(0x8000000D);
>>>>
>>>>
>>>> Nope.
>>>
>>> That's good news, actually. I would have been quite embarrased if it =
did
>>> it.
>>>
>>>
>>>> Where should I put my finger on to find out what's happening?
>>>>
>>>
>>> It seems that the pipeline log is not synced by
>>> __ipipe_unstall_iret_root.
>>> We need to know why. Question: is the root stage stalled or unstalled=
 by
>>> this
>>> routine during the latest call before the box freezes?
>>
>>
>> I'm currently switching my brain between to many tasks: Could you simp=
ly
>> tell me what variable to check so that I can hack some
>> ipipe_trace_special into the kernel?
>=20
> The value of the IPIPE_STALL_FLAG for the root domain upon exit from
> __ipipe_unstall_iret_root.

ipipe_root_domain->cpudata[cpuid].status is 0 on return.

Jan


--------------enigD1788BA707C2336AD550D8CC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFENlOiniDOoMHTA+kRAianAJ9wsES81N68wRbes97rAtnh2Ty6dwCeOxMQ
B2ngwHmALtsbTjwVT7/O1jY=
=GGTw
-----END PGP SIGNATURE-----

--------------enigD1788BA707C2336AD550D8CC--

