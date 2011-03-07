MIME-Version: 1.0
In-Reply-To: <4D725DB2.5030202@domain.hid>
References: <AANLkTik6fDir0vM8E_pJerRXY=jvPBtnNnZFO+jwHnOd@domain.hid>
	<4D722CC9.9060307@domain.hid> <4D725DB2.5030202@domain.hid>
Date: Sun, 6 Mar 2011 20:49:23 -0500
Message-ID: <AANLkTi==3BCs6m=dq7BkHKnq+h3NSfQujbNbwMZZyOZy@domain.hid>
From: Eric Eric <ericrebates@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Illegal instruction running trivial-periodic on
 ARM with 2.5.5.2/2.6.33
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Gilles, thank you for the prompt and helpful response.  I rebuilt with
--enable-arm-eabi and everything seems to be working now.

- Eric

On Sat, Mar 5, 2011 at 10:58 AM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> Gilles Chanteperdrix wrote:
>> Eric Cohen wrote:
>>> Hello, I am attempting to evaluate Xenomai and am running into an
>>> illegal instruction when I try to run trivial-periodic. =A0I am running
>>> Xenomai 2.5.5.2 with kernel 2.6.33.5-x3 on a Beagleboard. =A0Kernel and
>>> Xenomai were cross compiled with CodeSourcery 4.4.1. =A0Upon boot I can
>>> see /proc/xenomai/*. =A0Attempting to run trivial-periodic results in
>>> the following output:
>>>
>>> Xenomai or CONFIG_XENO_OPT_PERVASIVE disabled.
>>> (modprobe xeno_nucleus?)
>>>
>>> Note that CONFIG_XENO_OPT_PERVASIVE is in fact enabled, and nucleus is
>>> built into the kernel. =A0Running in GDB, trivial-periodic receives
>>> SIGILL (illegal instruction) and exits. =A0I get the following
>>> backtrace:
>>>
>>> #0 =A00x40022498 in xeno_bind_skin_opt () from /usr/xenomai/lib/libxeno=
mai.so.0
>>> #1 =A00x00000000 in ?? ()
>>>
>>> And the disassembly around the PC is:
>>>
>>> =A0 =A00x4002247c <+124>: =A0 movw =A0 =A0r0, #555 =A0 =A0 =A0 =A0; 0x2=
2b
>>> =A0 =A00x40022480 <+128>: =A0 mov =A0 =A0 r6, r5
>>> =A0 =A00x40022484 <+132>: =A0 mov =A0 =A0 r1, r8
>>> =A0 =A00x40022488 <+136>: =A0 mov =A0 =A0 r2, #1610612743 ; 0x60000007
>>> =A0 =A00x4002248c <+140>: =A0 mov =A0 =A0 r3, #3
>>> =A0 =A00x40022490 <+144>: =A0 mov =A0 =A0 r4, r7
>>> =A0 =A00x40022494 <+148>: =A0 svc =A0 =A0 0x009f0042
>>> =3D> 0x40022498 <+152>: =A0 ldr =A0 =A0 r12, [sp, #2140] =A0 =A0 =A0 =
=A0; 0x85c
>>> =A0 =A00x4002249c <+156>: =A0 cmp =A0 =A0 r12, #0
>>> =A0 =A00x400224a0 <+160>: =A0 beq =A0 =A0 0x4002246c <xeno_bind_skin_op=
t+108>
>>> =A0 =A00x400224a4 <+164>: =A0 mov =A0 =A0 r2, r0
>>> =A0 =A00x400224a8 <+168>: =A0 mvn =A0 =A0 r1, #84 ; 0x54
>>> =A0 =A00x400224ac <+172>: =A0 mov =A0 =A0 r0, r11
>>> =A0 =A00x400224b0 <+176>: =A0 bl =A0 =A0 =A00x400220d8
>>> =A0 =A00x400224b4 <+180>: =A0 cmn =A0 =A0 r0, #85 ; 0x55
>>>
>>> The other example programs result in a SIGILL in exactly the same place=
.
>>>
>>> Does anyone have any ideas or suggestions?
>>
>> I would say you have incompatible ABI settings for kernel-space and
>> user-space.
>
> Here we definitely see an OABI syscall. So, your kernel is probably
> configured for EABI.
>
> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.
>

