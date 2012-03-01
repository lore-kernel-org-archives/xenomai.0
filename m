MIME-Version: 1.0
In-Reply-To: <CAHOEnGcVoRVtfL0Fgz-zx-==2YkM7QH3abtSLDaZdyVo0gk60Q@mail.gmail.com>
References: <CAHOEnGfih5tin7NAnf-qU6tKxVtnb=LjuBFE5QxFQpxfA=EBkg@domain.hid>
	<CAHOEnGdKstVsBUKnQcCm3NK4BfngnGOAKfimXA5VL=ujUzR2ig@domain.hid>
	<4F3AAA52.6060802@domain.hid>
	<CAHOEnGdzwe3gj5c_PAkqBHsYCz=-+McZkDTz7kSOLUQyVDVDyg@domain.hid>
	<4F46C7CD.1070509@domain.hid>
	<CAHOEnGfV3f6aKwzvU+cAkofDXhoHXKQU4YRexUatB85KtTYiDg@domain.hid>
	<4F4920DE.40600@domain.hid>
	<CAHOEnGcVoRVtfL0Fgz-zx-==2YkM7QH3abtSLDaZdyVo0gk60Q@mail.gmail.com>
From: =?ISO-8859-1?Q?Oscar_D=E1vila?= <odavilar@domain.hid>
Date: Wed, 29 Feb 2012 22:23:59 -0600
Message-ID: <CAHOEnGfcSwNEi61Kq9=HHzNrMTV6eFc9ZzJJTSqKZRD4wS9juA@mail.gmail.com>
Content-Type: multipart/alternative; boundary=14dae9399b11810dc704ba26d5cd
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

--14dae9399b11810dc704ba26d5cd
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

2012/2/29 Oscar D=E1vila <odavilar@domain.hid>

>
> 2012/2/25 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>
>> On 02/24/2012 11:55 PM, Oscar D=E1vila wrote:
>> > 2012/2/23 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>> >
>> >> On 02/23/2012 11:43 PM, Oscar D=E1vila wrote:
>> >>> 2012/2/14 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>> >>>
>> >>>> On 02/14/2012 06:54 PM, Oscar D=E1vila wrote:
>> >>>>> I compiled Xenomai succesfully, but when i try to run an example i=
t
>> >>>> freezes
>> >>>>> / machine look up, any help will be apreciated, thanks.
>> >>>>>
>> >>>>> Here is some info about the system, its a Debian 6.0 with a
>> >>>>> kernel 2.6.35.9, xenomai-2.6.0, the adeos
>> >>>>> patch adeos-ipipe-2.6.35.9-x86-2.8-04.patch and Im also using the
>> >>>>> nmi_watchdog=3D2 in the boot kernel options.
>> >>>>
>> >>>> Please reproduce the bug:
>> >>>> - in text mode, so as to have the full bug trace;
>> >>>> - with frame pointers enabled;
>> >>>> - with highest kernel verbosity for BUGs and backtraces.
>> >>>>
>> >>>
>> >>> How do i do this last point? i mean, i already compile kernel with
>> frame
>> >>> pointers enabled, also i already ran it in text mode, and i active a=
ll
>> >> the
>> >>> xenomai debug kernel options. i saw some other debug options in kern=
el
>> >>> hacking, do i have to active those ones too?
>> >>
>> >> The stack trace looks fine. Could you show us the disassembly of the
>> >> __ipipe_sync_stage function?
>> >>
>> >>
>> > Here is what i think is the disassembly of the __ipipe_sync_stage
>> function,
>> > the full disassembly of the core.c file is in
>> > http://odavilar.0x1fee3.org/xenomai/__ipipe_sync_stage
>>
>> Please obtain the disassembly with objdump -d vmlinx, so that we get the
>> addresses corresponding with the instructions. Without the addresses, we
>> do not know where to look.
>>
>
> I need some help here, i've already dump the vmlinux image, but i get the
> asm with addresses but without the source so i don't know how to get the
> __ipipe_sync_stage function, y tried objdump -S vmlinux but didnt worked,
> do i have to check an option in the .config of the kernel to be able to g=
et
> the source?
>
>
> Thanks again.
>
>
Finally i could get the dump


post-prompt
No breakpoints or watchpoints.

breakpoints-table-end

post-prompt
Dump of assembler code for function __ipipe_sync_stage:
0xc106d376 <__ipipe_sync_stage+0>:	push   %ebp
0xc106d377 <__ipipe_sync_stage+1>:	mov    %esp,%ebp
0xc106d379 <__ipipe_sync_stage+3>:	push   %edi
0xc106d37a <__ipipe_sync_stage+4>:	push   %esi
0xc106d37b <__ipipe_sync_stage+5>:	push   %ebx
0xc106d37c <__ipipe_sync_stage+6>:	sub    $0x28,%esp
0xc106d37f <__ipipe_sync_stage+9>:	mov    $0xc1439694,%edx
0xc106d384 <__ipipe_sync_stage+14>:	mov    %fs:0xc1432f14,%eax
0xc106d38a <__ipipe_sync_stage+20>:	mov    (%eax,%edx,1),%esi
0xc106d38d <__ipipe_sync_stage+23>:	mov    $0xc1433cf4,%edx
0xc106d392 <__ipipe_sync_stage+28>:	add    %edx,%eax
0xc106d394 <__ipipe_sync_stage+30>:	imul   $0x1668,(%esi),%ecx
0xc106d39a <__ipipe_sync_stage+36>:	add    %ecx,%eax
0xc106d39c <__ipipe_sync_stage+38>:	btsl   $0x0,(%eax)
0xc106d3a0 <__ipipe_sync_stage+42>:	lea    0x4(%esi),%ecx
0xc106d3a3 <__ipipe_sync_stage+45>:	mov    %ecx,-0x20(%ebp)
0xc106d3a6 <__ipipe_sync_stage+48>:	mov    $0xc143302c,%ebx
0xc106d3ab <__ipipe_sync_stage+53>:	mov    %ebx,-0x10(%ebp)
0xc106d3ae <__ipipe_sync_stage+56>:	mov    %edx,-0x28(%ebp)
0xc106d3b1 <__ipipe_sync_stage+59>:	lea    0x10(%eax),%edx
0xc106d3b4 <__ipipe_sync_stage+62>:	mov    %edx,-0x14(%ebp)
0xc106d3b7 <__ipipe_sync_stage+65>:	lea    0x8(%eax),%ecx
0xc106d3ba <__ipipe_sync_stage+68>:	mov    %ecx,-0x18(%ebp)
0xc106d3bd <__ipipe_sync_stage+71>:	lea    0x4(%eax),%ebx
0xc106d3c0 <__ipipe_sync_stage+74>:	mov    %ebx,-0x1c(%ebp)
0xc106d3c3 <__ipipe_sync_stage+77>:	mov    %esi,-0x30(%ebp)
0xc106d3c6 <__ipipe_sync_stage+80>:	mov    0x4(%eax),%edx
0xc106d3c9 <__ipipe_sync_stage+83>:	test   %edx,%edx
0xc106d3cb <__ipipe_sync_stage+85>:	je     0xc106d51b <__ipipe_sync_stage+4=
21>
0xc106d3d1 <__ipipe_sync_stage+91>:	bsr    %edx,%edx
0xc106d3d4 <__ipipe_sync_stage+94>:	mov    0x8(%eax,%edx,4),%ecx
0xc106d3d8 <__ipipe_sync_stage+98>:	test   %ecx,%ecx
0xc106d3da <__ipipe_sync_stage+100>:	je     0xc106d51b <__ipipe_sync_stage+=
421>
0xc106d3e0 <__ipipe_sync_stage+106>:	bsr    %ecx,%ecx
0xc106d3e3 <__ipipe_sync_stage+109>:	mov    %edx,%ebx
0xc106d3e5 <__ipipe_sync_stage+111>:	shl    $0x5,%ebx
0xc106d3e8 <__ipipe_sync_stage+114>:	add    %ebx,%ecx
0xc106d3ea <__ipipe_sync_stage+116>:	lea    0x4(%ecx),%edi
0xc106d3ed <__ipipe_sync_stage+119>:	mov    (%eax,%edi,4),%ebx
0xc106d3f0 <__ipipe_sync_stage+122>:	test   %ebx,%ebx
0xc106d3f2 <__ipipe_sync_stage+124>:	je     0xc106d51b <__ipipe_sync_stage+=
421>
0xc106d3f8 <__ipipe_sync_stage+130>:	bsr    %ebx,%esi
0xc106d3fb <__ipipe_sync_stage+133>:	mov    %ecx,%ebx
0xc106d3fd <__ipipe_sync_stage+135>:	shl    $0x5,%ebx
0xc106d400 <__ipipe_sync_stage+138>:	mov    %ebx,-0x24(%ebp)
0xc106d403 <__ipipe_sync_stage+141>:	mov    -0x24(%ebp),%ebx
0xc106d406 <__ipipe_sync_stage+144>:	add    %esi,%ebx
0xc106d408 <__ipipe_sync_stage+146>:	mov    -0x14(%ebp),%esi
0xc106d40b <__ipipe_sync_stage+149>:	btr    %ebx,(%esi)
0xc106d40e <__ipipe_sync_stage+152>:	cmpl   $0x0,(%eax,%edi,4)
0xc106d412 <__ipipe_sync_stage+156>:	jne    0xc106d427 <__ipipe_sync_stage+=
177>
0xc106d414 <__ipipe_sync_stage+158>:	mov    -0x18(%ebp),%esi
0xc106d417 <__ipipe_sync_stage+161>:	btr    %ecx,(%esi)
0xc106d41a <__ipipe_sync_stage+164>:	cmpl   $0x0,0x8(%eax,%edx,4)
0xc106d41f <__ipipe_sync_stage+169>:	jne    0xc106d427 <__ipipe_sync_stage+=
177>
0xc106d421 <__ipipe_sync_stage+171>:	mov    -0x1c(%ebp),%ecx
0xc106d424 <__ipipe_sync_stage+174>:	btr    %edx,(%ecx)
0xc106d427 <__ipipe_sync_stage+177>:	test   %ebx,%ebx
0xc106d429 <__ipipe_sync_stage+179>:	js     0xc106d51b <__ipipe_sync_stage+=
421>
0xc106d42f <__ipipe_sync_stage+185>:	lea    0x2(%ebx),%edx
0xc106d432 <__ipipe_sync_stage+188>:	shl    $0x7,%edx
0xc106d435 <__ipipe_sync_stage+191>:	mov    -0x30(%ebp),%esi
0xc106d438 <__ipipe_sync_stage+194>:	testb  $0x20,(%esi,%edx,1)
0xc106d43c <__ipipe_sync_stage+198>:	jne    0xc106d3c6 <__ipipe_sync_stage+=
80>
0xc106d43e <__ipipe_sync_stage+200>:	mov    -0x20(%ebp),%eax
0xc106d441 <__ipipe_sync_stage+203>:	cmp    0xc13c6fd0,%eax
0xc106d447 <__ipipe_sync_stage+209>:	je     0xc106d44a <__ipipe_sync_stage+=
212>
0xc106d449 <__ipipe_sync_stage+211>:	sti
0xc106d44a <__ipipe_sync_stage+212>:	cmp    $0xc150c080,%esi
0xc106d450 <__ipipe_sync_stage+218>:	je     0xc106d468 <__ipipe_sync_stage+=
242>
0xc106d452 <__ipipe_sync_stage+220>:	lea    0x2(%ebx),%ecx
0xc106d455 <__ipipe_sync_stage+223>:	shl    $0x7,%ecx
0xc106d458 <__ipipe_sync_stage+226>:	mov    0xc(%ecx,%esi,1),%edx
0xc106d45c <__ipipe_sync_stage+230>:	mov    %ebx,%eax
0xc106d45e <__ipipe_sync_stage+232>:	call   *0x8(%esi,%ecx,1)
0xc106d462 <__ipipe_sync_stage+236>:	cli
0xc106d463 <__ipipe_sync_stage+237>:	jmp    0xc106d4f9 <__ipipe_sync_stage+=
387>
0xc106d468 <__ipipe_sync_stage+242>:	lea    -0x520(%ebx),%eax
0xc106d46e <__ipipe_sync_stage+248>:	cmp    $0x1f,%eax
0xc106d471 <__ipipe_sync_stage+251>:	lea    0x2(%ebx),%edi
0xc106d474 <__ipipe_sync_stage+254>:	ja     0xc106d4a9 <__ipipe_sync_stage+=
307>
0xc106d476 <__ipipe_sync_stage+256>:	call   0xc102d215 <irq_enter>
0xc106d47b <__ipipe_sync_stage+261>:	mov    %edi,%ecx
0xc106d47d <__ipipe_sync_stage+263>:	shl    $0x7,%ecx
0xc106d480 <__ipipe_sync_stage+266>:	mov    -0x3eaf3f74(%ecx),%edx
0xc106d486 <__ipipe_sync_stage+272>:	mov    %ebx,%eax
0xc106d488 <__ipipe_sync_stage+274>:	call   *-0x3eaf3f78(%ecx)
0xc106d48e <__ipipe_sync_stage+280>:	call   0xc102d523 <irq_exit>
0xc106d493 <__ipipe_sync_stage+285>:	cli
0xc106d494 <__ipipe_sync_stage+286>:	mov    %esp,%eax
0xc106d496 <__ipipe_sync_stage+288>:	and    $0xffffe000,%eax
0xc106d49b <__ipipe_sync_stage+293>:	cmpl   $0x0,0x14(%eax)
0xc106d49f <__ipipe_sync_stage+297>:	jne    0xc106d4f9 <__ipipe_sync_stage+=
387>
0xc106d4a1 <__ipipe_sync_stage+299>:	testb  $0x8,0x8(%eax)
0xc106d4a5 <__ipipe_sync_stage+303>:	je     0xc106d4f9 <__ipipe_sync_stage+=
387>
0xc106d4a7 <__ipipe_sync_stage+305>:	jmp    0xc106d4a1 <__ipipe_sync_stage+=
299>
0xc106d4a9 <__ipipe_sync_stage+307>:	shl    $0x7,%edi
0xc106d4ac <__ipipe_sync_stage+310>:	mov    -0x3eaf3f78(%edi),%edx
0xc106d4b2 <__ipipe_sync_stage+316>:	mov    %fs:0xc1432f14,%edi
0xc106d4b9 <__ipipe_sync_stage+323>:	add    -0x10(%ebp),%edi
0xc106d4bc <__ipipe_sync_stage+326>:	mov    %ebx,%eax
0xc106d4be <__ipipe_sync_stage+328>:	mov    %edx,-0x2c(%ebp)
0xc106d4c1 <__ipipe_sync_stage+331>:	call   0xc10145c3
<__ipipe_get_ioapic_irq_vector>
0xc106d4c6 <__ipipe_sync_stage+336>:	not    %eax
0xc106d4c8 <__ipipe_sync_stage+338>:	mov    %eax,0x2c(%edi)
0xc106d4cb <__ipipe_sync_stage+341>:	mov    %ebx,%eax
0xc106d4cd <__ipipe_sync_stage+343>:	not    %eax
0xc106d4cf <__ipipe_sync_stage+345>:	mov    -0x2c(%ebp),%edx
0xc106d4d2 <__ipipe_sync_stage+348>:	pushf
0xc106d4d3 <__ipipe_sync_stage+349>:	orl    $0x200,(%esp)
0xc106d4da <__ipipe_sync_stage+356>:	push   %cs
0xc106d4db <__ipipe_sync_stage+357>:	push   $0xc106d4f7
0xc106d4e0 <__ipipe_sync_stage+362>:	push   %eax
0xc106d4e1 <__ipipe_sync_stage+363>:	push   %gs
0xc106d4e3 <__ipipe_sync_stage+365>:	push   %fs
0xc106d4e5 <__ipipe_sync_stage+367>:	push   %es
0xc106d4e6 <__ipipe_sync_stage+368>:	push   %ds
0xc106d4e7 <__ipipe_sync_stage+369>:	push   %eax
0xc106d4e8 <__ipipe_sync_stage+370>:	push   %ebp
0xc106d4e9 <__ipipe_sync_stage+371>:	push   %edi
0xc106d4ea <__ipipe_sync_stage+372>:	push   %esi
0xc106d4eb <__ipipe_sync_stage+373>:	push   %edx
0xc106d4ec <__ipipe_sync_stage+374>:	push   %ecx
0xc106d4ed <__ipipe_sync_stage+375>:	push   %ebx
0xc106d4ee <__ipipe_sync_stage+376>:	mov    %edi,%eax
0xc106d4f0 <__ipipe_sync_stage+378>:	call   *%edx
0xc106d4f2 <__ipipe_sync_stage+380>:	jmp    0xc1269fd8
0xc106d4f7 <__ipipe_sync_stage+385>:	cli
0xc106d4f8 <__ipipe_sync_stage+386>:	cli
0xc106d4f9 <__ipipe_sync_stage+387>:	mov    %fs:0xc1432f14,%ecx
0xc106d500 <__ipipe_sync_stage+394>:	mov    $0xc1439694,%edx
0xc106d505 <__ipipe_sync_stage+399>:	mov    -0x28(%ebp),%ebx
0xc106d508 <__ipipe_sync_stage+402>:	lea    (%ecx,%ebx,1),%eax
0xc106d50b <__ipipe_sync_stage+405>:	mov    (%ecx,%edx,1),%edx
0xc106d50e <__ipipe_sync_stage+408>:	imul   $0x1668,(%edx),%edx
0xc106d514 <__ipipe_sync_stage+414>:	add    %edx,%eax
0xc106d516 <__ipipe_sync_stage+416>:	jmp    0xc106d3b1 <__ipipe_sync_stage+=
59>
0xc106d51b <__ipipe_sync_stage+421>:	btrl   $0x0,(%eax)
0xc106d51f <__ipipe_sync_stage+425>:	add    $0x28,%esp
0xc106d522 <__ipipe_sync_stage+428>:	pop    %ebx
0xc106d523 <__ipipe_sync_stage+429>:	pop    %esi
0xc106d524 <__ipipe_sync_stage+430>:	pop    %edi
0xc106d525 <__ipipe_sync_stage+431>:	pop    %ebp
0xc106d526 <__ipipe_sync_stage+432>:	ret
End of assembler dump.

post-prompt
No breakpoints or watchpoints.


breakpoints-table-end

Thanks again!

--=20
Atentamente:
Oscar D=E1vila Ram=EDrez

--14dae9399b11810dc704ba26d5cd
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><div class=3D"gmail_quote">2012/2/29 Oscar D=E1vila <span dir=3D"ltr">&=
lt;<a href=3D"mailto:odavilar@domain.hid">odavilar@domain.hid</a>&gt;</span><=
br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex">

<br><div class=3D"gmail_quote"><div><div></div><div class=3D"h5">2012/2/25 =
Gilles Chanteperdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chantep=
erdrix@domain.hid" target=3D"_blank">gilles.chanteperdrix@xenomai.org</a>&=
gt;</span><br>

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


<div><br></div><div><br></div><div>Thanks again.</div></div><div><div class=
=3D"h5"><br clear=3D"all"></div></div></blockquote><div><br></div><div>Fina=
lly i could get the dump</div><div><br></div><pre style=3D"word-wrap:break-=
word;white-space:pre-wrap">

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
pan></div><div><br></div><div>Thanks again!</div></div><br>-- <br><div>Aten=
tamente:<br>Oscar D=E1vila Ram=EDrez<br></div><br>

--14dae9399b11810dc704ba26d5cd--

