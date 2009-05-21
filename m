From: "Landau, Bracha" <BLandau@domain.hid>
Date: Thu, 21 May 2009 10:55:07 +0300
Message-ID: <065A7D06F7D4E546A18E80E08D066E181189D54B57@domain.hid>
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_065A7D06F7D4E546A18E80E08D066E181189D54B57ILMA1ILNDSCOM_"
MIME-Version: 1.0
Subject: [Xenomai-help] xenomai interferes with ethernet, crashes
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

--_000_065A7D06F7D4E546A18E80E08D066E181189D54B57ILMA1ILNDSCOM_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I am using a Xenomai-patched kernel on an MPC8272-based board.

When I run the plain kernel without activatine either Xenomai or CONFIG_IPI=
PE, the network interface works fine; I am able to ping other nodes on the =
network.

When I activate Xenomai, I don't get a reponse to ping (though I do see tra=
nsmission of packets on the network), and evenetually the kernel crashes wi=
th the following
(This phenomenon happens even when Xenomai is not active, but CONFIG_IPIPE =
is active)

ping 11.11.11.236
PING 11.11.11.236 (11.11.11.236): 56 data bytes

NETDEV WATCHDOG: eth0 (): transmit timed out
------------[ cut here ]------------
Badness at net/sched/sch_generic.c:226
NIP: c01c59c4 LR: c01c59c4 CTR: c01690fc
REGS: c0305c70 TRAP: 0700   Not tainted  (2.6.29)
MSR: 00029032 <EE,ME,CE,IR,DR>  CR: 24022022  XER: 00000000
TASK =3D c02e0588[0] 'swapper' THREAD: c0304000
GPR00: c01c59c4 c0305d20 c02e0588 00000030 00008b99 ffffffff 0000002d c0326=
164
GPR08: 00000001 c02ebd28 ffffffff 00000000 fdfb6060 f7efffee 0fffc000 00000=
000
GPR16: 0fff1864 0fff61bc 00000000 c02e0000 c0318548 c0318748 c0318948 c0318=
b48
GPR24: c0304000 00200200 c0305d88 c02ebda0 c02f0000 00000100 c01c587c cf441=
800
NIP [c01c59c4] dev_watchdog+0x148/0x224
LR [c01c59c4] dev_watchdog+0x148/0x224
Call Trace:
[c0305d20] [c01c59c4] dev_watchdog+0x148/0x224 (unreliable)
[c0305d80] [c00283fc] run_timer_softirq+0x15c/0x1d4
[c0305dd0] [c0023b88] __do_softirq+0x7c/0x10c
[c0305e10] [c000614c] do_softirq+0x60/0x80
[c0305e20] [c00239b4] irq_exit+0x38/0x7c
[c0305e30] [c004789c] __ipipe_sync_stage+0x168/0x254
[c0305e70] [c000a4fc] __ipipe_handle_irq+0x148/0x15c
[c0305ea0] [c000a6cc] __ipipe_grab_timer+0x88/0xc0
[c0305eb0] [c00114f0] __ipipe_ret_from_except+0x0/0xc
--- Exception: 901 at ipipe_suspend_domain+0xdc/0xec
    LR =3D cpu_idle+0x60/0xec
[c0305f70] [0fa07000] 0xfa07000 (unreliable)
[c0305f90] [c0008dbc] cpu_idle+0x60/0xec
[c0305fb0] [c022d130] __got2_end+0x5c/0x6c
[c0305fc0] [c02b8804] start_kernel+0x294/0x2a8
[c0305ff0] [00003438] 0x3438
Instruction dump:
80097254 2f800000 40be0038 38810008 7fe3fb78 38a00040 4bfee295 7fe4fb78
7c651b78 3c60c02b 38639a54 4be59b09 <0fe00000> 38000001 3d20c032 90097254
------------[ cut here ]------------
kernel BUG at drivers/net/phy/mdio_bus.c:262!
Oops: Exception in kernel mode, sig: 5 [#1]
Freescale MPC8272 ADS
NIP: c0176208 LR: c0176754 CTR: c0176718
REGS: c0305bf0 TRAP: 0700   Tainted: G        W   (2.6.29)
MSR: 00029032 <EE,ME,CE,IR,DR>  CR: 24022024  XER: 20000000
TASK =3D c02e0588[0] 'swapper' THREAD: c0304000
GPR00: 00000100 c0305ca0 c02e0588 cf74ca00 00000000 00000012 00000000 c0326=
164
GPR08: 00000001 c0304000 00000001 00000000 fdfb6060 f7efffee 0fffc000 00000=
000
GPR16: 0fff1864 0fff61bc 00000000 c02e0000 c0318548 c0318748 c0318948 c0318=
b48
GPR24: c0304000 00000000 00000012 00000000 c02f0000 cf74ca00 cf74cd90 cf74c=
c00
NIP [c0176208] mdiobus_write+0x2c/0x7c
LR [c0176754] lxt971_config_intr+0x3c/0x4c
Call Trace:
[c0305ca0] [f7efffee] 0xf7efffee (unreliable)
[c0305cd0] [c0176754] lxt971_config_intr+0x3c/0x4c
[c0305ce0] [c01743f4] phy_config_interrupt+0x2c/0x44
[c0305cf0] [c017463c] phy_stop+0x44/0x70
[c0305d00] [c017fbe4] fs_timeout+0x64/0x124
[c0305d20] [c01c59e8] dev_watchdog+0x16c/0x224
[c0305d80] [c00283fc] run_timer_softirq+0x15c/0x1d4
[c0305dd0] [c0023b88] __do_softirq+0x7c/0x10c
[c0305e10] [c000614c] do_softirq+0x60/0x80
[c0305e20] [c00239b4] irq_exit+0x38/0x7c
[c0305e30] [c004789c] __ipipe_sync_stage+0x168/0x254
[c0305e70] [c000a4fc] __ipipe_handle_irq+0x148/0x15c
[c0305ea0] [c000a6cc] __ipipe_grab_timer+0x88/0xc0
[c0305eb0] [c00114f0] __ipipe_ret_from_except+0x0/0xc
--- Exception: 901 at ipipe_suspend_domain+0xdc/0xec
    LR =3D cpu_idle+0x60/0xec
[c0305f70] [0fa07000] 0xfa07000 (unreliable)
[c0305f90] [c0008dbc] cpu_idle+0x60/0xec
[c0305fb0] [c022d130] __got2_end+0x5c/0x6c
[c0305fc0] [c02b8804] start_kernel+0x294/0x2a8
[c0305ff0] [00003438] 0x3438
Instruction dump:
4e800020 9421ffd0 7c0802a6 bf210014 54290024 7c7d1b78 90010034 7c9b2378
7cba2b78 7cd93378 8009000c 5400012e <0f000000> 3b830028 7f83e378 480b59b9
Kernel panic - not syncing: Fatal exception in interrupt
Rebooting in 180 seconds..

****************************
Any ideas?




________________________________
This e-mail is confidential, the property of NDS Ltd and intended for the a=
ddressee only. Any dissemination, copying or distribution of this message o=
r any attachments by anyone other than the intended recipient is strictly p=
rohibited. If you have received this message in error, please immediately n=
otify the postmaster@domain.hid and destroy the original message. Messages sen=
t to and from NDS may be monitored. NDS cannot guarantee any message delive=
ry method is secure or error-free. Information could be intercepted, corrup=
ted, lost, destroyed, arrive late or incomplete, or contain viruses. We do =
not accept responsibility for any errors or omissions in this message and/o=
r attachment that arise as a result of transmission. You should carry out y=
our own virus checks before opening any attachment. Any views or opinions p=
resented are solely those of the author and do not necessarily represent th=
ose of NDS.

To protect the environment please do not print this e-mail unless necessary=
.

NDS Limited Registered Office: One London Road, Staines,Middlesex TW18 4EX,=
 United Kingdom. A company registered in England and Wales Registered no. 3=
080780 VAT no. GB 603 8808 40-00

--_000_065A7D06F7D4E546A18E80E08D066E181189D54B57ILMA1ILNDSCOM_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta content=3D"MSHTML 6.00.2900.3527" name=3D"GENERATOR">
</head>
<body>
<div><font face=3D"Arial" size=3D"2"><span class=3D"531004807-21052009">I a=
m using a&nbsp;Xenomai-patched kernel on an MPC8272-based board.</span></fo=
nt></div>
<div><font face=3D"Arial" size=3D"2"><span class=3D"531004807-21052009"></s=
pan></font>&nbsp;</div>
<div><font face=3D"Arial" size=3D"2"><span class=3D"531004807-21052009">Whe=
n I run the plain kernel without activatine either Xenomai or CONFIG_IPIPE,=
 the network interface works fine; I am able to ping other nodes on the net=
work.
</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span class=3D"531004807-21052009"></s=
pan></font>&nbsp;</div>
<div><font face=3D"Arial" size=3D"2"><span class=3D"531004807-21052009">Whe=
n I activate Xenomai, I don't get a reponse to&nbsp;ping (though I do see t=
ransmission of packets on the network), and evenetually the kernel crashes =
with the following</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span class=3D"531004807-21052009">(Th=
is phenomenon&nbsp;happens even when Xenomai is not active, but CONFIG_IPIP=
E is active)</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span class=3D"531004807-21052009"></s=
pan></font>&nbsp;</div>
<div><font face=3D"Arial" size=3D"2"><span class=3D"531004807-21052009">pin=
g 11.11.11.236<br>
PING 11.11.11.236 (11.11.11.236): 56 data bytes</span></font></div>
<div>&nbsp;</div>
<div><font face=3D"Arial" size=3D"2"><span class=3D"531004807-21052009">NET=
DEV WATCHDOG: eth0 (): transmit timed out<br>
------------[ cut here ]------------<br>
Badness at net/sched/sch_generic.c:226<br>
NIP: c01c59c4 LR: c01c59c4 CTR: c01690fc<br>
REGS: c0305c70 TRAP: 0700&nbsp;&nbsp; Not tainted&nbsp; (2.6.29)<br>
MSR: 00029032 &lt;EE,ME,CE,IR,DR&gt;&nbsp; CR: 24022022&nbsp; XER: 00000000=
<br>
TASK =3D c02e0588[0] 'swapper' THREAD: c0304000<br>
GPR00: c01c59c4 c0305d20 c02e0588 00000030 00008b99 ffffffff 0000002d c0326=
164<br>
GPR08: 00000001 c02ebd28 ffffffff 00000000 fdfb6060 f7efffee 0fffc000 00000=
000<br>
GPR16: 0fff1864 0fff61bc 00000000 c02e0000 c0318548 c0318748 c0318948 c0318=
b48<br>
GPR24: c0304000 00200200 c0305d88 c02ebda0 c02f0000 00000100 c01c587c cf441=
800<br>
NIP [c01c59c4] dev_watchdog&#43;0x148/0x224<br>
LR [c01c59c4] dev_watchdog&#43;0x148/0x224<br>
Call Trace:<br>
[c0305d20] [c01c59c4] dev_watchdog&#43;0x148/0x224 (unreliable)<br>
[c0305d80] [c00283fc] run_timer_softirq&#43;0x15c/0x1d4<br>
[c0305dd0] [c0023b88] __do_softirq&#43;0x7c/0x10c<br>
[c0305e10] [c000614c] do_softirq&#43;0x60/0x80<br>
[c0305e20] [c00239b4] irq_exit&#43;0x38/0x7c<br>
[c0305e30] [c004789c] __ipipe_sync_stage&#43;0x168/0x254<br>
[c0305e70] [c000a4fc] __ipipe_handle_irq&#43;0x148/0x15c<br>
[c0305ea0] [c000a6cc] __ipipe_grab_timer&#43;0x88/0xc0<br>
[c0305eb0] [c00114f0] __ipipe_ret_from_except&#43;0x0/0xc<br>
--- Exception: 901 at ipipe_suspend_domain&#43;0xdc/0xec<br>
&nbsp;&nbsp;&nbsp; LR =3D cpu_idle&#43;0x60/0xec<br>
[c0305f70] [0fa07000] 0xfa07000 (unreliable)<br>
[c0305f90] [c0008dbc] cpu_idle&#43;0x60/0xec<br>
[c0305fb0] [c022d130] __got2_end&#43;0x5c/0x6c<br>
[c0305fc0] [c02b8804] start_kernel&#43;0x294/0x2a8<br>
[c0305ff0] [00003438] 0x3438<br>
Instruction dump:<br>
80097254 2f800000 40be0038 38810008 7fe3fb78 38a00040 4bfee295 7fe4fb78<br>
7c651b78 3c60c02b 38639a54 4be59b09 &lt;0fe00000&gt; 38000001 3d20c032 9009=
7254<br>
------------[ cut here ]------------<br>
kernel BUG at drivers/net/phy/mdio_bus.c:262!<br>
Oops: Exception in kernel mode, sig: 5 [#1]<br>
Freescale MPC8272 ADS<br>
NIP: c0176208 LR: c0176754 CTR: c0176718<br>
REGS: c0305bf0 TRAP: 0700&nbsp;&nbsp; Tainted: G&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; W&nbsp;&nbsp; (2.6.29)<br>
MSR: 00029032 &lt;EE,ME,CE,IR,DR&gt;&nbsp; CR: 24022024&nbsp; XER: 20000000=
<br>
TASK =3D c02e0588[0] 'swapper' THREAD: c0304000<br>
GPR00: 00000100 c0305ca0 c02e0588 cf74ca00 00000000 00000012 00000000 c0326=
164<br>
GPR08: 00000001 c0304000 00000001 00000000 fdfb6060 f7efffee 0fffc000 00000=
000<br>
GPR16: 0fff1864 0fff61bc 00000000 c02e0000 c0318548 c0318748 c0318948 c0318=
b48<br>
GPR24: c0304000 00000000 00000012 00000000 c02f0000 cf74ca00 cf74cd90 cf74c=
c00<br>
NIP [c0176208] mdiobus_write&#43;0x2c/0x7c<br>
LR [c0176754] lxt971_config_intr&#43;0x3c/0x4c<br>
Call Trace:<br>
[c0305ca0] [f7efffee] 0xf7efffee (unreliable)<br>
[c0305cd0] [c0176754] lxt971_config_intr&#43;0x3c/0x4c<br>
[c0305ce0] [c01743f4] phy_config_interrupt&#43;0x2c/0x44<br>
[c0305cf0] [c017463c] phy_stop&#43;0x44/0x70<br>
[c0305d00] [c017fbe4] fs_timeout&#43;0x64/0x124<br>
[c0305d20] [c01c59e8] dev_watchdog&#43;0x16c/0x224<br>
[c0305d80] [c00283fc] run_timer_softirq&#43;0x15c/0x1d4<br>
[c0305dd0] [c0023b88] __do_softirq&#43;0x7c/0x10c<br>
[c0305e10] [c000614c] do_softirq&#43;0x60/0x80<br>
[c0305e20] [c00239b4] irq_exit&#43;0x38/0x7c<br>
[c0305e30] [c004789c] __ipipe_sync_stage&#43;0x168/0x254<br>
[c0305e70] [c000a4fc] __ipipe_handle_irq&#43;0x148/0x15c<br>
[c0305ea0] [c000a6cc] __ipipe_grab_timer&#43;0x88/0xc0<br>
[c0305eb0] [c00114f0] __ipipe_ret_from_except&#43;0x0/0xc<br>
--- Exception: 901 at ipipe_suspend_domain&#43;0xdc/0xec<br>
&nbsp;&nbsp;&nbsp; LR =3D cpu_idle&#43;0x60/0xec<br>
[c0305f70] [0fa07000] 0xfa07000 (unreliable)<br>
[c0305f90] [c0008dbc] cpu_idle&#43;0x60/0xec<br>
[c0305fb0] [c022d130] __got2_end&#43;0x5c/0x6c<br>
[c0305fc0] [c02b8804] start_kernel&#43;0x294/0x2a8<br>
[c0305ff0] [00003438] 0x3438<br>
Instruction dump:<br>
4e800020 9421ffd0 7c0802a6 bf210014 54290024 7c7d1b78 90010034 7c9b2378<br>
7cba2b78 7cd93378 8009000c 5400012e &lt;0f000000&gt; 3b830028 7f83e378 480b=
59b9<br>
Kernel panic - not syncing: Fatal exception in interrupt<br>
Rebooting in 180 seconds..<br>
</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span class=3D"531004807-21052009"></s=
pan></font>&nbsp;</div>
<div><font face=3D"Arial" size=3D"2"><span class=3D"531004807-21052009">***=
*************************</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span class=3D"531004807-21052009">Any=
 ideas?</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span class=3D"531004807-21052009"></s=
pan></font>&nbsp;</div>
<div><font face=3D"Arial" size=3D"2"><span class=3D"531004807-21052009"></s=
pan></font>&nbsp;</div>
<div><font face=3D"Arial" size=3D"2"><span class=3D"531004807-21052009"></s=
pan></font>&nbsp;</div>
<br>
<hr>
<font face=3D"Arial" color=3D"Gray" size=3D"1">This e-mail is confidential,=
 the property of NDS Ltd and intended for the addressee only. Any dissemina=
tion, copying or distribution of this message or any attachments by anyone =
other than the intended recipient is strictly
 prohibited. If you have received this message in error, please immediately=
 notify the postmaster@domain.hid and destroy the original message. Messages s=
ent to and from NDS may be monitored. NDS cannot guarantee any message deli=
very method is secure or error-free.
 Information could be intercepted, corrupted, lost, destroyed, arrive late =
or incomplete, or contain viruses. We do not accept responsibility for any =
errors or omissions in this message and/or attachment that arise as a resul=
t of transmission. You should carry
 out your own virus checks before opening any attachment. Any views or opin=
ions presented are solely those of the author and do not necessarily repres=
ent those of NDS.<br>
<br>
To protect the environment please do not print this e-mail unless necessary=
.<br>
<br>
NDS Limited Registered Office: One London Road, Staines,Middlesex TW18 4EX,=
 United Kingdom. A company registered in England and Wales Registered no. 3=
080780 VAT no. GB 603 8808 40-00<br>
</font>
</body>
</html>

--_000_065A7D06F7D4E546A18E80E08D066E181189D54B57ILMA1ILNDSCOM_--

