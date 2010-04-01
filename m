Message-ID: <4BB47A54.1040806@domain.hid>
Date: Thu, 01 Apr 2010 12:49:56 +0200
From: Patrice Kadionik <kadionik@domain.hid>
MIME-Version: 1.0
References: <763864.6829.qm@domain.hid>
In-Reply-To: <763864.6829.qm@domain.hid>
Content-Type: multipart/alternative;
	boundary="------------080402010503080204040103"
Subject: Re: [Xenomai-help] Problem to cross-compile Xenomai user-space
	support
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Chtourou Sonda <chtourou_sonda@domain.hid>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------080402010503080204040103
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by plan.enseirb.fr id o31AlU1W005065

Le 31/03/2010 12:55, Chtourou Sonda a =C3=A9crit :

Hi Chtourou,

> Hi Patrice,
>> OK. Please, verify first that you can boot =C2=B5Clinux without Xenoma=
i on=20
>> your board with the 2 extra hrtimer and hrclock peripherals.
>> There is no priority on IRQ with NIOS.
>>
> So, If I have understood, I could put:
> IRO =3D 7 for hrtimer
> IRQ =3D 8 for hrclock
> IRQ =3D 1 for sys_clk_timer
> with  this configuration =C2=B5Clinux without Xenomai with the 2 extra=20
> hrtimer and hrclock peripherals can boot  on the board .
> But I'm wondering why with the first configuration (IRO =3D 1 for=20
> hrtimer,IRQ =3D 2 for hrclock and IRQ =3D 3 for sys_clk_timer), it didn=
't=20
> boot?
>
**Huan Fang=20
(https://mail.gna.org/public/xenomai-help/2010-04/msg00013.html) has=20
detected the problem.
I have done some investigations.

For recall,
- From the HW point of view, when you build your SoPC system with SOPC=20
Builder tool in Quartus II, you add different peripherals (Altera=20
peripheral and your own peripherals). After that you lanch a generate=20
command. At this, it creates a .ptf (and now a .sopc) file. This file is=20
an ASCII file (in a synthax like XML), a declarative file that gives all=20
informations for HDL synthesis. After that, you compile (a synthesis)=20
your SoPC system that gives the .sof file for programming your Altera FPG=
A.
- From the SW point of view, when you do a "$ make vendor_hwselect=20
SYSPTF=3Dyour_ptf_file.ptf", you generate (through Perl scripts) a nios2.=
h=20
file under  .../uClinux-dist/linux-2.6.x/include/asm-nios2 directory=20
that translates the .ptf file into .h file with #define declarations.

The sys_clk_timer must be the Linux timer even with the 2 Xenomai extra=20
timers. sys_cllk_timer is renamed in the nios2.h as timer0:
/* Redefining sys_clk_timer -> timer0 */
#undef na_sys_clk_timer
#undef na_sys_clk_timer_irq

#define na_timer0                                  ((void *) 0xXXXXXXXX)
#define na_timer0_irq                                                  Y

The Perl script (altera_avalon_timer.pm) used by the "make=20
vendor_hwselect" command parses the .ptf file and takes the first=20
encountered timer as Linux timer! So, if it is not the sys_clk_timer=20
(hrtimer or hrclock or your own timer...), it will be bad and you can't=20
boot.

How can you have sys_clk_timer as the first timer in your .ptf file?
If you change the order in the graphical view under SOPC builder, it=20
doesn't care.
The order of the peripherals in the generated .ptf file is their=20
creation order.
So, you MUST first create in SOPC Builder sys_clk_timer and then the 2=20
other timers for Xenomai hrtimer and hrclock.
If you are note sure, delete all timers in the SoPC, save the SoPC and=20
create finally in the right order the 3 timers.

If all is OK, you must have in the nios2.h something like:
/* Redefining sys_clk_timer -> timer0 */
#undef na_sys_clk_timer
#undef na_sys_clk_timer_irq

#define na_timer0                                  ((void *) 0xXXXXXXXX)
#define na_timer0_irq                                                  Y

Another verification is when you generate your SoPC system. The traces=20
during SoPC generation with SOPC Builder gives the order in the .ptf=20
file. For example, a good example:
# 2010.03.31 22:06:55 (*) Running Generator Program for ext_flash
# 2010.03.31 22:06:57 (*) Running Generator Program for ext_ram
# 2010.03.31 22:06:58 (*) Running Generator Program for onchip_ram_64_kby=
tes
# 2010.03.31 22:06:59 (*) Running Generator Program for sys_clk_timer
. . .
# 2010.03.31 22:07:05 (*) Running Generator Program for hrclock
. . .
# 2010.03.31 22:07:18 (*) Running Generator Program for uart_0
# 2010.03.31 22:07:21 (*) Running Generator Program for hrtimer
# 2010.03.31 22:07:22 (*) Running Generator Program for std_1s10_clock_0

So verify this point, it should be your problem.
>> Please verify that you have correctly enabled all the right options=20
>> under SOPC builder for hrtimer and hrclock.
>> Because we have flexibility in HW configuration with SoPC, we must be=20
>> more careful.
>>
> Configuration of hrtimer with the SoPC Builder:
> =E2=80=A2 Timer: 32 bits.
> =E2=80=A2 Timeout period: 1 =C2=B5s.
> =E2=80=A2 Preset : custom. Writable period, readable snapshot, Start/St=
op=20
> control bits.
>
> Configuration of hrclock with the SoPC Builder:
> in the snapshot mode. Its configuration with the SoPC Builder tool is:
> =E2=80=A2 64-bit timer.
> =E2=80=A2 Timeout period: 5 clocks. clock=3D20 ns (100 ns). The timer=20
> functionality is not used by Xenomai.
>
> =E2=80=A2 Preset: custom. Writable period, readable snapshot, Start/Sto=
p=20
> control bits.
>
> Is it correct?
>> According to errno.h, code -19  is ENODEV, please verify your timer=20
>> configuration and respect naming convention
>>
> Here, you speek about "sys_clock_timer"?
>
It is sys_clk_timer, sorry. I'll correct the typo error.

Patrice
> Configuration of sys_clock_timer with the SoPC Builder:
> =E2=80=A2 32-bit timer.
> =E2=80=A2 Timeout period: 10 ms.
> =E2=80=A2 Preset: custom. Writable period, readable snapshot, Start/Sto=
p=20
> control bits.
>
> Regards,
>
>


--=20
Patrice Kadionik. F6KQH / F4CUQ
-----------

+----------------------------------------------------------------------+
+"Tout doit etre aussi simple que possible, pas seulement plus simple" +
+----------------------------------------------------------------------+
+ Patrice Kadionik             http://www.enseirb.fr/~kadionik         +
+ IMS Laboratory               http://www.ims-bordeaux.fr/             +
+ ENSEIRB                      http://www.enseirb.fr                   +
+ PO BOX 99                    fax   : +33 5.56.37.20.23               +
+ 33402 TALENCE Cedex          voice : +33 5.56.84.23.47               +
+ FRANCE                       mailto:patrice.kadionik@domain.hid +
+----------------------------------------------------------------------+


--------------080402010503080204040103
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by plan.enseirb.fr id o31AlU1W005065

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content=3D"text/html; charset=3DUTF-8" http-equiv=3D"Content-Type=
">
</head>
<body bgcolor=3D"#ffffff" text=3D"#000000">
Le 31/03/2010 12:55, Chtourou Sonda a =C3=A9crit=C2=A0:<br>
<br>
Hi Chtourou,<br>
<br>
<blockquote cite=3D"mid:763864.6829.qm@domain.hid"
 type=3D"cite">
  <table border=3D"0" cellpadding=3D"0" cellspacing=3D"0">
    <tbody>
      <tr>
        <td
 style=3D"font-family: inherit; font-style: inherit; font-variant: inheri=
t; font-weight: inherit; font-size: inherit; line-height: inherit; font-s=
ize-adjust: inherit; font-stretch: inherit; -x-system-font: none;"
 valign=3D"top">
        <div id=3D"yiv294836398">Hi Patrice,<br>
        <blockquote type=3D"cite">
          <table style=3D"width: 527px; height: 49px;" border=3D"0"
 cellpadding=3D"0" cellspacing=3D"0">
            <tbody>
              <tr>
                <td
 style=3D"font-family: inherit; font-style: inherit; font-variant: inheri=
t; font-weight: inherit; font-size: inherit; line-height: inherit; font-s=
ize-adjust: inherit; font-stretch: inherit;"
 valign=3D"top"><font size=3D"2">OK. Please, verify first that you can bo=
ot
=C2=B5Clinux without Xenomai on your board with the 2 extra hrtimer and
hrclock peripherals.<br>
There is no priority on IRQ with NIOS.</font><br>
                </td>
              </tr>
            </tbody>
          </table>
        </blockquote>
So, If I have understood, I could put:<br>
IRO =3D 7 for hrtimer <br>
IRQ =3D 8 for hrclock<br>
IRQ =3D 1 for sys_clk_timer <br>
with=C2=A0 this configuration =C2=B5Clinux without Xenomai with the 2 ext=
ra
hrtimer and hrclock peripherals can boot=C2=A0 on the board .<br>
But I'm wondering why with the first configuration (IRO =3D 1 for
hrtimer,IRQ =3D 2 for hrclock and IRQ =3D 3 for sys_clk_timer), it didn't
boot? <span style=3D"font-family: monospace;"></span><br>
        </div>
        </td>
      </tr>
    </tbody>
  </table>
</blockquote>
<strong></strong>Huan Fang
(<a class=3D"moz-txt-link-freetext" href=3D"https://mail.gna.org/public/x=
enomai-help/2010-04/msg00013.html">https://mail.gna.org/public/xenomai-he=
lp/2010-04/msg00013.html</a>) has
detected the problem.<br>
I have done some investigations.<br>
<br>
For recall,<br>
- From the HW point of view, when you build your SoPC system with SOPC
Builder tool in Quartus II, you add different peripherals (Altera
peripheral and your own peripherals). After that you lanch a generate
command. At this, it creates a .ptf (and now a .sopc) file. This file
is an ASCII file (in a synthax like XML), a declarative file that gives
all informations for HDL synthesis. After that, you compile (a
synthesis) your SoPC system that gives the .sof file for programming
your Altera FPGA.<br>
- From the SW point of view, when you do a "$ make vendor_hwselect
SYSPTF=3Dyour_ptf_file.ptf", you generate (through Perl scripts) a
nios2.h file under=C2=A0 .../uClinux-dist/linux-2.6.x/include/asm-nios2
directory that translates the .ptf file into .h file with #define
declarations.<br>
<br>
The sys_clk_timer must be the Linux timer even with the 2 Xenomai extra
timers. sys_cllk_timer is renamed in the nios2.h as timer0:<br>
<tt>/* Redefining sys_clk_timer -&gt; timer0 */<br>
#undef na_sys_clk_timer<br>
#undef na_sys_clk_timer_irq<br>
<br>
#define na_timer0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((void=
 *) 0xXXXXXXXX)<br>
#define na_timer0_irq=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 Y</tt><br>
<br>
The Perl script (altera_avalon_timer.pm) used by the "make
vendor_hwselect" command parses the .ptf file and takes the first
encountered timer as Linux timer! So, if it is not the sys_clk_timer
(hrtimer or hrclock or your own timer...), it will be bad and you can't
boot.<br>
<br>
How can you have sys_clk_timer as the first timer in your .ptf file?<br>
If you change the order in the graphical view under SOPC builder, it
doesn't care.<br>
The order of the peripherals in the generated .ptf file is their
creation order.<br>
So, you MUST first create in SOPC Builder sys_clk_timer and then the 2
other timers for Xenomai hrtimer and hrclock.<br>
If you are note sure, delete all timers in the SoPC, save the SoPC and
create finally in the right order the 3 timers.<br>
<br>
If all is OK, you must have in the nios2.h something like:<br>
<tt>/* Redefining sys_clk_timer -&gt; timer0 */<br>
#undef na_sys_clk_timer<br>
#undef na_sys_clk_timer_irq<br>
<br>
#define na_timer0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((void=
 *) 0xXXXXXXXX)<br>
#define na_timer0_irq=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 Y<br>
</tt><br>
Another verification is when you generate your SoPC system. The traces
during SoPC generation with SOPC Builder gives the order in the .ptf
file. For example, a good example:<br>
# 2010.03.31 22:06:55 (*) Running Generator Program for ext_flash<br>
# 2010.03.31 22:06:57 (*) Running Generator Program for ext_ram<br>
# 2010.03.31 22:06:58 (*) Running Generator Program for
onchip_ram_64_kbytes<br>
# 2010.03.31 22:06:59 (*) Running Generator Program for sys_clk_timer<br>
. . .<br>
# 2010.03.31 22:07:05 (*) Running Generator Program for hrclock<br>
. . .<br>
# 2010.03.31 22:07:18 (*) Running Generator Program for uart_0<br>
# 2010.03.31 22:07:21 (*) Running Generator Program for hrtimer<br>
# 2010.03.31 22:07:22 (*) Running Generator Program for std_1s10_clock_0<=
br>
<br>
So verify this point, it should be your problem.<br>
<blockquote cite=3D"mid:763864.6829.qm@domain.hid"
 type=3D"cite">
  <table border=3D"0" cellpadding=3D"0" cellspacing=3D"0">
    <tbody>
      <tr>
        <td
 style=3D"font-family: inherit; font-style: inherit; font-variant: inheri=
t; font-weight: inherit; font-size: inherit; line-height: inherit; font-s=
ize-adjust: inherit; font-stretch: inherit; -x-system-font: none;"
 valign=3D"top">
        <div id=3D"yiv294836398">
        <blockquote type=3D"cite">
          <table style=3D"width: 527px; height: 57px;" border=3D"0"
 cellpadding=3D"0" cellspacing=3D"0">
            <tbody>
              <tr>
                <td
 style=3D"font-family: inherit; font-style: inherit; font-variant: inheri=
t; font-weight: inherit; font-size: inherit; line-height: inherit; font-s=
ize-adjust: inherit; font-stretch: inherit;"
 valign=3D"top"><font size=3D"2">Please verify that you have correctly
enabled all the right options under SOPC builder for hrtimer and
hrclock.<br>
Because we have flexibility in HW configuration with SoPC, we must be
more careful.</font><br>
                </td>
              </tr>
            </tbody>
          </table>
        </blockquote>
Configuration of hrtimer with the SoPC Builder:<br>
=E2=80=A2 Timer: 32 bits.<br>
=E2=80=A2 Timeout period: 1 =C2=B5s.<br>
=E2=80=A2 Preset : custom. Writable period, readable snapshot, Start/Stop
control bits.<br>
        <br>
Configuration of hrclock with the SoPC Builder:<br>
in the snapshot mode. Its configuration with the SoPC Builder tool is:<br=
>
=E2=80=A2 64-bit timer.<br>
=E2=80=A2 Timeout period: 5 clocks. clock=3D20 ns (100 ns). The timer
functionality is not used by Xenomai.<br>
        </div>
        </td>
      </tr>
    </tbody>
  </table>
</blockquote>
<blockquote cite=3D"mid:763864.6829.qm@domain.hid"
 type=3D"cite">
  <table border=3D"0" cellpadding=3D"0" cellspacing=3D"0">
    <tbody>
      <tr>
        <td
 style=3D"font-family: inherit; font-style: inherit; font-variant: inheri=
t; font-weight: inherit; font-size: inherit; line-height: inherit; font-s=
ize-adjust: inherit; font-stretch: inherit; -x-system-font: none;"
 valign=3D"top">
        <div id=3D"yiv294836398">=E2=80=A2 Preset: custom. Writable perio=
d,
readable snapshot, Start/Stop control bits.<br>
        <br>
Is it correct?<br>
        <blockquote type=3D"cite">
          <table style=3D"width: 527px; height: 36px;" border=3D"0"
 cellpadding=3D"0" cellspacing=3D"0">
            <tbody>
              <tr>
                <td
 style=3D"font-family: inherit; font-style: inherit; font-variant: inheri=
t; font-weight: inherit; font-size: inherit; line-height: inherit; font-s=
ize-adjust: inherit; font-stretch: inherit;"
 valign=3D"top"><font size=3D"2">According to errno.h, code -19=C2=A0 is =
ENODEV,
please verify your timer configuration and respect naming convention</fon=
t><br>
                </td>
              </tr>
            </tbody>
          </table>
        </blockquote>
Here, you speek about "sys_clock_timer"?<br>
        </div>
        </td>
      </tr>
    </tbody>
  </table>
</blockquote>
It is sys_clk_timer, sorry. I'll correct the typo error.<br>
<br>
Patrice<br>
<blockquote cite=3D"mid:763864.6829.qm@domain.hid"
 type=3D"cite">
  <table border=3D"0" cellpadding=3D"0" cellspacing=3D"0">
    <tbody>
      <tr>
        <td
 style=3D"font-family: inherit; font-style: inherit; font-variant: inheri=
t; font-weight: inherit; font-size: inherit; line-height: inherit; font-s=
ize-adjust: inherit; font-stretch: inherit; -x-system-font: none;"
 valign=3D"top">
        <div id=3D"yiv294836398">Configuration of sys_clock_timer with
the SoPC Builder: <br>
=E2=80=A2 32-bit timer.<br>
=E2=80=A2 Timeout period: 10 ms.<br>
=E2=80=A2 Preset: custom. Writable period, readable snapshot, Start/Stop
control bits.<br>
        <br>
Regards,<br>
        <br>
        </div>
        </td>
      </tr>
    </tbody>
  </table>
  <br>
</blockquote>
<br>
<br>
<pre class=3D"moz-signature" cols=3D"72">--=20
Patrice Kadionik. F6KQH / F4CUQ
-----------

+----------------------------------------------------------------------+
+"Tout doit etre aussi simple que possible, pas seulement plus simple" +
+----------------------------------------------------------------------+
+ Patrice Kadionik             <a class=3D"moz-txt-link-freetext" href=3D=
"http://www.enseirb.fr/~kadionik">http://www.enseirb.fr/~kadionik</a>    =
     +
+ IMS Laboratory               <a class=3D"moz-txt-link-freetext" href=3D=
"http://www.ims-bordeaux.fr/">http://www.ims-bordeaux.fr/</a>            =
 +
+ ENSEIRB                      <a class=3D"moz-txt-link-freetext" href=3D=
"http://www.enseirb.fr">http://www.enseirb.fr</a>                   +
+ PO BOX 99                    fax   : +33 5.56.37.20.23               +
+ 33402 TALENCE Cedex          voice : +33 5.56.84.23.47               +
+ FRANCE                       <a class=3D"moz-txt-link-freetext" href=3D=
"mailto:patrice.kadionik@domain.hid">mailto:patrice.kadionik@domain.hid=
deaux.fr</a> +
+----------------------------------------------------------------------+<=
/pre>
</body>
</html>

--------------080402010503080204040103--

