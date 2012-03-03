MIME-Version: 1.0
In-Reply-To: <4F509C26.7070308@domain.hid>
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
From: =?ISO-8859-1?Q?Oscar_D=E1vila?= <odavilar@domain.hid>
Date: Fri, 2 Mar 2012 18:14:53 -0600
Message-ID: <CAHOEnGegK_DzKg_RTf7yadD2mAxJJOSgdpMn+nxRCHsjAp7mrg@domain.hid>
Content-Type: multipart/alternative; boundary=e89a8fb1ef38435f1404ba4b96c1
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

--e89a8fb1ef38435f1404ba4b96c1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

2012/3/2 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> On 03/02/2012 11:04 AM, Gilles Chanteperdrix wrote:
> > On 03/01/2012 05:23 AM, Oscar D=E1vila wrote:
> >> Finally i could get the dump
> >>
> >>
> >> post-prompt
> >> No breakpoints or watchpoints.
> >>
> >> breakpoints-table-end
> >>
> >> post-prompt
> >> Dump of assembler code for function __ipipe_sync_stage:
> >> 0xc106d376 <__ipipe_sync_stage+0>:   push   %ebp
> >> (...)
> >> 0xc106d526 <__ipipe_sync_stage+432>: ret
> >> End of assembler dump.
> >
> > The address where the EIP is when the NMI watchdog triggers is
> > 0xc106d5e1, so, outside this code.
> >
> And this dump does not seem to correspond to the kernel that was running
> when the bug happened, because in that case we had
>
> 0xc106d5e1 =3D=3D __ipipe_sync_stage + 0x21b
>
> whereas in your dump,
>
> __ipipe_sync_stage + 0x21b =3D=3D 0xc106d591
>
> Sorry about that, i lost that image of the kernel.

Here is a new complete test.

Kernel Messages


Kernel failure message 1:
BUG: NMI Watchdog detected LOCKUP on CPU0, ip c10751d3, registers:
Modules linked in: isofs udf crc_itu_t i915 drm_kms_helper drm
i2c_algo_bit sco ppdev bridge stp bnep lp l2cap crc16 bluetooth rfkill
binfmt_misc fuse loop snd_intel8x0 snd_ac97_codec ac97_bus snd_pcm_oss
snd_mixer_oss snd_pcm snd_seq_midi snd_rawmidi snd_seq_midi_event
snd_seq snd_timer snd_seq_device i2c_i801 snd parport_pc i2c_core
soundcore snd_page_alloc parport rng_core tpm_tis tpm evdev psmouse
serio_raw usbhid hid ext3 jbd mbcache sg sr_mod sd_mod crc_t10dif
cdrom ata_generic uhci_hcd ehci_hcd ata_piix libata scsi_mod tg3
usbcore floppy libphy nls_base [last unloaded: scsi_wait_scan]

Pid: 1891, comm: ex01 Not tainted 2.6.35.9-xenomai-2.6.0-8 #5 IBM/8143PSR
EIP: 0060:[<c10751d3>] EFLAGS: 00200002 CPU: 0
EIP is at __ipipe_sync_stage+0x131/0x181
EAX: deb38000 EBX: 00000521 ECX: de8a6940 EDX: c1472580
ESI: c1542100 EDI: 00000523 EBP: deb39f98 ESP: deb39f64
 DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
Process ex01 (pid: 1891, ti=3Ddeb38000 task=3Dde8a6940 task.ti=3Ddeb38000)
I-pipe domain Linux
Stack:
 ffffffff c1542100 c109dfb0 c1468cf4 00000520 c1542104 c1c03cf8 c1c03cfc
<0> c1c03d04 c146802c deb39fb4 00200282 00000001 deb39fac c1019be4 080499c4
<0> 00000000 00000000 deb38000 c1287a71 080499c4 080486a4 00000000 00000000
Call Trace:
 [<c109dfb0>] ? hisyscall_event+0x0/0x2b2
 [<c1019be4>] ? __ipipe_syscall_root+0xd9/0xe8
 [<c1287a71>] ? system_call+0x2d/0x4f
Code: f9 c1 e1 07 8b 91 0c 21 54 c1 89 d8 ff 91 08 21 54 c1 e8 b7 b6
fb ff fa 89 e0 25 00 e0 ff ff 83 78 14 00 75 58 f6 40 08 08 74 52 <eb>
f8 c1 e7 07 8b 97 08 21 54 c1 64 8b 3d 14 7f 46 c1 03 7d f0
---[ end trace 6b3881f72975605e ]---


Objdump -S

c10750a2 <__ipipe_sync_stage>:
 * return of this routine.
 *
 * This routine must be called with hw interrupts off.
 */
void __ipipe_sync_stage(void)
{
c10750a2:	55                   	push   %ebp
c10750a3:	89 e5                	mov    %esp,%ebp
c10750a5:	57                   	push   %edi
c10750a6:	56                   	push   %esi
c10750a7:	53                   	push   %ebx
c10750a8:	83 ec 28             	sub    $0x28,%esp
	struct ipipe_percpu_domain_data *p;
	struct ipipe_domain *ipd;
	int irq;

	ipd =3D __ipipe_current_domain;
c10750ab:	ba 94 e6 46 c1       	mov    $0xc146e694,%edx
c10750b0:	64 a1 14 7f 46 c1    	mov    %fs:0xc1467f14,%eax
c10750b6:	8b 34 10             	mov    (%eax,%edx,1),%esi
	p =3D ipipe_cpudom_ptr(ipd);
c10750b9:	ba f4 8c 46 c1       	mov    $0xc1468cf4,%edx
c10750be:	01 d0                	add    %edx,%eax
c10750c0:	69 0e 68 16 00 00    	imul   $0x1668,(%esi),%ecx
c10750c6:	01 c8                	add    %ecx,%eax
c10750c8:	0f ba 28 00          	btsl   $0x0,(%eax)
		barrier();

		if (test_bit(IPIPE_LOCK_FLAG, &ipd->irqs[irq].control))
			continue;

		if (!__ipipe_pipeline_head_p(ipd))
c10750cc:	8d 4e 04             	lea    0x4(%esi),%ecx
c10750cf:	89 4d e0             	mov    %ecx,-0x20(%ebp)
void __ipipe_end_edge_irq(unsigned irq, struct irq_desc *desc);

static inline void __do_root_xirq(ipipe_irq_handler_t handler,
				  unsigned int irq)
{
	struct pt_regs *regs =3D &__raw_get_cpu_var(__ipipe_tick_regs);
c10750d2:	bb 2c 80 46 c1       	mov    $0xc146802c,%ebx
c10750d7:	89 5d f0             	mov    %ebx,-0x10(%ebp)
			__ipipe_do_root_xirq(ipd, irq);
			local_irq_disable_hw();
			root_stall_after_handler();
		}

		p =3D ipipe_cpudom_ptr(__ipipe_current_domain);
c10750da:	89 55 d8             	mov    %edx,-0x28(%ebp)
	clear_bit(nr, addr);
}

static inline void __clear_bit(int nr, volatile unsigned long *addr)
{
	asm volatile("btr %1,%0" : ADDR : "Ir" (nr));
c10750dd:	8d 50 10             	lea    0x10(%eax),%edx
c10750e0:	89 55 ec             	mov    %edx,-0x14(%ebp)
c10750e3:	8d 48 08             	lea    0x8(%eax),%ecx
c10750e6:	89 4d e8             	mov    %ecx,-0x18(%ebp)
c10750e9:	8d 58 04             	lea    0x4(%eax),%ebx
c10750ec:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
c10750ef:	89 75 d0             	mov    %esi,-0x30(%ebp)
{
	int l0b, l1b, l2b;
	unsigned long l0m, l1m, l2m;
	unsigned int irq;

	l0m =3D p->irqpend_himap;
c10750f2:	8b 50 04             	mov    0x4(%eax),%edx
	if (unlikely(l0m =3D=3D 0))
c10750f5:	85 d2                	test   %edx,%edx
c10750f7:	0f 84 4a 01 00 00    	je     c1075247 <__xirq_end+0x24>

int __ipipe_handle_irq(struct pt_regs *regs);

static inline unsigned long __ipipe_ffnz(unsigned long ul)
{
      __asm__("bsrl %1, %0":"=3Dr"(ul)
c10750fd:	0f bd d2             	bsr    %edx,%edx
		return -1;

	l0b =3D __ipipe_ffnz(l0m);
	l1m =3D p->irqpend_mdmap[l0b];
c1075100:	8b 4c 90 08          	mov    0x8(%eax,%edx,4),%ecx
	if (unlikely(l1m =3D=3D 0))
c1075104:	85 c9                	test   %ecx,%ecx
c1075106:	0f 84 3b 01 00 00    	je     c1075247 <__xirq_end+0x24>
c107510c:	0f bd c9             	bsr    %ecx,%ecx
		return -1;

	l1b =3D __ipipe_ffnz(l1m) + l0b * BITS_PER_LONG;
c107510f:	89 d3                	mov    %edx,%ebx
c1075111:	c1 e3 05             	shl    $0x5,%ebx
c1075114:	01 d9                	add    %ebx,%ecx
	l2m =3D p->irqpend_lomap[l1b];
c1075116:	8d 79 04             	lea    0x4(%ecx),%edi
c1075119:	8b 1c b8             	mov    (%eax,%edi,4),%ebx
	if (unlikely(l2m =3D=3D 0))
c107511c:	85 db                	test   %ebx,%ebx
c107511e:	0f 84 23 01 00 00    	je     c1075247 <__xirq_end+0x24>
c1075124:	0f bd f3             	bsr    %ebx,%esi
		return -1;

	l2b =3D __ipipe_ffnz(l2m);
	irq =3D l1b * BITS_PER_LONG + l2b;
c1075127:	89 cb                	mov    %ecx,%ebx
c1075129:	c1 e3 05             	shl    $0x5,%ebx
c107512c:	89 5d dc             	mov    %ebx,-0x24(%ebp)
c107512f:	8b 5d dc             	mov    -0x24(%ebp),%ebx
c1075132:	01 f3                	add    %esi,%ebx
c1075134:	8b 75 ec             	mov    -0x14(%ebp),%esi
c1075137:	0f b3 1e             	btr    %ebx,(%esi)

	__clear_bit(irq, p->irqpend_lomap);
	if (p->irqpend_lomap[l1b] =3D=3D 0) {
c107513a:	83 3c b8 00          	cmpl   $0x0,(%eax,%edi,4)
c107513e:	75 13                	jne    c1075153 <__ipipe_sync_stage+0xb1>
c1075140:	8b 75 e8             	mov    -0x18(%ebp),%esi
c1075143:	0f b3 0e             	btr    %ecx,(%esi)
		__clear_bit(l1b, p->irqpend_mdmap);
		if (p->irqpend_mdmap[l0b] =3D=3D 0)
c1075146:	83 7c 90 08 00       	cmpl   $0x0,0x8(%eax,%edx,4)
c107514b:	75 06                	jne    c1075153 <__ipipe_sync_stage+0xb1>
c107514d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
c1075150:	0f b3 11             	btr    %edx,(%ecx)
	if (ipd =3D=3D ipipe_root_domain)
		trace_hardirqs_off();

	for (;;) {
		irq =3D __ipipe_next_irq(p);
		if (irq < 0)
c1075153:	85 db                	test   %ebx,%ebx
c1075155:	0f 88 ec 00 00 00    	js     c1075247 <__xirq_end+0x24>
		 * that all updates to maps are done before the
		 * handler gets called.
		 */
		barrier();

		if (test_bit(IPIPE_LOCK_FLAG, &ipd->irqs[irq].control))
c107515b:	8d 53 02             	lea    0x2(%ebx),%edx
c107515e:	c1 e2 07             	shl    $0x7,%edx
c1075161:	8b 75 d0             	mov    -0x30(%ebp),%esi
c1075164:	f6 04 16 20          	testb  $0x20,(%esi,%edx,1)
c1075168:	75 88                	jne    c10750f2 <__ipipe_sync_stage+0x50>
			continue;

		if (!__ipipe_pipeline_head_p(ipd))
c107516a:	8b 45 e0             	mov    -0x20(%ebp),%eax
c107516d:	3b 05 50 77 3f c1    	cmp    0xc13f7750,%eax
c1075173:	74 01                	je     c1075176 <__ipipe_sync_stage+0xd4>
			local_irq_enable_hw();
c1075175:	fb                   	sti

		if (likely(ipd !=3D ipipe_root_domain)) {
c1075176:	81 fe 00 21 54 c1    	cmp    $0xc1542100,%esi
c107517c:	74 16                	je     c1075194 <__ipipe_sync_stage+0xf2>
			ipd->irqs[irq].handler(irq, ipd->irqs[irq].cookie);
c107517e:	8d 4b 02             	lea    0x2(%ebx),%ecx
c1075181:	c1 e1 07             	shl    $0x7,%ecx
c1075184:	8b 54 31 0c          	mov    0xc(%ecx,%esi,1),%edx
c1075188:	89 d8                	mov    %ebx,%eax
c107518a:	ff 54 0e 08          	call   *0x8(%esi,%ecx,1)
			__ipipe_run_irqtail(irq);
			local_irq_disable_hw();
c107518e:	fa                   	cli
c107518f:	e9 91 00 00 00       	jmp    c1075225 <__xirq_end+0x2>
		} else if (ipipe_virtual_irq_p(irq)) {
c1075194:	8d 83 e0 fa ff ff    	lea    -0x520(%ebx),%eax
c107519a:	83 f8 1f             	cmp    $0x1f,%eax
c107519d:	8d 7b 02             	lea    0x2(%ebx),%edi
c10751a0:	77 33                	ja     c10751d5 <__ipipe_sync_stage+0x133>
			irq_enter();
c10751a2:	e8 f8 b3 fb ff       	call   c103059f <irq_enter>
			ipd->irqs[irq].handler(irq, ipd->irqs[irq].cookie);
c10751a7:	89 f9                	mov    %edi,%ecx
c10751a9:	c1 e1 07             	shl    $0x7,%ecx
c10751ac:	8b 91 0c 21 54 c1    	mov    -0x3eabdef4(%ecx),%edx
c10751b2:	89 d8                	mov    %ebx,%eax
c10751b4:	ff 91 08 21 54 c1    	call   *-0x3eabdef8(%ecx)
			irq_exit();
c10751ba:	e8 b7 b6 fb ff       	call   c1030876 <irq_exit>
			local_irq_disable_hw();
c10751bf:	fa                   	cli
c10751c0:	89 e0                	mov    %esp,%eax
c10751c2:	25 00 e0 ff ff       	and    $0xffffe000,%eax
			root_stall_after_handler();
			while (__ipipe_check_root_resched())
c10751c7:	83 78 14 00          	cmpl   $0x0,0x14(%eax)
c10751cb:	75 58                	jne    c1075225 <__xirq_end+0x2>
c10751cd:	f6 40 08 08          	testb  $0x8,0x8(%eax)
c10751d1:	74 52                	je     c1075225 <__xirq_end+0x2>
c10751d3:	eb f8                	jmp    c10751cd <__ipipe_sync_stage+0x12b>
				__ipipe_preempt_schedule_irq();
		} else {
			__ipipe_do_root_xirq(ipd, irq);
c10751d5:	c1 e7 07             	shl    $0x7,%edi
c10751d8:	8b 97 08 21 54 c1    	mov    -0x3eabdef8(%edi),%edx
void __ipipe_end_edge_irq(unsigned irq, struct irq_desc *desc);

static inline void __do_root_xirq(ipipe_irq_handler_t handler,
				  unsigned int irq)
{
	struct pt_regs *regs =3D &__raw_get_cpu_var(__ipipe_tick_regs);
c10751de:	64 8b 3d 14 7f 46 c1 	mov    %fs:0xc1467f14,%edi
c10751e5:	03 7d f0             	add    -0x10(%ebp),%edi

static inline unsigned __ipipe_get_irq_vector(int irq)
{
#ifdef CONFIG_X86_IO_APIC
	unsigned __ipipe_get_ioapic_irq_vector(int irq);
	return __ipipe_get_ioapic_irq_vector(irq);
c10751e8:	89 d8                	mov    %ebx,%eax
c10751ea:	89 55 d4             	mov    %edx,-0x2c(%ebp)
c10751ed:	e8 15 02 fa ff       	call   c1015407 <__ipipe_get_ioapic_irq_vec=
tor>

	regs->orig_ax =3D ~__ipipe_get_irq_vector(irq);
c10751f2:	f7 d0                	not    %eax
c10751f4:	89 47 2c             	mov    %eax,0x2c(%edi)

	__asm__ __volatile__("pushfl\n\t"
c10751f7:	89 d8                	mov    %ebx,%eax
c10751f9:	f7 d0                	not    %eax
c10751fb:	8b 55 d4             	mov    -0x2c(%ebp),%edx
c10751fe:	9c                   	pushf
c10751ff:	81 0c 24 00 02 00 00 	orl    $0x200,(%esp)
c1075206:	0e                   	push   %cs
c1075207:	68 23 52 07 c1       	push   $0xc1075223
c107520c:	50                   	push   %eax
c107520d:	0f a8                	push   %gs
c107520f:	0f a0                	push   %fs
c1075211:	06                   	push   %es
c1075212:	1e                   	push   %ds
c1075213:	50                   	push   %eax
c1075214:	55                   	push   %ebp
c1075215:	57                   	push   %edi
c1075216:	56                   	push   %esi
c1075217:	52                   	push   %edx
c1075218:	51                   	push   %ecx
c1075219:	53                   	push   %ebx
c107521a:	89 f8                	mov    %edi,%eax
c107521c:	ff d2                	call   *%edx
c107521e:	e9 dd 27 21 00       	jmp    c1287a00 <__kprobes_text_start>

c1075223 <__xirq_end>:
c1075223:	fa                   	cli
			local_irq_disable_hw();
c1075224:	fa                   	cli
			root_stall_after_handler();
		}

		p =3D ipipe_cpudom_ptr(__ipipe_current_domain);
c1075225:	64 8b 0d 14 7f 46 c1 	mov    %fs:0xc1467f14,%ecx
c107522c:	ba 94 e6 46 c1       	mov    $0xc146e694,%edx
c1075231:	8b 5d d8             	mov    -0x28(%ebp),%ebx
c1075234:	8d 04 19             	lea    (%ecx,%ebx,1),%eax
c1075237:	8b 14 11             	mov    (%ecx,%edx,1),%edx
c107523a:	69 12 68 16 00 00    	imul   $0x1668,(%edx),%edx
c1075240:	01 d0                	add    %edx,%eax
c1075242:	e9 96 fe ff ff       	jmp    c10750dd <__ipipe_sync_stage+0x3b>
c1075247:	0f ba 30 00          	btrl   $0x0,(%eax)

	if (ipd =3D=3D ipipe_root_domain)
		trace_hardirqs_on();

	__clear_bit(IPIPE_STALL_FLAG, &p->status);
}
c107524b:	83 c4 28             	add    $0x28,%esp
c107524e:	5b                   	pop    %ebx
c107524f:	5e                   	pop    %esi
c1075250:	5f                   	pop    %edi
c1075251:	5d                   	pop    %ebp
c1075252:	c3                   	ret


And here http://odavilar.0x1fee3.org/xenomai/ you can find the dump with
gdb and the dump with objdump -d and also de .config of the kernel.

Thanks a lot.

--=20
Atentamente:
Oscar D=E1vila Ram=EDrez

--e89a8fb1ef38435f1404ba4b96c1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><div class=3D"gmail_quote">2012/3/2 Gilles Chanteperdrix <span dir=3D"l=
tr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.chantepe=
rdrix@domain.hid</a>&gt;</span><br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">

<div><div></div><div class=3D"h5">On 03/02/2012 11:04 AM, Gilles Chanteperd=
rix wrote:<br>
&gt; On 03/01/2012 05:23 AM, Oscar D=E1vila wrote:<br>
&gt;&gt; Finally i could get the dump<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; post-prompt<br>
&gt;&gt; No breakpoints or watchpoints.<br>
&gt;&gt;<br>
&gt;&gt; breakpoints-table-end<br>
&gt;&gt;<br>
&gt;&gt; post-prompt<br>
&gt;&gt; Dump of assembler code for function __ipipe_sync_stage:<br>
&gt;&gt; 0xc106d376 &lt;__ipipe_sync_stage+0&gt;: =A0 push =A0 %ebp<br>
&gt;&gt; (...)<br>
&gt;&gt; 0xc106d526 &lt;__ipipe_sync_stage+432&gt;: ret<br>
&gt;&gt; End of assembler dump.<br>
&gt;<br>
&gt; The address where the EIP is when the NMI watchdog triggers is<br>
&gt; 0xc106d5e1, so, outside this code.<br>
&gt;<br>
</div></div>And this dump does not seem to correspond to the kernel that wa=
s running<br>
when the bug happened, because in that case we had<br>
<br>
0xc106d5e1 =3D=3D __ipipe_sync_stage + 0x21b<br>
<br>
whereas in your dump,<br>
<br>
__ipipe_sync_stage + 0x21b =3D=3D 0xc106d591<br>
<font color=3D"#888888"><br></font></blockquote><div>Sorry about that, i lo=
st that image of the kernel.</div><div><br></div><div>Here is a new complet=
e test.</div><div><br></div><div>Kernel Messages</div><div><pre style=3D"wo=
rd-wrap:break-word;white-space:pre-wrap">

Kernel failure message 1:
BUG: NMI Watchdog detected LOCKUP on CPU0, ip c10751d3, registers:
Modules linked in: isofs udf crc_itu_t i915 drm_kms_helper drm i2c_algo_bit=
 sco ppdev bridge stp bnep lp l2cap crc16 bluetooth rfkill binfmt_misc fuse=
 loop snd_intel8x0 snd_ac97_codec ac97_bus snd_pcm_oss snd_mixer_oss snd_pc=
m snd_seq_midi snd_rawmidi snd_seq_midi_event snd_seq snd_timer snd_seq_dev=
ice i2c_i801 snd parport_pc i2c_core soundcore snd_page_alloc parport rng_c=
ore tpm_tis tpm evdev psmouse serio_raw usbhid hid ext3 jbd mbcache sg sr_m=
od sd_mod crc_t10dif cdrom ata_generic uhci_hcd ehci_hcd ata_piix libata sc=
si_mod tg3 usbcore floppy libphy nls_base [last unloaded: scsi_wait_scan]

Pid: 1891, comm: ex01 Not tainted 2.6.35.9-xenomai-2.6.0-8 #5 IBM/8143PSR
EIP: 0060:[&lt;c10751d3&gt;] EFLAGS: 00200002 CPU: 0
EIP is at __ipipe_sync_stage+0x131/0x181
EAX: deb38000 EBX: 00000521 ECX: de8a6940 EDX: c1472580
ESI: c1542100 EDI: 00000523 EBP: deb39f98 ESP: deb39f64
 DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
Process ex01 (pid: 1891, ti=3Ddeb38000 task=3Dde8a6940 task.ti=3Ddeb38000)
I-pipe domain Linux
Stack:
 ffffffff c1542100 c109dfb0 c1468cf4 00000520 c1542104 c1c03cf8 c1c03cfc
&lt;0&gt; c1c03d04 c146802c deb39fb4 00200282 00000001 deb39fac c1019be4 08=
0499c4
&lt;0&gt; 00000000 00000000 deb38000 c1287a71 080499c4 080486a4 00000000 00=
000000
Call Trace:
 [&lt;c109dfb0&gt;] ? hisyscall_event+0x0/0x2b2
 [&lt;c1019be4&gt;] ? __ipipe_syscall_root+0xd9/0xe8
 [&lt;c1287a71&gt;] ? system_call+0x2d/0x4f
Code: f9 c1 e1 07 8b 91 0c 21 54 c1 89 d8 ff 91 08 21 54 c1 e8 b7 b6 fb ff =
fa 89 e0 25 00 e0 ff ff 83 78 14 00 75 58 f6 40 08 08 74 52 &lt;eb&gt; f8 c=
1 e7 07 8b 97 08 21 54 c1 64 8b 3d 14 7f 46 c1 03 7d f0=20
---[ end trace 6b3881f72975605e ]---</pre><pre style=3D"word-wrap:break-wor=
d;white-space:pre-wrap"><br></pre></div><div>Objdump -S</div><div><br></div=
><div><pre style=3D"word-wrap:break-word;white-space:pre-wrap">c10750a2 &lt=
;__ipipe_sync_stage&gt;:
 * return of this routine.
 *
 * This routine must be called with hw interrupts off.
 */
void __ipipe_sync_stage(void)
{
c10750a2:	55                   	push   %ebp
c10750a3:	89 e5                	mov    %esp,%ebp
c10750a5:	57                   	push   %edi
c10750a6:	56                   	push   %esi
c10750a7:	53                   	push   %ebx
c10750a8:	83 ec 28             	sub    $0x28,%esp
	struct ipipe_percpu_domain_data *p;
	struct ipipe_domain *ipd;
	int irq;

	ipd =3D __ipipe_current_domain;
c10750ab:	ba 94 e6 46 c1       	mov    $0xc146e694,%edx
c10750b0:	64 a1 14 7f 46 c1    	mov    %fs:0xc1467f14,%eax
c10750b6:	8b 34 10             	mov    (%eax,%edx,1),%esi
	p =3D ipipe_cpudom_ptr(ipd);
c10750b9:	ba f4 8c 46 c1       	mov    $0xc1468cf4,%edx
c10750be:	01 d0                	add    %edx,%eax
c10750c0:	69 0e 68 16 00 00    	imul   $0x1668,(%esi),%ecx
c10750c6:	01 c8                	add    %ecx,%eax
c10750c8:	0f ba 28 00          	btsl   $0x0,(%eax)
		barrier();

		if (test_bit(IPIPE_LOCK_FLAG, &amp;ipd-&gt;irqs[irq].control))
			continue;

		if (!__ipipe_pipeline_head_p(ipd))
c10750cc:	8d 4e 04             	lea    0x4(%esi),%ecx
c10750cf:	89 4d e0             	mov    %ecx,-0x20(%ebp)
void __ipipe_end_edge_irq(unsigned irq, struct irq_desc *desc);

static inline void __do_root_xirq(ipipe_irq_handler_t handler,
				  unsigned int irq)
{
	struct pt_regs *regs =3D &amp;__raw_get_cpu_var(__ipipe_tick_regs);
c10750d2:	bb 2c 80 46 c1       	mov    $0xc146802c,%ebx
c10750d7:	89 5d f0             	mov    %ebx,-0x10(%ebp)
			__ipipe_do_root_xirq(ipd, irq);
			local_irq_disable_hw();
			root_stall_after_handler();
		}

		p =3D ipipe_cpudom_ptr(__ipipe_current_domain);
c10750da:	89 55 d8             	mov    %edx,-0x28(%ebp)
	clear_bit(nr, addr);
}

static inline void __clear_bit(int nr, volatile unsigned long *addr)
{
	asm volatile(&quot;btr %1,%0&quot; : ADDR : &quot;Ir&quot; (nr));
c10750dd:	8d 50 10             	lea    0x10(%eax),%edx
c10750e0:	89 55 ec             	mov    %edx,-0x14(%ebp)
c10750e3:	8d 48 08             	lea    0x8(%eax),%ecx
c10750e6:	89 4d e8             	mov    %ecx,-0x18(%ebp)
c10750e9:	8d 58 04             	lea    0x4(%eax),%ebx
c10750ec:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
c10750ef:	89 75 d0             	mov    %esi,-0x30(%ebp)
{
	int l0b, l1b, l2b;
	unsigned long l0m, l1m, l2m;
	unsigned int irq;

	l0m =3D p-&gt;irqpend_himap;
c10750f2:	8b 50 04             	mov    0x4(%eax),%edx
	if (unlikely(l0m =3D=3D 0))
c10750f5:	85 d2                	test   %edx,%edx
c10750f7:	0f 84 4a 01 00 00    	je     c1075247 &lt;__xirq_end+0x24&gt;

int __ipipe_handle_irq(struct pt_regs *regs);

static inline unsigned long __ipipe_ffnz(unsigned long ul)
{
      __asm__(&quot;bsrl %1, %0&quot;:&quot;=3Dr&quot;(ul)
c10750fd:	0f bd d2             	bsr    %edx,%edx
		return -1;

	l0b =3D __ipipe_ffnz(l0m);
	l1m =3D p-&gt;irqpend_mdmap[l0b];
c1075100:	8b 4c 90 08          	mov    0x8(%eax,%edx,4),%ecx
	if (unlikely(l1m =3D=3D 0))
c1075104:	85 c9                	test   %ecx,%ecx
c1075106:	0f 84 3b 01 00 00    	je     c1075247 &lt;__xirq_end+0x24&gt;
c107510c:	0f bd c9             	bsr    %ecx,%ecx
		return -1;

	l1b =3D __ipipe_ffnz(l1m) + l0b * BITS_PER_LONG;
c107510f:	89 d3                	mov    %edx,%ebx
c1075111:	c1 e3 05             	shl    $0x5,%ebx
c1075114:	01 d9                	add    %ebx,%ecx
	l2m =3D p-&gt;irqpend_lomap[l1b];
c1075116:	8d 79 04             	lea    0x4(%ecx),%edi
c1075119:	8b 1c b8             	mov    (%eax,%edi,4),%ebx
	if (unlikely(l2m =3D=3D 0))
c107511c:	85 db                	test   %ebx,%ebx
c107511e:	0f 84 23 01 00 00    	je     c1075247 &lt;__xirq_end+0x24&gt;
c1075124:	0f bd f3             	bsr    %ebx,%esi
		return -1;

	l2b =3D __ipipe_ffnz(l2m);
	irq =3D l1b * BITS_PER_LONG + l2b;
c1075127:	89 cb                	mov    %ecx,%ebx
c1075129:	c1 e3 05             	shl    $0x5,%ebx
c107512c:	89 5d dc             	mov    %ebx,-0x24(%ebp)
c107512f:	8b 5d dc             	mov    -0x24(%ebp),%ebx
c1075132:	01 f3                	add    %esi,%ebx
c1075134:	8b 75 ec             	mov    -0x14(%ebp),%esi
c1075137:	0f b3 1e             	btr    %ebx,(%esi)

	__clear_bit(irq, p-&gt;irqpend_lomap);
	if (p-&gt;irqpend_lomap[l1b] =3D=3D 0) {
c107513a:	83 3c b8 00          	cmpl   $0x0,(%eax,%edi,4)
c107513e:	75 13                	jne    c1075153 &lt;__ipipe_sync_stage+0xb1=
&gt;
c1075140:	8b 75 e8             	mov    -0x18(%ebp),%esi
c1075143:	0f b3 0e             	btr    %ecx,(%esi)
		__clear_bit(l1b, p-&gt;irqpend_mdmap);
		if (p-&gt;irqpend_mdmap[l0b] =3D=3D 0)
c1075146:	83 7c 90 08 00       	cmpl   $0x0,0x8(%eax,%edx,4)
c107514b:	75 06                	jne    c1075153 &lt;__ipipe_sync_stage+0xb1=
&gt;
c107514d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
c1075150:	0f b3 11             	btr    %edx,(%ecx)
	if (ipd =3D=3D ipipe_root_domain)
		trace_hardirqs_off();

	for (;;) {
		irq =3D __ipipe_next_irq(p);
		if (irq &lt; 0)
c1075153:	85 db                	test   %ebx,%ebx
c1075155:	0f 88 ec 00 00 00    	js     c1075247 &lt;__xirq_end+0x24&gt;
		 * that all updates to maps are done before the
		 * handler gets called.
		 */
		barrier();

		if (test_bit(IPIPE_LOCK_FLAG, &amp;ipd-&gt;irqs[irq].control))
c107515b:	8d 53 02             	lea    0x2(%ebx),%edx
c107515e:	c1 e2 07             	shl    $0x7,%edx
c1075161:	8b 75 d0             	mov    -0x30(%ebp),%esi
c1075164:	f6 04 16 20          	testb  $0x20,(%esi,%edx,1)
c1075168:	75 88                	jne    c10750f2 &lt;__ipipe_sync_stage+0x50=
&gt;
			continue;

		if (!__ipipe_pipeline_head_p(ipd))
c107516a:	8b 45 e0             	mov    -0x20(%ebp),%eax
c107516d:	3b 05 50 77 3f c1    	cmp    0xc13f7750,%eax
c1075173:	74 01                	je     c1075176 &lt;__ipipe_sync_stage+0xd4=
&gt;
			local_irq_enable_hw();
c1075175:	fb                   	sti   =20

		if (likely(ipd !=3D ipipe_root_domain)) {
c1075176:	81 fe 00 21 54 c1    	cmp    $0xc1542100,%esi
c107517c:	74 16                	je     c1075194 &lt;__ipipe_sync_stage+0xf2=
&gt;
			ipd-&gt;irqs[irq].handler(irq, ipd-&gt;irqs[irq].cookie);
c107517e:	8d 4b 02             	lea    0x2(%ebx),%ecx
c1075181:	c1 e1 07             	shl    $0x7,%ecx
c1075184:	8b 54 31 0c          	mov    0xc(%ecx,%esi,1),%edx
c1075188:	89 d8                	mov    %ebx,%eax
c107518a:	ff 54 0e 08          	call   *0x8(%esi,%ecx,1)
			__ipipe_run_irqtail(irq);
			local_irq_disable_hw();
c107518e:	fa                   	cli   =20
c107518f:	e9 91 00 00 00       	jmp    c1075225 &lt;__xirq_end+0x2&gt;
		} else if (ipipe_virtual_irq_p(irq)) {
c1075194:	8d 83 e0 fa ff ff    	lea    -0x520(%ebx),%eax
c107519a:	83 f8 1f             	cmp    $0x1f,%eax
c107519d:	8d 7b 02             	lea    0x2(%ebx),%edi
c10751a0:	77 33                	ja     c10751d5 &lt;__ipipe_sync_stage+0x13=
3&gt;
			irq_enter();
c10751a2:	e8 f8 b3 fb ff       	call   c103059f &lt;irq_enter&gt;
			ipd-&gt;irqs[irq].handler(irq, ipd-&gt;irqs[irq].cookie);
c10751a7:	89 f9                	mov    %edi,%ecx
c10751a9:	c1 e1 07             	shl    $0x7,%ecx
c10751ac:	8b 91 0c 21 54 c1    	mov    -0x3eabdef4(%ecx),%edx
c10751b2:	89 d8                	mov    %ebx,%eax
c10751b4:	ff 91 08 21 54 c1    	call   *-0x3eabdef8(%ecx)
			irq_exit();
c10751ba:	e8 b7 b6 fb ff       	call   c1030876 &lt;irq_exit&gt;
			local_irq_disable_hw();
c10751bf:	fa                   	cli   =20
c10751c0:	89 e0                	mov    %esp,%eax
c10751c2:	25 00 e0 ff ff       	and    $0xffffe000,%eax
			root_stall_after_handler();
			while (__ipipe_check_root_resched())
c10751c7:	83 78 14 00          	cmpl   $0x0,0x14(%eax)
c10751cb:	75 58                	jne    c1075225 &lt;__xirq_end+0x2&gt;
c10751cd:	f6 40 08 08          	testb  $0x8,0x8(%eax)
c10751d1:	74 52                	je     c1075225 &lt;__xirq_end+0x2&gt;
c10751d3:	eb f8                	jmp    c10751cd &lt;__ipipe_sync_stage+0x12=
b&gt;
				__ipipe_preempt_schedule_irq();
		} else {
			__ipipe_do_root_xirq(ipd, irq);
c10751d5:	c1 e7 07             	shl    $0x7,%edi
c10751d8:	8b 97 08 21 54 c1    	mov    -0x3eabdef8(%edi),%edx
void __ipipe_end_edge_irq(unsigned irq, struct irq_desc *desc);

static inline void __do_root_xirq(ipipe_irq_handler_t handler,
				  unsigned int irq)
{
	struct pt_regs *regs =3D &amp;__raw_get_cpu_var(__ipipe_tick_regs);
c10751de:	64 8b 3d 14 7f 46 c1 	mov    %fs:0xc1467f14,%edi
c10751e5:	03 7d f0             	add    -0x10(%ebp),%edi

static inline unsigned __ipipe_get_irq_vector(int irq)
{
#ifdef CONFIG_X86_IO_APIC
	unsigned __ipipe_get_ioapic_irq_vector(int irq);
	return __ipipe_get_ioapic_irq_vector(irq);
c10751e8:	89 d8                	mov    %ebx,%eax
c10751ea:	89 55 d4             	mov    %edx,-0x2c(%ebp)
c10751ed:	e8 15 02 fa ff       	call   c1015407 &lt;__ipipe_get_ioapic_irq_=
vector&gt;

	regs-&gt;orig_ax =3D ~__ipipe_get_irq_vector(irq);
c10751f2:	f7 d0                	not    %eax
c10751f4:	89 47 2c             	mov    %eax,0x2c(%edi)

	__asm__ __volatile__(&quot;pushfl\n\t&quot;
c10751f7:	89 d8                	mov    %ebx,%eax
c10751f9:	f7 d0                	not    %eax
c10751fb:	8b 55 d4             	mov    -0x2c(%ebp),%edx
c10751fe:	9c                   	pushf =20
c10751ff:	81 0c 24 00 02 00 00 	orl    $0x200,(%esp)
c1075206:	0e                   	push   %cs
c1075207:	68 23 52 07 c1       	push   $0xc1075223
c107520c:	50                   	push   %eax
c107520d:	0f a8                	push   %gs
c107520f:	0f a0                	push   %fs
c1075211:	06                   	push   %es
c1075212:	1e                   	push   %ds
c1075213:	50                   	push   %eax
c1075214:	55                   	push   %ebp
c1075215:	57                   	push   %edi
c1075216:	56                   	push   %esi
c1075217:	52                   	push   %edx
c1075218:	51                   	push   %ecx
c1075219:	53                   	push   %ebx
c107521a:	89 f8                	mov    %edi,%eax
c107521c:	ff d2                	call   *%edx
c107521e:	e9 dd 27 21 00       	jmp    c1287a00 &lt;__kprobes_text_start&gt=
;

c1075223 &lt;__xirq_end&gt;:
c1075223:	fa                   	cli   =20
			local_irq_disable_hw();
c1075224:	fa                   	cli   =20
			root_stall_after_handler();
		}

		p =3D ipipe_cpudom_ptr(__ipipe_current_domain);
c1075225:	64 8b 0d 14 7f 46 c1 	mov    %fs:0xc1467f14,%ecx
c107522c:	ba 94 e6 46 c1       	mov    $0xc146e694,%edx
c1075231:	8b 5d d8             	mov    -0x28(%ebp),%ebx
c1075234:	8d 04 19             	lea    (%ecx,%ebx,1),%eax
c1075237:	8b 14 11             	mov    (%ecx,%edx,1),%edx
c107523a:	69 12 68 16 00 00    	imul   $0x1668,(%edx),%edx
c1075240:	01 d0                	add    %edx,%eax
c1075242:	e9 96 fe ff ff       	jmp    c10750dd &lt;__ipipe_sync_stage+0x3b=
&gt;
c1075247:	0f ba 30 00          	btrl   $0x0,(%eax)

	if (ipd =3D=3D ipipe_root_domain)
		trace_hardirqs_on();

	__clear_bit(IPIPE_STALL_FLAG, &amp;p-&gt;status);
}
c107524b:	83 c4 28             	add    $0x28,%esp
c107524e:	5b                   	pop    %ebx
c107524f:	5e                   	pop    %esi
c1075250:	5f                   	pop    %edi
c1075251:	5d                   	pop    %ebp
c1075252:	c3                   	ret   =20
</pre></div><div><br></div><div>And here=A0<a href=3D"http://odavilar.0x1fe=
e3.org/xenomai/">http://odavilar.0x1fee3.org/xenomai/</a>=A0you can find th=
e dump with gdb and the dump with objdump -d and also de .config of the ker=
nel.</div>

<div><br></div><div>Thanks a lot.</div></div><br>-- <br><div>Atentamente:<b=
r>Oscar D=E1vila Ram=EDrez<br></div><br>

--e89a8fb1ef38435f1404ba4b96c1--

