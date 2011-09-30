MIME-Version: 1.0
Date: Fri, 30 Sep 2011 14:29:19 -0300
Message-ID: <CAMwkeZzYbE8DKnmDNMbU58Qi0HC4YWNKJRjxs-8n8Q75tY1j8w@domain.hid>
From: =?UTF-8?Q?Fernando_Herrero_Carr=C3=B3n?= <elferdo@domain.hid>
Content-Type: multipart/alternative; boundary=bcaec520f1cf2161bd04ae2bf7de
Subject: [Xenomai-help] Module unloading and reloading does not work
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai-help@domain.hid

--bcaec520f1cf2161bd04ae2bf7de
Content-Type: text/plain; charset=UTF-8

Dear list,

I am testing Xenomai 2.6.0-rc4 on a 2.6.38.8 linux kernel. I have two cards,
one NI 6713 for AO and one NI 6143 for AI. I use the analogy_ni_pcimio for
both, and it loads well. I can run the config program succesfully too.

If I remove the devices using 'analogy_config -r ...', then unload the
modules with:

rmmod analogy_ni_pcimio analogy_ni_mio analogy_ni_tio analogy_8255
analogy_ni_mite xeno_analogy

then load them again and try to reconfigure, I get the following error on
dmesg (I include the boot messages and the execution of a "cmd_read"):

[   55.735198] Analogy: analogy_ni_pcimio: pcimio_attach: found pci-6713
board
[   55.735246] Analogy: analogy_ni_pcimio: pcimio_attach: found irq 21
[   60.143227] Analogy: analogy_ni_pcimio: pcimio_attach: found pci-6143
board
[   60.143274] Analogy: analogy_ni_pcimio: pcimio_attach: found irq 20
[   79.772511] Analogy: a4l_ioctl_cancel: no acquisition to cancel on this
context
[   79.772517] Analogy: analogy_ni_pcimio: ni_ai_cmd: start
[   79.772525] Analogy: analogy_ni_pcimio: ni_ai_cmd:
Interrupt_A_Enable_Register = 0x0021
[   79.772531] Analogy: analogy_ni_pcimio: ni_ai_cmd: exit
[   80.572613] Analogy: analogy_ni_pcimio: ni_mio_common: interrupt:
a_status=90f0 ai_mite_status=00200000
[   80.572616] Analogy: analogy_ni_pcimio: ni_mio_common: SC_TC interrupt
[  236.290044] Analogy: MITE: Available NI device IDs: 0x1870 0x70c0
[  246.113821] Analogy: analogy_ni_pcimio: pcimio_attach: found pci-6143
board
[  246.113872] Analogy: analogy_ni_pcimio: pcimio_attach: found irq 20
[  246.113876] Analogy: analogy_ni_pcimio: pcimio_attach: irq not available
[  246.113879] Analogy: a4l_request_irq: IRQ registration failed
[  251.563782] Analogy: analogy_ni_pcimio: pcimio_attach: found pci-6713
board
[  251.563824] Analogy: analogy_ni_pcimio: pcimio_attach: found irq 21
[  251.563828] Analogy: analogy_ni_pcimio: pcimio_attach: irq not available
[  251.563830] Analogy: a4l_request_irq: IRQ registration failed

BTW, the analogy_config program does not report those errors.

This is bothering because I'm fiddling with the drivers and everytime I
change something I have to reboot. Anyone experiencing the same problem?

Thanks for your help,
Fernando

--bcaec520f1cf2161bd04ae2bf7de
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Dear list,<br><br>I am testing Xenomai 2.6.0-rc4 on a 2.6.38.8 linux kernel=
. I have two cards, one NI 6713 for AO and one NI 6143 for AI. I use the an=
alogy_ni_pcimio for both, and it loads well. I can run the config program s=
uccesfully too.<br>
<br>If I remove the devices using &#39;analogy_config -r ...&#39;, then unl=
oad the modules with:<br><br><div style=3D"margin-left: 40px;">rmmod analog=
y_ni_pcimio analogy_ni_mio analogy_ni_tio analogy_8255 analogy_ni_mite xeno=
_analogy<br>
<br></div>then load them again and try to reconfigure, I get the following =
error on dmesg (I include the boot messages and the execution of a &quot;cm=
d_read&quot;):<br><br><div style=3D"margin-left: 40px;">[=C2=A0=C2=A0 55.73=
5198] Analogy: analogy_ni_pcimio: pcimio_attach: found pci-6713 board<br>
[=C2=A0=C2=A0 55.735246] Analogy: analogy_ni_pcimio: pcimio_attach: found i=
rq 21<br>[=C2=A0=C2=A0 60.143227] Analogy: analogy_ni_pcimio: pcimio_attach=
: found pci-6143 board<br>[=C2=A0=C2=A0 60.143274] Analogy: analogy_ni_pcim=
io: pcimio_attach: found irq 20<br>
[=C2=A0=C2=A0 79.772511] Analogy: a4l_ioctl_cancel: no acquisition to cance=
l on this context<br>[=C2=A0=C2=A0 79.772517] Analogy: analogy_ni_pcimio: n=
i_ai_cmd: start<br>[=C2=A0=C2=A0 79.772525] Analogy: analogy_ni_pcimio: ni_=
ai_cmd: Interrupt_A_Enable_Register =3D 0x0021<br>
[=C2=A0=C2=A0 79.772531] Analogy: analogy_ni_pcimio: ni_ai_cmd: exit<br>[=
=C2=A0=C2=A0 80.572613] Analogy: analogy_ni_pcimio: ni_mio_common: interrup=
t: a_status=3D90f0 ai_mite_status=3D00200000<br>[=C2=A0=C2=A0 80.572616] An=
alogy: analogy_ni_pcimio: ni_mio_common: SC_TC interrupt<br>
[=C2=A0 236.290044] Analogy: MITE: Available NI device IDs: 0x1870 0x70c0<b=
r>[=C2=A0 246.113821] Analogy: analogy_ni_pcimio: pcimio_attach: found pci-=
6143 board<br>[=C2=A0 246.113872] Analogy: analogy_ni_pcimio: pcimio_attach=
: found irq 20<br>
[=C2=A0 246.113876] Analogy: analogy_ni_pcimio: pcimio_attach: irq not avai=
lable<br>[=C2=A0 246.113879] Analogy: a4l_request_irq: IRQ registration fai=
led<br>[=C2=A0 251.563782] Analogy: analogy_ni_pcimio: pcimio_attach: found=
 pci-6713 board<br>
[=C2=A0 251.563824] Analogy: analogy_ni_pcimio: pcimio_attach: found irq 21=
<br>[=C2=A0 251.563828] Analogy: analogy_ni_pcimio: pcimio_attach: irq not =
available<br>[=C2=A0 251.563830] Analogy: a4l_request_irq: IRQ registration=
 failed<br>
</div><br>BTW, the analogy_config program does not report those errors.<br>=
<br>This is bothering because I&#39;m fiddling with the drivers and everyti=
me I change something I have to reboot. Anyone experiencing the same proble=
m?<br>
<br>Thanks for your help,<br>Fernando<br>

--bcaec520f1cf2161bd04ae2bf7de--

