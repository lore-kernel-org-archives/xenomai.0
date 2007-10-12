Message-ID: <470F82FF.9020701@domain.hid>
Date: Fri, 12 Oct 2007 16:21:51 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4705ED3B.4070600@domain.hid>		<2ff1a98a0710050130j7e0db84dq838aab0417c8bd3f@domain.hid>		<4705FE04.7000909@domain.hid>
	<1191576011.20623.114.camel@domain.hid>		<470611FA.30103@domain.hid>
	<1191592977.20623.142.camel@domain.hid>		<470A26BC.506@domain.hid>
	<1192015852.22917.197.camel@domain.hid> <470F7F2E.3020206@domain.hid>
In-Reply-To: <470F7F2E.3020206@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] awful latencies (~110us)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: CHABAL David <david.chabal@domain.hid>
Cc: xenomai@xenomai.org

CHABAL David wrote:
> Philippe Gerum a =E9crit :
>>
>> I suspect the tracer to induce massive cache misses on your setup, whi=
ch
>> limits the interpretation we can have of this log. Could you apply the
>> following patch, and post back the frozen log for the very same test?
>> TIA,
>>
>> --- 2.6.20-ipipe-1.8-08/kernel/ipipe/core.c~    2007-09-16
>> 16:54:34.000000000 +0200
>> +++ 2.6.20-ipipe-1.8-08/kernel/ipipe/core.c    2007-10-10
>> 13:05:28.000000000 +0200
>> @@ -283,7 +283,7 @@
>>      unsigned long flags;
>>      int s;
>> =20
>> -    local_irq_save_hw(flags);
>> +    local_irq_save_hw_notrace(flags);
>>      __raw_spin_lock(lock);
>>      ipipe_load_cpuid();
>>      ipd =3D per_cpu(ipipe_percpu_domain, cpuid);
>> @@ -302,7 +302,7 @@
>>      ipd =3D per_cpu(ipipe_percpu_domain, cpuid);
>>      if (!raw_demangle_irq_bits(&x))
>>          __clear_bit(IPIPE_STALL_FLAG, &ipd->cpudata[cpuid].status);
>> -    local_irq_restore_hw(x);
>> +    local_irq_restore_hw_notrace(x);
>>  }
>> =20
>>  /*
>>
> The freeze file enclosed is generated with this patch and the i8259.c
> patch.
>=20
> ---|------------|------------|------------|--------|-------------------=
------
>=20
> RTS|       5.570|       9.400|      85.356|       0|    00:08:55/00:08:=
55
>=20
> Should I try without the I-pipe debugger ?

Never say never, but the tracer most probably not causing these
latencies. Currently, all points to the good-old programmable interrupt
controller.

Do you have CONFIG_X86_UP_IOAPIC enabled? If no, please try to do so.

Jan

--=20
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

