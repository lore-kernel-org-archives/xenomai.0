MIME-Version: 1.0
In-Reply-To: <CAHOEnGfcSwNEi61Kq9=HHzNrMTV6eFc9ZzJJTSqKZRD4wS9juA@mail.gmail.com>
References: <CAHOEnGfih5tin7NAnf-qU6tKxVtnb=LjuBFE5QxFQpxfA=EBkg@domain.hid>
	<CAHOEnGdKstVsBUKnQcCm3NK4BfngnGOAKfimXA5VL=ujUzR2ig@domain.hid>
	<4F3AAA52.6060802@domain.hid>
	<CAHOEnGdzwe3gj5c_PAkqBHsYCz=-+McZkDTz7kSOLUQyVDVDyg@domain.hid>
	<4F46C7CD.1070509@domain.hid>
	<CAHOEnGfV3f6aKwzvU+cAkofDXhoHXKQU4YRexUatB85KtTYiDg@domain.hid>
	<4F4920DE.40600@domain.hid>
	<CAHOEnGcVoRVtfL0Fgz-zx-==2YkM7QH3abtSLDaZdyVo0gk60Q@mail.gmail.com>
	<CAHOEnGfcSwNEi61Kq9=HHzNrMTV6eFc9ZzJJTSqKZRD4wS9juA@mail.gmail.com>
From: =?ISO-8859-1?Q?Oscar_D=E1vila?= <odavilar@domain.hid>
Date: Thu, 1 Mar 2012 21:46:05 -0600
Message-ID: <CAHOEnGd+cCVPQ9OJzD5+wLoyd9kBB-Ye5hbJtLCJbAzugxwQig@domain.hid>
Content-Type: multipart/alternative; boundary=f46d044468dbd5078e04ba3a6b0e
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

--f46d044468dbd5078e04ba3a6b0e
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

2012/2/29 Oscar D=E1vila <odavilar@domain.hid>

>
> 2012/2/29 Oscar D=E1vila <odavilar@domain.hid>
>
>>
>> 2012/2/25 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>>
>>> On 02/24/2012 11:55 PM, Oscar D=E1vila wrote:
>>> > 2012/2/23 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>>> >
>>> >> On 02/23/2012 11:43 PM, Oscar D=E1vila wrote:
>>> >>> 2012/2/14 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>>> >>>
>>> >>>> On 02/14/2012 06:54 PM, Oscar D=E1vila wrote:
>>> >>>>> I compiled Xenomai succesfully, but when i try to run an example =
it
>>> >>>> freezes
>>> >>>>> / machine look up, any help will be apreciated, thanks.
>>> >>>>>
>>> >>>>> Here is some info about the system, its a Debian 6.0 with a
>>> >>>>> kernel 2.6.35.9, xenomai-2.6.0, the adeos
>>> >>>>> patch adeos-ipipe-2.6.35.9-x86-2.8-04.patch and Im also using the
>>> >>>>> nmi_watchdog=3D2 in the boot kernel options.
>>> >>>>
>>> >>>> Please reproduce the bug:
>>> >>>> - in text mode, so as to have the full bug trace;
>>> >>>> - with frame pointers enabled;
>>> >>>> - with highest kernel verbosity for BUGs and backtraces.
>>> >>>>
>>> >>>
>>> >>> How do i do this last point? i mean, i already compile kernel with
>>> frame
>>> >>> pointers enabled, also i already ran it in text mode, and i active
>>> all
>>> >> the
>>> >>> xenomai debug kernel options. i saw some other debug options in
>>> kernel
>>> >>> hacking, do i have to active those ones too?
>>> >>
>>> >> The stack trace looks fine. Could you show us the disassembly of the
>>> >> __ipipe_sync_stage function?
>>> >>
>>> >>
>>> > Here is what i think is the disassembly of the __ipipe_sync_stage
>>> function,
>>> > the full disassembly of the core.c file is in
>>> > http://odavilar.0x1fee3.org/xenomai/__ipipe_sync_stage
>>>
>>> Please obtain the disassembly with objdump -d vmlinx, so that we get th=
e
>>> addresses corresponding with the instructions. Without the addresses, w=
e
>>> do not know where to look.
>>>
>>
>> I need some help here, i've already dump the vmlinux image, but i get th=
e
>> asm with addresses but without the source so i don't know how to get the
>> __ipipe_sync_stage function, y tried objdump -S vmlinux but didnt worked=
,
>> do i have to check an option in the .config of the kernel to be able to =
get
>> the source?
>>
>>
>> Thanks again.
>>
>>
> Finally i could get the dump
>
>
> post-prompt
> No breakpoints or watchpoints.
>
> breakpoints-table-end
>
> post-prompt
> Dump of assembler code for function __ipipe_sync_stage:
> 0xc106d376 <__ipipe_sync_stage+0>:	push   %ebp
> 0xc106d377 <__ipipe_sync_stage+1>:	mov    %esp,%ebp
> 0xc106d379 <__ipipe_sync_stage+3>:	push   %edi
> 0xc106d37a <__ipipe_sync_stage+4>:	push   %esi
> 0xc106d37b <__ipipe_sync_stage+5>:	push   %ebx
> 0xc106d37c <__ipipe_sync_stage+6>:	sub    $0x28,%esp
> 0xc106d37f <__ipipe_sync_stage+9>:	mov    $0xc1439694,%edx
> 0xc106d384 <__ipipe_sync_stage+14>:	mov    %fs:0xc1432f14,%eax
> 0xc106d38a <__ipipe_sync_stage+20>:	mov    (%eax,%edx,1),%esi
> 0xc106d38d <__ipipe_sync_stage+23>:	mov    $0xc1433cf4,%edx
> 0xc106d392 <__ipipe_sync_stage+28>:	add    %edx,%eax
> 0xc106d394 <__ipipe_sync_stage+30>:	imul   $0x1668,(%esi),%ecx
> 0xc106d39a <__ipipe_sync_stage+36>:	add    %ecx,%eax
> 0xc106d39c <__ipipe_sync_stage+38>:	btsl   $0x0,(%eax)
> 0xc106d3a0 <__ipipe_sync_stage+42>:	lea    0x4(%esi),%ecx
> 0xc106d3a3 <__ipipe_sync_stage+45>:	mov    %ecx,-0x20(%ebp)
> 0xc106d3a6 <__ipipe_sync_stage+48>:	mov    $0xc143302c,%ebx
> 0xc106d3ab <__ipipe_sync_stage+53>:	mov    %ebx,-0x10(%ebp)
> 0xc106d3ae <__ipipe_sync_stage+56>:	mov    %edx,-0x28(%ebp)
> 0xc106d3b1 <__ipipe_sync_stage+59>:	lea    0x10(%eax),%edx
> 0xc106d3b4 <__ipipe_sync_stage+62>:	mov    %edx,-0x14(%ebp)
> 0xc106d3b7 <__ipipe_sync_stage+65>:	lea    0x8(%eax),%ecx
> 0xc106d3ba <__ipipe_sync_stage+68>:	mov    %ecx,-0x18(%ebp)
> 0xc106d3bd <__ipipe_sync_stage+71>:	lea    0x4(%eax),%ebx
> 0xc106d3c0 <__ipipe_sync_stage+74>:	mov    %ebx,-0x1c(%ebp)
> 0xc106d3c3 <__ipipe_sync_stage+77>:	mov    %esi,-0x30(%ebp)
> 0xc106d3c6 <__ipipe_sync_stage+80>:	mov    0x4(%eax),%edx
> 0xc106d3c9 <__ipipe_sync_stage+83>:	test   %edx,%edx
> 0xc106d3cb <__ipipe_sync_stage+85>:	je     0xc106d51b <__ipipe_sync_stage=
+421>
> 0xc106d3d1 <__ipipe_sync_stage+91>:	bsr    %edx,%edx
> 0xc106d3d4 <__ipipe_sync_stage+94>:	mov    0x8(%eax,%edx,4),%ecx
> 0xc106d3d8 <__ipipe_sync_stage+98>:	test   %ecx,%ecx
> 0xc106d3da <__ipipe_sync_stage+100>:	je     0xc106d51b <__ipipe_sync_stag=
e+421>
> 0xc106d3e0 <__ipipe_sync_stage+106>:	bsr    %ecx,%ecx
> 0xc106d3e3 <__ipipe_sync_stage+109>:	mov    %edx,%ebx
> 0xc106d3e5 <__ipipe_sync_stage+111>:	shl    $0x5,%ebx
> 0xc106d3e8 <__ipipe_sync_stage+114>:	add    %ebx,%ecx
> 0xc106d3ea <__ipipe_sync_stage+116>:	lea    0x4(%ecx),%edi
> 0xc106d3ed <__ipipe_sync_stage+119>:	mov    (%eax,%edi,4),%ebx
> 0xc106d3f0 <__ipipe_sync_stage+122>:	test   %ebx,%ebx
> 0xc106d3f2 <__ipipe_sync_stage+124>:	je     0xc106d51b <__ipipe_sync_stag=
e+421>
> 0xc106d3f8 <__ipipe_sync_stage+130>:	bsr    %ebx,%esi
> 0xc106d3fb <__ipipe_sync_stage+133>:	mov    %ecx,%ebx
> 0xc106d3fd <__ipipe_sync_stage+135>:	shl    $0x5,%ebx
> 0xc106d400 <__ipipe_sync_stage+138>:	mov    %ebx,-0x24(%ebp)
> 0xc106d403 <__ipipe_sync_stage+141>:	mov    -0x24(%ebp),%ebx
> 0xc106d406 <__ipipe_sync_stage+144>:	add    %esi,%ebx
> 0xc106d408 <__ipipe_sync_stage+146>:	mov    -0x14(%ebp),%esi
> 0xc106d40b <__ipipe_sync_stage+149>:	btr    %ebx,(%esi)
> 0xc106d40e <__ipipe_sync_stage+152>:	cmpl   $0x0,(%eax,%edi,4)
> 0xc106d412 <__ipipe_sync_stage+156>:	jne    0xc106d427 <__ipipe_sync_stag=
e+177>
> 0xc106d414 <__ipipe_sync_stage+158>:	mov    -0x18(%ebp),%esi
> 0xc106d417 <__ipipe_sync_stage+161>:	btr    %ecx,(%esi)
> 0xc106d41a <__ipipe_sync_stage+164>:	cmpl   $0x0,0x8(%eax,%edx,4)
> 0xc106d41f <__ipipe_sync_stage+169>:	jne    0xc106d427 <__ipipe_sync_stag=
e+177>
> 0xc106d421 <__ipipe_sync_stage+171>:	mov    -0x1c(%ebp),%ecx
> 0xc106d424 <__ipipe_sync_stage+174>:	btr    %edx,(%ecx)
> 0xc106d427 <__ipipe_sync_stage+177>:	test   %ebx,%ebx
> 0xc106d429 <__ipipe_sync_stage+179>:	js     0xc106d51b <__ipipe_sync_stag=
e+421>
> 0xc106d42f <__ipipe_sync_stage+185>:	lea    0x2(%ebx),%edx
> 0xc106d432 <__ipipe_sync_stage+188>:	shl    $0x7,%edx
> 0xc106d435 <__ipipe_sync_stage+191>:	mov    -0x30(%ebp),%esi
> 0xc106d438 <__ipipe_sync_stage+194>:	testb  $0x20,(%esi,%edx,1)
> 0xc106d43c <__ipipe_sync_stage+198>:	jne    0xc106d3c6 <__ipipe_sync_stag=
e+80>
> 0xc106d43e <__ipipe_sync_stage+200>:	mov    -0x20(%ebp),%eax
> 0xc106d441 <__ipipe_sync_stage+203>:	cmp    0xc13c6fd0,%eax
> 0xc106d447 <__ipipe_sync_stage+209>:	je     0xc106d44a <__ipipe_sync_stag=
e+212>
> 0xc106d449 <__ipipe_sync_stage+211>:	sti
> 0xc106d44a <__ipipe_sync_stage+212>:	cmp    $0xc150c080,%esi
> 0xc106d450 <__ipipe_sync_stage+218>:	je     0xc106d468 <__ipipe_sync_stag=
e+242>
> 0xc106d452 <__ipipe_sync_stage+220>:	lea    0x2(%ebx),%ecx
> 0xc106d455 <__ipipe_sync_stage+223>:	shl    $0x7,%ecx
> 0xc106d458 <__ipipe_sync_stage+226>:	mov    0xc(%ecx,%esi,1),%edx
> 0xc106d45c <__ipipe_sync_stage+230>:	mov    %ebx,%eax
> 0xc106d45e <__ipipe_sync_stage+232>:	call   *0x8(%esi,%ecx,1)
> 0xc106d462 <__ipipe_sync_stage+236>:	cli
> 0xc106d463 <__ipipe_sync_stage+237>:	jmp    0xc106d4f9 <__ipipe_sync_stag=
e+387>
> 0xc106d468 <__ipipe_sync_stage+242>:	lea    -0x520(%ebx),%eax
> 0xc106d46e <__ipipe_sync_stage+248>:	cmp    $0x1f,%eax
> 0xc106d471 <__ipipe_sync_stage+251>:	lea    0x2(%ebx),%edi
> 0xc106d474 <__ipipe_sync_stage+254>:	ja     0xc106d4a9 <__ipipe_sync_stag=
e+307>
> 0xc106d476 <__ipipe_sync_stage+256>:	call   0xc102d215 <irq_enter>
> 0xc106d47b <__ipipe_sync_stage+261>:	mov    %edi,%ecx
> 0xc106d47d <__ipipe_sync_stage+263>:	shl    $0x7,%ecx
> 0xc106d480 <__ipipe_sync_stage+266>:	mov    -0x3eaf3f74(%ecx),%edx
> 0xc106d486 <__ipipe_sync_stage+272>:	mov    %ebx,%eax
> 0xc106d488 <__ipipe_sync_stage+274>:	call   *-0x3eaf3f78(%ecx)
> 0xc106d48e <__ipipe_sync_stage+280>:	call   0xc102d523 <irq_exit>
> 0xc106d493 <__ipipe_sync_stage+285>:	cli
> 0xc106d494 <__ipipe_sync_stage+286>:	mov    %esp,%eax
> 0xc106d496 <__ipipe_sync_stage+288>:	and    $0xffffe000,%eax
> 0xc106d49b <__ipipe_sync_stage+293>:	cmpl   $0x0,0x14(%eax)
> 0xc106d49f <__ipipe_sync_stage+297>:	jne    0xc106d4f9 <__ipipe_sync_stag=
e+387>
> 0xc106d4a1 <__ipipe_sync_stage+299>:	testb  $0x8,0x8(%eax)
> 0xc106d4a5 <__ipipe_sync_stage+303>:	je     0xc106d4f9 <__ipipe_sync_stag=
e+387>
> 0xc106d4a7 <__ipipe_sync_stage+305>:	jmp    0xc106d4a1 <__ipipe_sync_stag=
e+299>
> 0xc106d4a9 <__ipipe_sync_stage+307>:	shl    $0x7,%edi
> 0xc106d4ac <__ipipe_sync_stage+310>:	mov    -0x3eaf3f78(%edi),%edx
> 0xc106d4b2 <__ipipe_sync_stage+316>:	mov    %fs:0xc1432f14,%edi
> 0xc106d4b9 <__ipipe_sync_stage+323>:	add    -0x10(%ebp),%edi
> 0xc106d4bc <__ipipe_sync_stage+326>:	mov    %ebx,%eax
> 0xc106d4be <__ipipe_sync_stage+328>:	mov    %edx,-0x2c(%ebp)
> 0xc106d4c1 <__ipipe_sync_stage+331>:	call   0xc10145c3 <__ipipe_get_ioapi=
c_irq_vector>
> 0xc106d4c6 <__ipipe_sync_stage+336>:	not    %eax
> 0xc106d4c8 <__ipipe_sync_stage+338>:	mov    %eax,0x2c(%edi)
> 0xc106d4cb <__ipipe_sync_stage+341>:	mov    %ebx,%eax
> 0xc106d4cd <__ipipe_sync_stage+343>:	not    %eax
> 0xc106d4cf <__ipipe_sync_stage+345>:	mov    -0x2c(%ebp),%edx
> 0xc106d4d2 <__ipipe_sync_stage+348>:	pushf
> 0xc106d4d3 <__ipipe_sync_stage+349>:	orl    $0x200,(%esp)
> 0xc106d4da <__ipipe_sync_stage+356>:	push   %cs
> 0xc106d4db <__ipipe_sync_stage+357>:	push   $0xc106d4f7
> 0xc106d4e0 <__ipipe_sync_stage+362>:	push   %eax
> 0xc106d4e1 <__ipipe_sync_stage+363>:	push   %gs
> 0xc106d4e3 <__ipipe_sync_stage+365>:	push   %fs
> 0xc106d4e5 <__ipipe_sync_stage+367>:	push   %es
> 0xc106d4e6 <__ipipe_sync_stage+368>:	push   %ds
> 0xc106d4e7 <__ipipe_sync_stage+369>:	push   %eax
> 0xc106d4e8 <__ipipe_sync_stage+370>:	push   %ebp
> 0xc106d4e9 <__ipipe_sync_stage+371>:	push   %edi
> 0xc106d4ea <__ipipe_sync_stage+372>:	push   %esi
> 0xc106d4eb <__ipipe_sync_stage+373>:	push   %edx
> 0xc106d4ec <__ipipe_sync_stage+374>:	push   %ecx
> 0xc106d4ed <__ipipe_sync_stage+375>:	push   %ebx
> 0xc106d4ee <__ipipe_sync_stage+376>:	mov    %edi,%eax
> 0xc106d4f0 <__ipipe_sync_stage+378>:	call   *%edx
> 0xc106d4f2 <__ipipe_sync_stage+380>:	jmp    0xc1269fd8
> 0xc106d4f7 <__ipipe_sync_stage+385>:	cli
> 0xc106d4f8 <__ipipe_sync_stage+386>:	cli
> 0xc106d4f9 <__ipipe_sync_stage+387>:	mov    %fs:0xc1432f14,%ecx
> 0xc106d500 <__ipipe_sync_stage+394>:	mov    $0xc1439694,%edx
> 0xc106d505 <__ipipe_sync_stage+399>:	mov    -0x28(%ebp),%ebx
> 0xc106d508 <__ipipe_sync_stage+402>:	lea    (%ecx,%ebx,1),%eax
> 0xc106d50b <__ipipe_sync_stage+405>:	mov    (%ecx,%edx,1),%edx
> 0xc106d50e <__ipipe_sync_stage+408>:	imul   $0x1668,(%edx),%edx
> 0xc106d514 <__ipipe_sync_stage+414>:	add    %edx,%eax
> 0xc106d516 <__ipipe_sync_stage+416>:	jmp    0xc106d3b1 <__ipipe_sync_stag=
e+59>
> 0xc106d51b <__ipipe_sync_stage+421>:	btrl   $0x0,(%eax)
> 0xc106d51f <__ipipe_sync_stage+425>:	add    $0x28,%esp
> 0xc106d522 <__ipipe_sync_stage+428>:	pop    %ebx
> 0xc106d523 <__ipipe_sync_stage+429>:	pop    %esi
> 0xc106d524 <__ipipe_sync_stage+430>:	pop    %edi
> 0xc106d525 <__ipipe_sync_stage+431>:	pop    %ebp
> 0xc106d526 <__ipipe_sync_stage+432>:	ret
> End of assembler dump.
>
> post-prompt
> No breakpoints or watchpoints.
>
>
> breakpoints-table-end
>
> Thanks again!
>
>
http://odavilar.0x1fee3.org/dump__ipipe_sync_stage

c106d376 <__ipipe_sync_stage>:
 * return of this routine.
 *
 * This routine must be called with hw interrupts off.
 */
void __ipipe_sync_stage(void)
{
c106d376:	55                   	push   %ebp
c106d377:	89 e5                	mov    %esp,%ebp
c106d379:	57                   	push   %edi
c106d37a:	56                   	push   %esi
c106d37b:	53                   	push   %ebx
c106d37c:	83 ec 28             	sub    $0x28,%esp
	struct ipipe_percpu_domain_data *p;
	struct ipipe_domain *ipd;
	int irq;

	ipd =3D __ipipe_current_domain;
c106d37f:	ba 94 96 43 c1       	mov    $0xc1439694,%edx
c106d384:	64 a1 14 2f 43 c1    	mov    %fs:0xc1432f14,%eax
c106d38a:	8b 34 10             	mov    (%eax,%edx,1),%esi
	p =3D ipipe_cpudom_ptr(ipd);
c106d38d:	ba f4 3c 43 c1       	mov    $0xc1433cf4,%edx
c106d392:	01 d0                	add    %edx,%eax
c106d394:	69 0e 68 16 00 00    	imul   $0x1668,(%esi),%ecx
c106d39a:	01 c8                	add    %ecx,%eax
c106d39c:	0f ba 28 00          	btsl   $0x0,(%eax)
		barrier();

		if (test_bit(IPIPE_LOCK_FLAG, &ipd->irqs[irq].control))
			continue;

		if (!__ipipe_pipeline_head_p(ipd))
c106d3a0:	8d 4e 04             	lea    0x4(%esi),%ecx
c106d3a3:	89 4d e0             	mov    %ecx,-0x20(%ebp)
void __ipipe_end_edge_irq(unsigned irq, struct irq_desc *desc);

static inline void __do_root_xirq(ipipe_irq_handler_t handler,
				  unsigned int irq)
{
	struct pt_regs *regs =3D &__raw_get_cpu_var(__ipipe_tick_regs);
c106d3a6:	bb 2c 30 43 c1       	mov    $0xc143302c,%ebx
c106d3ab:	89 5d f0             	mov    %ebx,-0x10(%ebp)
			__ipipe_do_root_xirq(ipd, irq);
			local_irq_disable_hw();
			root_stall_after_handler();
		}

		p =3D ipipe_cpudom_ptr(__ipipe_current_domain);
c106d3ae:	89 55 d8             	mov    %edx,-0x28(%ebp)
	clear_bit(nr, addr);
}

static inline void __clear_bit(int nr, volatile unsigned long *addr)
{
	asm volatile("btr %1,%0" : ADDR : "Ir" (nr));
c106d3b1:	8d 50 10             	lea    0x10(%eax),%edx
c106d3b4:	89 55 ec             	mov    %edx,-0x14(%ebp)
c106d3b7:	8d 48 08             	lea    0x8(%eax),%ecx
c106d3ba:	89 4d e8             	mov    %ecx,-0x18(%ebp)
c106d3bd:	8d 58 04             	lea    0x4(%eax),%ebx
c106d3c0:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
c106d3c3:	89 75 d0             	mov    %esi,-0x30(%ebp)
{
	int l0b, l1b, l2b;
	unsigned long l0m, l1m, l2m;
	unsigned int irq;

	l0m =3D p->irqpend_himap;
c106d3c6:	8b 50 04             	mov    0x4(%eax),%edx
	if (unlikely(l0m =3D=3D 0))
c106d3c9:	85 d2                	test   %edx,%edx
c106d3cb:	0f 84 4a 01 00 00    	je     c106d51b <__xirq_end+0x24>

int __ipipe_handle_irq(struct pt_regs *regs);

static inline unsigned long __ipipe_ffnz(unsigned long ul)
{
      __asm__("bsrl %1, %0":"=3Dr"(ul)
c106d3d1:	0f bd d2             	bsr    %edx,%edx
		return -1;

	l0b =3D __ipipe_ffnz(l0m);
	l1m =3D p->irqpend_mdmap[l0b];
c106d3d4:	8b 4c 90 08          	mov    0x8(%eax,%edx,4),%ecx
	if (unlikely(l1m =3D=3D 0))
c106d3d8:	85 c9                	test   %ecx,%ecx
c106d3da:	0f 84 3b 01 00 00    	je     c106d51b <__xirq_end+0x24>
c106d3e0:	0f bd c9             	bsr    %ecx,%ecx
		return -1;

	l1b =3D __ipipe_ffnz(l1m) + l0b * BITS_PER_LONG;
c106d3e3:	89 d3                	mov    %edx,%ebx
c106d3e5:	c1 e3 05             	shl    $0x5,%ebx
c106d3e8:	01 d9                	add    %ebx,%ecx
	l2m =3D p->irqpend_lomap[l1b];
c106d3ea:	8d 79 04             	lea    0x4(%ecx),%edi
c106d3ed:	8b 1c b8             	mov    (%eax,%edi,4),%ebx
	if (unlikely(l2m =3D=3D 0))
c106d3f0:	85 db                	test   %ebx,%ebx
c106d3f2:	0f 84 23 01 00 00    	je     c106d51b <__xirq_end+0x24>
c106d3f8:	0f bd f3             	bsr    %ebx,%esi
		return -1;

	l2b =3D __ipipe_ffnz(l2m);
	irq =3D l1b * BITS_PER_LONG + l2b;
c106d3fb:	89 cb                	mov    %ecx,%ebx
c106d3fd:	c1 e3 05             	shl    $0x5,%ebx
c106d400:	89 5d dc             	mov    %ebx,-0x24(%ebp)
c106d403:	8b 5d dc             	mov    -0x24(%ebp),%ebx
c106d406:	01 f3                	add    %esi,%ebx
c106d408:	8b 75 ec             	mov    -0x14(%ebp),%esi
c106d40b:	0f b3 1e             	btr    %ebx,(%esi)

	__clear_bit(irq, p->irqpend_lomap);
	if (p->irqpend_lomap[l1b] =3D=3D 0) {
c106d40e:	83 3c b8 00          	cmpl   $0x0,(%eax,%edi,4)
c106d412:	75 13                	jne    c106d427 <__ipipe_sync_stage+0xb1>
c106d414:	8b 75 e8             	mov    -0x18(%ebp),%esi
c106d417:	0f b3 0e             	btr    %ecx,(%esi)
		__clear_bit(l1b, p->irqpend_mdmap);
		if (p->irqpend_mdmap[l0b] =3D=3D 0)
c106d41a:	83 7c 90 08 00       	cmpl   $0x0,0x8(%eax,%edx,4)
c106d41f:	75 06                	jne    c106d427 <__ipipe_sync_stage+0xb1>
c106d421:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
c106d424:	0f b3 11             	btr    %edx,(%ecx)
	if (ipd =3D=3D ipipe_root_domain)
		trace_hardirqs_off();

	for (;;) {
		irq =3D __ipipe_next_irq(p);
		if (irq < 0)
c106d427:	85 db                	test   %ebx,%ebx
c106d429:	0f 88 ec 00 00 00    	js     c106d51b <__xirq_end+0x24>
		 * that all updates to maps are done before the
		 * handler gets called.
		 */
		barrier();

		if (test_bit(IPIPE_LOCK_FLAG, &ipd->irqs[irq].control))
c106d42f:	8d 53 02             	lea    0x2(%ebx),%edx
c106d432:	c1 e2 07             	shl    $0x7,%edx
c106d435:	8b 75 d0             	mov    -0x30(%ebp),%esi
c106d438:	f6 04 16 20          	testb  $0x20,(%esi,%edx,1)
c106d43c:	75 88                	jne    c106d3c6 <__ipipe_sync_stage+0x50>
			continue;

		if (!__ipipe_pipeline_head_p(ipd))
c106d43e:	8b 45 e0             	mov    -0x20(%ebp),%eax
c106d441:	3b 05 d0 6f 3c c1    	cmp    0xc13c6fd0,%eax
c106d447:	74 01                	je     c106d44a <__ipipe_sync_stage+0xd4>
			local_irq_enable_hw();
c106d449:	fb                   	sti

		if (likely(ipd !=3D ipipe_root_domain)) {
c106d44a:	81 fe 80 c0 50 c1    	cmp    $0xc150c080,%esi
c106d450:	74 16                	je     c106d468 <__ipipe_sync_stage+0xf2>
			ipd->irqs[irq].handler(irq, ipd->irqs[irq].cookie);
c106d452:	8d 4b 02             	lea    0x2(%ebx),%ecx
c106d455:	c1 e1 07             	shl    $0x7,%ecx
c106d458:	8b 54 31 0c          	mov    0xc(%ecx,%esi,1),%edx
c106d45c:	89 d8                	mov    %ebx,%eax
c106d45e:	ff 54 0e 08          	call   *0x8(%esi,%ecx,1)
			__ipipe_run_irqtail(irq);
			local_irq_disable_hw();
c106d462:	fa                   	cli
c106d463:	e9 91 00 00 00       	jmp    c106d4f9 <__xirq_end+0x2>
		} else if (ipipe_virtual_irq_p(irq)) {
c106d468:	8d 83 e0 fa ff ff    	lea    -0x520(%ebx),%eax
c106d46e:	83 f8 1f             	cmp    $0x1f,%eax
c106d471:	8d 7b 02             	lea    0x2(%ebx),%edi
c106d474:	77 33                	ja     c106d4a9 <__ipipe_sync_stage+0x133>
			irq_enter();
c106d476:	e8 9a fd fb ff       	call   c102d215 <irq_enter>
			ipd->irqs[irq].handler(irq, ipd->irqs[irq].cookie);
c106d47b:	89 f9                	mov    %edi,%ecx
c106d47d:	c1 e1 07             	shl    $0x7,%ecx
c106d480:	8b 91 8c c0 50 c1    	mov    -0x3eaf3f74(%ecx),%edx
c106d486:	89 d8                	mov    %ebx,%eax
c106d488:	ff 91 88 c0 50 c1    	call   *-0x3eaf3f78(%ecx)
			irq_exit();
c106d48e:	e8 90 00 fc ff       	call   c102d523 <irq_exit>
			local_irq_disable_hw();
c106d493:	fa                   	cli
c106d494:	89 e0                	mov    %esp,%eax
c106d496:	25 00 e0 ff ff       	and    $0xffffe000,%eax
			root_stall_after_handler();
			while (__ipipe_check_root_resched())
c106d49b:	83 78 14 00          	cmpl   $0x0,0x14(%eax)
c106d49f:	75 58                	jne    c106d4f9 <__xirq_end+0x2>
c106d4a1:	f6 40 08 08          	testb  $0x8,0x8(%eax)
c106d4a5:	74 52                	je     c106d4f9 <__xirq_end+0x2>
c106d4a7:	eb f8                	jmp    c106d4a1 <__ipipe_sync_stage+0x12b>
				__ipipe_preempt_schedule_irq();
		} else {
			__ipipe_do_root_xirq(ipd, irq);
c106d4a9:	c1 e7 07             	shl    $0x7,%edi
c106d4ac:	8b 97 88 c0 50 c1    	mov    -0x3eaf3f78(%edi),%edx
void __ipipe_end_edge_irq(unsigned irq, struct irq_desc *desc);

static inline void __do_root_xirq(ipipe_irq_handler_t handler,
				  unsigned int irq)
{
	struct pt_regs *regs =3D &__raw_get_cpu_var(__ipipe_tick_regs);
c106d4b2:	64 8b 3d 14 2f 43 c1 	mov    %fs:0xc1432f14,%edi
c106d4b9:	03 7d f0             	add    -0x10(%ebp),%edi

static inline unsigned __ipipe_get_irq_vector(int irq)
{
#ifdef CONFIG_X86_IO_APIC
	unsigned __ipipe_get_ioapic_irq_vector(int irq);
	return __ipipe_get_ioapic_irq_vector(irq);
c106d4bc:	89 d8                	mov    %ebx,%eax
c106d4be:	89 55 d4             	mov    %edx,-0x2c(%ebp)
c106d4c1:	e8 fd 70 fa ff       	call   c10145c3 <__ipipe_get_ioapic_irq_vec=
tor>

	regs->orig_ax =3D ~__ipipe_get_irq_vector(irq);
c106d4c6:	f7 d0                	not    %eax
c106d4c8:	89 47 2c             	mov    %eax,0x2c(%edi)

	__asm__ __volatile__("pushfl\n\t"
c106d4cb:	89 d8                	mov    %ebx,%eax
c106d4cd:	f7 d0                	not    %eax
c106d4cf:	8b 55 d4             	mov    -0x2c(%ebp),%edx
c106d4d2:	9c                   	pushf
c106d4d3:	81 0c 24 00 02 00 00 	orl    $0x200,(%esp)
c106d4da:	0e                   	push   %cs
c106d4db:	68 f7 d4 06 c1       	push   $0xc106d4f7
c106d4e0:	50                   	push   %eax
c106d4e1:	0f a8                	push   %gs
c106d4e3:	0f a0                	push   %fs
c106d4e5:	06                   	push   %es
c106d4e6:	1e                   	push   %ds
c106d4e7:	50                   	push   %eax
c106d4e8:	55                   	push   %ebp
c106d4e9:	57                   	push   %edi
c106d4ea:	56                   	push   %esi
c106d4eb:	52                   	push   %edx
c106d4ec:	51                   	push   %ecx
c106d4ed:	53                   	push   %ebx
c106d4ee:	89 f8                	mov    %edi,%eax
c106d4f0:	ff d2                	call   *%edx
c106d4f2:	e9 e1 ca 1f 00       	jmp    c1269fd8 <__kprobes_text_start>

c106d4f7 <__xirq_end>:
c106d4f7:	fa                   	cli
			local_irq_disable_hw();
c106d4f8:	fa                   	cli
			root_stall_after_handler();
		}

		p =3D ipipe_cpudom_ptr(__ipipe_current_domain);
c106d4f9:	64 8b 0d 14 2f 43 c1 	mov    %fs:0xc1432f14,%ecx
c106d500:	ba 94 96 43 c1       	mov    $0xc1439694,%edx
c106d505:	8b 5d d8             	mov    -0x28(%ebp),%ebx
c106d508:	8d 04 19             	lea    (%ecx,%ebx,1),%eax
c106d50b:	8b 14 11             	mov    (%ecx,%edx,1),%edx
c106d50e:	69 12 68 16 00 00    	imul   $0x1668,(%edx),%edx
c106d514:	01 d0                	add    %edx,%eax
c106d516:	e9 96 fe ff ff       	jmp    c106d3b1 <__ipipe_sync_stage+0x3b>
c106d51b:	0f ba 30 00          	btrl   $0x0,(%eax)

	if (ipd =3D=3D ipipe_root_domain)
		trace_hardirqs_on();

	__clear_bit(IPIPE_STALL_FLAG, &p->status);
}
c106d51f:	83 c4 28             	add    $0x28,%esp
c106d522:	5b                   	pop    %ebx
c106d523:	5e                   	pop    %esi
c106d524:	5f                   	pop    %edi
c106d525:	5d                   	pop    %ebp
c106d526:	c3                   	ret


<http://odavilar.0x1fee3.org/dump__ipipe_sync_stage> Another dump now with
the source in it.

Maybe it can be more helpful

Thanks.

--=20
Atentamente:
Oscar D=E1vila Ram=EDrez

--f46d044468dbd5078e04ba3a6b0e
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">2012/2/29 Oscar D=E1vila <span dir=3D"ltr">&lt;<=
a href=3D"mailto:odavilar@domain.hid">odavilar@domain.hid</a>&gt;</span><br><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">

<br><div class=3D"gmail_quote"><div><div></div><div class=3D"h5">2012/2/29 =
Oscar D=E1vila <span dir=3D"ltr">&lt;<a href=3D"mailto:odavilar@domain.hid" =
target=3D"_blank">odavilar@domain.hid</a>&gt;</span><br><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex">


<br><div class=3D"gmail_quote"><div><div></div><div>2012/2/25 Gilles Chante=
perdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org=
i.org" target=3D"_blank">gilles.chanteperdrix@xenomai.org</a>&gt;</span><br=
>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<div><div></div><div>On 02/24/2012 11:55 PM, Oscar D=E1vila wrote:<br>
&gt; 2012/2/23 Gilles Chanteperdrix &lt;<a href=3D"mailto:gilles.chanteperd=
rix@domain.hid" target=3D"_blank">gilles.chanteperdrix@xenomai.org</a>&gt;=
<br>
&gt;<br>
&gt;&gt; On 02/23/2012 11:43 PM, Oscar D=E1vila wrote:<br>
&gt;&gt;&gt; 2012/2/14 Gilles Chanteperdrix &lt;<a href=3D"mailto:gilles.ch=
anteperdrix@domain.hid" target=3D"_blank">gilles.chanteperdrix@xenomai.org=
</a>&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; On 02/14/2012 06:54 PM, Oscar D=E1vila wrote:<br>
&gt;&gt;&gt;&gt;&gt; I compiled Xenomai succesfully, but when i try to run =
an example it<br>
&gt;&gt;&gt;&gt; freezes<br>
&gt;&gt;&gt;&gt;&gt; / machine look up, any help will be apreciated, thanks=
.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Here is some info about the system, its a Debian 6.0 w=
ith a<br>
&gt;&gt;&gt;&gt;&gt; kernel 2.6.35.9, xenomai-2.6.0, the adeos<br>
&gt;&gt;&gt;&gt;&gt; patch adeos-ipipe-2.6.35.9-x86-2.8-04.patch and Im als=
o using the<br>
&gt;&gt;&gt;&gt;&gt; nmi_watchdog=3D2 in the boot kernel options.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Please reproduce the bug:<br>
&gt;&gt;&gt;&gt; - in text mode, so as to have the full bug trace;<br>
&gt;&gt;&gt;&gt; - with frame pointers enabled;<br>
&gt;&gt;&gt;&gt; - with highest kernel verbosity for BUGs and backtraces.<b=
r>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; How do i do this last point? i mean, i already compile kernel =
with frame<br>
&gt;&gt;&gt; pointers enabled, also i already ran it in text mode, and i ac=
tive all<br>
&gt;&gt; the<br>
&gt;&gt;&gt; xenomai debug kernel options. i saw some other debug options i=
n kernel<br>
&gt;&gt;&gt; hacking, do i have to active those ones too?<br>
&gt;&gt;<br>
&gt;&gt; The stack trace looks fine. Could you show us the disassembly of t=
he<br>
&gt;&gt; __ipipe_sync_stage function?<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt; Here is what i think is the disassembly of the __ipipe_sync_stage func=
tion,<br>
&gt; the full disassembly of the core.c file is in<br>
&gt; <a href=3D"http://odavilar.0x1fee3.org/xenomai/__ipipe_sync_stage" tar=
get=3D"_blank">http://odavilar.0x1fee3.org/xenomai/__ipipe_sync_stage</a><b=
r>
<br>
</div></div>Please obtain the disassembly with objdump -d vmlinx, so that w=
e get the<br>
addresses corresponding with the instructions. Without the addresses, we<br=
>
do not know where to look.<br></blockquote><div><br></div></div></div><div>=
I need some help here, i&#39;ve already dump the vmlinux image, but i get t=
he asm with addresses but without the source so i don&#39;t know how to get=
 the __ipipe_sync_stage function, y tried objdump -S vmlinux but didnt work=
ed, do i have to check an option in the .config of the kernel to be able to=
 get the source?</div>



<div><br></div><div><br></div><div>Thanks again.</div></div><div><div><br c=
lear=3D"all"></div></div></blockquote><div><br></div></div></div><div>Final=
ly i could get the dump</div><div><br></div><pre style=3D"word-wrap:break-w=
ord;white-space:pre-wrap">

post-prompt
No breakpoints or watchpoints.

breakpoints-table-end

post-prompt
Dump of assembler code for function __ipipe_sync_stage:
0xc106d376 &lt;__ipipe_sync_stage+0&gt;:	push   %ebp
0xc106d377 &lt;__ipipe_sync_stage+1&gt;:	mov    %esp,%ebp
0xc106d379 &lt;__ipipe_sync_stage+3&gt;:	push   %edi
0xc106d37a &lt;__ipipe_sync_stage+4&gt;:	push   %esi
0xc106d37b &lt;__ipipe_sync_stage+5&gt;:	push   %ebx
0xc106d37c &lt;__ipipe_sync_stage+6&gt;:	sub    $0x28,%esp
0xc106d37f &lt;__ipipe_sync_stage+9&gt;:	mov    $0xc1439694,%edx
0xc106d384 &lt;__ipipe_sync_stage+14&gt;:	mov    %fs:0xc1432f14,%eax
0xc106d38a &lt;__ipipe_sync_stage+20&gt;:	mov    (%eax,%edx,1),%esi
0xc106d38d &lt;__ipipe_sync_stage+23&gt;:	mov    $0xc1433cf4,%edx
0xc106d392 &lt;__ipipe_sync_stage+28&gt;:	add    %edx,%eax
0xc106d394 &lt;__ipipe_sync_stage+30&gt;:	imul   $0x1668,(%esi),%ecx
0xc106d39a &lt;__ipipe_sync_stage+36&gt;:	add    %ecx,%eax
0xc106d39c &lt;__ipipe_sync_stage+38&gt;:	btsl   $0x0,(%eax)
0xc106d3a0 &lt;__ipipe_sync_stage+42&gt;:	lea    0x4(%esi),%ecx
0xc106d3a3 &lt;__ipipe_sync_stage+45&gt;:	mov    %ecx,-0x20(%ebp)
0xc106d3a6 &lt;__ipipe_sync_stage+48&gt;:	mov    $0xc143302c,%ebx
0xc106d3ab &lt;__ipipe_sync_stage+53&gt;:	mov    %ebx,-0x10(%ebp)
0xc106d3ae &lt;__ipipe_sync_stage+56&gt;:	mov    %edx,-0x28(%ebp)
0xc106d3b1 &lt;__ipipe_sync_stage+59&gt;:	lea    0x10(%eax),%edx
0xc106d3b4 &lt;__ipipe_sync_stage+62&gt;:	mov    %edx,-0x14(%ebp)
0xc106d3b7 &lt;__ipipe_sync_stage+65&gt;:	lea    0x8(%eax),%ecx
0xc106d3ba &lt;__ipipe_sync_stage+68&gt;:	mov    %ecx,-0x18(%ebp)
0xc106d3bd &lt;__ipipe_sync_stage+71&gt;:	lea    0x4(%eax),%ebx
0xc106d3c0 &lt;__ipipe_sync_stage+74&gt;:	mov    %ebx,-0x1c(%ebp)
0xc106d3c3 &lt;__ipipe_sync_stage+77&gt;:	mov    %esi,-0x30(%ebp)
0xc106d3c6 &lt;__ipipe_sync_stage+80&gt;:	mov    0x4(%eax),%edx
0xc106d3c9 &lt;__ipipe_sync_stage+83&gt;:	test   %edx,%edx
0xc106d3cb &lt;__ipipe_sync_stage+85&gt;:	je     0xc106d51b &lt;__ipipe_syn=
c_stage+421&gt;
0xc106d3d1 &lt;__ipipe_sync_stage+91&gt;:	bsr    %edx,%edx
0xc106d3d4 &lt;__ipipe_sync_stage+94&gt;:	mov    0x8(%eax,%edx,4),%ecx
0xc106d3d8 &lt;__ipipe_sync_stage+98&gt;:	test   %ecx,%ecx
0xc106d3da &lt;__ipipe_sync_stage+100&gt;:	je     0xc106d51b &lt;__ipipe_sy=
nc_stage+421&gt;
0xc106d3e0 &lt;__ipipe_sync_stage+106&gt;:	bsr    %ecx,%ecx
0xc106d3e3 &lt;__ipipe_sync_stage+109&gt;:	mov    %edx,%ebx
0xc106d3e5 &lt;__ipipe_sync_stage+111&gt;:	shl    $0x5,%ebx
0xc106d3e8 &lt;__ipipe_sync_stage+114&gt;:	add    %ebx,%ecx
0xc106d3ea &lt;__ipipe_sync_stage+116&gt;:	lea    0x4(%ecx),%edi
0xc106d3ed &lt;__ipipe_sync_stage+119&gt;:	mov    (%eax,%edi,4),%ebx
0xc106d3f0 &lt;__ipipe_sync_stage+122&gt;:	test   %ebx,%ebx
0xc106d3f2 &lt;__ipipe_sync_stage+124&gt;:	je     0xc106d51b &lt;__ipipe_sy=
nc_stage+421&gt;
0xc106d3f8 &lt;__ipipe_sync_stage+130&gt;:	bsr    %ebx,%esi
0xc106d3fb &lt;__ipipe_sync_stage+133&gt;:	mov    %ecx,%ebx
0xc106d3fd &lt;__ipipe_sync_stage+135&gt;:	shl    $0x5,%ebx
0xc106d400 &lt;__ipipe_sync_stage+138&gt;:	mov    %ebx,-0x24(%ebp)
0xc106d403 &lt;__ipipe_sync_stage+141&gt;:	mov    -0x24(%ebp),%ebx
0xc106d406 &lt;__ipipe_sync_stage+144&gt;:	add    %esi,%ebx
0xc106d408 &lt;__ipipe_sync_stage+146&gt;:	mov    -0x14(%ebp),%esi
0xc106d40b &lt;__ipipe_sync_stage+149&gt;:	btr    %ebx,(%esi)
0xc106d40e &lt;__ipipe_sync_stage+152&gt;:	cmpl   $0x0,(%eax,%edi,4)
0xc106d412 &lt;__ipipe_sync_stage+156&gt;:	jne    0xc106d427 &lt;__ipipe_sy=
nc_stage+177&gt;
0xc106d414 &lt;__ipipe_sync_stage+158&gt;:	mov    -0x18(%ebp),%esi
0xc106d417 &lt;__ipipe_sync_stage+161&gt;:	btr    %ecx,(%esi)
0xc106d41a &lt;__ipipe_sync_stage+164&gt;:	cmpl   $0x0,0x8(%eax,%edx,4)
0xc106d41f &lt;__ipipe_sync_stage+169&gt;:	jne    0xc106d427 &lt;__ipipe_sy=
nc_stage+177&gt;
0xc106d421 &lt;__ipipe_sync_stage+171&gt;:	mov    -0x1c(%ebp),%ecx
0xc106d424 &lt;__ipipe_sync_stage+174&gt;:	btr    %edx,(%ecx)
0xc106d427 &lt;__ipipe_sync_stage+177&gt;:	test   %ebx,%ebx
0xc106d429 &lt;__ipipe_sync_stage+179&gt;:	js     0xc106d51b &lt;__ipipe_sy=
nc_stage+421&gt;
0xc106d42f &lt;__ipipe_sync_stage+185&gt;:	lea    0x2(%ebx),%edx
0xc106d432 &lt;__ipipe_sync_stage+188&gt;:	shl    $0x7,%edx
0xc106d435 &lt;__ipipe_sync_stage+191&gt;:	mov    -0x30(%ebp),%esi
0xc106d438 &lt;__ipipe_sync_stage+194&gt;:	testb  $0x20,(%esi,%edx,1)
0xc106d43c &lt;__ipipe_sync_stage+198&gt;:	jne    0xc106d3c6 &lt;__ipipe_sy=
nc_stage+80&gt;
0xc106d43e &lt;__ipipe_sync_stage+200&gt;:	mov    -0x20(%ebp),%eax
0xc106d441 &lt;__ipipe_sync_stage+203&gt;:	cmp    0xc13c6fd0,%eax
0xc106d447 &lt;__ipipe_sync_stage+209&gt;:	je     0xc106d44a &lt;__ipipe_sy=
nc_stage+212&gt;
0xc106d449 &lt;__ipipe_sync_stage+211&gt;:	sti   =20
0xc106d44a &lt;__ipipe_sync_stage+212&gt;:	cmp    $0xc150c080,%esi
0xc106d450 &lt;__ipipe_sync_stage+218&gt;:	je     0xc106d468 &lt;__ipipe_sy=
nc_stage+242&gt;
0xc106d452 &lt;__ipipe_sync_stage+220&gt;:	lea    0x2(%ebx),%ecx
0xc106d455 &lt;__ipipe_sync_stage+223&gt;:	shl    $0x7,%ecx
0xc106d458 &lt;__ipipe_sync_stage+226&gt;:	mov    0xc(%ecx,%esi,1),%edx
0xc106d45c &lt;__ipipe_sync_stage+230&gt;:	mov    %ebx,%eax
0xc106d45e &lt;__ipipe_sync_stage+232&gt;:	call   *0x8(%esi,%ecx,1)
0xc106d462 &lt;__ipipe_sync_stage+236&gt;:	cli   =20
0xc106d463 &lt;__ipipe_sync_stage+237&gt;:	jmp    0xc106d4f9 &lt;__ipipe_sy=
nc_stage+387&gt;
0xc106d468 &lt;__ipipe_sync_stage+242&gt;:	lea    -0x520(%ebx),%eax
0xc106d46e &lt;__ipipe_sync_stage+248&gt;:	cmp    $0x1f,%eax
0xc106d471 &lt;__ipipe_sync_stage+251&gt;:	lea    0x2(%ebx),%edi
0xc106d474 &lt;__ipipe_sync_stage+254&gt;:	ja     0xc106d4a9 &lt;__ipipe_sy=
nc_stage+307&gt;
0xc106d476 &lt;__ipipe_sync_stage+256&gt;:	call   0xc102d215 &lt;irq_enter&=
gt;
0xc106d47b &lt;__ipipe_sync_stage+261&gt;:	mov    %edi,%ecx
0xc106d47d &lt;__ipipe_sync_stage+263&gt;:	shl    $0x7,%ecx
0xc106d480 &lt;__ipipe_sync_stage+266&gt;:	mov    -0x3eaf3f74(%ecx),%edx
0xc106d486 &lt;__ipipe_sync_stage+272&gt;:	mov    %ebx,%eax
0xc106d488 &lt;__ipipe_sync_stage+274&gt;:	call   *-0x3eaf3f78(%ecx)
0xc106d48e &lt;__ipipe_sync_stage+280&gt;:	call   0xc102d523 &lt;irq_exit&g=
t;
0xc106d493 &lt;__ipipe_sync_stage+285&gt;:	cli   =20
0xc106d494 &lt;__ipipe_sync_stage+286&gt;:	mov    %esp,%eax
0xc106d496 &lt;__ipipe_sync_stage+288&gt;:	and    $0xffffe000,%eax
0xc106d49b &lt;__ipipe_sync_stage+293&gt;:	cmpl   $0x0,0x14(%eax)
0xc106d49f &lt;__ipipe_sync_stage+297&gt;:	jne    0xc106d4f9 &lt;__ipipe_sy=
nc_stage+387&gt;
0xc106d4a1 &lt;__ipipe_sync_stage+299&gt;:	testb  $0x8,0x8(%eax)
0xc106d4a5 &lt;__ipipe_sync_stage+303&gt;:	je     0xc106d4f9 &lt;__ipipe_sy=
nc_stage+387&gt;
0xc106d4a7 &lt;__ipipe_sync_stage+305&gt;:	jmp    0xc106d4a1 &lt;__ipipe_sy=
nc_stage+299&gt;
0xc106d4a9 &lt;__ipipe_sync_stage+307&gt;:	shl    $0x7,%edi
0xc106d4ac &lt;__ipipe_sync_stage+310&gt;:	mov    -0x3eaf3f78(%edi),%edx
0xc106d4b2 &lt;__ipipe_sync_stage+316&gt;:	mov    %fs:0xc1432f14,%edi
0xc106d4b9 &lt;__ipipe_sync_stage+323&gt;:	add    -0x10(%ebp),%edi
0xc106d4bc &lt;__ipipe_sync_stage+326&gt;:	mov    %ebx,%eax
0xc106d4be &lt;__ipipe_sync_stage+328&gt;:	mov    %edx,-0x2c(%ebp)
0xc106d4c1 &lt;__ipipe_sync_stage+331&gt;:	call   0xc10145c3 &lt;__ipipe_ge=
t_ioapic_irq_vector&gt;
0xc106d4c6 &lt;__ipipe_sync_stage+336&gt;:	not    %eax
0xc106d4c8 &lt;__ipipe_sync_stage+338&gt;:	mov    %eax,0x2c(%edi)
0xc106d4cb &lt;__ipipe_sync_stage+341&gt;:	mov    %ebx,%eax
0xc106d4cd &lt;__ipipe_sync_stage+343&gt;:	not    %eax
0xc106d4cf &lt;__ipipe_sync_stage+345&gt;:	mov    -0x2c(%ebp),%edx
0xc106d4d2 &lt;__ipipe_sync_stage+348&gt;:	pushf =20
0xc106d4d3 &lt;__ipipe_sync_stage+349&gt;:	orl    $0x200,(%esp)
0xc106d4da &lt;__ipipe_sync_stage+356&gt;:	push   %cs
0xc106d4db &lt;__ipipe_sync_stage+357&gt;:	push   $0xc106d4f7
0xc106d4e0 &lt;__ipipe_sync_stage+362&gt;:	push   %eax
0xc106d4e1 &lt;__ipipe_sync_stage+363&gt;:	push   %gs
0xc106d4e3 &lt;__ipipe_sync_stage+365&gt;:	push   %fs
0xc106d4e5 &lt;__ipipe_sync_stage+367&gt;:	push   %es
0xc106d4e6 &lt;__ipipe_sync_stage+368&gt;:	push   %ds
0xc106d4e7 &lt;__ipipe_sync_stage+369&gt;:	push   %eax
0xc106d4e8 &lt;__ipipe_sync_stage+370&gt;:	push   %ebp
0xc106d4e9 &lt;__ipipe_sync_stage+371&gt;:	push   %edi
0xc106d4ea &lt;__ipipe_sync_stage+372&gt;:	push   %esi
0xc106d4eb &lt;__ipipe_sync_stage+373&gt;:	push   %edx
0xc106d4ec &lt;__ipipe_sync_stage+374&gt;:	push   %ecx
0xc106d4ed &lt;__ipipe_sync_stage+375&gt;:	push   %ebx
0xc106d4ee &lt;__ipipe_sync_stage+376&gt;:	mov    %edi,%eax
0xc106d4f0 &lt;__ipipe_sync_stage+378&gt;:	call   *%edx
0xc106d4f2 &lt;__ipipe_sync_stage+380&gt;:	jmp    0xc1269fd8
0xc106d4f7 &lt;__ipipe_sync_stage+385&gt;:	cli   =20
0xc106d4f8 &lt;__ipipe_sync_stage+386&gt;:	cli   =20
0xc106d4f9 &lt;__ipipe_sync_stage+387&gt;:	mov    %fs:0xc1432f14,%ecx
0xc106d500 &lt;__ipipe_sync_stage+394&gt;:	mov    $0xc1439694,%edx
0xc106d505 &lt;__ipipe_sync_stage+399&gt;:	mov    -0x28(%ebp),%ebx
0xc106d508 &lt;__ipipe_sync_stage+402&gt;:	lea    (%ecx,%ebx,1),%eax
0xc106d50b &lt;__ipipe_sync_stage+405&gt;:	mov    (%ecx,%edx,1),%edx
0xc106d50e &lt;__ipipe_sync_stage+408&gt;:	imul   $0x1668,(%edx),%edx
0xc106d514 &lt;__ipipe_sync_stage+414&gt;:	add    %edx,%eax
0xc106d516 &lt;__ipipe_sync_stage+416&gt;:	jmp    0xc106d3b1 &lt;__ipipe_sy=
nc_stage+59&gt;
0xc106d51b &lt;__ipipe_sync_stage+421&gt;:	btrl   $0x0,(%eax)
0xc106d51f &lt;__ipipe_sync_stage+425&gt;:	add    $0x28,%esp
0xc106d522 &lt;__ipipe_sync_stage+428&gt;:	pop    %ebx
0xc106d523 &lt;__ipipe_sync_stage+429&gt;:	pop    %esi
0xc106d524 &lt;__ipipe_sync_stage+430&gt;:	pop    %edi
0xc106d525 &lt;__ipipe_sync_stage+431&gt;:	pop    %ebp
0xc106d526 &lt;__ipipe_sync_stage+432&gt;:	ret   =20
End of assembler dump.

post-prompt
No breakpoints or watchpoints.
=A0</pre><div><span style=3D"white-space:pre-wrap">breakpoints-table-end</s=
pan></div><div><br></div><div>Thanks again!</div></div><div><div></div><div=
 class=3D"h5"><br></div></div></blockquote><div><br></div><div><a href=3D"h=
ttp://odavilar.0x1fee3.org/dump__ipipe_sync_stage">http://odavilar.0x1fee3.=
org/dump__ipipe_sync_stage</a></div>

<div><br></div><span class=3D"Apple-style-span" style=3D"font-family:&#39;T=
imes New Roman&#39;;font-size:medium"><pre style=3D"word-wrap:break-word;wh=
ite-space:pre-wrap">c106d376 &lt;__ipipe_sync_stage&gt;:
 * return of this routine.
 *
 * This routine must be called with hw interrupts off.
 */
void __ipipe_sync_stage(void)
{
c106d376:	55                   	push   %ebp
c106d377:	89 e5                	mov    %esp,%ebp
c106d379:	57                   	push   %edi
c106d37a:	56                   	push   %esi
c106d37b:	53                   	push   %ebx
c106d37c:	83 ec 28             	sub    $0x28,%esp
	struct ipipe_percpu_domain_data *p;
	struct ipipe_domain *ipd;
	int irq;

	ipd =3D __ipipe_current_domain;
c106d37f:	ba 94 96 43 c1       	mov    $0xc1439694,%edx
c106d384:	64 a1 14 2f 43 c1    	mov    %fs:0xc1432f14,%eax
c106d38a:	8b 34 10             	mov    (%eax,%edx,1),%esi
	p =3D ipipe_cpudom_ptr(ipd);
c106d38d:	ba f4 3c 43 c1       	mov    $0xc1433cf4,%edx
c106d392:	01 d0                	add    %edx,%eax
c106d394:	69 0e 68 16 00 00    	imul   $0x1668,(%esi),%ecx
c106d39a:	01 c8                	add    %ecx,%eax
c106d39c:	0f ba 28 00          	btsl   $0x0,(%eax)
		barrier();

		if (test_bit(IPIPE_LOCK_FLAG, &amp;ipd-&gt;irqs[irq].control))
			continue;

		if (!__ipipe_pipeline_head_p(ipd))
c106d3a0:	8d 4e 04             	lea    0x4(%esi),%ecx
c106d3a3:	89 4d e0             	mov    %ecx,-0x20(%ebp)
void __ipipe_end_edge_irq(unsigned irq, struct irq_desc *desc);

static inline void __do_root_xirq(ipipe_irq_handler_t handler,
				  unsigned int irq)
{
	struct pt_regs *regs =3D &amp;__raw_get_cpu_var(__ipipe_tick_regs);
c106d3a6:	bb 2c 30 43 c1       	mov    $0xc143302c,%ebx
c106d3ab:	89 5d f0             	mov    %ebx,-0x10(%ebp)
			__ipipe_do_root_xirq(ipd, irq);
			local_irq_disable_hw();
			root_stall_after_handler();
		}

		p =3D ipipe_cpudom_ptr(__ipipe_current_domain);
c106d3ae:	89 55 d8             	mov    %edx,-0x28(%ebp)
	clear_bit(nr, addr);
}

static inline void __clear_bit(int nr, volatile unsigned long *addr)
{
	asm volatile(&quot;btr %1,%0&quot; : ADDR : &quot;Ir&quot; (nr));
c106d3b1:	8d 50 10             	lea    0x10(%eax),%edx
c106d3b4:	89 55 ec             	mov    %edx,-0x14(%ebp)
c106d3b7:	8d 48 08             	lea    0x8(%eax),%ecx
c106d3ba:	89 4d e8             	mov    %ecx,-0x18(%ebp)
c106d3bd:	8d 58 04             	lea    0x4(%eax),%ebx
c106d3c0:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
c106d3c3:	89 75 d0             	mov    %esi,-0x30(%ebp)
{
	int l0b, l1b, l2b;
	unsigned long l0m, l1m, l2m;
	unsigned int irq;

	l0m =3D p-&gt;irqpend_himap;
c106d3c6:	8b 50 04             	mov    0x4(%eax),%edx
	if (unlikely(l0m =3D=3D 0))
c106d3c9:	85 d2                	test   %edx,%edx
c106d3cb:	0f 84 4a 01 00 00    	je     c106d51b &lt;__xirq_end+0x24&gt;

int __ipipe_handle_irq(struct pt_regs *regs);

static inline unsigned long __ipipe_ffnz(unsigned long ul)
{
      __asm__(&quot;bsrl %1, %0&quot;:&quot;=3Dr&quot;(ul)
c106d3d1:	0f bd d2             	bsr    %edx,%edx
		return -1;

	l0b =3D __ipipe_ffnz(l0m);
	l1m =3D p-&gt;irqpend_mdmap[l0b];
c106d3d4:	8b 4c 90 08          	mov    0x8(%eax,%edx,4),%ecx
	if (unlikely(l1m =3D=3D 0))
c106d3d8:	85 c9                	test   %ecx,%ecx
c106d3da:	0f 84 3b 01 00 00    	je     c106d51b &lt;__xirq_end+0x24&gt;
c106d3e0:	0f bd c9             	bsr    %ecx,%ecx
		return -1;

	l1b =3D __ipipe_ffnz(l1m) + l0b * BITS_PER_LONG;
c106d3e3:	89 d3                	mov    %edx,%ebx
c106d3e5:	c1 e3 05             	shl    $0x5,%ebx
c106d3e8:	01 d9                	add    %ebx,%ecx
	l2m =3D p-&gt;irqpend_lomap[l1b];
c106d3ea:	8d 79 04             	lea    0x4(%ecx),%edi
c106d3ed:	8b 1c b8             	mov    (%eax,%edi,4),%ebx
	if (unlikely(l2m =3D=3D 0))
c106d3f0:	85 db                	test   %ebx,%ebx
c106d3f2:	0f 84 23 01 00 00    	je     c106d51b &lt;__xirq_end+0x24&gt;
c106d3f8:	0f bd f3             	bsr    %ebx,%esi
		return -1;

	l2b =3D __ipipe_ffnz(l2m);
	irq =3D l1b * BITS_PER_LONG + l2b;
c106d3fb:	89 cb                	mov    %ecx,%ebx
c106d3fd:	c1 e3 05             	shl    $0x5,%ebx
c106d400:	89 5d dc             	mov    %ebx,-0x24(%ebp)
c106d403:	8b 5d dc             	mov    -0x24(%ebp),%ebx
c106d406:	01 f3                	add    %esi,%ebx
c106d408:	8b 75 ec             	mov    -0x14(%ebp),%esi
c106d40b:	0f b3 1e             	btr    %ebx,(%esi)

	__clear_bit(irq, p-&gt;irqpend_lomap);
	if (p-&gt;irqpend_lomap[l1b] =3D=3D 0) {
c106d40e:	83 3c b8 00          	cmpl   $0x0,(%eax,%edi,4)
c106d412:	75 13                	jne    c106d427 &lt;__ipipe_sync_stage+0xb1=
&gt;
c106d414:	8b 75 e8             	mov    -0x18(%ebp),%esi
c106d417:	0f b3 0e             	btr    %ecx,(%esi)
		__clear_bit(l1b, p-&gt;irqpend_mdmap);
		if (p-&gt;irqpend_mdmap[l0b] =3D=3D 0)
c106d41a:	83 7c 90 08 00       	cmpl   $0x0,0x8(%eax,%edx,4)
c106d41f:	75 06                	jne    c106d427 &lt;__ipipe_sync_stage+0xb1=
&gt;
c106d421:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
c106d424:	0f b3 11             	btr    %edx,(%ecx)
	if (ipd =3D=3D ipipe_root_domain)
		trace_hardirqs_off();

	for (;;) {
		irq =3D __ipipe_next_irq(p);
		if (irq &lt; 0)
c106d427:	85 db                	test   %ebx,%ebx
c106d429:	0f 88 ec 00 00 00    	js     c106d51b &lt;__xirq_end+0x24&gt;
		 * that all updates to maps are done before the
		 * handler gets called.
		 */
		barrier();

		if (test_bit(IPIPE_LOCK_FLAG, &amp;ipd-&gt;irqs[irq].control))
c106d42f:	8d 53 02             	lea    0x2(%ebx),%edx
c106d432:	c1 e2 07             	shl    $0x7,%edx
c106d435:	8b 75 d0             	mov    -0x30(%ebp),%esi
c106d438:	f6 04 16 20          	testb  $0x20,(%esi,%edx,1)
c106d43c:	75 88                	jne    c106d3c6 &lt;__ipipe_sync_stage+0x50=
&gt;
			continue;

		if (!__ipipe_pipeline_head_p(ipd))
c106d43e:	8b 45 e0             	mov    -0x20(%ebp),%eax
c106d441:	3b 05 d0 6f 3c c1    	cmp    0xc13c6fd0,%eax
c106d447:	74 01                	je     c106d44a &lt;__ipipe_sync_stage+0xd4=
&gt;
			local_irq_enable_hw();
c106d449:	fb                   	sti   =20

		if (likely(ipd !=3D ipipe_root_domain)) {
c106d44a:	81 fe 80 c0 50 c1    	cmp    $0xc150c080,%esi
c106d450:	74 16                	je     c106d468 &lt;__ipipe_sync_stage+0xf2=
&gt;
			ipd-&gt;irqs[irq].handler(irq, ipd-&gt;irqs[irq].cookie);
c106d452:	8d 4b 02             	lea    0x2(%ebx),%ecx
c106d455:	c1 e1 07             	shl    $0x7,%ecx
c106d458:	8b 54 31 0c          	mov    0xc(%ecx,%esi,1),%edx
c106d45c:	89 d8                	mov    %ebx,%eax
c106d45e:	ff 54 0e 08          	call   *0x8(%esi,%ecx,1)
			__ipipe_run_irqtail(irq);
			local_irq_disable_hw();
c106d462:	fa                   	cli   =20
c106d463:	e9 91 00 00 00       	jmp    c106d4f9 &lt;__xirq_end+0x2&gt;
		} else if (ipipe_virtual_irq_p(irq)) {
c106d468:	8d 83 e0 fa ff ff    	lea    -0x520(%ebx),%eax
c106d46e:	83 f8 1f             	cmp    $0x1f,%eax
c106d471:	8d 7b 02             	lea    0x2(%ebx),%edi
c106d474:	77 33                	ja     c106d4a9 &lt;__ipipe_sync_stage+0x13=
3&gt;
			irq_enter();
c106d476:	e8 9a fd fb ff       	call   c102d215 &lt;irq_enter&gt;
			ipd-&gt;irqs[irq].handler(irq, ipd-&gt;irqs[irq].cookie);
c106d47b:	89 f9                	mov    %edi,%ecx
c106d47d:	c1 e1 07             	shl    $0x7,%ecx
c106d480:	8b 91 8c c0 50 c1    	mov    -0x3eaf3f74(%ecx),%edx
c106d486:	89 d8                	mov    %ebx,%eax
c106d488:	ff 91 88 c0 50 c1    	call   *-0x3eaf3f78(%ecx)
			irq_exit();
c106d48e:	e8 90 00 fc ff       	call   c102d523 &lt;irq_exit&gt;
			local_irq_disable_hw();
c106d493:	fa                   	cli   =20
c106d494:	89 e0                	mov    %esp,%eax
c106d496:	25 00 e0 ff ff       	and    $0xffffe000,%eax
			root_stall_after_handler();
			while (__ipipe_check_root_resched())
c106d49b:	83 78 14 00          	cmpl   $0x0,0x14(%eax)
c106d49f:	75 58                	jne    c106d4f9 &lt;__xirq_end+0x2&gt;
c106d4a1:	f6 40 08 08          	testb  $0x8,0x8(%eax)
c106d4a5:	74 52                	je     c106d4f9 &lt;__xirq_end+0x2&gt;
c106d4a7:	eb f8                	jmp    c106d4a1 &lt;__ipipe_sync_stage+0x12=
b&gt;
				__ipipe_preempt_schedule_irq();
		} else {
			__ipipe_do_root_xirq(ipd, irq);
c106d4a9:	c1 e7 07             	shl    $0x7,%edi
c106d4ac:	8b 97 88 c0 50 c1    	mov    -0x3eaf3f78(%edi),%edx
void __ipipe_end_edge_irq(unsigned irq, struct irq_desc *desc);

static inline void __do_root_xirq(ipipe_irq_handler_t handler,
				  unsigned int irq)
{
	struct pt_regs *regs =3D &amp;__raw_get_cpu_var(__ipipe_tick_regs);
c106d4b2:	64 8b 3d 14 2f 43 c1 	mov    %fs:0xc1432f14,%edi
c106d4b9:	03 7d f0             	add    -0x10(%ebp),%edi

static inline unsigned __ipipe_get_irq_vector(int irq)
{
#ifdef CONFIG_X86_IO_APIC
	unsigned __ipipe_get_ioapic_irq_vector(int irq);
	return __ipipe_get_ioapic_irq_vector(irq);
c106d4bc:	89 d8                	mov    %ebx,%eax
c106d4be:	89 55 d4             	mov    %edx,-0x2c(%ebp)
c106d4c1:	e8 fd 70 fa ff       	call   c10145c3 &lt;__ipipe_get_ioapic_irq_=
vector&gt;

	regs-&gt;orig_ax =3D ~__ipipe_get_irq_vector(irq);
c106d4c6:	f7 d0                	not    %eax
c106d4c8:	89 47 2c             	mov    %eax,0x2c(%edi)

	__asm__ __volatile__(&quot;pushfl\n\t&quot;
c106d4cb:	89 d8                	mov    %ebx,%eax
c106d4cd:	f7 d0                	not    %eax
c106d4cf:	8b 55 d4             	mov    -0x2c(%ebp),%edx
c106d4d2:	9c                   	pushf =20
c106d4d3:	81 0c 24 00 02 00 00 	orl    $0x200,(%esp)
c106d4da:	0e                   	push   %cs
c106d4db:	68 f7 d4 06 c1       	push   $0xc106d4f7
c106d4e0:	50                   	push   %eax
c106d4e1:	0f a8                	push   %gs
c106d4e3:	0f a0                	push   %fs
c106d4e5:	06                   	push   %es
c106d4e6:	1e                   	push   %ds
c106d4e7:	50                   	push   %eax
c106d4e8:	55                   	push   %ebp
c106d4e9:	57                   	push   %edi
c106d4ea:	56                   	push   %esi
c106d4eb:	52                   	push   %edx
c106d4ec:	51                   	push   %ecx
c106d4ed:	53                   	push   %ebx
c106d4ee:	89 f8                	mov    %edi,%eax
c106d4f0:	ff d2                	call   *%edx
c106d4f2:	e9 e1 ca 1f 00       	jmp    c1269fd8 &lt;__kprobes_text_start&gt=
;

c106d4f7 &lt;__xirq_end&gt;:
c106d4f7:	fa                   	cli   =20
			local_irq_disable_hw();
c106d4f8:	fa                   	cli   =20
			root_stall_after_handler();
		}

		p =3D ipipe_cpudom_ptr(__ipipe_current_domain);
c106d4f9:	64 8b 0d 14 2f 43 c1 	mov    %fs:0xc1432f14,%ecx
c106d500:	ba 94 96 43 c1       	mov    $0xc1439694,%edx
c106d505:	8b 5d d8             	mov    -0x28(%ebp),%ebx
c106d508:	8d 04 19             	lea    (%ecx,%ebx,1),%eax
c106d50b:	8b 14 11             	mov    (%ecx,%edx,1),%edx
c106d50e:	69 12 68 16 00 00    	imul   $0x1668,(%edx),%edx
c106d514:	01 d0                	add    %edx,%eax
c106d516:	e9 96 fe ff ff       	jmp    c106d3b1 &lt;__ipipe_sync_stage+0x3b=
&gt;
c106d51b:	0f ba 30 00          	btrl   $0x0,(%eax)

	if (ipd =3D=3D ipipe_root_domain)
		trace_hardirqs_on();

	__clear_bit(IPIPE_STALL_FLAG, &amp;p-&gt;status);
}
c106d51f:	83 c4 28             	add    $0x28,%esp
c106d522:	5b                   	pop    %ebx
c106d523:	5e                   	pop    %esi
c106d524:	5f                   	pop    %edi
c106d525:	5d                   	pop    %ebp
c106d526:	c3                   	ret   =20

</pre></span><div><a href=3D"http://odavilar.0x1fee3.org/dump__ipipe_sync_s=
tage"></a>=A0Another dump now with the source in it.</div><div><br></div><d=
iv>Maybe it can be more=A0helpful</div><div><br></div><div>Thanks.</div><di=
v>

<br></div></div>-- <br><div>Atentamente:<br>Oscar D=E1vila Ram=EDrez<br></d=
iv><br>

--f46d044468dbd5078e04ba3a6b0e--

