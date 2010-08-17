Message-ID: <4C6A97EB.7000104@domain.hid>
Date: Tue, 17 Aug 2010 16:08:43 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1282047938.5255.89.camel@domain.hid>	
	<4C6A8194.80008@domain.hid>
	<1282048491.5255.92.camel@domain.hid>	
	<4C6A8332.5050308@domain.hid>
	<1282049663.5255.99.camel@domain.hid>	
	<4C6A893E.9000907@domain.hid>
	<1282051157.5255.108.camel@domain.hid>	
	<4C6A8E49.10204@domain.hid>
	<1282053444.5255.116.camel@domain.hid>
In-Reply-To: <1282053444.5255.116.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] xenomai 2.5.3/native, kernel 2.6.31.8 and fork()
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: =?UTF-8?B?S3J6eXN6dG9mIELFgmFzemtvd3NraQ==?= <kb@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>

Krzysztof B=C5=82aszkowski wrote:
> On Tue, 2010-08-17 at 15:27 +0200, Gilles Chanteperdrix wrote:
>> What are the contents of this linker script? I did not ask to compare
>> gcc -print-file-name=3Dlibc.so with the same file on the target. I ask=
ed
>> to compare:
>> gcc -print-file-name=3Dlibc.so (or if it is a linker script, the libc.=
so.6
>> it references)
>> with  /lib/libc.so.6
>>
>> In other words: the libc used by the compiler with the libc used at
>> run-time, as my very first answer was asking.
>>
>=20
> /usr/lib/libc.so can't be compared with /lib/libc.so.6.

libc.so is a linker script, so the sentence "or if it is a linker
script, the libc.so.6 it references" applies.

Anyway, now we got to the bottom of it, ok, libc.so references
/lib/libc.so.6. But since you already made me spend one hour having you
understand the difference between the compiler libc and the one of the
root filesystem, I will not have be able to run your test before tonight.=


In the mean-time, please run your test with Xenomai 2.5.4.

--=20
					    Gilles.


