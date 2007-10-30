Message-ID: <4726F2F5.3060206@domain.hid>
Date: Tue, 30 Oct 2007 10:01:41 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <472630A3.7020802@domain.hid> <472649BF.50909@domain.hid>
In-Reply-To: <472649BF.50909@domain.hid>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] make xenomai/serial/16550A module error
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Jan Kiszka wrote:
> Dennis Nguyen wrote:
>> I tried to build linux kernel 2.6.20.10 with xenomai 2.3.4 with serial=20
>> 16550A Module (I selected serial 16550A as a M).=20
>> (adeos-ipipe-2.6.20-i386-1.10-10.patch)
>>
>> I had an error:
>>    CC [M]  drivers/xenomai/serial/16550A.o
>> drivers/xenomai/serial/16550A.c: In function =91rt_16550_open=92:
>> drivers/xenomai/serial/16550A.c:448: error: incompatible types in assign=
ment
>> make[3]: *** [drivers/xenomai/serial/16550A.o] Error 1
>> make[2]: *** [drivers/xenomai/serial] Error 2
>> make[1]: *** [drivers/xenomai] Error 2
>> make: *** [drivers] Error 2
>> [root@domain.hid linux-2.6.20.10]#
>>
>> Any suggestion please?
>=20
> So far for "please use the latest patch". :-/
>=20
> Some assumption of the 2.3.x branch about what is when defined became
> invalid with ipipe-1.10-10, attached patch fixes it. Philippe, please app=
ly.
>=20

Merged, thanks.

> Jan
>=20


--=20
Philippe.

