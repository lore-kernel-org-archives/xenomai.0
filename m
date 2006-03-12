Message-ID: <441455C5.3020808@domain.hid>
Date: Sun, 12 Mar 2006 18:09:25 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] user mode vs. kernel module
References: <44113E39.1010902@domain.hid> <44140395.7090702@domain.hid>
In-Reply-To: <44140395.7090702@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
> Ignacio Garc=EDa P=E9rez wrote:
>=20
>> Hi,
>>
>> So far I've had my application implemented entirely as a kernel module=
=20
>> with some user mode helper programs. I've had in mind changing to user=
=20
>> mode but never felt compelled enough.
>>
>> Now, having a new requirement to implement, I think it's the moment to=
=20
>> give it a try, and I'm porting it. I have a couple of questions:
>>
>> 1- How significative, in real world terms, is the overhead involved in=
=20
>> operaing in user mode?. As far as I know all operations are executed=20
>> via "pods" which involve one or more system calls and context=20
>> switches. I'm using a Geode board right now but there are plans to=20
>> move to a more low-end platform (486).
>>
>> 2- ioperm. This is a true headache. I've spent countless hours=20
>> debugging this and banging my head agaist the wall. I'm not 100% sure=20
>> of what's going on here, but it looks like the ioperm call must be=20
>> issued from primary mode if you are doing the I/O from primary mode.=20
>> Something like this would segfault:
>>
>> ioperm(0x443, 0x01, 1);
>> rt_mutex_lock(...)
>> outb(0x01, 0x443)
>>
>> While this works fine:
>>
>> rt_mutex_lock(...)
>> ioperm(0x443, 0x01, 1);
>> outb(0x01, 0x443);
>>
>> While leads me to think that the rt_mutex_lock puts the task in=20
>> primary mode and then both ioperm and outb are executed in the same=20
>> mode so everything works.
>>
>> Is this right?
>=20
>=20
> No.
>=20
> . If so, I find this extremely inconvenient...
>=20
>>
>=20
> Fixed in the repository. Use iopl(3) as a work-around, or resync.
>=20

Btw, the fix concerns the active i/o bitmap ownership in the TSS for kern=
el=20
versions >=3D 2.6.15, but the segfault you encounter is likely an applica=
tion error:=20
ioperm() cannot be used for ports above 0x3ff. You must resort to using i=
opl() to=20
access port address 0x443.

>> Nacho.
>>
>>
>>
>>
>>
>> _______________________________________________
>> Xenomai-help mailing list
>> Xenomai-help@domain.hid
>> https://mail.gna.org/listinfo/xenomai-help
>>
>=20
>=20


--=20

Philippe.

