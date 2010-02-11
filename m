Message-ID: <4B745CAB.5000404@domain.hid>
Date: Thu, 11 Feb 2010 20:38:19 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <8b216e9e1002100327h3aa332ddl13ec590fcb81f0b7@domain.hid>
	<4B729B04.9010909@domain.hid>
	<8b216e9e1002100349y71f40d9ct9cbf496846f33f2e@domain.hid>
	<8b216e9e1002100358u71d73d36xb851e59e23e069d1@domain.hid>
	<4B72C18F.20903@domain.hid>
	<8b216e9e1002101128t1246a5deh28ca13229f1d688d@domain.hid>
	<8b216e9e1002111005h6b432bcby17d4127d3b9d385a@domain.hid>
	<4B7447AD.5050401@domain.hid>
	<8b216e9e1002111024h7c87d0c1n9f36a91602e52cd6@domain.hid>
	<4B744ED4.2000200@domain.hid>
	<8b216e9e1002111053gf6b4b2mf605e8c3b9f1c235@domain.hid>
In-Reply-To: <8b216e9e1002111053gf6b4b2mf605e8c3b9f1c235@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Problems when cross-compiling Xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?UTF-8?B?RmVsaXBlIEJyYW5kw6NvIENhdmFsY2FudGk=?= <cavalkaf@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Felipe Brand=C3=A3o Cavalcanti wrote:
> 2010/2/11 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org=
>
>=20
>> Felipe Brand=C3=A3o Cavalcanti wrote:
>>> Sending the boot log and the xeno-test output as attachments.
>> [    0.000000] OMAP clockevent source: GPTIMER12 at 32768 Hz
>>
>> Definitely not OK. We do not want this unprecise clockevent source.
>> Disable it in the kernel configuration (option CONFIG_OMAP_32K_TIMER).=

>>
>>
> This is very interesting - this option doesnt seem to be set in my curr=
ent
> kernel config. Ive attached my .config.

Selecting GPTIMER 1 should work. But if you get lockups or thing like
that, please try with a vanilla 2.6.30 to see if you get them.

--=20
Gilles Chanteperdrix, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com


