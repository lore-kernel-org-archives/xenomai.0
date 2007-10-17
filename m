Message-ID: <4715CE15.10202@domain.hid>
Date: Wed, 17 Oct 2007 10:55:49 +0200
From: "CHABAL David" <david.chabal@domain.hid>
MIME-Version: 1.0
References: <4705ED3B.4070600@domain.hid>	
	<2ff1a98a0710050130j7e0db84dq838aab0417c8bd3f@domain.hid>	
	<4705FE04.7000909@domain.hid> <1191576011.20623.114.camel@domain.hid>	
	<470611FA.30103@domain.hid> <1191592977.20623.142.camel@domain.hid>	
	<470A26BC.506@domain.hid> <1192015852.22917.197.camel@domain.hid>	
	<470F7F2E.3020206@domain.hid> <470F82FF.9020701@domain.hid>	
	<1192203284.6499.135.camel@domain.hid> <470F978B.1000005@domain.hid>	
	<1192207431.6499.161.camel@domain.hid> <4715C70F.4040501@domain.hid>
	<1192610471.5973.4.camel@domain.hid>
In-Reply-To: <1192610471.5973.4.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Philippe Gerum a =E9crit :
> On Wed, 2007-10-17 at 10:25 +0200, CHABAL David wrote:
>=20
>> I met some problems after applying adeos-ipipe-2.6.20-i386-1.10-06.pat=
ch
>> (sorry, if I post on the wrong mailing-list)
>>
>=20
> The most recent patch for the 2.6.20 series is 1.10-08.

OK. But the line "#undef..." is also present in 1.10-08.

>=20
>> 1. entry.S
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> [root@domain.hid linux-2.6.20]# make
>>    CHK     include/linux/version.h
>>    CHK     include/linux/utsrelease.h
>>    CHK     include/linux/compile.h
>> dnsdomainname: Unknown host
>>    AS      arch/i386/kernel/entry.o
>> arch/i386/kernel/entry.S: Assembler messages:
>> arch/i386/kernel/entry.S:307: Error: invalid character '_' in mnemonic
>> arch/i386/kernel/entry.S:398: Error: invalid character '_' in mnemonic
>> arch/i386/kernel/entry.S:444: Error: invalid character '_' in mnemonic
>> arch/i386/kernel/entry.S:536: Error: invalid character '_' in mnemonic
>> make[1]: *** [arch/i386/kernel/entry.o] Error 1
>> make: *** [arch/i386/kernel] Error 2
>>
>=20
> Make sure to disable CONFIG_PARAVIRT.
>=20

I don't have any CONFIG_PARAVIRT in my .config.


The linker claims a function, so I can't continue the test:
..
   UPD     include/linux/compile.h
   CC      init/version.o
   LD      init/built-in.o
   LD      .tmp_vmlinux1
kernel/built-in.o: In function `__ipipe_rd_trigger':
tracer.c:(.text+0x330a1): undefined reference to `sprint_symbol'
make: *** [.tmp_vmlinux1] Error 1
[root@domain.hid linux-2.6.20]#

David

