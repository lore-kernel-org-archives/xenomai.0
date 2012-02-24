MIME-Version: 1.0
In-Reply-To: <4F46C7CD.1070509@domain.hid>
References: <CAHOEnGfih5tin7NAnf-qU6tKxVtnb=LjuBFE5QxFQpxfA=EBkg@domain.hid>
	<CAHOEnGdKstVsBUKnQcCm3NK4BfngnGOAKfimXA5VL=ujUzR2ig@domain.hid>
	<4F3AAA52.6060802@domain.hid>
	<CAHOEnGdzwe3gj5c_PAkqBHsYCz=-+McZkDTz7kSOLUQyVDVDyg@domain.hid>
	<4F46C7CD.1070509@domain.hid>
From: =?ISO-8859-1?Q?Oscar_D=E1vila?= <odavilar@domain.hid>
Date: Fri, 24 Feb 2012 16:55:37 -0600
Message-ID: <CAHOEnGfV3f6aKwzvU+cAkofDXhoHXKQU4YRexUatB85KtTYiDg@domain.hid>
Content-Type: multipart/alternative; boundary=14dae9399b11e6922404b9bda9c7
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

--14dae9399b11e6922404b9bda9c7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

2012/2/23 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> On 02/23/2012 11:43 PM, Oscar D=E1vila wrote:
> > 2012/2/14 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> >
> >> On 02/14/2012 06:54 PM, Oscar D=E1vila wrote:
> >>> I compiled Xenomai succesfully, but when i try to run an example it
> >> freezes
> >>> / machine look up, any help will be apreciated, thanks.
> >>>
> >>> Here is some info about the system, its a Debian 6.0 with a
> >>> kernel 2.6.35.9, xenomai-2.6.0, the adeos
> >>> patch adeos-ipipe-2.6.35.9-x86-2.8-04.patch and Im also using the
> >>> nmi_watchdog=3D2 in the boot kernel options.
> >>
> >> Please reproduce the bug:
> >> - in text mode, so as to have the full bug trace;
> >> - with frame pointers enabled;
> >> - with highest kernel verbosity for BUGs and backtraces.
> >>
> >
> > How do i do this last point? i mean, i already compile kernel with fram=
e
> > pointers enabled, also i already ran it in text mode, and i active all
> the
> > xenomai debug kernel options. i saw some other debug options in kernel
> > hacking, do i have to active those ones too?
>
> The stack trace looks fine. Could you show us the disassembly of the
> __ipipe_sync_stage function?
>
>
Here is what i think is the disassembly of the __ipipe_sync_stage function,
the full disassembly of the core.c file is in
http://odavilar.0x1fee3.org/xenomai/__ipipe_sync_stage

.globl __ipipe_sync_stage
	.type	__ipipe_sync_stage, @function
__ipipe_sync_stage:
.LFB1334:
	.loc 1 1247 0
	.cfi_startproc
	pushl	%ebp
.LCFI66:
	.cfi_def_cfa_offset 8
	movl	%esp, %ebp
	.cfi_offset 5, -8
.LCFI67:
	.cfi_def_cfa_register 5
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$40, %esp
.LBB904:
	.loc 1 1252 0
	movl	$ipipe_percpu_domain, %edx
.LVL259:
.LBB905:
#APP
# 1252 "kernel/ipipe/core.c" 1
	movl %fs:this_cpu_off,%eax
# 0 "" 2
.LVL260:
#NO_APP
.LBE905:
.LBE904:
	movl	(%eax,%edx), %esi
	.cfi_offset 3, -20
	.cfi_offset 6, -16
	.cfi_offset 7, -12
.LVL261:
.LBB906:
	.loc 1 1253 0
	movl	$ipipe_percpu_darray, %edx
.LVL262:
.LBE906:
	addl	%edx, %eax
.LVL263:
	imull	$5736, (%esi), %ecx
	addl	%ecx, %eax
.LVL264:
.LBB907:
.LBB908:
	.loc 2 84 0
#APP
# 84 "/home/odavilar/workspace/xe/linux-2.6.35.9/arch/x86/include/asm/bitop=
s.h"
1
	bts $0,(%eax)
# 0 "" 2
#NO_APP
.LBE908:
.LBE907:
	.loc 1 1256 0
	.loc 1 1275 0
	leal	4(%esi), %ecx
	movl	%ecx, -32(%ebp)
.LBB909:
.LBB910:
.LBB911:
	.file 11 "/home/odavilar/workspace/xe/linux-2.6.35.9/arch/x86/include/asm/=
ipipe_32.h"
	.loc 11 68 0
	movl	$__ipipe_tick_regs, %ebx
	movl	%ebx, -16(%ebp)
.LBE911:
.LBE910:
.LBE909:
.LBB917:
	.loc 1 1296 0
	movl	%edx, -40(%ebp)
.LVL265:
.L148:
.LBE917:
.LBB919:
.LBB920:
.LBB921:
.LBB922:
	.loc 2 127 0
	leal	16(%eax), %edx
.LVL266:
	movl	%edx, -20(%ebp)
.LBE922:
.LBE921:
.LBB924:
.LBB925:
	leal	8(%eax), %ecx
.LVL267:
	movl	%ecx, -24(%ebp)
.LBE925:
.LBE924:
.LBB927:
.LBB928:
	leal	4(%eax), %ebx
	movl	%ebx, -28(%ebp)
	movl	%esi, -48(%ebp)
.LVL268:
.L142:
.LBE928:
.LBE927:
	.loc 1 648 0
	movl	4(%eax), %edx
.LVL269:
	.loc 1 649 0
	testl	%edx, %edx
	je	.L140
.LBB930:
.LBB931:
	.loc 11 54 0
#APP
# 54 "/home/odavilar/workspace/xe/linux-2.6.35.9/arch/x86/include/asm/ipipe=
_32.h"
1
	bsrl %edx, %edx
# 0 "" 2
.LVL270:
#NO_APP
.LBE931:
.LBE930:
	.loc 1 653 0
	movl	8(%eax,%edx,4), %ecx
.LVL271:
	.loc 1 654 0
	testl	%ecx, %ecx
	je	.L140
.LBB932:
.LBB933:
	.loc 11 54 0
#APP
# 54 "/home/odavilar/workspace/xe/linux-2.6.35.9/arch/x86/include/asm/ipipe=
_32.h"
1
	bsrl %ecx, %ecx
# 0 "" 2
.LVL272:
#NO_APP
.LBE933:
.LBE932:
	.loc 1 657 0
	movl	%edx, %ebx
.LVL273:
	sall	$5, %ebx
	addl	%ebx, %ecx
.LVL274:
	.loc 1 658 0
	leal	4(%ecx), %edi
.LVL275:
	movl	(%eax,%edi,4), %ebx
.LVL276:
	.loc 1 659 0
	testl	%ebx, %ebx
	je	.L140
.LBB934:
.LBB935:
	.loc 11 54 0
#APP
# 54 "/home/odavilar/workspace/xe/linux-2.6.35.9/arch/x86/include/asm/ipipe=
_32.h"
1
	bsrl %ebx, %esi
# 0 "" 2
.LVL277:
#NO_APP
.LBE935:
.LBE934:
	.loc 1 663 0
	movl	%ecx, %ebx
.LVL278:
	sall	$5, %ebx
	movl	%ebx, -36(%ebp)
	movl	-36(%ebp), %ebx
.LVL279:
	addl	%esi, %ebx
.LBB936:
.LBB923:
	.loc 2 127 0
	movl	-20(%ebp), %esi
#APP
# 127 "/home/odavilar/workspace/xe/linux-2.6.35.9/arch/x86/include/asm/bito=
ps.h"
1
	btr %ebx,(%esi)
# 0 "" 2
#NO_APP
.LBE923:
.LBE936:
	.loc 1 666 0
	cmpl	$0, (%eax,%edi,4)
	jne	.L141
.LBB937:
.LBB926:
	.loc 2 127 0
	movl	-24(%ebp), %esi
#APP
# 127 "/home/odavilar/workspace/xe/linux-2.6.35.9/arch/x86/include/asm/bito=
ps.h"
1
	btr %ecx,(%esi)
# 0 "" 2
#NO_APP
.LBE926:
.LBE937:
	.loc 1 668 0
	cmpl	$0, 8(%eax,%edx,4)
	jne	.L141
.LBB938:
.LBB929:
	.loc 2 127 0
	movl	-28(%ebp), %ecx
.LVL280:
#APP
# 127 "/home/odavilar/workspace/xe/linux-2.6.35.9/arch/x86/include/asm/bito=
ps.h"
1
	btr %edx,(%ecx)
# 0 "" 2
.LVL281:
#NO_APP
.L141:
.LBE929:
.LBE938:
.LBE920:
.LBE919:
	.loc 1 1263 0
	testl	%ebx, %ebx
	js	.L140
	.loc 1 1270 0
	.loc 1 1272 0
	leal	2(%ebx), %edx
.LVL282:
	sall	$7, %edx
	movl	-48(%ebp), %esi
	testb	$32, (%esi,%edx)
	jne	.L142
	.loc 1 1275 0
	movl	-32(%ebp), %eax
.LVL283:
	cmpl	__ipipe_pipeline, %eax
	je	.L143
	.loc 1 1276 0
#APP
# 1276 "kernel/ipipe/core.c" 1
	sti
# 0 "" 2
#NO_APP
.L143:
	.loc 1 1278 0
	cmpl	$ipipe_root, %esi
.LVL284:
	je	.L144
	.loc 1 1279 0
	leal	2(%ebx), %ecx
.LVL285:
	sall	$7, %ecx
	movl	12(%ecx,%esi), %edx
	movl	%ebx, %eax
	call	*8(%esi,%ecx)
	.loc 1 1281 0

<http://odavilar.0x1fee3.org/xenomai/__ipipe_sync_stage>Thanks
PS: Is there an irc channel for xenomai?

 --
>                                                                Gilles.
>
>


--=20
Atentamente:
Oscar D=E1vila Ram=EDrez

--14dae9399b11e6922404b9bda9c7
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><div class=3D"gmail_quote">2012/2/23 Gilles Chanteperdrix <span dir=3D"=
ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.chantep=
erdrix@domain.hid</a>&gt;</span><br><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">

<div class=3D"im">On 02/23/2012 11:43 PM, Oscar D=E1vila wrote:<br>
&gt; 2012/2/14 Gilles Chanteperdrix &lt;<a href=3D"mailto:gilles.chanteperd=
rix@domain.hid">gilles.chanteperdrix@xenomai.org</a>&gt;<br>
&gt;<br>
&gt;&gt; On 02/14/2012 06:54 PM, Oscar D=E1vila wrote:<br>
&gt;&gt;&gt; I compiled Xenomai succesfully, but when i try to run an examp=
le it<br>
&gt;&gt; freezes<br>
&gt;&gt;&gt; / machine look up, any help will be apreciated, thanks.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Here is some info about the system, its a Debian 6.0 with a<br=
>
&gt;&gt;&gt; kernel 2.6.35.9, xenomai-2.6.0, the adeos<br>
&gt;&gt;&gt; patch adeos-ipipe-2.6.35.9-x86-2.8-04.patch and Im also using =
the<br>
&gt;&gt;&gt; nmi_watchdog=3D2 in the boot kernel options.<br>
&gt;&gt;<br>
&gt;&gt; Please reproduce the bug:<br>
&gt;&gt; - in text mode, so as to have the full bug trace;<br>
&gt;&gt; - with frame pointers enabled;<br>
&gt;&gt; - with highest kernel verbosity for BUGs and backtraces.<br>
&gt;&gt;<br>
&gt;<br>
&gt; How do i do this last point? i mean, i already compile kernel with fra=
me<br>
&gt; pointers enabled, also i already ran it in text mode, and i active all=
 the<br>
&gt; xenomai debug kernel options. i saw some other debug options in kernel=
<br>
&gt; hacking, do i have to active those ones too?<br>
<br>
</div>The stack trace looks fine. Could you show us the disassembly of the<=
br>
__ipipe_sync_stage function?<br>
<font color=3D"#888888"><br></font></blockquote><div><br></div><div>Here is=
 what i think is the disassembly of the=A0__ipipe_sync_stage function, the =
full disassembly of the core.c file is in=A0<a href=3D"http://odavilar.0x1f=
ee3.org/xenomai/__ipipe_sync_stage">http://odavilar.0x1fee3.org/xenomai/__i=
pipe_sync_stage</a></div>

<div><br></div><div><span class=3D"Apple-style-span" style=3D"font-family:&=
#39;Times New Roman&#39;;font-size:medium"><pre style=3D"word-wrap:break-wo=
rd;white-space:pre-wrap">.globl __ipipe_sync_stage
	.type	__ipipe_sync_stage, @function
__ipipe_sync_stage:
.LFB1334:
	.loc 1 1247 0
	.cfi_startproc
	pushl	%ebp
.LCFI66:
	.cfi_def_cfa_offset 8
	movl	%esp, %ebp
	.cfi_offset 5, -8
.LCFI67:
	.cfi_def_cfa_register 5
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$40, %esp
.LBB904:
	.loc 1 1252 0
	movl	$ipipe_percpu_domain, %edx
.LVL259:
.LBB905:
#APP
# 1252 &quot;kernel/ipipe/core.c&quot; 1
	movl %fs:this_cpu_off,%eax
# 0 &quot;&quot; 2
.LVL260:
#NO_APP
.LBE905:
.LBE904:
	movl	(%eax,%edx), %esi
	.cfi_offset 3, -20
	.cfi_offset 6, -16
	.cfi_offset 7, -12
.LVL261:
.LBB906:
	.loc 1 1253 0
	movl	$ipipe_percpu_darray, %edx
.LVL262:
.LBE906:
	addl	%edx, %eax
.LVL263:
	imull	$5736, (%esi), %ecx
	addl	%ecx, %eax
.LVL264:
.LBB907:
.LBB908:
	.loc 2 84 0
#APP
# 84 &quot;/home/odavilar/workspace/xe/linux-2.6.35.9/arch/x86/include/asm/=
bitops.h&quot; 1
	bts $0,(%eax)
# 0 &quot;&quot; 2
#NO_APP
.LBE908:
.LBE907:
	.loc 1 1256 0
	.loc 1 1275 0
	leal	4(%esi), %ecx
	movl	%ecx, -32(%ebp)
.LBB909:
.LBB910:
.LBB911:
	.file 11 &quot;/home/odavilar/workspace/xe/linux-2.6.35.9/arch/x86/include=
/asm/ipipe_32.h&quot;
	.loc 11 68 0
	movl	$__ipipe_tick_regs, %ebx
	movl	%ebx, -16(%ebp)
.LBE911:
.LBE910:
.LBE909:
.LBB917:
	.loc 1 1296 0
	movl	%edx, -40(%ebp)
.LVL265:
.L148:
.LBE917:
.LBB919:
.LBB920:
.LBB921:
.LBB922:
	.loc 2 127 0
	leal	16(%eax), %edx
.LVL266:
	movl	%edx, -20(%ebp)
.LBE922:
.LBE921:
.LBB924:
.LBB925:
	leal	8(%eax), %ecx
.LVL267:
	movl	%ecx, -24(%ebp)
.LBE925:
.LBE924:
.LBB927:
.LBB928:
	leal	4(%eax), %ebx
	movl	%ebx, -28(%ebp)
	movl	%esi, -48(%ebp)
.LVL268:
.L142:
.LBE928:
.LBE927:
	.loc 1 648 0
	movl	4(%eax), %edx
.LVL269:
	.loc 1 649 0
	testl	%edx, %edx
	je	.L140
.LBB930:
.LBB931:
	.loc 11 54 0
#APP
# 54 &quot;/home/odavilar/workspace/xe/linux-2.6.35.9/arch/x86/include/asm/=
ipipe_32.h&quot; 1
	bsrl %edx, %edx
# 0 &quot;&quot; 2
.LVL270:
#NO_APP
.LBE931:
.LBE930:
	.loc 1 653 0
	movl	8(%eax,%edx,4), %ecx
.LVL271:
	.loc 1 654 0
	testl	%ecx, %ecx
	je	.L140
.LBB932:
.LBB933:
	.loc 11 54 0
#APP
# 54 &quot;/home/odavilar/workspace/xe/linux-2.6.35.9/arch/x86/include/asm/=
ipipe_32.h&quot; 1
	bsrl %ecx, %ecx
# 0 &quot;&quot; 2
.LVL272:
#NO_APP
.LBE933:
.LBE932:
	.loc 1 657 0
	movl	%edx, %ebx
.LVL273:
	sall	$5, %ebx
	addl	%ebx, %ecx
.LVL274:
	.loc 1 658 0
	leal	4(%ecx), %edi
.LVL275:
	movl	(%eax,%edi,4), %ebx
.LVL276:
	.loc 1 659 0
	testl	%ebx, %ebx
	je	.L140
.LBB934:
.LBB935:
	.loc 11 54 0
#APP
# 54 &quot;/home/odavilar/workspace/xe/linux-2.6.35.9/arch/x86/include/asm/=
ipipe_32.h&quot; 1
	bsrl %ebx, %esi
# 0 &quot;&quot; 2
.LVL277:
#NO_APP
.LBE935:
.LBE934:
	.loc 1 663 0
	movl	%ecx, %ebx
.LVL278:
	sall	$5, %ebx
	movl	%ebx, -36(%ebp)
	movl	-36(%ebp), %ebx
.LVL279:
	addl	%esi, %ebx
.LBB936:
.LBB923:
	.loc 2 127 0
	movl	-20(%ebp), %esi
#APP
# 127 &quot;/home/odavilar/workspace/xe/linux-2.6.35.9/arch/x86/include/asm=
/bitops.h&quot; 1
	btr %ebx,(%esi)
# 0 &quot;&quot; 2
#NO_APP
.LBE923:
.LBE936:
	.loc 1 666 0
	cmpl	$0, (%eax,%edi,4)
	jne	.L141
.LBB937:
.LBB926:
	.loc 2 127 0
	movl	-24(%ebp), %esi
#APP
# 127 &quot;/home/odavilar/workspace/xe/linux-2.6.35.9/arch/x86/include/asm=
/bitops.h&quot; 1
	btr %ecx,(%esi)
# 0 &quot;&quot; 2
#NO_APP
.LBE926:
.LBE937:
	.loc 1 668 0
	cmpl	$0, 8(%eax,%edx,4)
	jne	.L141
.LBB938:
.LBB929:
	.loc 2 127 0
	movl	-28(%ebp), %ecx
.LVL280:
#APP
# 127 &quot;/home/odavilar/workspace/xe/linux-2.6.35.9/arch/x86/include/asm=
/bitops.h&quot; 1
	btr %edx,(%ecx)
# 0 &quot;&quot; 2
.LVL281:
#NO_APP
.L141:
.LBE929:
.LBE938:
.LBE920:
.LBE919:
	.loc 1 1263 0
	testl	%ebx, %ebx
	js	.L140
	.loc 1 1270 0
	.loc 1 1272 0
	leal	2(%ebx), %edx
.LVL282:
	sall	$7, %edx
	movl	-48(%ebp), %esi
	testb	$32, (%esi,%edx)
	jne	.L142
	.loc 1 1275 0
	movl	-32(%ebp), %eax
.LVL283:
	cmpl	__ipipe_pipeline, %eax
	je	.L143
	.loc 1 1276 0
#APP
# 1276 &quot;kernel/ipipe/core.c&quot; 1
	sti
# 0 &quot;&quot; 2
#NO_APP
.L143:
	.loc 1 1278 0
	cmpl	$ipipe_root, %esi
.LVL284:
	je	.L144
	.loc 1 1279 0
	leal	2(%ebx), %ecx
.LVL285:
	sall	$7, %ecx
	movl	12(%ecx,%esi), %edx
	movl	%ebx, %eax
	call	*8(%esi,%ecx)
	.loc 1 1281 0</pre></span></div><div><a href=3D"http://odavilar.0x1fee3.or=
g/xenomai/__ipipe_sync_stage"></a>Thanks</div><div>PS: Is there an irc chan=
nel for xenomai?</div><div><br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">

<font color=3D"#888888">
--<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
<br>
</font></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div>=
Atentamente:<br>Oscar D=E1vila Ram=EDrez<br></div><br>

--14dae9399b11e6922404b9bda9c7--

