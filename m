Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Feb 2009 15:07:23 +0100
Message-ID: <4B2EEE69E41E524EB7FCDC62A15D68D8030CCF0F@ARVMAIL1.mra.roland-man.biz>
In-Reply-To: <49957D23.4040806@domain.hid>
References: <4B2EEE69E41E524EB7FCDC62A15D68D80308F137@domain.hid>
	<499572C2.3060609@domain.hid> <49957D23.4040806@domain.hid>
From: <thomas.debes@domain.hid>
Subject: Re: [Xenomai-help] Floating Point Exceptions in RT-Tasks
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: gilles.chanteperdrix@xenomai.org
Cc: xenomai@xenomai.org

In the meanwhile I tried it with Xenomai 2.4.6 (was 2.3.5 before). The =
effect is still the same. Is there anything else I can do?

Thomas

-----Urspr=FCngliche Nachricht-----
Von: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org
Gesendet: Freitag, 13. Februar 2009 15:01
An: Debes, Thomas RAEK3 MRA
Cc: xenomai@xenomai.org
Betreff: Re: [Xenomai-help] Floating Point Exceptions in RT-Tasks

Gilles Chanteperdrix wrote:
> thomas.debes@domain.hid wrote:
>> Hi,
>>
>> I successfully managed to enable FP Exceptions on our MPC5200 board =
for
>> plain linux applications (via fesetenv). When I put the same trigger
>> code (DivByZero) into a (native) RT task no exception is triggered =
until
>> I force a mode switch to secondary mode (e.g. printf). How can I get
>> them without performing the mode switch?
>=20
> An FPU exception triggers a signal, and signal can only be sent to a
> task running in secondary mode. So, even if we managed to get the =
signal
> to be sent to the task immediately, it would cause it to switch to
> secondary mode. Is it really what you want?

Actually, this should not happen. Could you send us a test program?

--=20
                                                 Gilles.

