Message-ID: <4F516540.5030801@domain.hid>
Date: Sat, 03 Mar 2012 01:26:40 +0100
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
	<4F509B3C.9030105@domain.hid> <4F509C26.7070308@domain.hid>
	<CAHOEnGegK_DzKg_RTf7yadD2mAxJJOSgdpMn+nxRCHsjAp7mrg@domain.hid>
In-Reply-To: <CAHOEnGegK_DzKg_RTf7yadD2mAxJJOSgdpMn+nxRCHsjAp7mrg@domain.hid>
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

On 03/03/2012 01:14 AM, Oscar D=C3=A1vila wrote:
> 2012/3/2 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>=20
>> On 03/02/2012 11:04 AM, Gilles Chanteperdrix wrote:
>>> On 03/01/2012 05:23 AM, Oscar D=C3=A1vila wrote:
>>>> Finally i could get the dump
>>>>
>>>>
>>>> post-prompt
>>>> No breakpoints or watchpoints.
>>>>
>>>> breakpoints-table-end
>>>>
>>>> post-prompt
>>>> Dump of assembler code for function __ipipe_sync_stage:
>>>> 0xc106d376 <__ipipe_sync_stage+0>:   push   %ebp
>>>> (...)
>>>> 0xc106d526 <__ipipe_sync_stage+432>: ret
>>>> End of assembler dump.
>>>
>>> The address where the EIP is when the NMI watchdog triggers is
>>> 0xc106d5e1, so, outside this code.
>>>
>> And this dump does not seem to correspond to the kernel that was runni=
ng
>> when the bug happened, because in that case we had
>>
>> 0xc106d5e1 =3D=3D __ipipe_sync_stage + 0x21b
>>
>> whereas in your dump,
>>
>> __ipipe_sync_stage + 0x21b =3D=3D 0xc106d591
>>
>> Sorry about that, i lost that image of the kernel.
>=20
> Here is a new complete test.
>=20
> Kernel Messages
>=20
>=20
> Kernel failure message 1:
> BUG: NMI Watchdog detected LOCKUP on CPU0, ip c10751d3, registers:
>
> 			local_irq_disable_hw();
> c10751bf:	fa                   	cli
> c10751c0:	89 e0                	mov    %esp,%eax
> c10751c2:	25 00 e0 ff ff       	and    $0xffffe000,%eax
> 			root_stall_after_handler();
> 			while (__ipipe_check_root_resched())
> c10751c7:	83 78 14 00          	cmpl   $0x0,0x14(%eax)
> c10751cb:	75 58                	jne    c1075225 <__xirq_end+0x2>
> c10751cd:	f6 40 08 08          	testb  $0x8,0x8(%eax)
> c10751d1:	74 52                	je     c1075225 <__xirq_end+0x2>
> c10751d3:	eb f8                	jmp    c10751cd <__ipipe_sync_stage+0x1=
2b>
> 				__ipipe_preempt_schedule_irq();

Looks like an infinite loop when CONFIG_PREEMPT is off. Try putting an
#ifdef CONFIG_PREEMPT around this code:

#ifdef CONFIG_PREEMPT
 			while (__ipipe_check_root_resched())
 				__ipipe_preempt_schedule_irq();
#endif

To test that this is indeed the issue, you may try enabling
CONFIG_PREEMPT in the code.



>=20


--=20
                                                                Gilles.


