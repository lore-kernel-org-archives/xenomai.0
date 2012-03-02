Message-ID: <4F509C26.7070308@domain.hid>
Date: Fri, 02 Mar 2012 11:08:38 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAHOEnGfih5tin7NAnf-qU6tKxVtnb=LjuBFE5QxFQpxfA=EBkg@domain.hid>
	<CAHOEnGdKstVsBUKnQcCm3NK4BfngnGOAKfimXA5VL=ujUzR2ig@domain.hid>
	<4F3AAA52.6060802@domain.hid>
	<CAHOEnGdzwe3gj5c_PAkqBHsYCz=-+McZkDTz7kSOLUQyVDVDyg@domain.hid>
	<4F46C7CD.1070509@domain.hid>
	<CAHOEnGfV3f6aKwzvU+cAkofDXhoHXKQU4YRexUatB85KtTYiDg@domain.hid>
	<4F4920DE.40600@domain.hid>
	<CAHOEnGcVoRVtfL0Fgz-zx-==2YkM7QH3abtSLDaZdyVo0gk60Q@mail.gmail.com>
	<CAHOEnGfcSwNEi61Kq9=HHzNrMTV6eFc9ZzJJTSqKZRD4wS9juA@mail.gmail.com>
	<4F509B3C.9030105@domain.hid>
In-Reply-To: <4F509B3C.9030105@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Freeze while running examples
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?UTF-8?B?T3NjYXIgRMOhdmlsYQ==?= <odavilar@domain.hid>
Cc: xenomai@xenomai.org

On 03/02/2012 11:04 AM, Gilles Chanteperdrix wrote:
> On 03/01/2012 05:23 AM, Oscar D=C3=A1vila wrote:
>> Finally i could get the dump
>>
>>
>> post-prompt
>> No breakpoints or watchpoints.
>>
>> breakpoints-table-end
>>
>> post-prompt
>> Dump of assembler code for function __ipipe_sync_stage:
>> 0xc106d376 <__ipipe_sync_stage+0>:	push   %ebp
>> (...)
>> 0xc106d526 <__ipipe_sync_stage+432>:	ret
>> End of assembler dump.
>=20
> The address where the EIP is when the NMI watchdog triggers is
> 0xc106d5e1, so, outside this code.
>=20
And this dump does not seem to correspond to the kernel that was running
when the bug happened, because in that case we had

0xc106d5e1 =3D=3D __ipipe_sync_stage + 0x21b

whereas in your dump,

__ipipe_sync_stage + 0x21b =3D=3D 0xc106d591

--=20
					   Gilles.


