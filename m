In-Reply-To: <18164.5365.820554.634410@domain.hid>
Message-ID: <OFB8A3FC86.9A858D18-ONC1257360.003E332F-C1257361.00240ACF@datacon.at>
From: juergen.lanner@domain.hid
Date: Tue, 25 Sep 2007 08:34:02 +0200
MIME-Version: 1.0
Content-type: multipart/mixed; 
	Boundary="0__=4EBBF9F3DFADB5BF8f9e8a93df938690918c4EBBF9F3DFADB5BF"
Subject: Re: [Xenomai-help] POSIX skin or CONFIG_XENO_OPT_PERVASIVE disabled
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--0__=4EBBF9F3DFADB5BF8f9e8a93df938690918c4EBBF9F3DFADB5BF
Content-type: multipart/related; 
	Boundary="1__=4EBBF9F3DFADB5BF8f9e8a93df938690918c4EBBF9F3DFADB5BF"

--1__=4EBBF9F3DFADB5BF8f9e8a93df938690918c4EBBF9F3DFADB5BF
Content-type: multipart/alternative; 
	Boundary="2__=4EBBF9F3DFADB5BF8f9e8a93df938690918c4EBBF9F3DFADB5BF"

--2__=4EBBF9F3DFADB5BF8f9e8a93df938690918c4EBBF9F3DFADB5BF
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: quoted-printable


Hello Gilles!

Thank you very much for your reponse.

LAPIC is disabled in BIOS, so "make menuconfig" does not even give me t=
he
possibility to change it at all.
in the .config file I could find CONFIG_X86_LOCAL_APIC=3Dy.
I f I set it to =3Dn and start "make menuconfig" again, it resets it to=
 y
even if I do not change anything manually.

However, if I let it like this (=3Dy) and build the kernel and start it=
 with
"lapic=3D1" I get a boot log that seems quite ok.
At least the Xenomai messages are encouraging:
...
[   16.783784] Local APIC disabled by BIOS -- reenabling.
[   16.783789] Found and enabled local APIC!
[   16.783795] mapped APIC to ffffd000 (fee00000)
...
[   18.129248] I-pipe: Domain Xenomai registered.
[   18.129343] Xenomai: hal/x86 started.
[   18.132813] Xenomai: real-time nucleus v2.3.3 (Summer Song) loaded.
[   18.133012] Xenomai: SMI-enabled chipset found but SMI workaround no=
t
enabled (check
[   18.133016]          CONFIG_XENO_HW_SMI_WORKAROUND). You may encount=
er
high
[   18.133019]          interrupt latencies!
[   18.134404] Xenomai: starting native API services.
[   18.134491] Xenomai: starting POSIX services.
[   18.134620] Xenomai: starting RTDM services.
...
(Please find the full log here (See attached file:
boot_with_lapic_equ_1.txt))

Without the "lapic=3D1" there are some errors reported.
...
[   16.797406] Local APIC disabled by BIOS -- you can enable it with
"lapic"
[   16.797416] mapped APIC to ffffd000 (013fa000)
...
[   16.891593] Local APIC not detected. Using dummy APIC emulation.
...
[   18.037577] Xenomai: Local APIC absent or disabled!
[   18.037579]          Disable APIC support or pass "lapic=3D1" as
bootparam.
[   18.037753] Xenomai: system init failed, code -19.
[   18.037838] Xenomai: native skin init failed, code -19.
[   18.037946] Xenomai: starting POSIX services.
[   18.038029] Xenomai: POSIX skin init failed, code -19.
[   18.038114] Xenomai: RTDM skin init failed, code -19.
(Please find the full log here (See attached file:
boot_without_lapic_equ_1.txt))


But even if the bootup seems ok as seen in the first case, the test
applications won't start.

It keeps saying some xenomai part is not available, e.g. the latency
application
root@domain.hid# ./latency
Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE disabled.
(modprobe xeno_native?)

You can see this in complete also from the output of xeno-test (See
attached file: output_xeno_test.txt)

So, do you still think it has something to do with the LAPIC?
I still have the suspicion that I missed something important during set=
up
(building/installing) of xenomai.
Do I have to explicitely "enable" e.g. the native skin?
The CONFIG_XENO_OPT_PERVASIVE is enables (=3Dy) in the kernel's .config=
 file,
I checked this
Also the "modprobe xeno_native" hint distracts me, do I have to load th=
is
kernel module expicitely? Where is it?

Thanks

Juergen



                                                                       =
    
             Gilles                                                    =
    
             Chanteperdrix                                             =
    
             <gilles.chanteper                                         =
 To 
             drix@domain.hid>           juergen.lanner@domain.hid       =
    
                                                                       =
 cc 
             21.09.2007 21:01          xenomai@xenomai.org            =
    
                                                                   Subj=
ect 
                                       Re: [Xenomai-help] POSIX skin or=
    
                                       CONFIG_XENO_OPT_PERVASIVE disabl=
ed  
                                                                       =
    
                                                                       =
    
                                                                       =
    
                                                                       =
    
                                                                       =
    
                                                                       =
    




juergen.lanner@domain.hid wrote:
 >
 >
 > Hi there!
 >
 > Sorry for the newbie question, but I am stuck here ...
 > I get this message every time I try to run e.g. latency test on my
system.
 >
 > What do I wrong?
 >
 > I use
 > Ubuntu 7.04 desktop
 > Kernel 2.6.20.19 from www.kernel.org
 > Xenomai 2.3.3
 > adeos-ipipe-2.6.20-i386-1.8-08.patch
 >
 > I already saw
 > (...)
 > running: cat /proc/interrupts
 >            CPU0
 >   0:    7243712    XT-PIC-XT        timer, rthal_broadcast_timer
 >   1:         30    XT-PIC-XT        i8042
 >   2:          0    XT-PIC-XT        cascade
 >   5:     544285    XT-PIC-XT        uhci_hcd:usb1, eth3,
 > i915@domain.hid
 >   7:      18259    XT-PIC-XT        ehci_hcd:usb3
 >   8:          3    XT-PIC-XT        rtc
 >   9:   17584667    XT-PIC-XT        eth0
 >  12:        196    XT-PIC-XT        i8042
 >  14:      10992    XT-PIC-XT        ide0
 >  15:       7236    XT-PIC-XT        uhci_hcd:usb2, eth1, eth2
 > NMI:       3198
 > LOC:    7243618
 > ERR:          0
 > MIS:          0

The conclusion of vicki problem was that he had the APIC enabled in
kernel configuration whereas his hardware had no APIC. Are you sure you=

are not running into the same issue ? From /proc/interrupts contents, i=
t
looks like you are not using APIC, so, check that it is not enabled in
kernel configuration.

--


                                                                 Gilles=

Chanteperdrix.
=

--2__=4EBBF9F3DFADB5BF8f9e8a93df938690918c4EBBF9F3DFADB5BF
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline
Content-transfer-encoding: quoted-printable

<html><body>
<p><font face=3D"Arial">Hello Gilles!</font><br>
<br>
<font face=3D"Arial">Thank you very much for your reponse.</font><br>
<br>
<font face=3D"Arial">LAPIC is disabled in BIOS, so &quot;make menuconfi=
g&quot; does not even give me the possibility to change it at all.</fon=
t><br>
<font face=3D"Arial">in the .config file I could find CONFIG_X86_LOCAL_=
APIC=3Dy.</font><br>
<font face=3D"Arial">I f I set it to =3Dn and start &quot;make menuconf=
ig&quot; again, it resets it to y even if I do not change anything manu=
ally.</font><br>
<br>
<font face=3D"Arial">However, if I let it like this (=3Dy) and build th=
e kernel and start it with &quot;lapic=3D1&quot; I get a boot log that =
seems quite ok.</font><br>
<font face=3D"Arial">At least the Xenomai messages are encouraging:</fo=
nt><br>
<font face=3D"Arial">...</font><br>
<font face=3D"Arial">[   16.783784] Local APIC disabled by BIOS -- reen=
abling.</font><br>
<font face=3D"Arial">[   16.783789] Found and enabled local APIC!</font=
><br>
<font face=3D"Arial">[   16.783795] mapped APIC to ffffd000 (fee00000)<=
/font><br>
<font face=3D"Arial">...</font><br>
<font face=3D"Arial">[   18.129248] I-pipe: Domain Xenomai registered.<=
/font><br>
<font face=3D"Arial">[   18.129343] Xenomai: hal/x86 started.</font><br=
>
<font face=3D"Arial">[   18.132813] Xenomai: real-time nucleus v2.3.3 (=
Summer Song) loaded.</font><br>
<font face=3D"Arial">[   18.133012] Xenomai: SMI-enabled chipset found =
but SMI workaround not enabled (check</font><br>
<font face=3D"Arial">[   18.133016]          CONFIG_XENO_HW_SMI_WORKARO=
UND). You may encounter high</font><br>
<font face=3D"Arial">[   18.133019]          interrupt latencies!</font=
><br>
<font face=3D"Arial">[   18.134404] Xenomai: starting native API servic=
es.</font><br>
<font face=3D"Arial">[   18.134491] Xenomai: starting POSIX services.</=
font><br>
<font face=3D"Arial">[   18.134620] Xenomai: starting RTDM services.</f=
ont><br>
<font face=3D"Arial">...</font><br>
<font face=3D"Arial">(Please find the full log here </font><i>(See atta=
ched file: boot_with_lapic_equ_1.txt)</i><font face=3D"Arial">)</font><=
br>
<br>
<font face=3D"Arial">Without the &quot;lapic=3D1&quot; there are some e=
rrors reported.</font><br>
<font face=3D"Arial">...</font><br>
<font face=3D"Arial">[   16.797406] Local APIC disabled by BIOS -- you =
can enable it with &quot;lapic&quot;</font><br>
<font face=3D"Arial">[   16.797416] mapped APIC to ffffd000 (013fa000)<=
/font><br>
<font face=3D"Arial">...</font><br>
<font face=3D"Arial">[   16.891593] Local APIC not detected. Using dumm=
y APIC emulation.</font><br>
<font face=3D"Arial">...</font><br>
<font face=3D"Arial">[   18.037577] Xenomai: Local APIC absent or disab=
led!</font><br>
<font face=3D"Arial">[   18.037579]          Disable APIC support or pa=
ss &quot;lapic=3D1&quot; as bootparam.</font><br>
<font face=3D"Arial">[   18.037753] Xenomai: system init failed, code -=
19.</font><br>
<font face=3D"Arial">[   18.037838] Xenomai: native skin init failed, c=
ode -19.</font><br>
<font face=3D"Arial">[   18.037946] Xenomai: starting POSIX services.</=
font><br>
<font face=3D"Arial">[   18.038029] Xenomai: POSIX skin init failed, co=
de -19.</font><br>
<font face=3D"Arial">[   18.038114] Xenomai: RTDM skin init failed, cod=
e -19.</font><br>
<font face=3D"Arial">(Please find the full log here </font><i>(See atta=
ched file: boot_without_lapic_equ_1.txt)</i><font face=3D"Arial">)</fon=
t><br>
<br>
<br>
<font face=3D"Arial">But even if the bootup seems ok as seen in the fir=
st case, the test applications won't start.</font><br>
<br>
<font face=3D"Arial">It keeps saying some xenomai part is not available=
, e.g. the latency application</font><br>
<font face=3D"Arial">root@domain.hid# ./latency</fon=
t><br>
<font face=3D"Arial">Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE =
disabled.</font><br>
<font face=3D"Arial">(modprobe xeno_native?)</font><br>
<br>
<font face=3D"Arial">You can see this in complete also from the output =
of xeno-test </font><i>(See attached file: output_xeno_test.txt)</i><br=
>
<br>
<font face=3D"Arial">So, do you still think it has something to do with=
 the LAPIC?</font><br>
<font face=3D"Arial">I still have the suspicion that I missed something=
 important during setup (building/installing) of xenomai.</font><br>
<font face=3D"Arial">Do I have to explicitely &quot;enable&quot; e.g. t=
he native skin?</font><br>
<font face=3D"Arial">The CONFIG_XENO_OPT_PERVASIVE is enables (=3Dy) in=
 the kernel's .config file, I checked this</font><br>
<font face=3D"Arial">Also the &quot;modprobe xeno_native&quot; hint dis=
tracts me, do I have to load this kernel module expicitely? Where is it=
?</font><br>
<br>
<font face=3D"Arial">Thanks</font><br>
<br>
<font face=3D"Arial">Juergen</font><br>
<br>
<img width=3D"16" height=3D"16" src=3D"cid:4__=3D4EBBF9F3DFADB5BF8f9e8a=
93df938@domain.hid" border=3D"0" alt=3D"Inactive hide details for Gille=
s Chanteperdrix &lt;gilles.chanteperdrix@xenomai.org&gt;">Gilles Chantepe=
rdrix &lt;gilles.chanteperdrix@xenomai.org&gt;<br>
<br>
<br>

<table width=3D"100%" border=3D"0" cellspacing=3D"0" cellpadding=3D"0">=

<tr valign=3D"top"><td style=3D"background-image:url(cid:5__=3D4EBBF9F3=
DFADB5BF8f9e8a93df938@domain.hid); background-repeat: no-repeat; " widt=
h=3D"40%">
<ul>
<ul>
<ul>
<ul><b><font size=3D"2">Gilles Chanteperdrix &lt;gilles.chanteperdrix@xenomai.org=
mail.com&gt;</font></b><font size=3D"2"> </font>
<p><font size=3D"2">21.09.2007 21:01</font></ul>
</ul>
</ul>
</ul>
</td><td width=3D"60%">
<table width=3D"100%" border=3D"0" cellspacing=3D"0" cellpadding=3D"0">=

<tr valign=3D"top"><td width=3D"1%" valign=3D"middle"><img width=3D"58"=
 height=3D"1" src=3D"cid:6__=3D4EBBF9F3DFADB5BF8f9e8a93df938@domain.hid=
" border=3D"0" alt=3D""><br>
<div align=3D"right"><font size=3D"2">To</font></div></td><td width=3D"=
100%"><img width=3D"1" height=3D"1" src=3D"cid:6__=3D4EBBF9F3DFADB5BF8f=
9e8a93df938@domain.hid" border=3D"0" alt=3D""><br>
<font size=3D"2">juergen.lanner@domain.hid</font></td></tr>

<tr valign=3D"top"><td width=3D"1%" valign=3D"middle"><img width=3D"58"=
 height=3D"1" src=3D"cid:6__=3D4EBBF9F3DFADB5BF8f9e8a93df938@domain.hid=
" border=3D"0" alt=3D""><br>
<div align=3D"right"><font size=3D"2">cc</font></div></td><td width=3D"=
100%"><img width=3D"1" height=3D"1" src=3D"cid:6__=3D4EBBF9F3DFADB5BF8f=
9e8a93df938@domain.hid" border=3D"0" alt=3D""><br>
<font size=3D"2">xenomai@xenomai.org</font></td></tr>

<tr valign=3D"top"><td width=3D"1%" valign=3D"middle"><img width=3D"58"=
 height=3D"1" src=3D"cid:6__=3D4EBBF9F3DFADB5BF8f9e8a93df938@domain.hid=
" border=3D"0" alt=3D""><br>
<div align=3D"right"><font size=3D"2">Subject</font></div></td><td widt=
h=3D"100%"><img width=3D"1" height=3D"1" src=3D"cid:6__=3D4EBBF9F3DFADB=
5BF8f9e8a93df938@domain.hid" border=3D"0" alt=3D""><br>
<font size=3D"2">Re: [Xenomai-help] POSIX skin or CONFIG_XENO_OPT_PERVA=
SIVE disabled</font></td></tr>
</table>

<table border=3D"0" cellspacing=3D"0" cellpadding=3D"0">
<tr valign=3D"top"><td width=3D"58"><img width=3D"1" height=3D"1" src=3D=
"cid:6__=3D4EBBF9F3DFADB5BF8f9e8a93df938@domain.hid" border=3D"0" alt=3D=
""></td><td width=3D"336"><img width=3D"1" height=3D"1" src=3D"cid:6__=3D=
4EBBF9F3DFADB5BF8f9e8a93df938@domain.hid" border=3D"0" alt=3D""></td></=
tr>
</table>
</td></tr>
</table>
<br>
<tt>juergen.lanner@domain.hid wrote:<br>
 &gt; <br>
 &gt; <br>
 &gt; Hi there!<br>
 &gt; <br>
 &gt; Sorry for the newbie question, but I am stuck here ...<br>
 &gt; I get this message every time I try to run e.g. latency test on m=
y system.<br>
 &gt; <br>
 &gt; What do I wrong?<br>
 &gt; <br>
 &gt; I use<br>
 &gt; Ubuntu 7.04 desktop<br>
 &gt; Kernel 2.6.20.19 from www.kernel.org<br>
 &gt; Xenomai 2.3.3<br>
 &gt; adeos-ipipe-2.6.20-i386-1.8-08.patch<br>
 &gt; <br>
 &gt; I already saw<br>
 &gt; (...)<br>
 &gt; running: cat /proc/interrupts<br>
 &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;CPU0<br>
 &gt; &nbsp; 0: &nbsp; &nbsp;7243712 &nbsp; &nbsp;XT-PIC-XT &nbsp; &nbs=
p; &nbsp; &nbsp;timer, rthal_broadcast_timer<br>
 &gt; &nbsp; 1: &nbsp; &nbsp; &nbsp; &nbsp; 30 &nbsp; &nbsp;XT-PIC-XT &=
nbsp; &nbsp; &nbsp; &nbsp;i8042<br>
 &gt; &nbsp; 2: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0 &nbsp; &nbsp;XT-PIC=
-XT &nbsp; &nbsp; &nbsp; &nbsp;cascade<br>
 &gt; &nbsp; 5: &nbsp; &nbsp; 544285 &nbsp; &nbsp;XT-PIC-XT &nbsp; &nbs=
p; &nbsp; &nbsp;uhci_hcd:usb1, eth3,<br>
 &gt; i915@domain.hid<br>
 &gt; &nbsp; 7: &nbsp; &nbsp; &nbsp;18259 &nbsp; &nbsp;XT-PIC-XT &nbsp;=
 &nbsp; &nbsp; &nbsp;ehci_hcd:usb3<br>
 &gt; &nbsp; 8: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;3 &nbsp; &nbsp;XT-PIC=
-XT &nbsp; &nbsp; &nbsp; &nbsp;rtc<br>
 &gt; &nbsp; 9: &nbsp; 17584667 &nbsp; &nbsp;XT-PIC-XT &nbsp; &nbsp; &n=
bsp; &nbsp;eth0<br>
 &gt; &nbsp;12: &nbsp; &nbsp; &nbsp; &nbsp;196 &nbsp; &nbsp;XT-PIC-XT &=
nbsp; &nbsp; &nbsp; &nbsp;i8042<br>
 &gt; &nbsp;14: &nbsp; &nbsp; &nbsp;10992 &nbsp; &nbsp;XT-PIC-XT &nbsp;=
 &nbsp; &nbsp; &nbsp;ide0<br>
 &gt; &nbsp;15: &nbsp; &nbsp; &nbsp; 7236 &nbsp; &nbsp;XT-PIC-XT &nbsp;=
 &nbsp; &nbsp; &nbsp;uhci_hcd:usb2, eth1, eth2<br>
 &gt; NMI: &nbsp; &nbsp; &nbsp; 3198<br>
 &gt; LOC: &nbsp; &nbsp;7243618<br>
 &gt; ERR: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0<br>
 &gt; MIS: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0<br>
<br>
The conclusion of vicki problem was that he had the APIC enabled in<br>=

kernel configuration whereas his hardware had no APIC. Are you sure you=
<br>
are not running into the same issue ? From /proc/interrupts contents, i=
t<br>
looks like you are not using APIC, so, check that it is not enabled in<=
br>
kernel configuration.<br>
<br>
-- <br>
<br>
<br>
		 		 		 		 		 &nbsp; &nbsp; Gilles Chanteperdrix.<br>
</tt><br>
</body></html>=


--2__=4EBBF9F3DFADB5BF8f9e8a93df938690918c4EBBF9F3DFADB5BF--


--1__=4EBBF9F3DFADB5BF8f9e8a93df938690918c4EBBF9F3DFADB5BF
Content-type: image/gif; 
	name="graycol.gif"
Content-Disposition: inline; filename="graycol.gif"
Content-ID: <4__=4EBBF9F3DFADB5BF8f9e8a93df938@domain.hid>
Content-transfer-encoding: base64

R0lGODlhEAAQAKECAMzMzAAAAP///wAAACH5BAEAAAIALAAAAAAQABAAAAIXlI+py+0PopwxUbpu
ZRfKZ2zgSJbmSRYAIf4fT3B0aW1pemVkIGJ5IFVsZWFkIFNtYXJ0U2F2ZXIhAAA7

--1__=4EBBF9F3DFADB5BF8f9e8a93df938690918c4EBBF9F3DFADB5BF
Content-type: image/gif; 
	name="pic12717.gif"
Content-Disposition: inline; filename="pic12717.gif"
Content-ID: <5__=4EBBF9F3DFADB5BF8f9e8a93df938@domain.hid>
Content-transfer-encoding: base64

R0lGODlhWABDALP/AAAAAK04Qf79/o+Gm7WuwlNObwoJFCsoSMDAwGFsmIuezf///wAAAAAAAAAA
AAAAACH5BAEAAAgALAAAAABYAEMAQAT/EMlJq704682770RiFMRinqggEUNSHIchG0BCfHhOjAuh
EDeUqTASLCbBhQrhG7xis2j0lssNDopE4jfIJhDaggI8YB1sZeZgLVA9YVCpnGagVjV171aRVrYR
RghXcAGFhoUETwYxcXNyADJ3GlcSKGAwLwllVC1vjIUHBWsFilKQdI8GA5IcpApeJQt8L09lmgkH
LZikoU5wjqcyAMMFrJIDPAKvCFletKSev1HBw8KrxtjZ2tvc3d5VyKtCKW3jfz4uMKmq3xu4N0nK
BVoJQmx2LGVOmrqNjjJf2hHAQo/eDwJGTKhQMcgQEEAnEjFS98+RnW3smGkZU6ncCWav/4wYOnAI
TihRL/4FEwbp28BXMMcoscQCVxlepL4IGDSCyJyVQOu0o7CjmLN50OZlqWmyFy5/6yBBuji0AxFR
M00oQAqNIstqI6qKHUsWRAEAvagsmfUEAImyxgbmUpJk3IklNUtJOUAVLoUr1+wqDGTE4zk+T6FG
uQb3SizBCwatiiUgCBN8vrz+zFjVyQ8FWkOlg4NQiZMB5QS8QO3mpOaKnL0Z2EKvNMSILEThKhCg
zMKPVxYJh23qm9KNW7pArPynMqZDiErsTMqI+LRi3QAgkFUbXpuFKhSYZALd0O5RKa2z9EYKBbpb
qxIKsjUPRgD7I2XYV6wyrOw92ykExP8NW4URhknC5dKGE4v4NENQj2jXjmfNgOZDaXb5glRmXQ33
YEWQYNcZFnrYcIQLNzyTFDQNkXIff0ExVlY4srziQk43inZgL4rwxxINMvpFFAz1KOODHiu+4aEw
NEjFl5B3JIKWKF3k6I9bfUGp5ZZcdunll5IA4cuHvQQJ5gcsoCWOOUwgltIwAKRxJgbIkJAQZEq0
2YliZnpZZ4BH3CnYOXldOUOfQoYDqF1LFHbXCrO8xmRsfoXDXJ6ChjCAH3QlhJcT6VWE6FCkfCco
CgrMFsROrIEX3o2whVjWDjoJccN3LdggSGXLCdLEgHr1lyU3O3QxhgohNKXJCWv8JQr/PDdaqd6w
2rj1inLiGeiCJoDspAoQlYE6QWLSECehcWIYxIQES6zhbn1iImTHEQyqJ4eIxJJoUBc+3CbBuwZE
V5cJPPkIjFDdeEabQbd6WgICTxiiz0f5dBKquXF6k4senwEhYGnKEFJeGrxUZy8dB8gmAXI/sPvH
ESfCwVt5hTgYiqQqtdRNHQIU1PJ33ZqmzgE90OwLaoJcnMop1WiMmgkPHQRIrwgFuNV90A3doNKT
mrKIN07AnGcI9BQjhCBN4RfA1qIZnMqorJCogKfGQnxSCDilTVIA0yl5ciTovgLuBDKFUDE9aQcw
9SA+rjSNf9/M1gxrj6VwDTS0IUSElMzBfsj0NFXR2kwsV1A5IF1grLgLL/r1R40BZEnuBWgmQEyb
jqRwSAt6bqMCOFkvKFN2GPPkUzIm/SCF8z8pVzpbjVnMsy0vOr1hw3SaSRUhpY09v0z0J1FnwzPl
fmh+xl4WtR0zGu24I4KbMQm3lnVu2oNWxI9W/lcyzA+mCKF4DBikxb/+UWtOGRiFP8qEwAayIgIA
Ow==

--1__=4EBBF9F3DFADB5BF8f9e8a93df938690918c4EBBF9F3DFADB5BF
Content-type: image/gif; 
	name="ecblank.gif"
Content-Disposition: inline; filename="ecblank.gif"
Content-ID: <6__=4EBBF9F3DFADB5BF8f9e8a93df938@domain.hid>
Content-transfer-encoding: base64

R0lGODlhEAABAIAAAAAAAP///yH5BAEAAAEALAAAAAAQAAEAAAIEjI8ZBQA7


--1__=4EBBF9F3DFADB5BF8f9e8a93df938690918c4EBBF9F3DFADB5BF--


--0__=4EBBF9F3DFADB5BF8f9e8a93df938690918c4EBBF9F3DFADB5BF
Content-type: application/octet-stream; 
	name="boot_with_lapic_equ_1.txt"
Content-Disposition: attachment; filename="boot_with_lapic_equ_1.txt"
Content-ID: <1__=4EBBF9F3DFADB5BF8f9e8a93df938@domain.hid>
Content-transfer-encoding: base64

WyAgICAwLjAwMDAwMF0gTGludXggdmVyc2lvbiAyLjYuMjAuMTktYWRlb3MteGVub21haTIuMy4w
IChyb290QGduY3UtZGVza3RvcCkgKGdjYyB2ZXJzaW9uIDQuMS4yIChVYnVudHUgNC4xLjItMHVi
dW50dTQpKSAjMSBTTVAgTW9uIFNlcCAyNCAxMjowMjozNyBDRVNUIDIwMDcKWyAgICAwLjAwMDAw
MF0gQklPUy1wcm92aWRlZCBwaHlzaWNhbCBSQU0gbWFwOgpbICAgIDAuMDAwMDAwXSBzYW5pdGl6
ZSBzdGFydApbICAgIDAuMDAwMDAwXSBzYW5pdGl6ZSBlbmQKWyAgICAwLjAwMDAwMF0gY29weV9l
ODIwX21hcCgpIHN0YXJ0OiAwMDAwMDAwMDAwMDAwMDAwIHNpemU6IDAwMDAwMDAwMDAwOWY4MDAg
ZW5kOiAwMDAwMDAwMDAwMDlmODAwIHR5cGU6IDEKWyAgICAwLjAwMDAwMF0gY29weV9lODIwX21h
cCgpIHR5cGUgaXMgRTgyMF9SQU0KWyAgICAwLjAwMDAwMF0gY29weV9lODIwX21hcCgpIHN0YXJ0
OiAwMDAwMDAwMDAwMDlmODAwIHNpemU6IDAwMDAwMDAwMDAwMDA4MDAgZW5kOiAwMDAwMDAwMDAw
MGEwMDAwIHR5cGU6IDIKWyAgICAwLjAwMDAwMF0gY29weV9lODIwX21hcCgpIHN0YXJ0OiAwMDAw
MDAwMDAwMGNlMDAwIHNpemU6IDAwMDAwMDAwMDAwMDIwMDAgZW5kOiAwMDAwMDAwMDAwMGQwMDAw
IHR5cGU6IDIKWyAgICAwLjAwMDAwMF0gY29weV9lODIwX21hcCgpIHN0YXJ0OiAwMDAwMDAwMDAw
MGUwMDAwIHNpemU6IDAwMDAwMDAwMDAwMjAwMDAgZW5kOiAwMDAwMDAwMDAwMTAwMDAwIHR5cGU6
IDIKWyAgICAwLjAwMDAwMF0gY29weV9lODIwX21hcCgpIHN0YXJ0OiAwMDAwMDAwMDAwMTAwMDAw
IHNpemU6IDAwMDAwMDAwMWY1ZTAwMDAgZW5kOiAwMDAwMDAwMDFmNmUwMDAwIHR5cGU6IDEKWyAg
ICAwLjAwMDAwMF0gY29weV9lODIwX21hcCgpIHR5cGUgaXMgRTgyMF9SQU0KWyAgICAwLjAwMDAw
MF0gY29weV9lODIwX21hcCgpIHN0YXJ0OiAwMDAwMDAwMDFmNmUwMDAwIHNpemU6IDAwMDAwMDAw
MDAwMGEwMDAgZW5kOiAwMDAwMDAwMDFmNmVhMDAwIHR5cGU6IDMKWyAgICAwLjAwMDAwMF0gY29w
eV9lODIwX21hcCgpIHN0YXJ0OiAwMDAwMDAwMDFmNmVhMDAwIHNpemU6IDAwMDAwMDAwMDAwMTYw
MDAgZW5kOiAwMDAwMDAwMDFmNzAwMDAwIHR5cGU6IDQKWyAgICAwLjAwMDAwMF0gY29weV9lODIw
X21hcCgpIHN0YXJ0OiAwMDAwMDAwMDFmNzAwMDAwIHNpemU6IDAwMDAwMDAwMDA5MDAwMDAgZW5k
OiAwMDAwMDAwMDIwMDAwMDAwIHR5cGU6IDIKWyAgICAwLjAwMDAwMF0gY29weV9lODIwX21hcCgp
IHN0YXJ0OiAwMDAwMDAwMGZlYzEwMDAwIHNpemU6IDAwMDAwMDAwMDAwMTAwMDAgZW5kOiAwMDAw
MDAwMGZlYzIwMDAwIHR5cGU6IDIKWyAgICAwLjAwMDAwMF0gY29weV9lODIwX21hcCgpIHN0YXJ0
OiAwMDAwMDAwMGZmODAwMDAwIHNpemU6IDAwMDAwMDAwMDA0MDAwMDAgZW5kOiAwMDAwMDAwMGZm
YzAwMDAwIHR5cGU6IDIKWyAgICAwLjAwMDAwMF0gY29weV9lODIwX21hcCgpIHN0YXJ0OiAwMDAw
MDAwMGZmZmZmYzAwIHNpemU6IDAwMDAwMDAwMDAwMDA0MDAgZW5kOiAwMDAwMDAwMTAwMDAwMDAw
IHR5cGU6IDIKWyAgICAwLjAwMDAwMF0gIEJJT1MtZTgyMDogMDAwMDAwMDAwMDAwMDAwMCAtIDAw
MDAwMDAwMDAwOWY4MDAgKHVzYWJsZSkKWyAgICAwLjAwMDAwMF0gIEJJT1MtZTgyMDogMDAwMDAw
MDAwMDA5ZjgwMCAtIDAwMDAwMDAwMDAwYTAwMDAgKHJlc2VydmVkKQpbICAgIDAuMDAwMDAwXSAg
QklPUy1lODIwOiAwMDAwMDAwMDAwMGNlMDAwIC0gMDAwMDAwMDAwMDBkMDAwMCAocmVzZXJ2ZWQp
ClsgICAgMC4wMDAwMDBdICBCSU9TLWU4MjA6IDAwMDAwMDAwMDAwZTAwMDAgLSAwMDAwMDAwMDAw
MTAwMDAwIChyZXNlcnZlZCkKWyAgICAwLjAwMDAwMF0gIEJJT1MtZTgyMDogMDAwMDAwMDAwMDEw
MDAwMCAtIDAwMDAwMDAwMWY2ZTAwMDAgKHVzYWJsZSkKWyAgICAwLjAwMDAwMF0gIEJJT1MtZTgy
MDogMDAwMDAwMDAxZjZlMDAwMCAtIDAwMDAwMDAwMWY2ZWEwMDAgKEFDUEkgZGF0YSkKWyAgICAw
LjAwMDAwMF0gIEJJT1MtZTgyMDogMDAwMDAwMDAxZjZlYTAwMCAtIDAwMDAwMDAwMWY3MDAwMDAg
KEFDUEkgTlZTKQpbICAgIDAuMDAwMDAwXSAgQklPUy1lODIwOiAwMDAwMDAwMDFmNzAwMDAwIC0g
MDAwMDAwMDAyMDAwMDAwMCAocmVzZXJ2ZWQpClsgICAgMC4wMDAwMDBdICBCSU9TLWU4MjA6IDAw
MDAwMDAwZmVjMTAwMDAgLSAwMDAwMDAwMGZlYzIwMDAwIChyZXNlcnZlZCkKWyAgICAwLjAwMDAw
MF0gIEJJT1MtZTgyMDogMDAwMDAwMDBmZjgwMDAwMCAtIDAwMDAwMDAwZmZjMDAwMDAgKHJlc2Vy
dmVkKQpbICAgIDAuMDAwMDAwXSAgQklPUy1lODIwOiAwMDAwMDAwMGZmZmZmYzAwIC0gMDAwMDAw
MDEwMDAwMDAwMCAocmVzZXJ2ZWQpClsgICAgMC4wMDAwMDBdIDBNQiBISUdITUVNIGF2YWlsYWJs
ZS4KWyAgICAwLjAwMDAwMF0gNTAyTUIgTE9XTUVNIGF2YWlsYWJsZS4KWyAgICAwLjAwMDAwMF0g
RW50ZXJpbmcgYWRkX2FjdGl2ZV9yYW5nZSgwLCAwLCAxMjg3MzYpIDAgZW50cmllcyBvZiAyNTYg
dXNlZApbICAgIDAuMDAwMDAwXSBab25lIFBGTiByYW5nZXM6ClsgICAgMC4wMDAwMDBdICAgRE1B
ICAgICAgICAgICAgIDAgLT4gICAgIDQwOTYKWyAgICAwLjAwMDAwMF0gICBOb3JtYWwgICAgICAg
NDA5NiAtPiAgIDEyODczNgpbICAgIDAuMDAwMDAwXSAgIEhpZ2hNZW0gICAgMTI4NzM2IC0+ICAg
MTI4NzM2ClsgICAgMC4wMDAwMDBdIGVhcmx5X25vZGVfbWFwWzFdIGFjdGl2ZSBQRk4gcmFuZ2Vz
ClsgICAgMC4wMDAwMDBdICAgICAwOiAgICAgICAgMCAtPiAgIDEyODczNgpbICAgIDAuMDAwMDAw
XSBPbiBub2RlIDAgdG90YWxwYWdlczogMTI4NzM2ClsgICAgMC4wMDAwMDBdICAgRE1BIHpvbmU6
IDMyIHBhZ2VzIHVzZWQgZm9yIG1lbW1hcApbICAgIDAuMDAwMDAwXSAgIERNQSB6b25lOiAwIHBh
Z2VzIHJlc2VydmVkClsgICAgMC4wMDAwMDBdICAgRE1BIHpvbmU6IDQwNjQgcGFnZXMsIExJRk8g
YmF0Y2g6MApbICAgIDAuMDAwMDAwXSAgIE5vcm1hbCB6b25lOiA5NzMgcGFnZXMgdXNlZCBmb3Ig
bWVtbWFwClsgICAgMC4wMDAwMDBdICAgTm9ybWFsIHpvbmU6IDEyMzY2NyBwYWdlcywgTElGTyBi
YXRjaDozMQpbICAgIDAuMDAwMDAwXSAgIEhpZ2hNZW0gem9uZTogMCBwYWdlcyB1c2VkIGZvciBt
ZW1tYXAKWyAgICAwLjAwMDAwMF0gRE1JIG5vdCBwcmVzZW50IG9yIGludmFsaWQuClsgICAgMC4w
MDAwMDBdIEFsbG9jYXRpbmcgUENJIHJlc291cmNlcyBzdGFydGluZyBhdCAzMDAwMDAwMCAoZ2Fw
OiAyMDAwMDAwMDpkZWMxMDAwMCkKWyAgICAwLjAwMDAwMF0gRGV0ZWN0ZWQgODk3LjEzMiBNSHog
cHJvY2Vzc29yLgpbICAgMTYuNzgzMjIyXSBCdWlsdCAxIHpvbmVsaXN0cy4gIFRvdGFsIHBhZ2Vz
OiAxMjc3MzEKWyAgIDE2Ljc4MzIzMF0gS2VybmVsIGNvbW1hbmQgbGluZTogcm9vdD1VVUlEPWUx
MDdhOTk4LTYwOWItNGM2My1iZGQyLTQwODhiZTllMzExYiBybyBzaW5nbGUgbGFwaWM9MQpbICAg
MTYuNzgzNzg0XSBMb2NhbCBBUElDIGRpc2FibGVkIGJ5IEJJT1MgLS0gcmVlbmFibGluZy4KWyAg
IDE2Ljc4Mzc4OV0gRm91bmQgYW5kIGVuYWJsZWQgbG9jYWwgQVBJQyEKWyAgIDE2Ljc4Mzc5NV0g
bWFwcGVkIEFQSUMgdG8gZmZmZmQwMDAgKGZlZTAwMDAwKQpbICAgMTYuNzgzODAxXSBFbmFibGlu
ZyBmYXN0IEZQVSBzYXZlIGFuZCByZXN0b3JlLi4uIGRvbmUuClsgICAxNi43ODM4MDddIEVuYWJs
aW5nIHVubWFza2VkIFNJTUQgRlBVIGV4Y2VwdGlvbiBzdXBwb3J0Li4uIGRvbmUuClsgICAxNi43
ODM4MjFdIEluaXRpYWxpemluZyBDUFUjMApbICAgMTYuNzgzOTI4XSBQSUQgaGFzaCB0YWJsZSBl
bnRyaWVzOiAyMDQ4IChvcmRlcjogMTEsIDgxOTIgYnl0ZXMpClsgICAxNi43ODQxNDddIEktcGlw
ZSAxLjgtMDg6IHBpcGVsaW5lIGVuYWJsZWQuClsgICAxNi43ODYxMTRdIENvbnNvbGU6IGNvbG91
ciBWR0ErIDgweDI1ClsgICAxNi43OTAzNjhdIERlbnRyeSBjYWNoZSBoYXNoIHRhYmxlIGVudHJp
ZXM6IDY1NTM2IChvcmRlcjogNiwgMjYyMTQ0IGJ5dGVzKQpbICAgMTYuNzkwODA0XSBJbm9kZS1j
YWNoZSBoYXNoIHRhYmxlIGVudHJpZXM6IDMyNzY4IChvcmRlcjogNSwgMTMxMDcyIGJ5dGVzKQpb
ICAgMTYuODExNTY0XSBNZW1vcnk6IDUwMDE0OGsvNTE0OTQ0ayBhdmFpbGFibGUgKDE5MjlrIGtl
cm5lbCBjb2RlLCAxNDIyNGsgcmVzZXJ2ZWQsIDg4MGsgZGF0YSwgMjY0ayBpbml0LCAwayBoaWdo
bWVtKQpbICAgMTYuODExNjkxXSB2aXJ0dWFsIGtlcm5lbCBtZW1vcnkgbGF5b3V0OgpbICAgMTYu
ODExNjk0XSAgICAgZml4bWFwICA6IDB4ZmZmNTMwMDAgLSAweGZmZmZmMDAwICAgKCA2ODgga0Ip
ClsgICAxNi44MTE2OTZdICAgICBwa21hcCAgIDogMHhmZjgwMDAwMCAtIDB4ZmZjMDAwMDAgICAo
NDA5NiBrQikKWyAgIDE2LjgxMTY5OV0gICAgIHZtYWxsb2MgOiAweGUwMDAwMDAwIC0gMHhmZjdm
ZTAwMCAgICggNTAzIE1CKQpbICAgMTYuODExNzAyXSAgICAgbG93bWVtICA6IDB4YzAwMDAwMDAg
LSAweGRmNmUwMDAwICAgKCA1MDIgTUIpClsgICAxNi44MTE3MDRdICAgICAgIC5pbml0IDogMHhj
MDNjNjAwMCAtIDB4YzA0MDgwMDAgICAoIDI2NCBrQikKWyAgIDE2LjgxMTcwN10gICAgICAgLmRh
dGEgOiAweGMwMmUyNTJkIC0gMHhjMDNiZTZiNCAgICggODgwIGtCKQpbICAgMTYuODExNzA5XSAg
ICAgICAudGV4dCA6IDB4YzAxMDAwMDAgLSAweGMwMmUyNTJkICAgKDE5Mjkga0IpClsgICAxNi44
MTIzOTFdIENoZWNraW5nIGlmIHRoaXMgcHJvY2Vzc29yIGhvbm91cnMgdGhlIFdQIGJpdCBldmVu
IGluIHN1cGVydmlzb3IgbW9kZS4uLiBPay4KWyAgIDE2Ljg3MTg4Ml0gQ2FsaWJyYXRpbmcgZGVs
YXkgdXNpbmcgdGltZXIgc3BlY2lmaWMgcm91dGluZS4uIDE3OTQuNzkgQm9nb01JUFMgKGxwaj04
OTczOTUpClsgICAxNi44NzIxMzFdIFNlY3VyaXR5IEZyYW1ld29yayB2MS4wLjAgaW5pdGlhbGl6
ZWQKWyAgIDE2Ljg3MjI1M10gTW91bnQtY2FjaGUgaGFzaCB0YWJsZSBlbnRyaWVzOiA1MTIKWyAg
IDE2Ljg3MjU2OF0gQ1BVOiBBZnRlciBnZW5lcmljIGlkZW50aWZ5LCBjYXBzOiBhN2U5ZmJiZiAw
MDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDE4MCAwMDAwMDAwMCAwMDAwMDAwMApbICAg
MTYuODcyNTkxXSBDUFU6IEwxIEkgY2FjaGU6IDMySywgTDEgRCBjYWNoZTogMzJLClsgICAxNi44
NzI3NDJdIENQVTogTDIgY2FjaGU6IDEwMjRLClsgICAxNi44NzI4MjldIENQVTogQWZ0ZXIgYWxs
IGluaXRzLCBjYXBzOiBhN2U5ZmJiZiAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMjA0MCAwMDAwMDE4
MCAwMDAwMDAwMCAwMDAwMDAwMApbICAgMTYuODcyODQ3XSBDb21wYXQgdkRTTyBtYXBwZWQgdG8g
ZmZmZmUwMDAuClsgICAxNi44NzI5NTZdIENoZWNraW5nICdobHQnIGluc3RydWN0aW9uLi4uIE9L
LgpbICAgMTYuODc3MTAxXSBTTVAgYWx0ZXJuYXRpdmVzOiBzd2l0Y2hpbmcgdG8gVVAgY29kZQpb
ICAgMTYuODc3NDg4XSBGcmVlaW5nIFNNUCBhbHRlcm5hdGl2ZXM6IDEzayBmcmVlZApbICAgMTYu
ODc3NjA1XSBDUFUwOiBJbnRlbCBNb2JpbGUgR2VudWluZSBJbnRlbChSKSBwcm9jZXNzb3IgICAg
ICAgMTEwME1IeiBzdGVwcGluZyAwNQpbICAgMTYuODc3ODk4XSBTTVAgbW90aGVyYm9hcmQgbm90
IGRldGVjdGVkLgpbICAgMTYuOTc5ODg5XSBCcm91Z2h0IHVwIDEgQ1BVcwpbICAgMTYuOTgwNDIw
XSBORVQ6IFJlZ2lzdGVyZWQgcHJvdG9jb2wgZmFtaWx5IDE2ClsgICAxNi45ODA2NDFdIEVJU0Eg
YnVzIHJlZ2lzdGVyZWQKWyAgIDE2Ljk4MjE0Nl0gUENJOiBQQ0kgQklPUyByZXZpc2lvbiAyLjEw
IGVudHJ5IGF0IDB4ZmQ5NTQsIGxhc3QgYnVzPTMKWyAgIDE2Ljk4MjIzN10gUENJOiBVc2luZyBj
b25maWd1cmF0aW9uIHR5cGUgMQpbICAgMTYuOTgyMzE4XSBTZXR0aW5nIHVwIHN0YW5kYXJkIFBD
SSByZXNvdXJjZXMKWyAgIDE3LjAwMzY1M10gTGludXggUGx1ZyBhbmQgUGxheSBTdXBwb3J0IHYw
Ljk3IChjKSBBZGFtIEJlbGF5ClsgICAxNy4wMDM3NTZdIFBuUEJJT1M6IFNjYW5uaW5nIHN5c3Rl
bSBmb3IgUG5QIEJJT1Mgc3VwcG9ydC4uLgpbICAgMTcuMDAzODYwXSBQblBCSU9TOiBGb3VuZCBQ
blAgQklPUyBpbnN0YWxsYXRpb24gc3RydWN0dXJlIGF0IDB4YzAwZjY2NTAKWyAgIDE3LjAwMzk1
MV0gUG5QQklPUzogUG5QIEJJT1MgdmVyc2lvbiAxLjAsIGVudHJ5IDB4ZjAwMDA6MHhhYTdkLCBk
c2VnIDB4NDAwClsgICAxNy4wMDYzODldIFBOUEJJT1MgZmF1bHQuLiBhdHRlbXB0aW5nIHJlY292
ZXJ5LgpbICAgMTcuMDA2NDc3XSBQblBCSU9TOiBXYXJuaW5nISBZb3VyIFBuUCBCSU9TIGNhdXNl
ZCBhIGZhdGFsIGVycm9yLiBBdHRlbXB0aW5nIHRvIGNvbnRpbnVlClsgICAxNy4wMDY1ODNdIFBu
UEJJT1M6IFlvdSBtYXkgbmVlZCB0byByZWJvb3Qgd2l0aCB0aGUgInBucGJpb3M9b2ZmIiBvcHRp
b24gdG8gb3BlcmF0ZSBzdGFibHkKWyAgIDE3LjAwNjY4OV0gUG5QQklPUzogQ2hlY2sgd2l0aCB5
b3VyIHZlbmRvciBmb3IgYW4gdXBkYXRlZCBCSU9TClsgICAxNy4wMDY3NzddIFBuUEJJT1M6IGdl
dF9kZXZfbm9kZTogdW5leHBlY3RlZCBzdGF0dXMgMHgzNwpbICAgMTcuMDA2OTI3XSBQblBCSU9T
OiAxNSBub2RlcyByZXBvcnRlZCBieSBQblAgQklPUzsgMTUgcmVjb3JkZWQgYnkgZHJpdmVyClsg
ICAxNy4wMDcwNjJdIFBDSTogUHJvYmluZyBQQ0kgaGFyZHdhcmUKWyAgIDE3LjAwNzE0OV0gUENJ
OiBQcm9iaW5nIFBDSSBoYXJkd2FyZSAoYnVzIDAwKQpbICAgMTcuMDA3MzY1XSBCb290IHZpZGVv
IGRldmljZSBpcyAwMDAwOjAwOjAyLjAKWyAgIDE3LjAwNzcwMF0gUENJIHF1aXJrOiByZWdpb24g
MTAwMC0xMDdmIGNsYWltZWQgYnkgSUNINCBBQ1BJL0dQSU8vVENPClsgICAxNy4wMDc3ODldIFBD
SSBxdWlyazogcmVnaW9uIDExODAtMTFiZiBjbGFpbWVkIGJ5IElDSDQgR1BJTwpbICAgMTcuMDA4
MTM0XSBQQ0k6IEZpcm13YXJlIGxlZnQgMDAwMDowMjowNC4wIGUxMDAgaW50ZXJydXB0cyBlbmFi
bGVkLCBkaXNhYmxpbmcKWyAgIDE3LjAwODM4MF0gUENJOiBGaXJtd2FyZSBsZWZ0IDAwMDA6MDI6
MDguMCBlMTAwIGludGVycnVwdHMgZW5hYmxlZCwgZGlzYWJsaW5nClsgICAxNy4wMDg1NTBdIFBD
STogVHJhbnNwYXJlbnQgYnJpZGdlIC0gMDAwMDowMDoxZS4wClsgICAxNy4wMDg3MjJdIFBDSTog
RmlybXdhcmUgbGVmdCAwMDAwOjAzOjA3LjAgZTEwMCBpbnRlcnJ1cHRzIGVuYWJsZWQsIGRpc2Fi
bGluZwpbICAgMTcuMDA4OTQ1XSBQQ0k6IEZpcm13YXJlIGxlZnQgMDAwMDowMzowOC4wIGUxMDAg
aW50ZXJydXB0cyBlbmFibGVkLCBkaXNhYmxpbmcKWyAgIDE3LjAxMDQ0OF0gUENJOiBVc2luZyBJ
UlEgcm91dGVyIFBJSVgvSUNIIFs4MDg2LzI0YzBdIGF0IDAwMDA6MDA6MWYuMApbICAgMTcuMDEw
NTU3XSBQQ0k6IHNldHRpbmcgSVJRIDkgYXMgbGV2ZWwtdHJpZ2dlcmVkClsgICAxNy4wMTA1NjJd
IFBDSTogRm91bmQgSVJRIDkgZm9yIGRldmljZSAwMDAwOjAwOjFmLjEKWyAgIDE3LjAxMDY3MV0g
UENJOiBTaGFyaW5nIElSUSA5IHdpdGggMDAwMDowMjowNS4wClsgICAxNy4wMTc5MjVdIE5FVDog
UmVnaXN0ZXJlZCBwcm90b2NvbCBmYW1pbHkgOApbICAgMTcuMDE4MDEzXSBORVQ6IFJlZ2lzdGVy
ZWQgcHJvdG9jb2wgZmFtaWx5IDIwClsgICAxNy4wMTgxODBdIHBucDogMDA6MDk6IGlvcG9ydCBy
YW5nZSAweGZlMDAtMHhmZTAxIGhhcyBiZWVuIHJlc2VydmVkClsgICAxNy4wMTgyNzVdIHBucDog
MDA6MGI6IGlvcG9ydCByYW5nZSAweDRkMC0weDRkMSBoYXMgYmVlbiByZXNlcnZlZApbICAgMTcu
MDE4MzY0XSBwbnA6IDAwOjBiOiBpb3BvcnQgcmFuZ2UgMHgxMDAwLTB4MTA1ZiBoYXMgYmVlbiBy
ZXNlcnZlZApbICAgMTcuMDE4NDU3XSBwbnA6IDAwOjBiOiBpb3BvcnQgcmFuZ2UgMHgxMDYwLTB4
MTA3ZiBoYXMgYmVlbiByZXNlcnZlZApbICAgMTcuMDE4NTQ1XSBwbnA6IDAwOjBiOiBpb3BvcnQg
cmFuZ2UgMHgxMTgwLTB4MTFiZiBoYXMgYmVlbiByZXNlcnZlZApbICAgMTcuMDE5MDU4XSBQQ0k6
IElnbm9yZSBib2d1cyByZXNvdXJjZSA2IFswOjBdIG9mIDAwMDA6MDA6MDIuMApbICAgMTcuMDE5
MTU0XSBQQ0k6IEJyaWRnZTogMDAwMDowMjowNy4wClsgICAxNy4wMTkyMzhdICAgSU8gd2luZG93
OiA0MDAwLTRmZmYKWyAgIDE3LjAxOTMxOF0gICBNRU0gd2luZG93OiBlMDMwMDAwMC1lMDNmZmZm
ZgpbICAgMTcuMDE5NDAzXSAgIFBSRUZFVENIIHdpbmRvdzogMzAwMDAwMDAtMzAwZmZmZmYKWyAg
IDE3LjAxOTQ5MV0gUENJOiBCcmlkZ2U6IDAwMDA6MDA6MWUuMApbICAgMTcuMDE5NTgwXSAgIElP
IHdpbmRvdzogMzAwMC00ZmZmClsgICAxNy4wMTk2NjldICAgTUVNIHdpbmRvdzogZTAyMDAwMDAt
ZTAzZmZmZmYKWyAgIDE3LjAxOTc1N10gICBQUkVGRVRDSCB3aW5kb3c6IDMwMDAwMDAwLTMwMWZm
ZmZmClsgICAxNy4wMTk4OTRdIFBDSTogU2V0dGluZyBsYXRlbmN5IHRpbWVyIG9mIGRldmljZSAw
MDAwOjAwOjFlLjAgdG8gNjQKWyAgIDE3LjAxOTk0NV0gTkVUOiBSZWdpc3RlcmVkIHByb3RvY29s
IGZhbWlseSAyClsgICAxNy4wMjk4OTZdIElQIHJvdXRlIGNhY2hlIGhhc2ggdGFibGUgZW50cmll
czogNDA5NiAob3JkZXI6IDIsIDE2Mzg0IGJ5dGVzKQpbICAgMTcuMDMwMTAzXSBUQ1AgZXN0YWJs
aXNoZWQgaGFzaCB0YWJsZSBlbnRyaWVzOiAxNjM4NCAob3JkZXI6IDUsIDEzMTA3MiBieXRlcykK
WyAgIDE3LjAzMDM3OF0gVENQIGJpbmQgaGFzaCB0YWJsZSBlbnRyaWVzOiA4MTkyIChvcmRlcjog
NCwgNjU1MzYgYnl0ZXMpClsgICAxNy4wMzA1NTFdIFRDUDogSGFzaCB0YWJsZXMgY29uZmlndXJl
ZCAoZXN0YWJsaXNoZWQgMTYzODQgYmluZCA4MTkyKQpbICAgMTcuMDMwNjQyXSBUQ1AgcmVubyBy
ZWdpc3RlcmVkClsgICAxNy4wMzMwMzVdIGNoZWNraW5nIGlmIGltYWdlIGlzIGluaXRyYW1mcy4u
LiBpdCBpcwpbICAgMTguMTI4MzEzXSBGcmVlaW5nIGluaXRyZCBtZW1vcnk6IDU5NjNrIGZyZWVk
ClsgICAxOC4xMjg5NDddIGF1ZGl0OiBpbml0aWFsaXppbmcgbmV0bGluayBzb2NrZXQgKGRpc2Fi
bGVkKQpbICAgMTguMTI5MDU5XSBhdWRpdCgxMTkwNjk0ODg5LjUzNzoxKTogaW5pdGlhbGl6ZWQK
WyAgIDE4LjEyOTI0OF0gSS1waXBlOiBEb21haW4gWGVub21haSByZWdpc3RlcmVkLgpbICAgMTgu
MTI5MzQzXSBYZW5vbWFpOiBoYWwveDg2IHN0YXJ0ZWQuClsgICAxOC4xMzI4MTNdIFhlbm9tYWk6
IHJlYWwtdGltZSBudWNsZXVzIHYyLjMuMyAoU3VtbWVyIFNvbmcpIGxvYWRlZC4KWyAgIDE4LjEz
MzAxMl0gWGVub21haTogU01JLWVuYWJsZWQgY2hpcHNldCBmb3VuZCBidXQgU01JIHdvcmthcm91
bmQgbm90IGVuYWJsZWQgKGNoZWNrClsgICAxOC4xMzMwMTZdICAgICAgICAgIENPTkZJR19YRU5P
X0hXX1NNSV9XT1JLQVJPVU5EKS4gWW91IG1heSBlbmNvdW50ZXIgaGlnaApbICAgMTguMTMzMDE5
XSAgICAgICAgICBpbnRlcnJ1cHQgbGF0ZW5jaWVzIQpbICAgMTguMTM0NDA0XSBYZW5vbWFpOiBz
dGFydGluZyBuYXRpdmUgQVBJIHNlcnZpY2VzLgpbICAgMTguMTM0NDkxXSBYZW5vbWFpOiBzdGFy
dGluZyBQT1NJWCBzZXJ2aWNlcy4KWyAgIDE4LjEzNDYyMF0gWGVub21haTogc3RhcnRpbmcgUlRE
TSBzZXJ2aWNlcy4KWyAgIDE4LjEzNDkwN10gVkZTOiBEaXNrIHF1b3RhcyBkcXVvdF82LjUuMQpb
ICAgMTguMTM1MDIxXSBEcXVvdC1jYWNoZSBoYXNoIHRhYmxlIGVudHJpZXM6IDEwMjQgKG9yZGVy
IDAsIDQwOTYgYnl0ZXMpClsgICAxOC4xMzUyNzVdIGlvIHNjaGVkdWxlciBub29wIHJlZ2lzdGVy
ZWQKWyAgIDE4LjEzNTQxN10gaW8gc2NoZWR1bGVyIGFudGljaXBhdG9yeSByZWdpc3RlcmVkClsg
ICAxOC4xMzU1NjBdIGlvIHNjaGVkdWxlciBkZWFkbGluZSByZWdpc3RlcmVkClsgICAxOC4xMzU3
MjldIGlvIHNjaGVkdWxlciBjZnEgcmVnaXN0ZXJlZCAoZGVmYXVsdCkKWyAgIDIzLjYzMjA3NF0g
MDAwMDowMDoxZC43IEVIQ0k6IEJJT1MgaGFuZG9mZiBmYWlsZWQgKEJJT1MgYnVnID8pIDAxMDEw
MDAxClsgICAyMy42MzI2MTBdIGlzYXBucDogU2Nhbm5pbmcgZm9yIFBuUCBjYXJkcy4uLgpbICAg
MjMuOTg5NTY3XSBpc2FwbnA6IE5vIFBsdWcgJiBQbGF5IGRldmljZSBmb3VuZApbICAgMjQuMDMx
MzE3XSBSZWFsIFRpbWUgQ2xvY2sgRHJpdmVyIHYxLjEyYWMKWyAgIDI0LjAzMTQzNV0gaW50ZWxf
cm5nOiBGV0ggbm90IGRldGVjdGVkClsgICAyNC4wMzE1MzBdIFNlcmlhbDogODI1MC8xNjU1MCBk
cml2ZXIgJFJldmlzaW9uOiAxLjkwICQgNCBwb3J0cywgSVJRIHNoYXJpbmcgZW5hYmxlZApbICAg
MjQuMDMxNzY4XSBzZXJpYWw4MjUwOiB0dHlTMCBhdCBJL08gMHgzZjggKGlycSA9IDQpIGlzIGEg
MTY1NTBBClsgICAyNC4wMzIwNDZdIHNlcmlhbDgyNTA6IHR0eVMxIGF0IEkvTyAweDJmOCAoaXJx
ID0gMykgaXMgYSAxNjU1MEEKWyAgIDI0LjAzMjMxN10gc2VyaWFsODI1MDogdHR5UzIgYXQgSS9P
IDB4M2U4IChpcnEgPSA0KSBpcyBhIDE2NTUwQQpbICAgMjQuMDMyNjAwXSBzZXJpYWw4MjUwOiB0
dHlTMyBhdCBJL08gMHgyZTggKGlycSA9IDMpIGlzIGEgMTY1NTBBClsgICAyNC4wMzQxOThdIFJB
TURJU0sgZHJpdmVyIGluaXRpYWxpemVkOiAxNiBSQU0gZGlza3Mgb2YgNjU1MzZLIHNpemUgMTAy
NCBibG9ja3NpemUKWyAgIDI0LjAzNDQ4Ml0gVW5pZm9ybSBNdWx0aS1QbGF0Zm9ybSBFLUlERSBk
cml2ZXIgUmV2aXNpb246IDcuMDBhbHBoYTIKWyAgIDI0LjAzNDU3Ml0gaWRlOiBBc3N1bWluZyAz
M01IeiBzeXN0ZW0gYnVzIHNwZWVkIGZvciBQSU8gbW9kZXM7IG92ZXJyaWRlIHdpdGggaWRlYnVz
PXh4ClsgICAyNC4wMzUwOTNdIFBOUDogUFMvMiBDb250cm9sbGVyIFtQTlAwMzAzXSBhdCAweDYw
LDB4NjQgaXJxIDEKWyAgIDI0LjAzNTE4MV0gUE5QOiBQUy8yIGNvbnRyb2xsZXIgZG9lc24ndCBo
YXZlIEFVWCBpcnE7IHVzaW5nIGRlZmF1bHQgMTIKWyAgIDI0LjAzODA2M10gc2VyaW86IGk4MDQy
IEtCRCBwb3J0IGF0IDB4NjAsMHg2NCBpcnEgMQpbICAgMjQuMDM4MTU1XSBzZXJpbzogaTgwNDIg
QVVYIHBvcnQgYXQgMHg2MCwweDY0IGlycSAxMgpbICAgMjQuMDM4NDI0XSBtaWNlOiBQUy8yIG1v
dXNlIGRldmljZSBjb21tb24gZm9yIGFsbCBtaWNlClsgICAyNC4wMzg2ODNdIEVJU0E6IFByb2Jp
bmcgYnVzIDAgYXQgZWlzYS4wClsgICAyNC4wMzg3NzVdIENhbm5vdCBhbGxvY2F0ZSByZXNvdXJj
ZSBmb3IgRUlTQSBzbG90IDEKWyAgIDI0LjAzODg3NV0gQ2Fubm90IGFsbG9jYXRlIHJlc291cmNl
IGZvciBFSVNBIHNsb3QgMgpbICAgMjQuMDM4OTYzXSBDYW5ub3QgYWxsb2NhdGUgcmVzb3VyY2Ug
Zm9yIEVJU0Egc2xvdCAzClsgICAyNC4wMzkwNTBdIENhbm5vdCBhbGxvY2F0ZSByZXNvdXJjZSBm
b3IgRUlTQSBzbG90IDQKWyAgIDI0LjAzOTE1OF0gRUlTQTogRGV0ZWN0ZWQgMCBjYXJkcy4KWyAg
IDI0LjAzOTM3Nl0gVENQIGN1YmljIHJlZ2lzdGVyZWQKWyAgIDI0LjAzOTQ3MF0gTkVUOiBSZWdp
c3RlcmVkIHByb3RvY29sIGZhbWlseSAxClsgICAyNC4wMzk1OTBdIFRlc3RpbmcgTk1JIHdhdGNo
ZG9nIC4uLiBPSy4KWyAgIDI0LjA0OTczNV0gVXNpbmcgSVBJIE5vLVNob3J0Y3V0IG1vZGUKWyAg
IDI0LjA0OTgzMl0gVGltZTogdHNjIGNsb2Nrc291cmNlIGhhcyBiZWVuIGluc3RhbGxlZC4KWyAg
IDI0LjA1MDEzMl0gRnJlZWluZyB1bnVzZWQga2VybmVsIG1lbW9yeTogMjY0ayBmcmVlZApbICAg
MjQuMDcyOTI4XSBpbnB1dDogQVQgVHJhbnNsYXRlZCBTZXQgMiBrZXlib2FyZCBhcyAvY2xhc3Mv
aW5wdXQvaW5wdXQwClsgICAyNS4xMTM0ODBdIHVzYmNvcmU6IHJlZ2lzdGVyZWQgbmV3IGludGVy
ZmFjZSBkcml2ZXIgdXNiZnMKWyAgIDI1LjExMzYwN10gdXNiY29yZTogcmVnaXN0ZXJlZCBuZXcg
aW50ZXJmYWNlIGRyaXZlciBodWIKWyAgIDI1LjExMzcyNl0gdXNiY29yZTogcmVnaXN0ZXJlZCBu
ZXcgZGV2aWNlIGRyaXZlciB1c2IKWyAgIDI1LjExNjEyM10gVVNCIFVuaXZlcnNhbCBIb3N0IENv
bnRyb2xsZXIgSW50ZXJmYWNlIGRyaXZlciB2My4wClsgICAyNS4xMTYyOTBdIFBDSTogc2V0dGlu
ZyBJUlEgNSBhcyBsZXZlbC10cmlnZ2VyZWQKWyAgIDI1LjExNjI5NV0gUENJOiBGb3VuZCBJUlEg
NSBmb3IgZGV2aWNlIDAwMDA6MDA6MWQuMApbICAgMjUuMTE2Mzg5XSBQQ0k6IFNoYXJpbmcgSVJR
IDUgd2l0aCAwMDAwOjAwOjAyLjAKWyAgIDI1LjExNjQ4OV0gUENJOiBTaGFyaW5nIElSUSA1IHdp
dGggMDAwMDowMjowMy4wClsgICAyNS4xMTY2MDBdIFBDSTogU2V0dGluZyBsYXRlbmN5IHRpbWVy
IG9mIGRldmljZSAwMDAwOjAwOjFkLjAgdG8gNjQKWyAgIDI1LjExNjYwNl0gdWhjaV9oY2QgMDAw
MDowMDoxZC4wOiBVSENJIEhvc3QgQ29udHJvbGxlcgpbICAgMjUuMTE2ODk2XSB1aGNpX2hjZCAw
MDAwOjAwOjFkLjA6IG5ldyBVU0IgYnVzIHJlZ2lzdGVyZWQsIGFzc2lnbmVkIGJ1cyBudW1iZXIg
MQpbICAgMjUuMTE3MDI3XSB1aGNpX2hjZCAwMDAwOjAwOjFkLjA6IGlycSA1LCBpbyBiYXNlIDB4
MDAwMDFjMDAKWyAgIDI1LjExNzI5Ml0gdXNiIHVzYjE6IGNvbmZpZ3VyYXRpb24gIzEgY2hvc2Vu
IGZyb20gMSBjaG9pY2UKWyAgIDI1LjExNzQxOV0gaHViIDEtMDoxLjA6IFVTQiBodWIgZm91bmQK
WyAgIDI1LjExNzUxMF0gaHViIDEtMDoxLjA6IDIgcG9ydHMgZGV0ZWN0ZWQKWyAgIDI1LjIxODY5
M10gUENJOiBzZXR0aW5nIElSUSAxNSBhcyBsZXZlbC10cmlnZ2VyZWQKWyAgIDI1LjIxODcwMV0g
UENJOiBGb3VuZCBJUlEgMTUgZm9yIGRldmljZSAwMDAwOjAwOjFkLjEKWyAgIDI1LjIxODgzNF0g
UENJOiBTZXR0aW5nIGxhdGVuY3kgdGltZXIgb2YgZGV2aWNlIDAwMDA6MDA6MWQuMSB0byA2NApb
ICAgMjUuMjE4ODQxXSB1aGNpX2hjZCAwMDAwOjAwOjFkLjE6IFVIQ0kgSG9zdCBDb250cm9sbGVy
ClsgICAyNS4yMTg5NjBdIHVoY2lfaGNkIDAwMDA6MDA6MWQuMTogbmV3IFVTQiBidXMgcmVnaXN0
ZXJlZCwgYXNzaWduZWQgYnVzIG51bWJlciAyClsgICAyNS4yMTkwOTRdIHVoY2lfaGNkIDAwMDA6
MDA6MWQuMTogaXJxIDE1LCBpbyBiYXNlIDB4MDAwMDIwMDAKWyAgIDI1LjIxOTM0M10gdXNiIHVz
YjI6IGNvbmZpZ3VyYXRpb24gIzEgY2hvc2VuIGZyb20gMSBjaG9pY2UKWyAgIDI1LjIxOTQ3OV0g
aHViIDItMDoxLjA6IFVTQiBodWIgZm91bmQKWyAgIDI1LjIxOTU3Ml0gaHViIDItMDoxLjA6IDIg
cG9ydHMgZGV0ZWN0ZWQKWyAgIDI1LjMyMzE5OV0gSUNINDogSURFIGNvbnRyb2xsZXIgYXQgUENJ
IHNsb3QgMDAwMDowMDoxZi4xClsgICAyNS4zMjMzMDNdIFBDSTogRW5hYmxpbmcgZGV2aWNlIDAw
MDA6MDA6MWYuMSAoMDAwNSAtPiAwMDA3KQpbICAgMjUuMzIzNDAwXSBQQ0k6IEZvdW5kIElSUSA5
IGZvciBkZXZpY2UgMDAwMDowMDoxZi4xClsgICAyNS4zMjM1MTNdIFBDSTogU2hhcmluZyBJUlEg
OSB3aXRoIDAwMDA6MDI6MDUuMApbICAgMjUuMzIzNjA5XSBJQ0g0OiBjaGlwc2V0IHJldmlzaW9u
IDIKWyAgIDI1LjMyMzY5NV0gSUNINDogbm90IDEwMCUgbmF0aXZlIG1vZGU6IHdpbGwgcHJvYmUg
aXJxcyBsYXRlcgpbICAgMjUuMzIzNzkzXSAgICAgaWRlMDogQk0tRE1BIGF0IDB4MjQwMC0weDI0
MDcsIEJJT1Mgc2V0dGluZ3M6IGhkYTpETUEsIGhkYjpwaW8KWyAgIDI1LjMyNDAzNV0gUHJvYmlu
ZyBJREUgaW50ZXJmYWNlIGlkZTAuLi4KWyAgIDI1LjQwMTA2NV0gZTEwMDogSW50ZWwoUikgUFJP
LzEwMCBOZXR3b3JrIERyaXZlciwgMy41LjE3LWsyLU5BUEkKWyAgIDI1LjQwMTE2N10gZTEwMDog
Q29weXJpZ2h0KGMpIDE5OTktMjAwNiBJbnRlbCBDb3Jwb3JhdGlvbgpbICAgMjUuNTg3MTExXSBo
ZGE6IFNBTVNVTkcgTVAwNDAySCwgQVRBIERJU0sgZHJpdmUKWyAgIDI2LjE5ODgyN10gaWRlMCBh
dCAweDFmMC0weDFmNywweDNmNiBvbiBpcnEgMTQKWyAgIDI2LjIxOTQwNV0gU0NTSSBzdWJzeXN0
ZW0gaW5pdGlhbGl6ZWQKWyAgIDI2LjIzNjE0OF0gbGliYXRhIHZlcnNpb24gMi4wMCBsb2FkZWQu
ClsgICAyNi4yNDk1MDJdIFBDSTogc2V0dGluZyBJUlEgNyBhcyBsZXZlbC10cmlnZ2VyZWQKWyAg
IDI2LjI0OTUxMl0gUENJOiBGb3VuZCBJUlEgNyBmb3IgZGV2aWNlIDAwMDA6MDA6MWQuNwpbICAg
MjYuMjQ5Njc5XSBQQ0k6IFNldHRpbmcgbGF0ZW5jeSB0aW1lciBvZiBkZXZpY2UgMDAwMDowMDox
ZC43IHRvIDY0ClsgICAyNi4yNDk2ODZdIGVoY2lfaGNkIDAwMDA6MDA6MWQuNzogRUhDSSBIb3N0
IENvbnRyb2xsZXIKWyAgIDI2LjI0OTgzMV0gZWhjaV9oY2QgMDAwMDowMDoxZC43OiBuZXcgVVNC
IGJ1cyByZWdpc3RlcmVkLCBhc3NpZ25lZCBidXMgbnVtYmVyIDMKWyAgIDI2LjI0OTk4MF0gZWhj
aV9oY2QgMDAwMDowMDoxZC43OiBkZWJ1ZyBwb3J0IDEKWyAgIDI2LjI1MDA3MF0gUENJOiBjYWNo
ZSBsaW5lIHNpemUgb2YgMzIgaXMgbm90IHN1cHBvcnRlZCBieSBkZXZpY2UgMDAwMDowMDoxZC43
ClsgICAyNi4yNTAwODVdIGVoY2lfaGNkIDAwMDA6MDA6MWQuNzogaXJxIDcsIGlvIG1lbSAweGUw
MTAwMDAwClsgICAyNi4yNTQwNjZdIGVoY2lfaGNkIDAwMDA6MDA6MWQuNzogVVNCIDIuMCBzdGFy
dGVkLCBFSENJIDEuMDAsIGRyaXZlciAxMCBEZWMgMjAwNApbICAgMjYuMjU0MzE0XSB1c2IgdXNi
MzogY29uZmlndXJhdGlvbiAjMSBjaG9zZW4gZnJvbSAxIGNob2ljZQpbICAgMjYuMjU0NDQwXSBo
dWIgMy0wOjEuMDogVVNCIGh1YiBmb3VuZApbICAgMjYuMjU0NTM0XSBodWIgMy0wOjEuMDogNCBw
b3J0cyBkZXRlY3RlZApbICAgMjYuMjY5MDI3XSBoZGE6IG1heCByZXF1ZXN0IHNpemU6IDUxMktp
QgpbICAgMjYuMzU1ODQxXSBQQ0k6IEZvdW5kIElSUSA5IGZvciBkZXZpY2UgMDAwMDowMjowNC4w
ClsgICAyNi4zNTU5NTRdIFBDSTogU2hhcmluZyBJUlEgOSB3aXRoIDAwMDA6MDA6MWYuMwpbICAg
MjYuMzc5NDQxXSBlMTAwOiBldGgwOiBlMTAwX3Byb2JlOiBhZGRyIDB4ZTAyMTkwMDAsIGlycSA5
LCBNQUMgYWRkciAwMDowMDo1QjowMDpGOTo2RApbICAgMjYuMzc5NTgxXSBQQ0k6IEZvdW5kIElS
USAxNSBmb3IgZGV2aWNlIDAwMDA6MDI6MDguMApbICAgMjYuNDAzMjEwXSBlMTAwOiBldGgxOiBl
MTAwX3Byb2JlOiBhZGRyIDB4ZTAyMWEwMDAsIGlycSAxNSwgTUFDIGFkZHIgMDA6RTA6NEI6MTk6
QzQ6NDgKWyAgIDI2LjQyODk2OF0gZTEwMDogZXRoMjogZTEwMF9wcm9iZTogYWRkciAweGUwMzQw
MDAwLCBpcnEgMTUsIE1BQyBhZGRyIDAwOjAwOjVCOjAwOkY5OjZFClsgICAyNi40NTQ3MTZdIGUx
MDA6IGV0aDM6IGUxMDBfcHJvYmU6IGFkZHIgMHhlMDM0MTAwMCwgaXJxIDUsIE1BQyBhZGRyIDAw
OjAwOjVCOjAwOkY5OjZGClsgICAyNi42NjAzNzJdIHVzYiAzLTI6IG5ldyBoaWdoIHNwZWVkIFVT
QiBkZXZpY2UgdXNpbmcgZWhjaV9oY2QgYW5kIGFkZHJlc3MgMgpbICAgMjYuNzM4MzA5XSBoZGE6
IDc4MjQyOTc2IHNlY3RvcnMgKDQwMDYwIE1CKSB3LzgxOTJLaUIgQ2FjaGUsIENIUz0xNjM4My8y
NTUvNjMsIFVETUEoMzMpClsgICAyNi43MzkwNjldIGhkYTogY2FjaGUgZmx1c2hlcyBzdXBwb3J0
ZWQKWyAgIDI2LjczOTIxNV0gIGhkYTogaGRhMSBoZGEyIDwgaGRhNSA+ClsgICAyNi43NzUzMTVd
IHVzYiAzLTI6IGNvbmZpZ3VyYXRpb24gIzEgY2hvc2VuIGZyb20gMSBjaG9pY2UKWyAgIDI2Ljk4
MTE5Nl0gdXNiIDMtNDogbmV3IGhpZ2ggc3BlZWQgVVNCIGRldmljZSB1c2luZyBlaGNpX2hjZCBh
bmQgYWRkcmVzcyAzClsgICAyNy4wODkyMjJdIEVYVDMtZnM6IElORk86IHJlY292ZXJ5IHJlcXVp
cmVkIG9uIHJlYWRvbmx5IGZpbGVzeXN0ZW0uClsgICAyNy4wODkzNDBdIEVYVDMtZnM6IHdyaXRl
IGFjY2VzcyB3aWxsIGJlIGVuYWJsZWQgZHVyaW5nIHJlY292ZXJ5LgpbICAgMjcuMTQ1NzIxXSB1
c2IgMy00OiBjb25maWd1cmF0aW9uICMyIGNob3NlbiBmcm9tIDEgY2hvaWNlClsgICAyNy4xNDYy
ODldIHVzYmNvcmU6IHJlZ2lzdGVyZWQgbmV3IGludGVyZmFjZSBkcml2ZXIgbGlidXN1YWwKWyAg
IDI3LjE1NDk2N10gSW5pdGlhbGl6aW5nIFVTQiBNYXNzIFN0b3JhZ2UgZHJpdmVyLi4uClsgICAy
Ny4yNTAxNzRdIHNjc2kwIDogU0NTSSBlbXVsYXRpb24gZm9yIFVTQiBNYXNzIFN0b3JhZ2UgZGV2
aWNlcwpbICAgMjcuMjUwMzgzXSB1c2Itc3RvcmFnZTogZGV2aWNlIGZvdW5kIGF0IDIKWyAgIDI3
LjI1MDM4N10gdXNiLXN0b3JhZ2U6IHdhaXRpbmcgZm9yIGRldmljZSB0byBzZXR0bGUgYmVmb3Jl
IHNjYW5uaW5nClsgICAyNy4yNTA0MThdIHNjc2kxIDogU0NTSSBlbXVsYXRpb24gZm9yIFVTQiBN
YXNzIFN0b3JhZ2UgZGV2aWNlcwpbICAgMjcuMjUwNTY4XSB1c2Jjb3JlOiByZWdpc3RlcmVkIG5l
dyBpbnRlcmZhY2UgZHJpdmVyIHVzYi1zdG9yYWdlClsgICAyNy4yNTA2NThdIFVTQiBNYXNzIFN0
b3JhZ2Ugc3VwcG9ydCByZWdpc3RlcmVkLgpbICAgMjcuMjUwOTA4XSB1c2Itc3RvcmFnZTogZGV2
aWNlIGZvdW5kIGF0IDMKWyAgIDI3LjI1MDkxMl0gdXNiLXN0b3JhZ2U6IHdhaXRpbmcgZm9yIGRl
dmljZSB0byBzZXR0bGUgYmVmb3JlIHNjYW5uaW5nClsgICAyNy4yNjEzNzldIGtqb3VybmFsZCBz
dGFydGluZy4gIENvbW1pdCBpbnRlcnZhbCA1IHNlY29uZHMKWyAgIDI3LjI2MTQ4OF0gRVhUMy1m
czogcmVjb3ZlcnkgY29tcGxldGUuClsgICAyNy4yNjE5NjldIEVYVDMtZnM6IG1vdW50ZWQgZmls
ZXN5c3RlbSB3aXRoIG9yZGVyZWQgZGF0YSBtb2RlLgpbICAgMzIuMjQ3OTM0XSBzY3NpIDA6MDow
OjA6IERpcmVjdC1BY2Nlc3MgICAgIENCTSAgICAgIEZsYXNoIERpc2sgICAgICAgNC4wMCBQUTog
MCBBTlNJOiAyClsgICAzMi4yNDg1MzJdIHVzYi1zdG9yYWdlOiBkZXZpY2Ugc2NhbiBjb21wbGV0
ZQpbICAgMzIuMzQ5MTY0XSB1c2IgMy00OiByZXNldCBoaWdoIHNwZWVkIFVTQiBkZXZpY2UgdXNp
bmcgZWhjaV9oY2QgYW5kIGFkZHJlc3MgMwpbICAgMzIuNDUxMTA1XSB1c2IgMy00OiBkZXZpY2Ug
ZGVzY3JpcHRvciByZWFkLzY0LCBlcnJvciAtNzEKWyAgIDMyLjY1NDk4OV0gdXNiIDMtNDogZGV2
aWNlIGRlc2NyaXB0b3IgcmVhZC82NCwgZXJyb3IgLTcxClsgICAzMi44NTc4NzVdIHVzYiAzLTQ6
IHJlc2V0IGhpZ2ggc3BlZWQgVVNCIGRldmljZSB1c2luZyBlaGNpX2hjZCBhbmQgYWRkcmVzcyAz
ClsgICAzMi45NjA4MTZdIHVzYiAzLTQ6IGRldmljZSBkZXNjcmlwdG9yIHJlYWQvNjQsIGVycm9y
IC03MQpbICAgMzMuMTY0NzAxXSB1c2IgMy00OiBkZXZpY2UgZGVzY3JpcHRvciByZWFkLzY0LCBl
cnJvciAtNzEKWyAgIDMzLjM2NzU4OF0gdXNiIDMtNDogcmVzZXQgaGlnaCBzcGVlZCBVU0IgZGV2
aWNlIHVzaW5nIGVoY2lfaGNkIGFuZCBhZGRyZXNzIDMKWyAgIDMzLjUwMTUxMl0gdXNiIDMtNDog
cmVzZXQgaGlnaCBzcGVlZCBVU0IgZGV2aWNlIHVzaW5nIGVoY2lfaGNkIGFuZCBhZGRyZXNzIDMK
WyAgIDMzLjYwMzQ1M10gdXNiIDMtNDogZGV2aWNlIGRlc2NyaXB0b3IgcmVhZC82NCwgZXJyb3Ig
LTcxClsgICAzMy44MDYzMzldIHVzYiAzLTQ6IGRldmljZSBkZXNjcmlwdG9yIHJlYWQvNjQsIGVy
cm9yIC03MQpbICAgMzQuMDA5MjI2XSB1c2IgMy00OiByZXNldCBoaWdoIHNwZWVkIFVTQiBkZXZp
Y2UgdXNpbmcgZWhjaV9oY2QgYW5kIGFkZHJlc3MgMwpbICAgMzQuMTE0MTY2XSB1c2IgMy00OiBk
ZXZpY2UgZGVzY3JpcHRvciByZWFkLzY0LCBlcnJvciAtNzEKWyAgIDM0LjMxNzA1MV0gdXNiIDMt
NDogZGV2aWNlIGRlc2NyaXB0b3IgcmVhZC82NCwgZXJyb3IgLTcxClsgICAzNC41MTk5MzhdIHVz
YiAzLTQ6IHJlc2V0IGhpZ2ggc3BlZWQgVVNCIGRldmljZSB1c2luZyBlaGNpX2hjZCBhbmQgYWRk
cmVzcyAzClsgICAzNC42NTI4NjNdIHVzYiAzLTQ6IHJlc2V0IGhpZ2ggc3BlZWQgVVNCIGRldmlj
ZSB1c2luZyBlaGNpX2hjZCBhbmQgYWRkcmVzcyAzClsgICAzNC43NTU4MDNdIHVzYiAzLTQ6IGRl
dmljZSBkZXNjcmlwdG9yIHJlYWQvNjQsIGVycm9yIC03MQpbICAgMzQuOTU5Njg4XSB1c2IgMy00
OiBkZXZpY2UgZGVzY3JpcHRvciByZWFkLzY0LCBlcnJvciAtNzEKWyAgIDM1LjE2MjU4N10gdXNi
IDMtNDogcmVzZXQgaGlnaCBzcGVlZCBVU0IgZGV2aWNlIHVzaW5nIGVoY2lfaGNkIGFuZCBhZGRy
ZXNzIDMKWyAgIDM1LjI2NDUyMF0gdXNiIDMtNDogZGV2aWNlIGRlc2NyaXB0b3IgcmVhZC82NCwg
ZXJyb3IgLTcxClsgICAzNS40Njc0MjFdIHVzYiAzLTQ6IGRldmljZSBkZXNjcmlwdG9yIHJlYWQv
NjQsIGVycm9yIC03MQpbICAgMzUuNjcwMjk5XSB1c2IgMy00OiByZXNldCBoaWdoIHNwZWVkIFVT
QiBkZXZpY2UgdXNpbmcgZWhjaV9oY2QgYW5kIGFkZHJlc3MgMwpbICAgMzUuODA0MjIxXSB1c2Ig
My00OiByZXNldCBoaWdoIHNwZWVkIFVTQiBkZXZpY2UgdXNpbmcgZWhjaV9oY2QgYW5kIGFkZHJl
c3MgMwpbICAgMzUuOTA2MTYxXSB1c2IgMy00OiBkZXZpY2UgZGVzY3JpcHRvciByZWFkLzY0LCBl
cnJvciAtNzEKWyAgIDM2LjEwOTA1Ml0gdXNiIDMtNDogZGV2aWNlIGRlc2NyaXB0b3IgcmVhZC82
NCwgZXJyb3IgLTcxClsgICAzNi4zMTE5NTVdIHVzYiAzLTQ6IHJlc2V0IGhpZ2ggc3BlZWQgVVNC
IGRldmljZSB1c2luZyBlaGNpX2hjZCBhbmQgYWRkcmVzcyAzClsgICAzNi40MTQ4OThdIHVzYiAz
LTQ6IGRldmljZSBkZXNjcmlwdG9yIHJlYWQvNjQsIGVycm9yIC03MQpbICAgMzYuNDc1MDQ3XSBl
MTAwOiBldGgwOiBlMTAwX3dhdGNoZG9nOiBsaW5rIHVwLCAxMDBNYnBzLCBmdWxsLWR1cGxleApb
ICAgMzYuNjE4ODU5XSB1c2IgMy00OiBkZXZpY2UgZGVzY3JpcHRvciByZWFkLzY0LCBlcnJvciAt
NzEKWyAgIDM2LjgyMTY2MF0gdXNiIDMtNDogcmVzZXQgaGlnaCBzcGVlZCBVU0IgZGV2aWNlIHVz
aW5nIGVoY2lfaGNkIGFuZCBhZGRyZXNzIDMKWyAgIDM2Ljg1NDI3Ml0gdXNiLXN0b3JhZ2U6IGRl
dmljZSBzY2FuIGNvbXBsZXRlClsgICAzNy44MzY3NzRdIE5FVDogUmVnaXN0ZXJlZCBwcm90b2Nv
bCBmYW1pbHkgMTcKWyAgIDM4Ljg2Nzk3NF0gcGNpX2hvdHBsdWc6IFBDSSBIb3QgUGx1ZyBQQ0kg
Q29yZSB2ZXJzaW9uOiAwLjUKWyAgIDM4Ljg3NzExNl0gc2hwY2hwOiBTdGFuZGFyZCBIb3QgUGx1
ZyBQQ0kgQ29udHJvbGxlciBEcml2ZXIgdmVyc2lvbjogMC40ClsgICAzOS42OTQ3MjRdIExpbnV4
IGFncGdhcnQgaW50ZXJmYWNlIHYwLjEwMSAoYykgRGF2ZSBKb25lcwpbICAgMzkuNzMxOTM3XSBh
Z3BnYXJ0OiBEZXRlY3RlZCBhbiBJbnRlbCA4NTUgQ2hpcHNldC4KWyAgIDM5LjczMjM1MF0gYWdw
Z2FydDogRGV0ZWN0ZWQgODA2MEsgc3RvbGVuIG1lbW9yeS4KWyAgIDM5Ljc0NDQwMl0gYWdwZ2Fy
dDogQUdQIGFwZXJ0dXJlIGlzIDEyOE0gQCAweGU4MDAwMDAwClsgICAzOS45ODQ5MTZdIGlucHV0
OiBHZW5QUy8yIEdlbml1cyBNb3VzZSBhcyAvY2xhc3MvaW5wdXQvaW5wdXQxClsgICA0MC4zNjMw
MzBdIFNDU0kgZGV2aWNlIHNkYTogMjQ5MDg3IDUxMi1ieXRlIGhkd3Igc2VjdG9ycyAoMTI4IE1C
KQpbICAgNDAuNTA2MzczXSBzZGE6IFdyaXRlIFByb3RlY3QgaXMgb2ZmClsgICA0MC41MDY0NjRd
IHNkYTogTW9kZSBTZW5zZTogMDAgMDAgMDAgMDAKWyAgIDQwLjUwNjQ2OV0gc2RhOiBhc3N1bWlu
ZyBkcml2ZSBjYWNoZTogd3JpdGUgdGhyb3VnaApbICAgNDAuNjI2MjM4XSBTQ1NJIGRldmljZSBz
ZGE6IDI0OTA4NyA1MTItYnl0ZSBoZHdyIHNlY3RvcnMgKDEyOCBNQikKWyAgIDQwLjYzOTA2NV0g
c2RhOiBXcml0ZSBQcm90ZWN0IGlzIG9mZgpbICAgNDAuNjM5MTUyXSBzZGE6IE1vZGUgU2Vuc2U6
IDAwIDAwIDAwIDAwClsgICA0MC42MzkxNTZdIHNkYTogYXNzdW1pbmcgZHJpdmUgY2FjaGU6IHdy
aXRlIHRocm91Z2gKWyAgIDQwLjYzOTI0Nl0gIHNkYTogc2RhMQpbICAgNDAuNjQxMDkwXSBzZCAw
OjA6MDowOiBBdHRhY2hlZCBzY3NpIHJlbW92YWJsZSBkaXNrIHNkYQpbICAgNDAuNjY2ODkwXSBz
ZCAwOjA6MDowOiBBdHRhY2hlZCBzY3NpIGdlbmVyaWMgc2cwIHR5cGUgMApbICAgNDAuODUxNTg1
XSBmdXNlIGluaXQgKEFQSSB2ZXJzaW9uIDcuOCkKWyAgIDQwLjkyMzg1Nl0gbHA6IGRyaXZlciBs
b2FkZWQgYnV0IG5vIGRldmljZXMgZm91bmQKWyAgIDQwLjk5NTE3NF0gQWRkaW5nIDE0Nzc5NDBr
IHN3YXAgb24gL2Rldi9kaXNrL2J5LXV1aWQvYTg0NGZlZWQtOTVhOC00NzgwLTlmNzItNWM3MjVj
MTQxMjc4LiAgUHJpb3JpdHk6LTEgZXh0ZW50czoxIGFjcm9zczoxNDc3OTQwawpbICAgNDEuMTI1
ODIzXSBFWFQzIEZTIG9uIGhkYTEsIGludGVybmFsIGpvdXJuYWwKWyAgIDQxLjI4ODc5MF0gTkVU
OiBSZWdpc3RlcmVkIHByb3RvY29sIGZhbWlseSAxMApbICAgNDEuMjg4OTQ5XSBsbzogRGlzYWJs
ZWQgUHJpdmFjeSBFeHRlbnNpb25zClsgICA0MS4yODkxNDldIEFERFJDT05GKE5FVERFVl9VUCk6
IGV0aDE6IGxpbmsgaXMgbm90IHJlYWR5ClsgICA0MS4yODkxNTRdIEFERFJDT05GKE5FVERFVl9V
UCk6IGV0aDI6IGxpbmsgaXMgbm90IHJlYWR5ClsgICA0MS4yODkxNThdIEFERFJDT05GKE5FVERF
Vl9VUCk6IGV0aDM6IGxpbmsgaXMgbm90IHJlYWR5ClsgICA1Mi4wNDUwNDRdIGV0aDA6IG5vIElQ
djYgcm91dGVycyBwcmVzZW50ClsgMTU5NS42MjYyNjJdIENhcGFiaWxpdHkgTFNNIGluaXRpYWxp
emVkClsgMTU5Ni43MTUxMjFdIHBwZGV2OiB1c2VyLXNwYWNlIHBhcmFsbGVsIHBvcnQgZHJpdmVy
ClsgMTU5Ny44MDQzNTldIFtkcm1dIEluaXRpYWxpemVkIGRybSAxLjEuMCAyMDA2MDgxMApbIDE1
OTcuODI4MDc5XSBQQ0k6IEZvdW5kIElSUSA1IGZvciBkZXZpY2UgMDAwMDowMDowMi4wClsgMTU5
Ny44Mjg0NjNdIFBDSTogU2hhcmluZyBJUlEgNSB3aXRoIDAwMDA6MDA6MWQuMApbIDE1OTcuODI4
NzA3XSBQQ0k6IFNoYXJpbmcgSVJRIDUgd2l0aCAwMDAwOjAyOjAzLjAKWyAxNTk3LjgyOTUyOV0g
W2RybV0gSW5pdGlhbGl6ZWQgaTkxNSAxLjYuMCAyMDA2MDExOSBvbiBtaW5vciAwClsgMTU5Ny44
MzAzMjRdIFtkcm1dIEluaXRpYWxpemVkIGk5MTUgMS42LjAgMjAwNjAxMTkgb24gbWlub3IgMQpb
IDE2MDEuNjE4ODU1XSBCbHVldG9vdGg6IENvcmUgdmVyIDIuMTEKWyAxNjAxLjYxOTM5Ml0gTkVU
OiBSZWdpc3RlcmVkIHByb3RvY29sIGZhbWlseSAzMQpbIDE2MDEuNjE5Mzk4XSBCbHVldG9vdGg6
IEhDSSBkZXZpY2UgYW5kIGNvbm5lY3Rpb24gbWFuYWdlciBpbml0aWFsaXplZApbIDE2MDEuNjE5
NDA0XSBCbHVldG9vdGg6IEhDSSBzb2NrZXQgbGF5ZXIgaW5pdGlhbGl6ZWQKWyAxNjAxLjcyMTY3
M10gQmx1ZXRvb3RoOiBMMkNBUCB2ZXIgMi44ClsgMTYwMS43MjE2ODBdIEJsdWV0b290aDogTDJD
QVAgc29ja2V0IGxheWVyIGluaXRpYWxpemVkClsgMTYwMS43OTA2NzRdIEJsdWV0b290aDogUkZD
T01NIHNvY2tldCBsYXllciBpbml0aWFsaXplZApbIDE2MDEuNzkwNjkzXSBCbHVldG9vdGg6IFJG
Q09NTSBUVFkgbGF5ZXIgaW5pdGlhbGl6ZWQKWyAxNjAxLjc5MDY5N10gQmx1ZXRvb3RoOiBSRkNP
TU0gdmVyIDEuOApbIDE2MTEuNDIyNTExXSBldGgwOiBubyBJUHY2IHJvdXRlcnMgcHJlc2VudAo=

--0__=4EBBF9F3DFADB5BF8f9e8a93df938690918c4EBBF9F3DFADB5BF
Content-type: application/octet-stream; 
	name="boot_without_lapic_equ_1.txt"
Content-Disposition: attachment; filename="boot_without_lapic_equ_1.txt"
Content-ID: <2__=4EBBF9F3DFADB5BF8f9e8a93df938@domain.hid>
Content-transfer-encoding: base64

WyAgICAwLjAwMDAwMF0gTGludXggdmVyc2lvbiAyLjYuMjAuMTktYWRlb3MteGVub21haTIuMy4w
IChyb290QGduY3UtZGVza3RvcCkgKGdjYyB2ZXJzaW9uIDQuMS4yIChVYnVudHUgNC4xLjItMHVi
dW50dTQpKSAjMSBTTVAgTW9uIFNlcCAyNCAxMjowMjozNyBDRVNUIDIwMDcKWyAgICAwLjAwMDAw
MF0gQklPUy1wcm92aWRlZCBwaHlzaWNhbCBSQU0gbWFwOgpbICAgIDAuMDAwMDAwXSBzYW5pdGl6
ZSBzdGFydApbICAgIDAuMDAwMDAwXSBzYW5pdGl6ZSBlbmQKWyAgICAwLjAwMDAwMF0gY29weV9l
ODIwX21hcCgpIHN0YXJ0OiAwMDAwMDAwMDAwMDAwMDAwIHNpemU6IDAwMDAwMDAwMDAwOWY4MDAg
ZW5kOiAwMDAwMDAwMDAwMDlmODAwIHR5cGU6IDEKWyAgICAwLjAwMDAwMF0gY29weV9lODIwX21h
cCgpIHR5cGUgaXMgRTgyMF9SQU0KWyAgICAwLjAwMDAwMF0gY29weV9lODIwX21hcCgpIHN0YXJ0
OiAwMDAwMDAwMDAwMDlmODAwIHNpemU6IDAwMDAwMDAwMDAwMDA4MDAgZW5kOiAwMDAwMDAwMDAw
MGEwMDAwIHR5cGU6IDIKWyAgICAwLjAwMDAwMF0gY29weV9lODIwX21hcCgpIHN0YXJ0OiAwMDAw
MDAwMDAwMGNlMDAwIHNpemU6IDAwMDAwMDAwMDAwMDIwMDAgZW5kOiAwMDAwMDAwMDAwMGQwMDAw
IHR5cGU6IDIKWyAgICAwLjAwMDAwMF0gY29weV9lODIwX21hcCgpIHN0YXJ0OiAwMDAwMDAwMDAw
MGUwMDAwIHNpemU6IDAwMDAwMDAwMDAwMjAwMDAgZW5kOiAwMDAwMDAwMDAwMTAwMDAwIHR5cGU6
IDIKWyAgICAwLjAwMDAwMF0gY29weV9lODIwX21hcCgpIHN0YXJ0OiAwMDAwMDAwMDAwMTAwMDAw
IHNpemU6IDAwMDAwMDAwMWY1ZTAwMDAgZW5kOiAwMDAwMDAwMDFmNmUwMDAwIHR5cGU6IDEKWyAg
ICAwLjAwMDAwMF0gY29weV9lODIwX21hcCgpIHR5cGUgaXMgRTgyMF9SQU0KWyAgICAwLjAwMDAw
MF0gY29weV9lODIwX21hcCgpIHN0YXJ0OiAwMDAwMDAwMDFmNmUwMDAwIHNpemU6IDAwMDAwMDAw
MDAwMGEwMDAgZW5kOiAwMDAwMDAwMDFmNmVhMDAwIHR5cGU6IDMKWyAgICAwLjAwMDAwMF0gY29w
eV9lODIwX21hcCgpIHN0YXJ0OiAwMDAwMDAwMDFmNmVhMDAwIHNpemU6IDAwMDAwMDAwMDAwMTYw
MDAgZW5kOiAwMDAwMDAwMDFmNzAwMDAwIHR5cGU6IDQKWyAgICAwLjAwMDAwMF0gY29weV9lODIw
X21hcCgpIHN0YXJ0OiAwMDAwMDAwMDFmNzAwMDAwIHNpemU6IDAwMDAwMDAwMDA5MDAwMDAgZW5k
OiAwMDAwMDAwMDIwMDAwMDAwIHR5cGU6IDIKWyAgICAwLjAwMDAwMF0gY29weV9lODIwX21hcCgp
IHN0YXJ0OiAwMDAwMDAwMGZlYzEwMDAwIHNpemU6IDAwMDAwMDAwMDAwMTAwMDAgZW5kOiAwMDAw
MDAwMGZlYzIwMDAwIHR5cGU6IDIKWyAgICAwLjAwMDAwMF0gY29weV9lODIwX21hcCgpIHN0YXJ0
OiAwMDAwMDAwMGZmODAwMDAwIHNpemU6IDAwMDAwMDAwMDA0MDAwMDAgZW5kOiAwMDAwMDAwMGZm
YzAwMDAwIHR5cGU6IDIKWyAgICAwLjAwMDAwMF0gY29weV9lODIwX21hcCgpIHN0YXJ0OiAwMDAw
MDAwMGZmZmZmYzAwIHNpemU6IDAwMDAwMDAwMDAwMDA0MDAgZW5kOiAwMDAwMDAwMTAwMDAwMDAw
IHR5cGU6IDIKWyAgICAwLjAwMDAwMF0gIEJJT1MtZTgyMDogMDAwMDAwMDAwMDAwMDAwMCAtIDAw
MDAwMDAwMDAwOWY4MDAgKHVzYWJsZSkKWyAgICAwLjAwMDAwMF0gIEJJT1MtZTgyMDogMDAwMDAw
MDAwMDA5ZjgwMCAtIDAwMDAwMDAwMDAwYTAwMDAgKHJlc2VydmVkKQpbICAgIDAuMDAwMDAwXSAg
QklPUy1lODIwOiAwMDAwMDAwMDAwMGNlMDAwIC0gMDAwMDAwMDAwMDBkMDAwMCAocmVzZXJ2ZWQp
ClsgICAgMC4wMDAwMDBdICBCSU9TLWU4MjA6IDAwMDAwMDAwMDAwZTAwMDAgLSAwMDAwMDAwMDAw
MTAwMDAwIChyZXNlcnZlZCkKWyAgICAwLjAwMDAwMF0gIEJJT1MtZTgyMDogMDAwMDAwMDAwMDEw
MDAwMCAtIDAwMDAwMDAwMWY2ZTAwMDAgKHVzYWJsZSkKWyAgICAwLjAwMDAwMF0gIEJJT1MtZTgy
MDogMDAwMDAwMDAxZjZlMDAwMCAtIDAwMDAwMDAwMWY2ZWEwMDAgKEFDUEkgZGF0YSkKWyAgICAw
LjAwMDAwMF0gIEJJT1MtZTgyMDogMDAwMDAwMDAxZjZlYTAwMCAtIDAwMDAwMDAwMWY3MDAwMDAg
KEFDUEkgTlZTKQpbICAgIDAuMDAwMDAwXSAgQklPUy1lODIwOiAwMDAwMDAwMDFmNzAwMDAwIC0g
MDAwMDAwMDAyMDAwMDAwMCAocmVzZXJ2ZWQpClsgICAgMC4wMDAwMDBdICBCSU9TLWU4MjA6IDAw
MDAwMDAwZmVjMTAwMDAgLSAwMDAwMDAwMGZlYzIwMDAwIChyZXNlcnZlZCkKWyAgICAwLjAwMDAw
MF0gIEJJT1MtZTgyMDogMDAwMDAwMDBmZjgwMDAwMCAtIDAwMDAwMDAwZmZjMDAwMDAgKHJlc2Vy
dmVkKQpbICAgIDAuMDAwMDAwXSAgQklPUy1lODIwOiAwMDAwMDAwMGZmZmZmYzAwIC0gMDAwMDAw
MDEwMDAwMDAwMCAocmVzZXJ2ZWQpClsgICAgMC4wMDAwMDBdIDBNQiBISUdITUVNIGF2YWlsYWJs
ZS4KWyAgICAwLjAwMDAwMF0gNTAyTUIgTE9XTUVNIGF2YWlsYWJsZS4KWyAgICAwLjAwMDAwMF0g
RW50ZXJpbmcgYWRkX2FjdGl2ZV9yYW5nZSgwLCAwLCAxMjg3MzYpIDAgZW50cmllcyBvZiAyNTYg
dXNlZApbICAgIDAuMDAwMDAwXSBab25lIFBGTiByYW5nZXM6ClsgICAgMC4wMDAwMDBdICAgRE1B
ICAgICAgICAgICAgIDAgLT4gICAgIDQwOTYKWyAgICAwLjAwMDAwMF0gICBOb3JtYWwgICAgICAg
NDA5NiAtPiAgIDEyODczNgpbICAgIDAuMDAwMDAwXSAgIEhpZ2hNZW0gICAgMTI4NzM2IC0+ICAg
MTI4NzM2ClsgICAgMC4wMDAwMDBdIGVhcmx5X25vZGVfbWFwWzFdIGFjdGl2ZSBQRk4gcmFuZ2Vz
ClsgICAgMC4wMDAwMDBdICAgICAwOiAgICAgICAgMCAtPiAgIDEyODczNgpbICAgIDAuMDAwMDAw
XSBPbiBub2RlIDAgdG90YWxwYWdlczogMTI4NzM2ClsgICAgMC4wMDAwMDBdICAgRE1BIHpvbmU6
IDMyIHBhZ2VzIHVzZWQgZm9yIG1lbW1hcApbICAgIDAuMDAwMDAwXSAgIERNQSB6b25lOiAwIHBh
Z2VzIHJlc2VydmVkClsgICAgMC4wMDAwMDBdICAgRE1BIHpvbmU6IDQwNjQgcGFnZXMsIExJRk8g
YmF0Y2g6MApbICAgIDAuMDAwMDAwXSAgIE5vcm1hbCB6b25lOiA5NzMgcGFnZXMgdXNlZCBmb3Ig
bWVtbWFwClsgICAgMC4wMDAwMDBdICAgTm9ybWFsIHpvbmU6IDEyMzY2NyBwYWdlcywgTElGTyBi
YXRjaDozMQpbICAgIDAuMDAwMDAwXSAgIEhpZ2hNZW0gem9uZTogMCBwYWdlcyB1c2VkIGZvciBt
ZW1tYXAKWyAgICAwLjAwMDAwMF0gRE1JIG5vdCBwcmVzZW50IG9yIGludmFsaWQuClsgICAgMC4w
MDAwMDBdIEFsbG9jYXRpbmcgUENJIHJlc291cmNlcyBzdGFydGluZyBhdCAzMDAwMDAwMCAoZ2Fw
OiAyMDAwMDAwMDpkZWMxMDAwMCkKWyAgICAwLjAwMDAwMF0gRGV0ZWN0ZWQgODk3LjE1NyBNSHog
cHJvY2Vzc29yLgpbICAgMTYuNzk2ODU5XSBCdWlsdCAxIHpvbmVsaXN0cy4gIFRvdGFsIHBhZ2Vz
OiAxMjc3MzEKWyAgIDE2Ljc5Njg2N10gS2VybmVsIGNvbW1hbmQgbGluZTogcm9vdD1VVUlEPWUx
MDdhOTk4LTYwOWItNGM2My1iZGQyLTQwODhiZTllMzExYiBybyBzaW5nbGUKWyAgIDE2Ljc5NzQw
Nl0gTG9jYWwgQVBJQyBkaXNhYmxlZCBieSBCSU9TIC0tIHlvdSBjYW4gZW5hYmxlIGl0IHdpdGgg
ImxhcGljIgpbICAgMTYuNzk3NDE2XSBtYXBwZWQgQVBJQyB0byBmZmZmZDAwMCAoMDEzZmEwMDAp
ClsgICAxNi43OTc0MjJdIEVuYWJsaW5nIGZhc3QgRlBVIHNhdmUgYW5kIHJlc3RvcmUuLi4gZG9u
ZS4KWyAgIDE2Ljc5NzQyOF0gRW5hYmxpbmcgdW5tYXNrZWQgU0lNRCBGUFUgZXhjZXB0aW9uIHN1
cHBvcnQuLi4gZG9uZS4KWyAgIDE2Ljc5NzQ0Ml0gSW5pdGlhbGl6aW5nIENQVSMwClsgICAxNi43
OTc1NDhdIFBJRCBoYXNoIHRhYmxlIGVudHJpZXM6IDIwNDggKG9yZGVyOiAxMSwgODE5MiBieXRl
cykKWyAgIDE2Ljc5Nzc2NV0gSS1waXBlIDEuOC0wODogcGlwZWxpbmUgZW5hYmxlZC4KWyAgIDE2
Ljc5OTcyMl0gQ29uc29sZTogY29sb3VyIFZHQSsgODB4MjUKWyAgIDE2LjgwMzkyMF0gRGVudHJ5
IGNhY2hlIGhhc2ggdGFibGUgZW50cmllczogNjU1MzYgKG9yZGVyOiA2LCAyNjIxNDQgYnl0ZXMp
ClsgICAxNi44MDQzNjFdIElub2RlLWNhY2hlIGhhc2ggdGFibGUgZW50cmllczogMzI3NjggKG9y
ZGVyOiA1LCAxMzEwNzIgYnl0ZXMpClsgICAxNi44MjUxMTldIE1lbW9yeTogNTAwMTQ4ay81MTQ5
NDRrIGF2YWlsYWJsZSAoMTkyOWsga2VybmVsIGNvZGUsIDE0MjI4ayByZXNlcnZlZCwgODgwayBk
YXRhLCAyNjRrIGluaXQsIDBrIGhpZ2htZW0pClsgICAxNi44MjUyNDhdIHZpcnR1YWwga2VybmVs
IG1lbW9yeSBsYXlvdXQ6ClsgICAxNi44MjUyNTBdICAgICBmaXhtYXAgIDogMHhmZmY1MzAwMCAt
IDB4ZmZmZmYwMDAgICAoIDY4OCBrQikKWyAgIDE2LjgyNTI1M10gICAgIHBrbWFwICAgOiAweGZm
ODAwMDAwIC0gMHhmZmMwMDAwMCAgICg0MDk2IGtCKQpbICAgMTYuODI1MjU1XSAgICAgdm1hbGxv
YyA6IDB4ZTAwMDAwMDAgLSAweGZmN2ZlMDAwICAgKCA1MDMgTUIpClsgICAxNi44MjUyNThdICAg
ICBsb3dtZW0gIDogMHhjMDAwMDAwMCAtIDB4ZGY2ZTAwMDAgICAoIDUwMiBNQikKWyAgIDE2Ljgy
NTI2MV0gICAgICAgLmluaXQgOiAweGMwM2M2MDAwIC0gMHhjMDQwODAwMCAgICggMjY0IGtCKQpb
ICAgMTYuODI1MjYzXSAgICAgICAuZGF0YSA6IDB4YzAyZTI1MmQgLSAweGMwM2JlNmI0ICAgKCA4
ODAga0IpClsgICAxNi44MjUyNjZdICAgICAgIC50ZXh0IDogMHhjMDEwMDAwMCAtIDB4YzAyZTI1
MmQgICAoMTkyOSBrQikKWyAgIDE2LjgyNTk0MF0gQ2hlY2tpbmcgaWYgdGhpcyBwcm9jZXNzb3Ig
aG9ub3VycyB0aGUgV1AgYml0IGV2ZW4gaW4gc3VwZXJ2aXNvciBtb2RlLi4uIE9rLgpbICAgMTYu
ODg1NTAyXSBDYWxpYnJhdGluZyBkZWxheSB1c2luZyB0aW1lciBzcGVjaWZpYyByb3V0aW5lLi4g
MTc5NC43OSBCb2dvTUlQUyAobHBqPTg5NzM5NykKWyAgIDE2Ljg4NTc1Ml0gU2VjdXJpdHkgRnJh
bWV3b3JrIHYxLjAuMCBpbml0aWFsaXplZApbICAgMTYuODg1ODc4XSBNb3VudC1jYWNoZSBoYXNo
IHRhYmxlIGVudHJpZXM6IDUxMgpbICAgMTYuODg2MTk1XSBDUFU6IEFmdGVyIGdlbmVyaWMgaWRl
bnRpZnksIGNhcHM6IGE3ZTlmOWJmIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMTgw
IDAwMDAwMDAwIDAwMDAwMDAwClsgICAxNi44ODYyMThdIENQVTogTDEgSSBjYWNoZTogMzJLLCBM
MSBEIGNhY2hlOiAzMksKWyAgIDE2Ljg4NjM3MF0gQ1BVOiBMMiBjYWNoZTogMTAyNEsKWyAgIDE2
Ljg4NjQ1NV0gQ1BVOiBBZnRlciBhbGwgaW5pdHMsIGNhcHM6IGE3ZTlmOWJmIDAwMDAwMDAwIDAw
MDAwMDAwIDAwMDAyMDQwIDAwMDAwMTgwIDAwMDAwMDAwIDAwMDAwMDAwClsgICAxNi44ODY0NzRd
IENvbXBhdCB2RFNPIG1hcHBlZCB0byBmZmZmZTAwMC4KWyAgIDE2Ljg4NjU4MV0gQ2hlY2tpbmcg
J2hsdCcgaW5zdHJ1Y3Rpb24uLi4gT0suClsgICAxNi44OTA3MjRdIFNNUCBhbHRlcm5hdGl2ZXM6
IHN3aXRjaGluZyB0byBVUCBjb2RlClsgICAxNi44OTExMTFdIEZyZWVpbmcgU01QIGFsdGVybmF0
aXZlczogMTNrIGZyZWVkClsgICAxNi44OTEyMjhdIENQVTA6IEludGVsIE1vYmlsZSBHZW51aW5l
IEludGVsKFIpIHByb2Nlc3NvciAgICAgICAxMTAwTUh6IHN0ZXBwaW5nIDA1ClsgICAxNi44OTE1
MTNdIFNNUCBtb3RoZXJib2FyZCBub3QgZGV0ZWN0ZWQuClsgICAxNi44OTE1OTNdIExvY2FsIEFQ
SUMgbm90IGRldGVjdGVkLiBVc2luZyBkdW1teSBBUElDIGVtdWxhdGlvbi4KWyAgIDE2Ljg5MTcy
OV0gQnJvdWdodCB1cCAxIENQVXMKWyAgIDE2Ljg5MjI1Ml0gTkVUOiBSZWdpc3RlcmVkIHByb3Rv
Y29sIGZhbWlseSAxNgpbICAgMTYuODkyNDcxXSBFSVNBIGJ1cyByZWdpc3RlcmVkClsgICAxNi44
OTM5ODBdIFBDSTogUENJIEJJT1MgcmV2aXNpb24gMi4xMCBlbnRyeSBhdCAweGZkOTU0LCBsYXN0
IGJ1cz0zClsgICAxNi44OTQwNjldIFBDSTogVXNpbmcgY29uZmlndXJhdGlvbiB0eXBlIDEKWyAg
IDE2Ljg5NDE1M10gU2V0dGluZyB1cCBzdGFuZGFyZCBQQ0kgcmVzb3VyY2VzClsgICAxNi45MTU0
MzddIExpbnV4IFBsdWcgYW5kIFBsYXkgU3VwcG9ydCB2MC45NyAoYykgQWRhbSBCZWxheQpbICAg
MTYuOTE1NTU0XSBQblBCSU9TOiBTY2FubmluZyBzeXN0ZW0gZm9yIFBuUCBCSU9TIHN1cHBvcnQu
Li4KWyAgIDE2LjkxNTY1MV0gUG5QQklPUzogRm91bmQgUG5QIEJJT1MgaW5zdGFsbGF0aW9uIHN0
cnVjdHVyZSBhdCAweGMwMGY2NjUwClsgICAxNi45MTU3NDRdIFBuUEJJT1M6IFBuUCBCSU9TIHZl
cnNpb24gMS4wLCBlbnRyeSAweGYwMDAwOjB4YWE3ZCwgZHNlZyAweDQwMApbICAgMTYuOTE4Nzk4
XSBQTlBCSU9TIGZhdWx0Li4gYXR0ZW1wdGluZyByZWNvdmVyeS4KWyAgIDE2LjkxODg4NF0gUG5Q
QklPUzogV2FybmluZyEgWW91ciBQblAgQklPUyBjYXVzZWQgYSBmYXRhbCBlcnJvci4gQXR0ZW1w
dGluZyB0byBjb250aW51ZQpbICAgMTYuOTE4OTg5XSBQblBCSU9TOiBZb3UgbWF5IG5lZWQgdG8g
cmVib290IHdpdGggdGhlICJwbnBiaW9zPW9mZiIgb3B0aW9uIHRvIG9wZXJhdGUgc3RhYmx5Clsg
ICAxNi45MTkwOTZdIFBuUEJJT1M6IENoZWNrIHdpdGggeW91ciB2ZW5kb3IgZm9yIGFuIHVwZGF0
ZWQgQklPUwpbICAgMTYuOTE5MTc5XSBQblBCSU9TOiBnZXRfZGV2X25vZGU6IHVuZXhwZWN0ZWQg
c3RhdHVzIDB4MzcKWyAgIDE2LjkxOTI2N10gUG5QQklPUzogMTUgbm9kZXMgcmVwb3J0ZWQgYnkg
UG5QIEJJT1M7IDE1IHJlY29yZGVkIGJ5IGRyaXZlcgpbICAgMTYuOTE5NDA0XSBQQ0k6IFByb2Jp
bmcgUENJIGhhcmR3YXJlClsgICAxNi45MTk1MzRdIFBDSTogUHJvYmluZyBQQ0kgaGFyZHdhcmUg
KGJ1cyAwMCkKWyAgIDE2LjkxOTc1M10gQm9vdCB2aWRlbyBkZXZpY2UgaXMgMDAwMDowMDowMi4w
ClsgICAxNi45MjAwODZdIFBDSSBxdWlyazogcmVnaW9uIDEwMDAtMTA3ZiBjbGFpbWVkIGJ5IElD
SDQgQUNQSS9HUElPL1RDTwpbICAgMTYuOTIwMTgxXSBQQ0kgcXVpcms6IHJlZ2lvbiAxMTgwLTEx
YmYgY2xhaW1lZCBieSBJQ0g0IEdQSU8KWyAgIDE2LjkyMDUyNl0gUENJOiBGaXJtd2FyZSBsZWZ0
IDAwMDA6MDI6MDQuMCBlMTAwIGludGVycnVwdHMgZW5hYmxlZCwgZGlzYWJsaW5nClsgICAxNi45
MjA3NzBdIFBDSTogRmlybXdhcmUgbGVmdCAwMDAwOjAyOjA4LjAgZTEwMCBpbnRlcnJ1cHRzIGVu
YWJsZWQsIGRpc2FibGluZwpbICAgMTYuOTIwOTQxXSBQQ0k6IFRyYW5zcGFyZW50IGJyaWRnZSAt
IDAwMDA6MDA6MWUuMApbICAgMTYuOTIxMTIwXSBQQ0k6IEZpcm13YXJlIGxlZnQgMDAwMDowMzow
Ny4wIGUxMDAgaW50ZXJydXB0cyBlbmFibGVkLCBkaXNhYmxpbmcKWyAgIDE2LjkyMTMwMF0gUENJ
OiBGaXJtd2FyZSBsZWZ0IDAwMDA6MDM6MDguMCBlMTAwIGludGVycnVwdHMgZW5hYmxlZCwgZGlz
YWJsaW5nClsgICAxNi45MjI3OTRdIFBDSTogVXNpbmcgSVJRIHJvdXRlciBQSUlYL0lDSCBbODA4
Ni8yNGMwXSBhdCAwMDAwOjAwOjFmLjAKWyAgIDE2LjkyMjkwMl0gUENJOiBzZXR0aW5nIElSUSA5
IGFzIGxldmVsLXRyaWdnZXJlZApbICAgMTYuOTIyOTA3XSBQQ0k6IEZvdW5kIElSUSA5IGZvciBk
ZXZpY2UgMDAwMDowMDoxZi4xClsgICAxNi45MjMwMTNdIFBDSTogU2hhcmluZyBJUlEgOSB3aXRo
IDAwMDA6MDI6MDUuMApbICAgMTYuOTMwMjU2XSBORVQ6IFJlZ2lzdGVyZWQgcHJvdG9jb2wgZmFt
aWx5IDgKWyAgIDE2LjkzMDM0M10gTkVUOiBSZWdpc3RlcmVkIHByb3RvY29sIGZhbWlseSAyMApb
ICAgMTYuOTMwNTIwXSBwbnA6IDAwOjA5OiBpb3BvcnQgcmFuZ2UgMHhmZTAwLTB4ZmUwMSBoYXMg
YmVlbiByZXNlcnZlZApbICAgMTYuOTMwNjIxXSBwbnA6IDAwOjBiOiBpb3BvcnQgcmFuZ2UgMHg0
ZDAtMHg0ZDEgaGFzIGJlZW4gcmVzZXJ2ZWQKWyAgIDE2LjkzMDcwOV0gcG5wOiAwMDowYjogaW9w
b3J0IHJhbmdlIDB4MTAwMC0weDEwNWYgaGFzIGJlZW4gcmVzZXJ2ZWQKWyAgIDE2LjkzMDgwM10g
cG5wOiAwMDowYjogaW9wb3J0IHJhbmdlIDB4MTA2MC0weDEwN2YgaGFzIGJlZW4gcmVzZXJ2ZWQK
WyAgIDE2LjkzMDg4OV0gcG5wOiAwMDowYjogaW9wb3J0IHJhbmdlIDB4MTE4MC0weDExYmYgaGFz
IGJlZW4gcmVzZXJ2ZWQKWyAgIDE2LjkzMTM4OF0gUENJOiBJZ25vcmUgYm9ndXMgcmVzb3VyY2Ug
NiBbMDowXSBvZiAwMDAwOjAwOjAyLjAKWyAgIDE2LjkzMTUyNV0gUENJOiBCcmlkZ2U6IDAwMDA6
MDI6MDcuMApbICAgMTYuOTMxNjA3XSAgIElPIHdpbmRvdzogNDAwMC00ZmZmClsgICAxNi45MzE2
OThdICAgTUVNIHdpbmRvdzogZTAzMDAwMDAtZTAzZmZmZmYKWyAgIDE2LjkzMTc4M10gICBQUkVG
RVRDSCB3aW5kb3c6IDMwMDAwMDAwLTMwMGZmZmZmClsgICAxNi45MzE4NjhdIFBDSTogQnJpZGdl
OiAwMDAwOjAwOjFlLjAKWyAgIDE2LjkzMTk1MV0gICBJTyB3aW5kb3c6IDMwMDAtNGZmZgpbICAg
MTYuOTMyMDQxXSAgIE1FTSB3aW5kb3c6IGUwMjAwMDAwLWUwM2ZmZmZmClsgICAxNi45MzIxMjVd
ICAgUFJFRkVUQ0ggd2luZG93OiAzMDAwMDAwMC0zMDFmZmZmZgpbICAgMTYuOTMyMjI0XSBQQ0k6
IFNldHRpbmcgbGF0ZW5jeSB0aW1lciBvZiBkZXZpY2UgMDAwMDowMDoxZS4wIHRvIDY0ClsgICAx
Ni45MzIyNzNdIE5FVDogUmVnaXN0ZXJlZCBwcm90b2NvbCBmYW1pbHkgMgpbICAgMTYuOTQxNTUz
XSBJUCByb3V0ZSBjYWNoZSBoYXNoIHRhYmxlIGVudHJpZXM6IDQwOTYgKG9yZGVyOiAyLCAxNjM4
NCBieXRlcykKWyAgIDE2Ljk0MTc2M10gVENQIGVzdGFibGlzaGVkIGhhc2ggdGFibGUgZW50cmll
czogMTYzODQgKG9yZGVyOiA1LCAxMzEwNzIgYnl0ZXMpClsgICAxNi45NDIwNDBdIFRDUCBiaW5k
IGhhc2ggdGFibGUgZW50cmllczogODE5MiAob3JkZXI6IDQsIDY1NTM2IGJ5dGVzKQpbICAgMTYu
OTQyMjE1XSBUQ1A6IEhhc2ggdGFibGVzIGNvbmZpZ3VyZWQgKGVzdGFibGlzaGVkIDE2Mzg0IGJp
bmQgODE5MikKWyAgIDE2Ljk0MjMwOV0gVENQIHJlbm8gcmVnaXN0ZXJlZApbICAgMTYuOTQ0Njky
XSBjaGVja2luZyBpZiBpbWFnZSBpcyBpbml0cmFtZnMuLi4gaXQgaXMKWyAgIDE4LjAzNjc0MV0g
RnJlZWluZyBpbml0cmQgbWVtb3J5OiA1OTYzayBmcmVlZApbICAgMTguMDM3Mzg4XSBhdWRpdDog
aW5pdGlhbGl6aW5nIG5ldGxpbmsgc29ja2V0IChkaXNhYmxlZCkKWyAgIDE4LjAzNzQ5NF0gYXVk
aXQoMTE5MDY0MjkyMS41MzM6MSk6IGluaXRpYWxpemVkClsgICAxOC4wMzc1NzddIFhlbm9tYWk6
IExvY2FsIEFQSUMgYWJzZW50IG9yIGRpc2FibGVkIQpbICAgMTguMDM3NTc5XSAgICAgICAgICBE
aXNhYmxlIEFQSUMgc3VwcG9ydCBvciBwYXNzICJsYXBpYz0xIiBhcyBib290cGFyYW0uClsgICAx
OC4wMzc3NTNdIFhlbm9tYWk6IHN5c3RlbSBpbml0IGZhaWxlZCwgY29kZSAtMTkuClsgICAxOC4w
Mzc4MzhdIFhlbm9tYWk6IG5hdGl2ZSBza2luIGluaXQgZmFpbGVkLCBjb2RlIC0xOS4KWyAgIDE4
LjAzNzk0Nl0gWGVub21haTogc3RhcnRpbmcgUE9TSVggc2VydmljZXMuClsgICAxOC4wMzgwMjld
IFhlbm9tYWk6IFBPU0lYIHNraW4gaW5pdCBmYWlsZWQsIGNvZGUgLTE5LgpbICAgMTguMDM4MTE0
XSBYZW5vbWFpOiBSVERNIHNraW4gaW5pdCBmYWlsZWQsIGNvZGUgLTE5LgpbICAgMTguMDM4NDA0
XSBWRlM6IERpc2sgcXVvdGFzIGRxdW90XzYuNS4xClsgICAxOC4wMzg1MTldIERxdW90LWNhY2hl
IGhhc2ggdGFibGUgZW50cmllczogMTAyNCAob3JkZXIgMCwgNDA5NiBieXRlcykKWyAgIDE4LjAz
ODY4M10gaW8gc2NoZWR1bGVyIG5vb3AgcmVnaXN0ZXJlZApbICAgMTguMDM4ODI3XSBpbyBzY2hl
ZHVsZXIgYW50aWNpcGF0b3J5IHJlZ2lzdGVyZWQKWyAgIDE4LjAzODk4NF0gaW8gc2NoZWR1bGVy
IGRlYWRsaW5lIHJlZ2lzdGVyZWQKWyAgIDE4LjAzOTE0Ml0gaW8gc2NoZWR1bGVyIGNmcSByZWdp
c3RlcmVkIChkZWZhdWx0KQpbICAgMjMuNTM1NzU1XSAwMDAwOjAwOjFkLjcgRUhDSTogQklPUyBo
YW5kb2ZmIGZhaWxlZCAoQklPUyBidWcgPykgMDEwMTAwMDEKWyAgIDIzLjUzNjI5M10gaXNhcG5w
OiBTY2FubmluZyBmb3IgUG5QIGNhcmRzLi4uClsgICAyMy44OTMyMDhdIGlzYXBucDogTm8gUGx1
ZyAmIFBsYXkgZGV2aWNlIGZvdW5kClsgICAyMy45MzU3MzJdIFJlYWwgVGltZSBDbG9jayBEcml2
ZXIgdjEuMTJhYwpbICAgMjMuOTM1ODUwXSBpbnRlbF9ybmc6IEZXSCBub3QgZGV0ZWN0ZWQKWyAg
IDIzLjkzNTk0Nl0gU2VyaWFsOiA4MjUwLzE2NTUwIGRyaXZlciAkUmV2aXNpb246IDEuOTAgJCA0
IHBvcnRzLCBJUlEgc2hhcmluZyBlbmFibGVkClsgICAyMy45MzYxOTBdIHNlcmlhbDgyNTA6IHR0
eVMwIGF0IEkvTyAweDNmOCAoaXJxID0gNCkgaXMgYSAxNjU1MEEKWyAgIDIzLjkzNjQ1OV0gc2Vy
aWFsODI1MDogdHR5UzEgYXQgSS9PIDB4MmY4IChpcnEgPSAzKSBpcyBhIDE2NTUwQQpbICAgMjMu
OTM2NzM4XSBzZXJpYWw4MjUwOiB0dHlTMiBhdCBJL08gMHgzZTggKGlycSA9IDQpIGlzIGEgMTY1
NTBBClsgICAyMy45MzcwMTVdIHNlcmlhbDgyNTA6IHR0eVMzIGF0IEkvTyAweDJlOCAoaXJxID0g
MykgaXMgYSAxNjU1MEEKWyAgIDIzLjkzODYyNF0gUkFNRElTSyBkcml2ZXIgaW5pdGlhbGl6ZWQ6
IDE2IFJBTSBkaXNrcyBvZiA2NTUzNksgc2l6ZSAxMDI0IGJsb2Nrc2l6ZQpbICAgMjMuOTM4OTE3
XSBVbmlmb3JtIE11bHRpLVBsYXRmb3JtIEUtSURFIGRyaXZlciBSZXZpc2lvbjogNy4wMGFscGhh
MgpbICAgMjMuOTM5MDA3XSBpZGU6IEFzc3VtaW5nIDMzTUh6IHN5c3RlbSBidXMgc3BlZWQgZm9y
IFBJTyBtb2Rlczsgb3ZlcnJpZGUgd2l0aCBpZGVidXM9eHgKWyAgIDIzLjkzOTUwNF0gUE5QOiBQ
Uy8yIENvbnRyb2xsZXIgW1BOUDAzMDNdIGF0IDB4NjAsMHg2NCBpcnEgMQpbICAgMjMuOTM5NjE3
XSBQTlA6IFBTLzIgY29udHJvbGxlciBkb2Vzbid0IGhhdmUgQVVYIGlycTsgdXNpbmcgZGVmYXVs
dCAxMgpbICAgMjMuOTQyNzg0XSBzZXJpbzogaTgwNDIgS0JEIHBvcnQgYXQgMHg2MCwweDY0IGly
cSAxClsgICAyMy45NDI4NzRdIHNlcmlvOiBpODA0MiBBVVggcG9ydCBhdCAweDYwLDB4NjQgaXJx
IDEyClsgICAyMy45NDMxNDNdIG1pY2U6IFBTLzIgbW91c2UgZGV2aWNlIGNvbW1vbiBmb3IgYWxs
IG1pY2UKWyAgIDIzLjk0MzQwMF0gRUlTQTogUHJvYmluZyBidXMgMCBhdCBlaXNhLjAKWyAgIDIz
Ljk0MzQ5MV0gQ2Fubm90IGFsbG9jYXRlIHJlc291cmNlIGZvciBFSVNBIHNsb3QgMQpbICAgMjMu
OTQzNTg3XSBDYW5ub3QgYWxsb2NhdGUgcmVzb3VyY2UgZm9yIEVJU0Egc2xvdCAyClsgICAyMy45
NDM2NzNdIENhbm5vdCBhbGxvY2F0ZSByZXNvdXJjZSBmb3IgRUlTQSBzbG90IDMKWyAgIDIzLjk0
Mzc2MV0gQ2Fubm90IGFsbG9jYXRlIHJlc291cmNlIGZvciBFSVNBIHNsb3QgNApbICAgMjMuOTQz
ODY4XSBFSVNBOiBEZXRlY3RlZCAwIGNhcmRzLgpbICAgMjMuOTQ0MDg3XSBUQ1AgY3ViaWMgcmVn
aXN0ZXJlZApbICAgMjMuOTQ0MTgyXSBORVQ6IFJlZ2lzdGVyZWQgcHJvdG9jb2wgZmFtaWx5IDEK
WyAgIDIzLjk0NDMwNF0gVXNpbmcgSVBJIE5vLVNob3J0Y3V0IG1vZGUKWyAgIDIzLjk0NDUyMF0g
VGltZTogdHNjIGNsb2Nrc291cmNlIGhhcyBiZWVuIGluc3RhbGxlZC4KWyAgIDIzLjk0NDcxNV0g
RnJlZWluZyB1bnVzZWQga2VybmVsIG1lbW9yeTogMjY0ayBmcmVlZApbICAgMjMuOTc4NjIwXSBp
bnB1dDogQVQgVHJhbnNsYXRlZCBTZXQgMiBrZXlib2FyZCBhcyAvY2xhc3MvaW5wdXQvaW5wdXQw
ClsgICAyNC45ODM0ODddIHVzYmNvcmU6IHJlZ2lzdGVyZWQgbmV3IGludGVyZmFjZSBkcml2ZXIg
dXNiZnMKWyAgIDI0Ljk4MzYxMV0gdXNiY29yZTogcmVnaXN0ZXJlZCBuZXcgaW50ZXJmYWNlIGRy
aXZlciBodWIKWyAgIDI0Ljk4MzczOV0gdXNiY29yZTogcmVnaXN0ZXJlZCBuZXcgZGV2aWNlIGRy
aXZlciB1c2IKWyAgIDI0Ljk4NjE1Ml0gVVNCIFVuaXZlcnNhbCBIb3N0IENvbnRyb2xsZXIgSW50
ZXJmYWNlIGRyaXZlciB2My4wClsgICAyNC45ODYzMDhdIFBDSTogc2V0dGluZyBJUlEgNSBhcyBs
ZXZlbC10cmlnZ2VyZWQKWyAgIDI0Ljk4NjMxNF0gUENJOiBGb3VuZCBJUlEgNSBmb3IgZGV2aWNl
IDAwMDA6MDA6MWQuMApbICAgMjQuOTg2NDA2XSBQQ0k6IFNoYXJpbmcgSVJRIDUgd2l0aCAwMDAw
OjAwOjAyLjAKWyAgIDI0Ljk4NjUwNl0gUENJOiBTaGFyaW5nIElSUSA1IHdpdGggMDAwMDowMjow
My4wClsgICAyNC45ODY2MTVdIFBDSTogU2V0dGluZyBsYXRlbmN5IHRpbWVyIG9mIGRldmljZSAw
MDAwOjAwOjFkLjAgdG8gNjQKWyAgIDI0Ljk4NjYyMl0gdWhjaV9oY2QgMDAwMDowMDoxZC4wOiBV
SENJIEhvc3QgQ29udHJvbGxlcgpbICAgMjQuOTg2OTQxXSB1aGNpX2hjZCAwMDAwOjAwOjFkLjA6
IG5ldyBVU0IgYnVzIHJlZ2lzdGVyZWQsIGFzc2lnbmVkIGJ1cyBudW1iZXIgMQpbICAgMjQuOTg3
MDcyXSB1aGNpX2hjZCAwMDAwOjAwOjFkLjA6IGlycSA1LCBpbyBiYXNlIDB4MDAwMDFjMDAKWyAg
IDI0Ljk4NzMyN10gdXNiIHVzYjE6IGNvbmZpZ3VyYXRpb24gIzEgY2hvc2VuIGZyb20gMSBjaG9p
Y2UKWyAgIDI0Ljk4NzQ0N10gaHViIDEtMDoxLjA6IFVTQiBodWIgZm91bmQKWyAgIDI0Ljk4NzUz
N10gaHViIDEtMDoxLjA6IDIgcG9ydHMgZGV0ZWN0ZWQKWyAgIDI1LjA5NDA5M10gUENJOiBzZXR0
aW5nIElSUSAxNSBhcyBsZXZlbC10cmlnZ2VyZWQKWyAgIDI1LjA5NDEwMV0gUENJOiBGb3VuZCBJ
UlEgMTUgZm9yIGRldmljZSAwMDAwOjAwOjFkLjEKWyAgIDI1LjA5NDIzOF0gUENJOiBTZXR0aW5n
IGxhdGVuY3kgdGltZXIgb2YgZGV2aWNlIDAwMDA6MDA6MWQuMSB0byA2NApbICAgMjUuMDk0MjQ1
XSB1aGNpX2hjZCAwMDAwOjAwOjFkLjE6IFVIQ0kgSG9zdCBDb250cm9sbGVyClsgICAyNS4wOTQz
NjddIHVoY2lfaGNkIDAwMDA6MDA6MWQuMTogbmV3IFVTQiBidXMgcmVnaXN0ZXJlZCwgYXNzaWdu
ZWQgYnVzIG51bWJlciAyClsgICAyNS4wOTQ1MDFdIHVoY2lfaGNkIDAwMDA6MDA6MWQuMTogaXJx
IDE1LCBpbyBiYXNlIDB4MDAwMDIwMDAKWyAgIDI1LjA5NDczOF0gdXNiIHVzYjI6IGNvbmZpZ3Vy
YXRpb24gIzEgY2hvc2VuIGZyb20gMSBjaG9pY2UKWyAgIDI1LjA5NDg2M10gaHViIDItMDoxLjA6
IFVTQiBodWIgZm91bmQKWyAgIDI1LjA5NDk2N10gaHViIDItMDoxLjA6IDIgcG9ydHMgZGV0ZWN0
ZWQKWyAgIDI1LjI1MDg0OV0gUENJOiBzZXR0aW5nIElSUSA3IGFzIGxldmVsLXRyaWdnZXJlZApb
ICAgMjUuMjUwODYwXSBQQ0k6IEZvdW5kIElSUSA3IGZvciBkZXZpY2UgMDAwMDowMDoxZC43Clsg
ICAyNS4yNTEwMDRdIFBDSTogU2V0dGluZyBsYXRlbmN5IHRpbWVyIG9mIGRldmljZSAwMDAwOjAw
OjFkLjcgdG8gNjQKWyAgIDI1LjI1MTAxMV0gZWhjaV9oY2QgMDAwMDowMDoxZC43OiBFSENJIEhv
c3QgQ29udHJvbGxlcgpbICAgMjUuMjUxMTU3XSBlaGNpX2hjZCAwMDAwOjAwOjFkLjc6IG5ldyBV
U0IgYnVzIHJlZ2lzdGVyZWQsIGFzc2lnbmVkIGJ1cyBudW1iZXIgMwpbICAgMjUuMjUxMzA0XSBl
aGNpX2hjZCAwMDAwOjAwOjFkLjc6IGRlYnVnIHBvcnQgMQpbICAgMjUuMjUxMzk0XSBQQ0k6IGNh
Y2hlIGxpbmUgc2l6ZSBvZiAzMiBpcyBub3Qgc3VwcG9ydGVkIGJ5IGRldmljZSAwMDAwOjAwOjFk
LjcKWyAgIDI1LjI1MTQxMV0gZWhjaV9oY2QgMDAwMDowMDoxZC43OiBpcnEgNywgaW8gbWVtIDB4
ZTAxMDAwMDAKWyAgIDI1LjI1NTM3Ml0gZWhjaV9oY2QgMDAwMDowMDoxZC43OiBVU0IgMi4wIHN0
YXJ0ZWQsIEVIQ0kgMS4wMCwgZHJpdmVyIDEwIERlYyAyMDA0ClsgICAyNS4yNTU2MTZdIHVzYiB1
c2IzOiBjb25maWd1cmF0aW9uICMxIGNob3NlbiBmcm9tIDEgY2hvaWNlClsgICAyNS4yNTU3NDBd
IGh1YiAzLTA6MS4wOiBVU0IgaHViIGZvdW5kClsgICAyNS4yNTU4MzhdIGh1YiAzLTA6MS4wOiA0
IHBvcnRzIGRldGVjdGVkClsgICAyNS4zNDY1NTddIGUxMDA6IEludGVsKFIpIFBSTy8xMDAgTmV0
d29yayBEcml2ZXIsIDMuNS4xNy1rMi1OQVBJClsgICAyNS4zNDY2NTZdIGUxMDA6IENvcHlyaWdo
dChjKSAxOTk5LTIwMDYgSW50ZWwgQ29ycG9yYXRpb24KWyAgIDI1LjM1OTY5Nl0gSUNINDogSURF
IGNvbnRyb2xsZXIgYXQgUENJIHNsb3QgMDAwMDowMDoxZi4xClsgICAyNS4zNTk4MDRdIFBDSTog
RW5hYmxpbmcgZGV2aWNlIDAwMDA6MDA6MWYuMSAoMDAwNSAtPiAwMDA3KQpbICAgMjUuMzU5OTAx
XSBQQ0k6IEZvdW5kIElSUSA5IGZvciBkZXZpY2UgMDAwMDowMDoxZi4xClsgICAyNS4zNjAwMTBd
IFBDSTogU2hhcmluZyBJUlEgOSB3aXRoIDAwMDA6MDI6MDUuMApbICAgMjUuMzYwMTA3XSBJQ0g0
OiBjaGlwc2V0IHJldmlzaW9uIDIKWyAgIDI1LjM2MDE5MF0gSUNINDogbm90IDEwMCUgbmF0aXZl
IG1vZGU6IHdpbGwgcHJvYmUgaXJxcyBsYXRlcgpbICAgMjUuMzYwMjg0XSAgICAgaWRlMDogQk0t
RE1BIGF0IDB4MjQwMC0weDI0MDcsIEJJT1Mgc2V0dGluZ3M6IGhkYTpETUEsIGhkYjpwaW8KWyAg
IDI1LjM2MDUxNl0gUHJvYmluZyBJREUgaW50ZXJmYWNlIGlkZTAuLi4KWyAgIDI1LjYyMzcxNl0g
aGRhOiBTQU1TVU5HIE1QMDQwMkgsIEFUQSBESVNLIGRyaXZlClsgICAyNS42NTU1NzRdIHVzYiAz
LTI6IG5ldyBoaWdoIHNwZWVkIFVTQiBkZXZpY2UgdXNpbmcgZWhjaV9oY2QgYW5kIGFkZHJlc3Mg
MgpbICAgMjUuNzcwNDczXSB1c2IgMy0yOiBjb25maWd1cmF0aW9uICMxIGNob3NlbiBmcm9tIDEg
Y2hvaWNlClsgICAyNS45NzYzODRdIHVzYiAzLTQ6IG5ldyBoaWdoIHNwZWVkIFVTQiBkZXZpY2Ug
dXNpbmcgZWhjaV9oY2QgYW5kIGFkZHJlc3MgMwpbICAgMjYuMTQwODk1XSB1c2IgMy00OiBjb25m
aWd1cmF0aW9uICMyIGNob3NlbiBmcm9tIDEgY2hvaWNlClsgICAyNi4xNDMzMDldIHVzYmNvcmU6
IHJlZ2lzdGVyZWQgbmV3IGludGVyZmFjZSBkcml2ZXIgbGlidXN1YWwKWyAgIDI2LjE2NjM1MV0g
U0NTSSBzdWJzeXN0ZW0gaW5pdGlhbGl6ZWQKWyAgIDI2LjE3MDcyMV0gSW5pdGlhbGl6aW5nIFVT
QiBNYXNzIFN0b3JhZ2UgZHJpdmVyLi4uClsgICAyNi4yMzU0MjVdIGlkZTAgYXQgMHgxZjAtMHgx
ZjcsMHgzZjYgb24gaXJxIDE0ClsgICAyNi4yNTM4NjJdIHNjc2kwIDogU0NTSSBlbXVsYXRpb24g
Zm9yIFVTQiBNYXNzIFN0b3JhZ2UgZGV2aWNlcwpbICAgMjYuMjU0MDM5XSB1c2Itc3RvcmFnZTog
ZGV2aWNlIGZvdW5kIGF0IDIKWyAgIDI2LjI1NDA0M10gdXNiLXN0b3JhZ2U6IHdhaXRpbmcgZm9y
IGRldmljZSB0byBzZXR0bGUgYmVmb3JlIHNjYW5uaW5nClsgICAyNi4yNTQwOTldIHNjc2kxIDog
U0NTSSBlbXVsYXRpb24gZm9yIFVTQiBNYXNzIFN0b3JhZ2UgZGV2aWNlcwpbICAgMjYuMjU0MjU1
XSB1c2Itc3RvcmFnZTogZGV2aWNlIGZvdW5kIGF0IDMKWyAgIDI2LjI1NDI1OV0gdXNiLXN0b3Jh
Z2U6IHdhaXRpbmcgZm9yIGRldmljZSB0byBzZXR0bGUgYmVmb3JlIHNjYW5uaW5nClsgICAyNi4y
NTQyNzFdIHVzYmNvcmU6IHJlZ2lzdGVyZWQgbmV3IGludGVyZmFjZSBkcml2ZXIgdXNiLXN0b3Jh
Z2UKWyAgIDI2LjI1NDM2MF0gVVNCIE1hc3MgU3RvcmFnZSBzdXBwb3J0IHJlZ2lzdGVyZWQuClsg
ICAyNi4yNTQ3MzZdIGxpYmF0YSB2ZXJzaW9uIDIuMDAgbG9hZGVkLgpbICAgMjYuMjY1MDM4XSBQ
Q0k6IEZvdW5kIElSUSA5IGZvciBkZXZpY2UgMDAwMDowMjowNC4wClsgICAyNi4yNjUxNDhdIFBD
STogU2hhcmluZyBJUlEgOSB3aXRoIDAwMDA6MDA6MWYuMwpbICAgMjYuMjg4NjQ3XSBlMTAwOiBl
dGgwOiBlMTAwX3Byb2JlOiBhZGRyIDB4ZTAyMTkwMDAsIGlycSA5LCBNQUMgYWRkciAwMDowMDo1
QjowMDpGOTo2RApbICAgMjYuMjg4Nzc4XSBQQ0k6IEZvdW5kIElSUSAxNSBmb3IgZGV2aWNlIDAw
MDA6MDI6MDguMApbICAgMjYuMzEyMzUyXSBlMTAwOiBldGgxOiBlMTAwX3Byb2JlOiBhZGRyIDB4
ZTAyMWEwMDAsIGlycSAxNSwgTUFDIGFkZHIgMDA6RTA6NEI6MTk6QzQ6NDgKWyAgIDI2LjMzODAz
OF0gZTEwMDogZXRoMjogZTEwMF9wcm9iZTogYWRkciAweGUwMzQwMDAwLCBpcnEgMTUsIE1BQyBh
ZGRyIDAwOjAwOjVCOjAwOkY5OjZFClsgICAyNi4zNjM3MzddIGUxMDA6IGV0aDM6IGUxMDBfcHJv
YmU6IGFkZHIgMHhlMDM0MTAwMCwgaXJxIDUsIE1BQyBhZGRyIDAwOjAwOjVCOjAwOkY5OjZGClsg
ICAyNi4zNzgwOTVdIGhkYTogbWF4IHJlcXVlc3Qgc2l6ZTogNTEyS2lCClsgICAyNi44NDA1MjJd
IGhkYTogNzgyNDI5NzYgc2VjdG9ycyAoNDAwNjAgTUIpIHcvODE5MktpQiBDYWNoZSwgQ0hTPTE2
MzgzLzI1NS82MywgVURNQSgzMykKWyAgIDI2Ljg0MTMxM10gaGRhOiBjYWNoZSBmbHVzaGVzIHN1
cHBvcnRlZApbICAgMjYuODQxNDU5XSAgaGRhOiBoZGExIGhkYTIgPCBoZGE1ID4KWyAgIDI3LjE5
NjMwNl0ga2pvdXJuYWxkIHN0YXJ0aW5nLiAgQ29tbWl0IGludGVydmFsIDUgc2Vjb25kcwpbICAg
MjcuMTk2NDEwXSBFWFQzLWZzOiBtb3VudGVkIGZpbGVzeXN0ZW0gd2l0aCBvcmRlcmVkIGRhdGEg
bW9kZS4KWyAgIDMxLjI1MTExM10gc2NzaSAwOjA6MDowOiBEaXJlY3QtQWNjZXNzICAgICBDQk0g
ICAgICBGbGFzaCBEaXNrICAgICAgIDQuMDAgUFE6IDAgQU5TSTogMgpbICAgMzEuMjUxNzY1XSB1
c2Itc3RvcmFnZTogZGV2aWNlIHNjYW4gY29tcGxldGUKWyAgIDMxLjM1MzM2MV0gdXNiIDMtNDog
cmVzZXQgaGlnaCBzcGVlZCBVU0IgZGV2aWNlIHVzaW5nIGVoY2lfaGNkIGFuZCBhZGRyZXNzIDMK
WyAgIDMxLjQ1NTI5Ml0gdXNiIDMtNDogZGV2aWNlIGRlc2NyaXB0b3IgcmVhZC82NCwgZXJyb3Ig
LTcxClsgICAzMS42NTgxNzddIHVzYiAzLTQ6IGRldmljZSBkZXNjcmlwdG9yIHJlYWQvNjQsIGVy
cm9yIC03MQpbICAgMzEuODYxMDYzXSB1c2IgMy00OiByZXNldCBoaWdoIHNwZWVkIFVTQiBkZXZp
Y2UgdXNpbmcgZWhjaV9oY2QgYW5kIGFkZHJlc3MgMwpbICAgMzEuOTYzMDA1XSB1c2IgMy00OiBk
ZXZpY2UgZGVzY3JpcHRvciByZWFkLzY0LCBlcnJvciAtNzEKWyAgIDMyLjE2NTg5M10gdXNiIDMt
NDogZGV2aWNlIGRlc2NyaXB0b3IgcmVhZC82NCwgZXJyb3IgLTcxClsgICAzMi4zNjg3NzhdIHVz
YiAzLTQ6IHJlc2V0IGhpZ2ggc3BlZWQgVVNCIGRldmljZSB1c2luZyBlaGNpX2hjZCBhbmQgYWRk
cmVzcyAzClsgICAzMi43NzA1NDRdIHVzYiAzLTQ6IGRldmljZSBub3QgYWNjZXB0aW5nIGFkZHJl
c3MgMywgZXJyb3IgLTcxClsgICAzMi44NzI0OTJdIHVzYiAzLTQ6IHJlc2V0IGhpZ2ggc3BlZWQg
VVNCIGRldmljZSB1c2luZyBlaGNpX2hjZCBhbmQgYWRkcmVzcyAzClsgICAzMy4yNzQyNjFdIHVz
YiAzLTQ6IGRldmljZSBub3QgYWNjZXB0aW5nIGFkZHJlc3MgMywgZXJyb3IgLTcxClsgICAzMy4y
NzQzODddIHVzYiAzLTQ6IFVTQiBkaXNjb25uZWN0LCBhZGRyZXNzIDMKWyAgIDMzLjI3NDk1N10g
dXNiLXN0b3JhZ2U6IGRldmljZSBzY2FuIGNvbXBsZXRlClsgICAzMy4zNzYyMDldIHVzYiAzLTQ6
IG5ldyBoaWdoIHNwZWVkIFVTQiBkZXZpY2UgdXNpbmcgZWhjaV9oY2QgYW5kIGFkZHJlc3MgNApb
ICAgMzMuNDc4MTQ5XSB1c2IgMy00OiBkZXZpY2UgZGVzY3JpcHRvciByZWFkLzY0LCBlcnJvciAt
NzEKWyAgIDMzLjY4MTAzNl0gdXNiIDMtNDogZGV2aWNlIGRlc2NyaXB0b3IgcmVhZC82NCwgZXJy
b3IgLTcxClsgICAzMy44ODM5MjNdIHVzYiAzLTQ6IG5ldyBoaWdoIHNwZWVkIFVTQiBkZXZpY2Ug
dXNpbmcgZWhjaV9oY2QgYW5kIGFkZHJlc3MgNQpbICAgMzMuOTg1ODY0XSB1c2IgMy00OiBkZXZp
Y2UgZGVzY3JpcHRvciByZWFkLzY0LCBlcnJvciAtNzEKWyAgIDM0LjE4ODc1MF0gdXNiIDMtNDog
ZGV2aWNlIGRlc2NyaXB0b3IgcmVhZC82NCwgZXJyb3IgLTcxClsgICAzNC4zOTE2MzVdIHVzYiAz
LTQ6IG5ldyBoaWdoIHNwZWVkIFVTQiBkZXZpY2UgdXNpbmcgZWhjaV9oY2QgYW5kIGFkZHJlc3Mg
NgpbICAgMzQuNDAzNzQwXSB1c2IgMy00OiBkZXZpY2UgZGVzY3JpcHRvciByZWFkLzgsIGVycm9y
IC03MQpbICAgMzQuNTE1Njc1XSB1c2IgMy00OiBkZXZpY2UgZGVzY3JpcHRvciByZWFkLzgsIGVy
cm9yIC03MQpbICAgMzQuNzE4NDUwXSB1c2IgMy00OiBuZXcgaGlnaCBzcGVlZCBVU0IgZGV2aWNl
IHVzaW5nIGVoY2lfaGNkIGFuZCBhZGRyZXNzIDcKWyAgIDM1LjEyMDIyMF0gdXNiIDMtNDogZGV2
aWNlIG5vdCBhY2NlcHRpbmcgYWRkcmVzcyA3LCBlcnJvciAtNzEKWyAgIDM2LjU2OTYxOF0gZTEw
MDogZXRoMDogZTEwMF93YXRjaGRvZzogbGluayB1cCwgMTAwTWJwcywgZnVsbC1kdXBsZXgKWyAg
IDM3Ljk0MTcwNl0gTkVUOiBSZWdpc3RlcmVkIHByb3RvY29sIGZhbWlseSAxNwpbICAgMzguNjUw
OTgyXSBwY2lfaG90cGx1ZzogUENJIEhvdCBQbHVnIFBDSSBDb3JlIHZlcnNpb246IDAuNQpbICAg
MzguNjYwMjEzXSBzaHBjaHA6IFN0YW5kYXJkIEhvdCBQbHVnIFBDSSBDb250cm9sbGVyIERyaXZl
ciB2ZXJzaW9uOiAwLjQKWyAgIDM5LjM1NzI5Nl0gTGludXggYWdwZ2FydCBpbnRlcmZhY2UgdjAu
MTAxIChjKSBEYXZlIEpvbmVzClsgICAzOS42Njg3NDBdIGFncGdhcnQ6IERldGVjdGVkIGFuIElu
dGVsIDg1NSBDaGlwc2V0LgpbICAgMzkuNjY5MTYxXSBhZ3BnYXJ0OiBEZXRlY3RlZCA4MDYwSyBz
dG9sZW4gbWVtb3J5LgpbICAgMzkuNjc4OTM2XSBhZ3BnYXJ0OiBBR1AgYXBlcnR1cmUgaXMgMTI4
TSBAIDB4ZTgwMDAwMDAKWyAgIDM5Ljk0MDc3M10gaW5wdXQ6IEdlblBTLzIgR2VuaXVzIE1vdXNl
IGFzIC9jbGFzcy9pbnB1dC9pbnB1dDEKWyAgIDQwLjMyNjE0NF0gU0NTSSBkZXZpY2Ugc2RhOiAy
NDkwODcgNTEyLWJ5dGUgaGR3ciBzZWN0b3JzICgxMjggTUIpClsgICA0MC4zMjY4MTldIHNkYTog
V3JpdGUgUHJvdGVjdCBpcyBvZmYKWyAgIDQwLjMyNjkwNl0gc2RhOiBNb2RlIFNlbnNlOiAwMCAw
MCAwMCAwMApbICAgNDAuMzI2OTEwXSBzZGE6IGFzc3VtaW5nIGRyaXZlIGNhY2hlOiB3cml0ZSB0
aHJvdWdoClsgICA0MC4zMjg2OTFdIFNDU0kgZGV2aWNlIHNkYTogMjQ5MDg3IDUxMi1ieXRlIGhk
d3Igc2VjdG9ycyAoMTI4IE1CKQpbICAgNDAuMzI5NDM5XSBzZGE6IFdyaXRlIFByb3RlY3QgaXMg
b2ZmClsgICA0MC4zMjk1MjRdIHNkYTogTW9kZSBTZW5zZTogMDAgMDAgMDAgMDAKWyAgIDQwLjMy
OTUyOF0gc2RhOiBhc3N1bWluZyBkcml2ZSBjYWNoZTogd3JpdGUgdGhyb3VnaApbICAgNDAuMzI5
NjE1XSAgc2RhOiBzZGExClsgICA0MC4zMzEyNDNdIHNkIDA6MDowOjA6IEF0dGFjaGVkIHNjc2kg
cmVtb3ZhYmxlIGRpc2sgc2RhClsgICA0MC4zNDk0ODZdIHNkIDA6MDowOjA6IEF0dGFjaGVkIHNj
c2kgZ2VuZXJpYyBzZzAgdHlwZSAwClsgICA0MC41MjI5NjVdIGZ1c2UgaW5pdCAoQVBJIHZlcnNp
b24gNy44KQpbICAgNDAuNTk1NTY2XSBscDogZHJpdmVyIGxvYWRlZCBidXQgbm8gZGV2aWNlcyBm
b3VuZApbICAgNDAuNjc3NjI4XSBBZGRpbmcgMTQ3Nzk0MGsgc3dhcCBvbiAvZGV2L2Rpc2svYnkt
dXVpZC9hODQ0ZmVlZC05NWE4LTQ3ODAtOWY3Mi01YzcyNWMxNDEyNzguICBQcmlvcml0eTotMSBl
eHRlbnRzOjEgYWNyb3NzOjE0Nzc5NDBrClsgICA0MC44MTkyMzddIEVYVDMgRlMgb24gaGRhMSwg
aW50ZXJuYWwgam91cm5hbApbICAgNDEuMzg1NDk3XSBORVQ6IFJlZ2lzdGVyZWQgcHJvdG9jb2wg
ZmFtaWx5IDEwClsgICA0MS4zODU2ODBdIGxvOiBEaXNhYmxlZCBQcml2YWN5IEV4dGVuc2lvbnMK
WyAgIDQxLjM4NTg3NF0gQUREUkNPTkYoTkVUREVWX1VQKTogZXRoMTogbGluayBpcyBub3QgcmVh
ZHkKWyAgIDQxLjM4NTg3OV0gQUREUkNPTkYoTkVUREVWX1VQKTogZXRoMjogbGluayBpcyBub3Qg
cmVhZHkKWyAgIDQxLjM4NTg4M10gQUREUkNPTkYoTkVUREVWX1VQKTogZXRoMzogbGluayBpcyBu
b3QgcmVhZHkKWyAgIDUxLjY5NDg2OF0gZXRoMDogbm8gSVB2NiByb3V0ZXJzIHByZXNlbnQKWyAg
IDU4LjQ3ODA2Ml0gQ2FwYWJpbGl0eSBMU00gaW5pdGlhbGl6ZWQKWyAgIDU5LjUwNTI5N10gcHBk
ZXY6IHVzZXItc3BhY2UgcGFyYWxsZWwgcG9ydCBkcml2ZXIKWyAgIDYwLjU5NTI4MV0gW2RybV0g
SW5pdGlhbGl6ZWQgZHJtIDEuMS4wIDIwMDYwODEwClsgICA2MC42MTQ1MjRdIFBDSTogRm91bmQg
SVJRIDUgZm9yIGRldmljZSAwMDAwOjAwOjAyLjAKWyAgIDYwLjYxNDg5Nl0gUENJOiBTaGFyaW5n
IElSUSA1IHdpdGggMDAwMDowMDoxZC4wClsgICA2MC42MTUxNDddIFBDSTogU2hhcmluZyBJUlEg
NSB3aXRoIDAwMDA6MDI6MDMuMApbICAgNjAuNjE1ODY1XSBbZHJtXSBJbml0aWFsaXplZCBpOTE1
IDEuNi4wIDIwMDYwMTE5IG9uIG1pbm9yIDAKWyAgIDYwLjYxNjYxOF0gW2RybV0gSW5pdGlhbGl6
ZWQgaTkxNSAxLjYuMCAyMDA2MDExOSBvbiBtaW5vciAxClsgICA2NC4xNzUwNTNdIEJsdWV0b290
aDogQ29yZSB2ZXIgMi4xMQpbICAgNjQuMTc1NTg5XSBORVQ6IFJlZ2lzdGVyZWQgcHJvdG9jb2wg
ZmFtaWx5IDMxClsgICA2NC4xNzU1OTRdIEJsdWV0b290aDogSENJIGRldmljZSBhbmQgY29ubmVj
dGlvbiBtYW5hZ2VyIGluaXRpYWxpemVkClsgICA2NC4xNzU2MDFdIEJsdWV0b290aDogSENJIHNv
Y2tldCBsYXllciBpbml0aWFsaXplZApbICAgNjQuNzI2NDc2XSBCbHVldG9vdGg6IEwyQ0FQIHZl
ciAyLjgKWyAgIDY0LjcyNjQ4NF0gQmx1ZXRvb3RoOiBMMkNBUCBzb2NrZXQgbGF5ZXIgaW5pdGlh
bGl6ZWQKWyAgIDY0Ljc5MDg0NF0gQmx1ZXRvb3RoOiBSRkNPTU0gc29ja2V0IGxheWVyIGluaXRp
YWxpemVkClsgICA2NC43OTA4NjVdIEJsdWV0b290aDogUkZDT01NIFRUWSBsYXllciBpbml0aWFs
aXplZApbICAgNjQuNzkwODY5XSBCbHVldG9vdGg6IFJGQ09NTSB2ZXIgMS44ClsgICA3NS4zMjU1
NDZdIGV0aDA6IG5vIElQdjYgcm91dGVycyBwcmVzZW50Cg==

--0__=4EBBF9F3DFADB5BF8f9e8a93df938690918c4EBBF9F3DFADB5BF
Content-type: application/octet-stream; 
	name="output_xeno_test.txt"
Content-Disposition: attachment; filename="output_xeno_test.txt"
Content-ID: <3__=4EBBF9F3DFADB5BF8f9e8a93df938@domain.hid>
Content-transfer-encoding: base64

eGVuby10ZXN0OiBzdGFydGVkIAp3aXRoQnVzeWJveCBpcyAwCnhlbm8tdGVzdDogcnVubmluZyB0
ZXN0cwoKVHVlIFNlcCAyNSAwNzozNzoyMSBDRVNUIDIwMDcKcnVubmluZzogL3Vzci94ZW5vbWFp
L2Jpbi94ZW5vLWNvbmZpZyAtLXZlcmJvc2UKeGVuby1jb25maWcgLS12ZXJib3NlCiAgICAtLXZl
cnNpb249IjIuMy4zIgogICAgLS1jYz0iZ2NjIgogICAgLS1hcmNoPSJpMzg2IgogICAgLS1wcmVm
aXg9Ii91c3IveGVub21haSIKICAgIC0teGVuby1jZmxhZ3M9Ii1JL3Vzci94ZW5vbWFpL2luY2x1
ZGUgLURfR05VX1NPVVJDRSAtRF9SRUVOVFJBTlQgLURfX1hFTk9fXyIKICAgIC0teGVuby1sZGZs
YWdzPSItTC91c3IveGVub21haS9saWIgLWxwdGhyZWFkICIKICAgIC0tcG9zaXgtY2ZsYWdzPSIt
SS91c3IveGVub21haS9pbmNsdWRlIC1JL3Vzci94ZW5vbWFpL2luY2x1ZGUvcG9zaXggLURfR05V
X1NPVVJDRSAtRF9SRUVOVFJBTlQgLURfX1hFTk9fXyIKICAgIC0tcG9zaXgtbGRmbGFncz0iLUwv
dXNyL3hlbm9tYWkvbGliIC1scHRocmVhZF9ydCAtbHB0aHJlYWQgLWxydCAiCiAgICAtLWxpYnJh
cnktZGlyPSIvdXNyL3hlbm9tYWkvbGliIgoKVHVlIFNlcCAyNSAwNzozNzoyMSBDRVNUIDIwMDcK
cnVubmluZzogL3Vzci94ZW5vbWFpL2Jpbi94ZW5vLWluZm8KSWYgc29tZSBmaWVsZHMgYXJlIGVt
cHR5IG9yIGxvb2sgdW51c3VhbCB5b3UgbWF5IGhhdmUgYW4gb2xkIHZlcnNpb24uCkNvbXBhcmUg
dG8gdGhlIGN1cnJlbnQgbWluaW1hbCByZXF1aXJlbWVudHMgaW4gRG9jdW1lbnRhdGlvbi9DaGFu
Z2VzLgogCkxpbnV4IGduY3UtZGVza3RvcCAyLjYuMjAuMTktYWRlb3MteGVub21haTIuMy4wICMx
IFNNUCBNb24gU2VwIDI0IDEyOjAyOjM3IENFU1QgMjAwNyBpNjg2IEdOVS9MaW51eAogCkdudSBD
ICAgICAgICAgICAgICAgICAgNC4xLjIKR251IG1ha2UgICAgICAgICAgICAgICAzLjgxCnV0aWwt
bGludXggICAgICAgICAgICAgMi4xMnIKbW91bnQgICAgICAgICAgICAgICAgICAyLjEycgptb2R1
bGUtaW5pdC10b29scyAgICAgIDMuMy1wcmUyCmUyZnNwcm9ncyAgICAgICAgICAgICAgMS40MC1X
SVAKUFBQICAgICAgICAgICAgICAgICAgICAyLjQuNApMaW51eCBDIExpYnJhcnkgICAgICAgID4g
bGliYy4yLjUKRHluYW1pYyBsaW5rZXIgKGxkZCkgICAyLjUKUHJvY3BzICAgICAgICAgICAgICAg
ICAzLjIuNwpOZXQtdG9vbHMgICAgICAgICAgICAgIDEuNjAKQ29uc29sZS10b29scyAgICAgICAg
ICAwLjIuMwpTaC11dGlscyAgICAgICAgICAgICAgIDUuOTcKTW9kdWxlcyBMb2FkZWQgICAgICAg
ICBubHNfaXNvODg1OV8xIG5sc19jcDQzNyB2ZmF0IGZhdCBiaW5mbXRfbWlzYyByZmNvbW0gbDJj
YXAgYmx1ZXRvb3RoIGk5MTUgZHJtIHBwZGV2IGNhcGFiaWxpdHkgY29tbW9uY2FwIGlwdjYgcGFy
cG9ydF9wYyBscCBwYXJwb3J0IGZ1c2Ugc2cgc2RfbW9kIHNlcmlvX3JhdyBwc21vdXNlIGludGVs
X2FncCBhZ3BnYXJ0IHNocGNocCBwY2lfaG90cGx1ZyBhZl9wYWNrZXQgZXZkZXYgdXNiX3N0b3Jh
Z2UgZXh0MyBqYmQgbWJjYWNoZSBsaWJ1c3VhbCBpZGVfZGlzayBhdGFfZ2VuZXJpYyBhdGFfcGlp
eCBsaWJhdGEgc2NzaV9tb2QgZTEwMCBtaWkgcGlpeCBnZW5lcmljIGVoY2lfaGNkIHVoY2lfaGNk
IHVzYmNvcmUKClR1ZSBTZXAgMjUgMDc6Mzc6MjEgQ0VTVCAyMDA3CnJ1bm5pbmc6IGNhdCAvcHJv
Yy9jcHVpbmZvCnByb2Nlc3Nvcgk6IDAKdmVuZG9yX2lkCTogR2VudWluZUludGVsCmNwdSBmYW1p
bHkJOiA2Cm1vZGVsCQk6IDkKbW9kZWwgbmFtZQk6IE1vYmlsZSBHZW51aW5lIEludGVsKFIpIHBy
b2Nlc3NvciAgICAgICAxMTAwTUh6CnN0ZXBwaW5nCTogNQpjcHUgTUh6CQk6IDg5Ny4xMzIKY2Fj
aGUgc2l6ZQk6IDEwMjQgS0IKZmRpdl9idWcJOiBubwpobHRfYnVnCQk6IG5vCmYwMGZfYnVnCTog
bm8KY29tYV9idWcJOiBubwpmcHUJCTogeWVzCmZwdV9leGNlcHRpb24JOiB5ZXMKY3B1aWQgbGV2
ZWwJOiAyCndwCQk6IHllcwpmbGFncwkJOiBmcHUgdm1lIGRlIHBzZSB0c2MgbXNyIG1jZSBjeDgg
YXBpYyBzZXAgbXRyciBwZ2UgbWNhIGNtb3YgcGF0IGNsZmx1c2ggZHRzIGFjcGkgbW14IGZ4c3Ig
c3NlIHNzZTIgdG0gcGJlIHVwIGVzdCB0bTIKYm9nb21pcHMJOiAxNzk0Ljc5CmNsZmx1c2ggc2l6
ZQk6IDY0CgoKVHVlIFNlcCAyNSAwNzozNzoyMSBDRVNUIDIwMDcKcnVubmluZzogbWQ1c3VtIC9w
cm9jL2NwdWluZm8gIyBjcHVpbmZvIGZpbmdlcnByaW50CjNmNjMxN2YwMWJmNTIzMTRjMTU5YjY4
MTI5OGU4MjE5ICAvcHJvYy9jcHVpbmZvCiMgQ09ORklHX1BSRUVNUFRfTk9ORSBpcyBub3Qgc2V0
CkNPTkZJR19QUkVFTVBUX1ZPTFVOVEFSWT15CiMgQ09ORklHX1BSRUVNUFQgaXMgbm90IHNldApD
T05GSUdfUFJFRU1QVF9CS0w9eQpDT05GSUdfSVBJUEU9eQojIENPTkZJR19QTSBpcyBub3Qgc2V0
CiMgQ09ORklHX0NQVV9GUkVRIGlzIG5vdCBzZXQKIyBDT05GSUdfSVBJUEVfREVCVUcgaXMgbm90
IHNldAojIENPTkZJR19ERUJVR19TUElOTE9DSyBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX1NQ
SU5MT0NLX1NMRUVQIGlzIG5vdCBzZXQKClR1ZSBTZXAgMjUgMDc6Mzc6MjEgQ0VTVCAyMDA3CnJ1
bm5pbmc6IGNhdCAvcHJvYy9pcGlwZS9MaW51eAogICAgICAgKy0tLS0tIEhhbmRsaW5nIChbQV1j
Y2VwdGVkLCBbR11yYWJiZWQsIFtXXWlyZWQsIFtEXWlzY2FyZGVkKQogICAgICAgfCstLS0tIFN0
aWNreQogICAgICAgfHwrLS0tIExvY2tlZAogICAgICAgfHx8Ky0tIEV4Y2x1c2l2ZQogICAgICAg
fHx8fCstIFZpcnR1YWwKW0lSUV0gIHx8fHx8CiAgIDA6ICBBLi4uLgogICAxOiAgQS4uLi4KICAg
MjogIEEuLi4uCiAgIDM6ICBBLkwuLgogICA0OiAgQS5MLi4KICAgNTogIEEuLi4uCiAgIDY6ICBB
Li4uLgogICA3OiAgQS4uLi4KICAgODogIEEuLi4uCiAgIDk6ICBBLi4uLgogIDEwOiAgQS4uLi4K
ICAxMTogIEEuLi4uCiAgMTI6ICBBLi4uLgogIDEzOiAgQS4uLi4KICAxNDogIEEuLi4uCiAgMTU6
ICBBLi4uLgogIDE2OiAgQS4uLi4KICAxNzogIEEuLi4uCiAgMTg6ICBBLi4uLgogIDE5OiAgQS4u
Li4KICAyMDogIEEuLi4uCiAgMjE6ICBBLi4uLgogIDIyOiAgQS4uLi4KICAyMzogIEEuLi4uCiAg
MjQ6ICBBLi4uLgogIDI1OiAgQS4uLi4KICAyNjogIEEuLi4uCiAgMjc6ICBBLi4uLgogIDI4OiAg
QS4uLi4KICAyOTogIEEuLi4uCiAgMzA6ICBBLi4uLgogIDMxOiAgQS4uLi4KICAzMjogIEEuLi4u
CiAgMzM6ICBBLi4uLgogIDM0OiAgQS4uLi4KICAzNTogIEEuLi4uCiAgMzY6ICBBLi4uLgogIDM3
OiAgQS4uLi4KICAzODogIEEuLi4uCiAgMzk6ICBBLi4uLgogIDQwOiAgQS4uLi4KICA0MTogIEEu
Li4uCiAgNDI6ICBBLi4uLgogIDQzOiAgQS4uLi4KICA0NDogIEEuLi4uCiAgNDU6ICBBLi4uLgog
IDQ2OiAgQS4uLi4KICA0NzogIEEuLi4uCiAgNDg6ICBBLi4uLgogIDQ5OiAgQS4uLi4KICA1MDog
IEEuLi4uCiAgNTE6ICBBLi4uLgogIDUyOiAgQS4uLi4KICA1MzogIEEuLi4uCiAgNTQ6ICBBLi4u
LgogIDU1OiAgQS4uLi4KICA1NjogIEEuLi4uCiAgNTc6ICBBLi4uLgogIDU4OiAgQS4uLi4KICA1
OTogIEEuLi4uCiAgNjA6ICBBLi4uLgogIDYxOiAgQS4uLi4KICA2MjogIEEuLi4uCiAgNjM6ICBB
Li4uLgogIDY0OiAgQS4uLi4KICA2NTogIEEuLi4uCiAgNjY6ICBBLi4uLgogIDY3OiAgQS4uLi4K
ICA2ODogIEEuLi4uCiAgNjk6ICBBLi4uLgogIDcwOiAgQS4uLi4KICA3MTogIEEuLi4uCiAgNzI6
ICBBLi4uLgogIDczOiAgQS4uLi4KICA3NDogIEEuLi4uCiAgNzU6ICBBLi4uLgogIDc2OiAgQS4u
Li4KICA3NzogIEEuLi4uCiAgNzg6ICBBLi4uLgogIDc5OiAgQS4uLi4KICA4MDogIEEuLi4uCiAg
ODE6ICBBLi4uLgogIDgyOiAgQS4uLi4KICA4MzogIEEuLi4uCiAgODQ6ICBBLi4uLgogIDg1OiAg
QS4uLi4KICA4NjogIEEuLi4uCiAgODc6ICBBLi4uLgogIDg4OiAgQS4uLi4KICA4OTogIEEuLi4u
CiAgOTA6ICBBLi4uLgogIDkxOiAgQS4uLi4KICA5MjogIEEuLi4uCiAgOTM6ICBBLi4uLgogIDk0
OiAgQS4uLi4KICA5NTogIEEuLi4uCiAgOTY6ICBBLi4uLgogIDk3OiAgQS4uLi4KICA5ODogIEEu
Li4uCiAgOTk6ICBBLi4uLgogMTAwOiAgQS4uLi4KIDEwMTogIEEuLi4uCiAxMDI6ICBBLi4uLgog
MTAzOiAgQS4uLi4KIDEwNDogIEEuLi4uCiAxMDU6ICBBLi4uLgogMTA2OiAgQS4uLi4KIDEwNzog
IEEuLi4uCiAxMDg6ICBBLi4uLgogMTA5OiAgQS4uLi4KIDExMDogIEEuLi4uCiAxMTE6ICBBLi4u
LgogMTEyOiAgQS4uLi4KIDExMzogIEEuLi4uCiAxMTQ6ICBBLi4uLgogMTE1OiAgQS4uLi4KIDEx
NjogIEEuLi4uCiAxMTc6ICBBLi4uLgogMTE4OiAgQS4uLi4KIDExOTogIEEuLi4uCiAxMjA6ICBB
Li4uLgogMTIxOiAgQS4uLi4KIDEyMjogIEEuLi4uCiAxMjM6ICBBLi4uLgogMTI0OiAgQS4uLi4K
IDEyNTogIEEuLi4uCiAxMjY6ICBBLi4uLgogMTI3OiAgQS4uLi4KIDEyODogIEEuLi4uCiAxMjk6
ICBBLi4uLgogMTMwOiAgQS4uLi4KIDEzMTogIEEuLi4uCiAxMzI6ICBBLi4uLgogMTMzOiAgQS4u
Li4KIDEzNDogIEEuLi4uCiAxMzU6ICBBLi4uLgogMTM2OiAgQS4uLi4KIDEzNzogIEEuLi4uCiAx
Mzg6ICBBLi4uLgogMTM5OiAgQS4uLi4KIDE0MDogIEEuLi4uCiAxNDE6ICBBLi4uLgogMTQyOiAg
QS4uLi4KIDE0MzogIEEuLi4uCiAxNDQ6ICBBLi4uLgogMTQ1OiAgQS4uLi4KIDE0NjogIEEuLi4u
CiAxNDc6ICBBLi4uLgogMTQ4OiAgQS4uLi4KIDE0OTogIEEuLi4uCiAxNTA6ICBBLi4uLgogMTUx
OiAgQS4uLi4KIDE1MjogIEEuLi4uCiAxNTM6ICBBLi4uLgogMTU0OiAgQS4uLi4KIDE1NTogIEEu
Li4uCiAxNTY6ICBBLi4uLgogMTU3OiAgQS4uLi4KIDE1ODogIEEuLi4uCiAxNTk6ICBBLi4uLgog
MTYwOiAgQS4uLi4KIDE2MTogIEEuLi4uCiAxNjI6ICBBLi4uLgogMTYzOiAgQS4uLi4KIDE2NDog
IEEuLi4uCiAxNjU6ICBBLi4uLgogMTY2OiAgQS4uLi4KIDE2NzogIEEuLi4uCiAxNjg6ICBBLi4u
LgogMTY5OiAgQS4uLi4KIDE3MDogIEEuLi4uCiAxNzE6ICBBLi4uLgogMTcyOiAgQS4uLi4KIDE3
MzogIEEuLi4uCiAxNzQ6ICBBLi4uLgogMTc1OiAgQS4uLi4KIDE3NjogIEEuLi4uCiAxNzc6ICBB
Li4uLgogMTc4OiAgQS4uLi4KIDE3OTogIEEuLi4uCiAxODA6ICBBLi4uLgogMTgxOiAgQS4uLi4K
IDE4MjogIEEuLi4uCiAxODM6ICBBLi4uLgogMTg0OiAgQS4uLi4KIDE4NTogIEEuLi4uCiAxODY6
ICBBLi4uLgogMTg3OiAgQS4uLi4KIDE4ODogIEEuLi4uCiAxODk6ICBBLi4uLgogMTkwOiAgQS4u
Li4KIDE5MTogIEEuLi4uCiAxOTI6ICBBLi4uLgogMTkzOiAgQS4uLi4KIDE5NDogIEEuLi4uCiAx
OTU6ICBBLi4uLgogMTk2OiAgQS4uLi4KIDE5NzogIEEuLi4uCiAxOTg6ICBBLi4uLgogMTk5OiAg
QS4uLi4KIDIwMDogIEEuLi4uCiAyMDE6ICBBLi4uLgogMjAyOiAgQS4uLi4KIDIwMzogIEEuLi4u
CiAyMDQ6ICBBLi4uLgogMjA1OiAgQS4uLi4KIDIwNjogIEEuLi4uCiAyMDc6ICBBLi4uLgogMjA4
OiAgQS4uLi4KIDIwOTogIEEuLi4uCiAyMTA6ICBBLi4uLgogMjExOiAgQS4uLi4KIDIxMjogIEEu
Li4uCiAyMTM6ICBBLi4uLgogMjE0OiAgQS4uLi4KIDIxNTogIEEuLi4uCiAyMTY6ICBBLi4uLgog
MjE3OiAgQS4uLi4KIDIxODogIEEuLi4uCiAyMTk6ICBBLi4uLgogMjIwOiAgQS4uLi4KIDIyMTog
IEEuLi4uCiAyMjI6ICBBLi4uLgogMjIzOiAgQS4uLi4KIDIyNDogIEEuLi4uCiAyMzA6ICBBLi4u
LgogMjMxOiAgQS4uLi4KIDIzMjogIEEuLi4uCiAyMzM6ICBBLi4uLgogMjM0OiAgR1MuLi4KIDIz
NjogIEEuLi4uCiAyMzc6ICBBLi4uLgogMjM4OiAgQS4uLi4KIDIzOTogIEEuLi4uCiAyNDA6ICBB
Li4uLgogMjU2OiAgRy4uLlYKIDI1NzogIEcuLi5WCltEb21haW4gaW5mb10KaWQ9MHgwMDAwMDAw
MApwcmlvcml0eT0xMDAKClR1ZSBTZXAgMjUgMDc6Mzc6MjEgQ0VTVCAyMDA3CnJ1bm5pbmc6IGNh
dCAvcHJvYy9pcGlwZS9YZW5vbWFpCiAgICAgICArLS0tLS0gSGFuZGxpbmcgKFtBXWNjZXB0ZWQs
IFtHXXJhYmJlZCwgW1ddaXJlZCwgW0RdaXNjYXJkZWQpCiAgICAgICB8Ky0tLS0gU3RpY2t5CiAg
ICAgICB8fCstLS0gTG9ja2VkCiAgICAgICB8fHwrLS0gRXhjbHVzaXZlCiAgICAgICB8fHx8Ky0g
VmlydHVhbApbSVJRXSAgfHx8fHwKIDIzMDogIFcuLi4uCiAyMzM6ICBXLi5YLgogMjM0OiAgR1Mu
Li4KIDI1ODogIFcuLi5WCltEb21haW4gaW5mb10KaWQ9MHg1ODQ1NGU0Zgpwcmlvcml0eT10b3Bt
b3N0CgpUdWUgU2VwIDI1IDA3OjM3OjIxIENFU1QgMjAwNwpydW5uaW5nOiBjYXQgL3Byb2MvaXBp
cGUvdmVyc2lvbgoxLjgtMDgKClR1ZSBTZXAgMjUgMDc6Mzc6MjEgQ0VTVCAyMDA3CnJ1bm5pbmc6
IGdlbmVyYXRlX2xvYWRzIDEKZXZhbDogMTogYXJpdGg6IHN5bnRheCBlcnJvcjogImpvYnNjdC0x
IgpjbGVhbnVwX2xvYWQ6IG5vIGRkX2pvYnMgZm91bmQKClR1ZSBTZXAgMjUgMDc6Mzc6MjEgQ0VT
VCAyMDA3CnJ1bm5pbmc6IGNhdCAvcHJvYy9pbnRlcnJ1cHRzCiAgICAgICAgICAgQ1BVMCAgICAg
ICAKICAwOiAgICAzNzUzNDAyICAgIFhULVBJQy1YVCAgICAgICAgdGltZXIsIHJ0aGFsX2Jyb2Fk
Y2FzdF90aW1lcgogIDE6ICAgICAgICAgNDIgICAgWFQtUElDLVhUICAgICAgICBpODA0MgogIDI6
ICAgICAgICAgIDAgICAgWFQtUElDLVhUICAgICAgICBjYXNjYWRlCiAgNTogICAgIDE2NDcwOCAg
ICBYVC1QSUMtWFQgICAgICAgIHVoY2lfaGNkOnVzYjEsIGV0aDMsIGk5MTVAcGNpOjAwMDA6MDA6
MDIuMAogIDc6ICAgICAgIDQ5MjIgICAgWFQtUElDLVhUICAgICAgICBlaGNpX2hjZDp1c2IzCiAg
ODogICAgICAgICAgMyAgICBYVC1QSUMtWFQgICAgICAgIHJ0YwogIDk6ICAgICAxMDgxNjcgICAg
WFQtUElDLVhUICAgICAgICBldGgwCiAxMjogICAgICAgIDkxMiAgICBYVC1QSUMtWFQgICAgICAg
IGk4MDQyCiAxNDogICAgICAyNjM3NSAgICBYVC1QSUMtWFQgICAgICAgIGlkZTAKIDE1OiAgICAg
ICAzNzQ4ICAgIFhULVBJQy1YVCAgICAgICAgdWhjaV9oY2Q6dXNiMiwgZXRoMSwgZXRoMgpOTUk6
ICAgICAgIDE5NTkgCkxPQzogICAgMzc1MzMwNyAKRVJSOiAgICAgICAgICAwCk1JUzogICAgICAg
ICAgMAoKVHVlIFNlcCAyNSAwNzozNzoyMSBDRVNUIDIwMDcKcnVubmluZzogY2F0IC9wcm9jL2xv
YWRhdmcKMC4wMiAwLjA0IDAuMDIgNC8xMTggODUyMQoKVHVlIFNlcCAyNSAwNzozNzoyMSBDRVNU
IDIwMDcKcnVubmluZzogY2F0IC9wcm9jL21lbWluZm8KTWVtVG90YWw6ICAgICAgIDUwNjU3NiBr
QgpNZW1GcmVlOiAgICAgICAgMTAzNTc2IGtCCkJ1ZmZlcnM6ICAgICAgICAgODc5Njgga0IKQ2Fj
aGVkOiAgICAgICAgIDE0NDgzNiBrQgpTd2FwQ2FjaGVkOiAgICAgICAgICAwIGtCCkFjdGl2ZTog
ICAgICAgICAxNjMzNDQga0IKSW5hY3RpdmU6ICAgICAgIDE0NjU0OCBrQgpIaWdoVG90YWw6ICAg
ICAgICAgICAwIGtCCkhpZ2hGcmVlOiAgICAgICAgICAgIDAga0IKTG93VG90YWw6ICAgICAgIDUw
NjU3NiBrQgpMb3dGcmVlOiAgICAgICAgMTAzNTc2IGtCClN3YXBUb3RhbDogICAgIDE0Nzc5NDAg
a0IKU3dhcEZyZWU6ICAgICAgMTQ3Nzk0MCBrQgpEaXJ0eTogICAgICAgICAgICAgICAwIGtCCldy
aXRlYmFjazogICAgICAgICAgIDAga0IKQW5vblBhZ2VzOiAgICAgICA3NzEwOCBrQgpNYXBwZWQ6
ICAgICAgICAgIDM0NjQ0IGtCClNsYWI6ICAgICAgICAgICAgMjkxMjgga0IKU1JlY2xhaW1hYmxl
OiAgICAxNzg2NCBrQgpTVW5yZWNsYWltOiAgICAgIDExMjY0IGtCClBhZ2VUYWJsZXM6ICAgICAg
IDE4NzIga0IKTkZTX1Vuc3RhYmxlOiAgICAgICAgMCBrQgpCb3VuY2U6ICAgICAgICAgICAgICAw
IGtCCkNvbW1pdExpbWl0OiAgIDE3MzEyMjgga0IKQ29tbWl0dGVkX0FTOiAgIDM4NjM2OCBrQgpW
bWFsbG9jVG90YWw6ICAgNTE2MDg4IGtCClZtYWxsb2NVc2VkOiAgICAgIDQyODgga0IKVm1hbGxv
Y0NodW5rOiAgIDUxMTYwNCBrQgoKVHVlIFNlcCAyNSAwNzozNzoyMSBDRVNUIDIwMDcKcnVubmlu
ZzogY2F0IC9wcm9jL3hlbm9tYWkvYXBjCkFQQyAgICAgICAgICBDUFUwCiAgMDogICAgICAgICAg
ICAwICAgIChwaXBlX3dha2V1cCkKICAxOiAgICAgICAgICAgIDAgICAgKGxvc3RhZ2VfaGFuZGxl
cikKICAyOiAgICAgICAgICAgIDAgICAgKHJlZ2lzdHJ5X2V4cG9ydCkKICAzOiAgICAgICAgICAg
IDAgICAgKHBvc2l4X3NpZ25hbHNfaGFuZGxlcikKClR1ZSBTZXAgMjUgMDc6Mzc6MjEgQ0VTVCAy
MDA3CnJ1bm5pbmc6IGNhdCAvcHJvYy94ZW5vbWFpL2ZhdWx0cwpUUkFQICAgICAgICAgQ1BVMAog
IDA6ICAgICAgICAgICAgMCAgICAoRGl2aWRlIGVycm9yKQogIDE6ICAgICAgICAgICAgMCAgICAo
RGVidWcpCiAgMzogICAgICAgICAgICAwICAgIChJbnQzKQogIDQ6ICAgICAgICAgICAgMCAgICAo
T3ZlcmZsb3cpCiAgNTogICAgICAgICAgICAwICAgIChCb3VuZHMpCiAgNjogICAgICAgICAgICAw
ICAgIChJbnZhbGlkIG9wY29kZSkKICA3OiAgICAgICAgICAgIDAgICAgKEZQVSBub3QgYXZhaWxh
YmxlKQogIDg6ICAgICAgICAgICAgMCAgICAoRG91YmxlIGZhdWx0KQogIDk6ICAgICAgICAgICAg
MCAgICAoRlBVIHNlZ21lbnQgb3ZlcnJ1bikKIDEwOiAgICAgICAgICAgIDAgICAgKEludmFsaWQg
VFNTKQogMTE6ICAgICAgICAgICAgMCAgICAoU2VnbWVudCBub3QgcHJlc2VudCkKIDEyOiAgICAg
ICAgICAgIDAgICAgKFN0YWNrIHNlZ21lbnQpCiAxMzogICAgICAgICAgICAwICAgIChHZW5lcmFs
IHByb3RlY3Rpb24pCiAxNDogICAgICAgICAgICAwICAgIChQYWdlIGZhdWx0KQogMTU6ICAgICAg
ICAgICAgMCAgICAoU3B1cmlvdXMgaW50ZXJydXB0KQogMTY6ICAgICAgICAgICAgMCAgICAoRlBV
IGVycm9yKQogMTc6ICAgICAgICAgICAgMCAgICAoQWxpZ25tZW50IGNoZWNrKQogMTg6ICAgICAg
ICAgICAgMCAgICAoTWFjaGluZSBjaGVjaykKIDE5OiAgICAgICAgICAgIDAgICAgKFNJTUQgZXJy
b3IpCgpUdWUgU2VwIDI1IDA3OjM3OjIxIENFU1QgMjAwNwpydW5uaW5nOiBjYXQgL3Byb2MveGVu
b21haS9oYWwKMS44LTA4CgpUdWUgU2VwIDI1IDA3OjM3OjIxIENFU1QgMjAwNwpydW5uaW5nOiBj
YXQgL3Byb2MveGVub21haS9oZWFwCnNpemU9MTMwNTYwOnVzZWQ9NjQ6cGFnZXN6PTUxMgoKVHVl
IFNlcCAyNSAwNzozNzoyMSBDRVNUIDIwMDcKcnVubmluZzogY2F0IC9wcm9jL3hlbm9tYWkvaXJx
CklSUSAgICAgICAgIENQVTAKMjMwOiAgICAgICAgICAgMAoyMzM6ICAgICAgICA3NTAyICAgICAg
ICAgW3RpbWVyXQoyMzQ6ICAgICAgICAgICAwCjI1ODogICAgICAgICAgIDAgICAgICAgICBbdmly
dHVhbF0KClR1ZSBTZXAgMjUgMDc6Mzc6MjEgQ0VTVCAyMDA3CnJ1bm5pbmc6IGNhdCAvcHJvYy94
ZW5vbWFpL2xhdGVuY3kKMjY5OQoKVHVlIFNlcCAyNSAwNzozNzoyMSBDRVNUIDIwMDcKcnVubmlu
ZzogY2F0IC9wcm9jL3hlbm9tYWkvc2NoZWQKQ1BVICBQSUQgICAgUFJJICAgICAgUEVSSU9EICAg
VElNRU9VVCAgICBTVEFUICAgICAgIE5BTUUKICAwICAwICAgICAgIC0xICAgICAgMCAgICAgICAg
MCAgICAgICAgICBSICAgICAgICAgIFJPT1QvMAoKVHVlIFNlcCAyNSAwNzozNzoyMSBDRVNUIDIw
MDcKcnVubmluZzogY2F0IC9wcm9jL3hlbm9tYWkvc3RhdApDUFUgIFBJRCAgICBNU1cgICAgICAg
IENTVyAgICAgICAgUEYgICAgU1RBVCAgICAgICAlQ1BVICBOQU1FCiAgMCAgMCAgICAgIDAgICAg
ICAgICAgMCAgICAgICAgICAwICAgICAwMDUwMDA4MCAgMTAwLjAgIFJPT1QvMAogIDAgIDAgICAg
ICAwICAgICAgICAgIDc1MDIgICAgICAgMCAgICAgMDAwMDAwMDAgICAgMC4wICBJUlEyMzM6IFt0
aW1lcl0KClR1ZSBTZXAgMjUgMDc6Mzc6MjEgQ0VTVCAyMDA3CnJ1bm5pbmc6IGNhdCAvcHJvYy94
ZW5vbWFpL3RpbWVyCnN0YXR1cz1vbmVzaG90K3dhdGNoZG9nOnNldHVwPTg0OnRpY2t2YWw9MTpq
aWZmaWVzPTM3Njk2MTkxMDc2NTcKClR1ZSBTZXAgMjUgMDc6Mzc6MjEgQ0VTVCAyMDA3CnJ1bm5p
bmc6IGNhdCAvcHJvYy94ZW5vbWFpL3ZlcnNpb24KMi4zLjMKClR1ZSBTZXAgMjUgMDc6Mzc6MjEg
Q0VTVCAyMDA3CnJ1bm5pbmc6IGNhdCAvcHJvYy94ZW5vbWFpL2ludGVyZmFjZXMvbmF0aXZlCjAK
ClR1ZSBTZXAgMjUgMDc6Mzc6MjEgQ0VTVCAyMDA3CnJ1bm5pbmc6IGNhdCAvcHJvYy94ZW5vbWFp
L2ludGVyZmFjZXMvcG9zaXgKMAoKVHVlIFNlcCAyNSAwNzozNzoyMSBDRVNUIDIwMDcKcnVubmlu
ZzogY2F0IC9wcm9jL3hlbm9tYWkvaW50ZXJmYWNlcy9ydGRtCjAKClR1ZSBTZXAgMjUgMDc6Mzc6
MjEgQ0VTVCAyMDA3CnJ1bm5pbmc6IGNhdCAvcHJvYy94ZW5vbWFpL2ludGVyZmFjZXMvc3lzCjAK
ClR1ZSBTZXAgMjUgMDc6Mzc6MjEgQ0VTVCAyMDA3CnJ1bm5pbmc6IGNhdCAvcHJvYy94ZW5vbWFp
L3J0ZG0vZmlsZGVzCnRvdGFsPTEyODpvcGVuPTA6ZnJlZT0xMjgKClR1ZSBTZXAgMjUgMDc6Mzc6
MjEgQ0VTVCAyMDA3CnJ1bm5pbmc6IGNhdCAvcHJvYy94ZW5vbWFpL3J0ZG0vbmFtZWRfZGV2aWNl
cwpIYXNoCU5hbWUJCQkJRHJpdmVyCQkvcHJvYwoKVHVlIFNlcCAyNSAwNzozNzoyMSBDRVNUIDIw
MDcKcnVubmluZzogY2F0IC9wcm9jL3hlbm9tYWkvcnRkbS9vcGVuX2ZpbGRlcwpJbmRleAlMb2Nr
ZWQJRGV2aWNlCgpUdWUgU2VwIDI1IDA3OjM3OjIxIENFU1QgMjAwNwpydW5uaW5nOiBjYXQgL3By
b2MveGVub21haS9ydGRtL3Byb3RvY29sX2RldmljZXMKSGFzaAlQcm90b2NvbEZhbWlseTpTb2Nr
ZXRUeXBlCURyaXZlcgkJL3Byb2MKClR1ZSBTZXAgMjUgMDc6Mzc6MjEgQ0VTVCAyMDA3CnJ1bm5p
bmc6IHRvcCAtYm4xYwp0b3AgLSAwNzozNzoyMiB1cCAgMTowMiwgIDIgdXNlcnMsICBsb2FkIGF2
ZXJhZ2U6IDAuMDIsIDAuMDQsIDAuMDIKVGFza3M6IDEwOCB0b3RhbCwgICAxIHJ1bm5pbmcsIDEw
NyBzbGVlcGluZywgICAwIHN0b3BwZWQsICAgMCB6b21iaWUKQ3B1KHMpOiAgMC43JXVzLCAgMC4z
JXN5LCAgMC4yJW5pLCA5NC40JWlkLCAgNC40JXdhLCAgMC4wJWhpLCAgMC4wJXNpLCAgMC4wJXN0
Ck1lbTogICAgNTA2NTc2ayB0b3RhbCwgICA0MDMwMDBrIHVzZWQsICAgMTAzNTc2ayBmcmVlLCAg
ICA4Nzk2OGsgYnVmZmVycwpTd2FwOiAgMTQ3Nzk0MGsgdG90YWwsICAgICAgICAwayB1c2VkLCAg
MTQ3Nzk0MGsgZnJlZSwgICAxNDQ4MzZrIGNhY2hlZAoKICBQSUQgVVNFUiAgICAgIFBSICBOSSAg
VklSVCAgUkVTICBTSFIgUyAlQ1BVICVNRU0gICAgVElNRSsgIENPTU1BTkQgICAgICAgICAgICAK
IDg1ODMgcm9vdCAgICAgIDIxICAgMCAgMjMxNiAxMDYwICA3OTIgUiAgMi4wICAwLjIgICAwOjAw
LjAxIHRvcCAtYm4xYyAgICAgICAgICAKICAgIDEgcm9vdCAgICAgIDE4ICAgMCAgMjQ3MiAxNTM2
ICA1ODggUyAgMC4wICAwLjMgICAwOjAxLjYzIC9zYmluL2luaXQgICAgICAgICAKICAgIDIgcm9v
dCAgICAgIFJUICAgMCAgICAgMCAgICAwICAgIDAgUyAgMC4wICAwLjAgICAwOjAwLjAwIFttaWdy
YXRpb24vMF0gICAgICAKClR1ZSBTZXAgMjUgMDc6Mzc6MjIgQ0VTVCAyMDA3CnJ1bm5pbmc6IC4v
cnVuIC0tIC1zaCAtVCAxMjAgLXQwICMgbGF0ZW5jeQoqCioKKiBUeXBlIF5DIHRvIHN0b3AgdGhp
cyBhcHBsaWNhdGlvbi4KKgoqClhlbm9tYWk6IG5hdGl2ZSBza2luIG9yIENPTkZJR19YRU5PX09Q
VF9QRVJWQVNJVkUgZGlzYWJsZWQuCihtb2Rwcm9iZSB4ZW5vX25hdGl2ZT8pCgpUdWUgU2VwIDI1
IDA3OjM3OjIyIENFU1QgMjAwNwpydW5uaW5nOiAuL3J1biAtLSAtc2ggLVQgMTIwIC10MSAjIGxh
dGVuY3kKKgoqCiogVHlwZSBeQyB0byBzdG9wIHRoaXMgYXBwbGljYXRpb24uCioKKgpYZW5vbWFp
OiBuYXRpdmUgc2tpbiBvciBDT05GSUdfWEVOT19PUFRfUEVSVkFTSVZFIGRpc2FibGVkLgoobW9k
cHJvYmUgeGVub19uYXRpdmU/KQoKVHVlIFNlcCAyNSAwNzozNzoyMiBDRVNUIDIwMDcKcnVubmlu
ZzogLi9ydW4gLS0gLXNoIC1UIDEyMCAtdDIgIyBsYXRlbmN5CioKKgoqIFR5cGUgXkMgdG8gc3Rv
cCB0aGlzIGFwcGxpY2F0aW9uLgoqCioKWGVub21haTogbmF0aXZlIHNraW4gb3IgQ09ORklHX1hF
Tk9fT1BUX1BFUlZBU0lWRSBkaXNhYmxlZC4KKG1vZHByb2JlIHhlbm9fbmF0aXZlPykKClR1ZSBT
ZXAgMjUgMDc6Mzc6MjMgQ0VTVCAyMDA3CnJ1bm5pbmc6IC4vcnVuIC0tIC1UIDEyMCAjIHN3aXRj
aHRlc3QKKgoqCiogVHlwZSBeQyB0byBzdG9wIHRoaXMgYXBwbGljYXRpb24uCioKKgpYZW5vbWFp
OiBQT1NJWCBza2luIG9yIENPTkZJR19YRU5PX09QVF9QRVJWQVNJVkUgZGlzYWJsZWQuCihtb2Rw
cm9iZSB4ZW5vX3Bvc2l4PykKClR1ZSBTZXAgMjUgMDc6Mzc6MjMgQ0VTVCAyMDA3CnJ1bm5pbmc6
IC4vcnVuIC0tIC1oICMgc3dpdGNoYmVuY2gKKgoqCiogVHlwZSBeQyB0byBzdG9wIHRoaXMgYXBw
bGljYXRpb24uCioKKgpYZW5vbWFpOiBuYXRpdmUgc2tpbiBvciBDT05GSUdfWEVOT19PUFRfUEVS
VkFTSVZFIGRpc2FibGVkLgoobW9kcHJvYmUgeGVub19uYXRpdmU/KQoKVHVlIFNlcCAyNSAwNzoz
NzoyMyBDRVNUIDIwMDcKcnVubmluZzogLi9ydW4gLS0gLXAgMTAgLW4gLWwgMTAwMCAjIGN5Y2xp
Y3Rlc3QKKgoqCiogVHlwZSBeQyB0byBzdG9wIHRoaXMgYXBwbGljYXRpb24uCioKKgpYZW5vbWFp
OiBQT1NJWCBza2luIG9yIENPTkZJR19YRU5PX09QVF9QRVJWQVNJVkUgZGlzYWJsZWQuCihtb2Rw
cm9iZSB4ZW5vX3Bvc2l4PykKClR1ZSBTZXAgMjUgMDc6Mzc6MjQgQ0VTVCAyMDA3CnJ1bm5pbmc6
IGNhdCAvcHJvYy9pbnRlcnJ1cHRzCiAgICAgICAgICAgQ1BVMCAgICAgICAKICAwOiAgICAzNzU1
ODk0ICAgIFhULVBJQy1YVCAgICAgICAgdGltZXIsIHJ0aGFsX2Jyb2FkY2FzdF90aW1lcgogIDE6
ICAgICAgICAgNDIgICAgWFQtUElDLVhUICAgICAgICBpODA0MgogIDI6ICAgICAgICAgIDAgICAg
WFQtUElDLVhUICAgICAgICBjYXNjYWRlCiAgNTogICAgIDE2NDg5NyAgICBYVC1QSUMtWFQgICAg
ICAgIHVoY2lfaGNkOnVzYjEsIGV0aDMsIGk5MTVAcGNpOjAwMDA6MDA6MDIuMAogIDc6ICAgICAg
IDQ5MjYgICAgWFQtUElDLVhUICAgICAgICBlaGNpX2hjZDp1c2IzCiAgODogICAgICAgICAgMyAg
ICBYVC1QSUMtWFQgICAgICAgIHJ0YwogIDk6ICAgICAxMDgyMzQgICAgWFQtUElDLVhUICAgICAg
ICBldGgwCiAxMjogICAgICAgIDkxMiAgICBYVC1QSUMtWFQgICAgICAgIGk4MDQyCiAxNDogICAg
ICAyNjYzOSAgICBYVC1QSUMtWFQgICAgICAgIGlkZTAKIDE1OiAgICAgICAzNzUyICAgIFhULVBJ
Qy1YVCAgICAgICAgdWhjaV9oY2Q6dXNiMiwgZXRoMSwgZXRoMgpOTUk6ICAgICAgIDE5NjEgCkxP
QzogICAgMzc1NTc5OSAKRVJSOiAgICAgICAgICAwCk1JUzogICAgICAgICAgMAoKVHVlIFNlcCAy
NSAwNzozNzoyNCBDRVNUIDIwMDcKcnVubmluZzogY2F0IC9wcm9jL2xvYWRhdmcKMC4xMCAwLjA1
IDAuMDMgNC8xMTggOTA5MwoKVHVlIFNlcCAyNSAwNzozNzoyNCBDRVNUIDIwMDcKcnVubmluZzog
Y2F0IC9wcm9jL21lbWluZm8KTWVtVG90YWw6ICAgICAgIDUwNjU3NiBrQgpNZW1GcmVlOiAgICAg
ICAgMTAzMTk2IGtCCkJ1ZmZlcnM6ICAgICAgICAgODgyODgga0IKQ2FjaGVkOiAgICAgICAgIDE0
NDg1NiBrQgpTd2FwQ2FjaGVkOiAgICAgICAgICAwIGtCCkFjdGl2ZTogICAgICAgICAxNjMzNzYg
a0IKSW5hY3RpdmU6ICAgICAgIDE0Njg2OCBrQgpIaWdoVG90YWw6ICAgICAgICAgICAwIGtCCkhp
Z2hGcmVlOiAgICAgICAgICAgIDAga0IKTG93VG90YWw6ICAgICAgIDUwNjU3NiBrQgpMb3dGcmVl
OiAgICAgICAgMTAzMTk2IGtCClN3YXBUb3RhbDogICAgIDE0Nzc5NDAga0IKU3dhcEZyZWU6ICAg
ICAgMTQ3Nzk0MCBrQgpEaXJ0eTogICAgICAgICAgICAgIDUyIGtCCldyaXRlYmFjazogICAgICAg
ICAgIDAga0IKQW5vblBhZ2VzOiAgICAgICA3NzEwNCBrQgpNYXBwZWQ6ICAgICAgICAgIDM0NjQ0
IGtCClNsYWI6ICAgICAgICAgICAgMjkxODAga0IKU1JlY2xhaW1hYmxlOiAgICAxNzg4NCBrQgpT
VW5yZWNsYWltOiAgICAgIDExMjk2IGtCClBhZ2VUYWJsZXM6ICAgICAgIDE4ODgga0IKTkZTX1Vu
c3RhYmxlOiAgICAgICAgMCBrQgpCb3VuY2U6ICAgICAgICAgICAgICAwIGtCCkNvbW1pdExpbWl0
OiAgIDE3MzEyMjgga0IKQ29tbWl0dGVkX0FTOiAgIDM4NjM3MiBrQgpWbWFsbG9jVG90YWw6ICAg
NTE2MDg4IGtCClZtYWxsb2NVc2VkOiAgICAgIDQyODgga0IKVm1hbGxvY0NodW5rOiAgIDUxMTYw
NCBrQgoKVHVlIFNlcCAyNSAwNzozNzoyNCBDRVNUIDIwMDcKcnVubmluZzogY2F0IC9wcm9jL3hl
bm9tYWkvYXBjCkFQQyAgICAgICAgICBDUFUwCiAgMDogICAgICAgICAgICAwICAgIChwaXBlX3dh
a2V1cCkKICAxOiAgICAgICAgICAgIDAgICAgKGxvc3RhZ2VfaGFuZGxlcikKICAyOiAgICAgICAg
ICAgIDAgICAgKHJlZ2lzdHJ5X2V4cG9ydCkKICAzOiAgICAgICAgICAgIDAgICAgKHBvc2l4X3Np
Z25hbHNfaGFuZGxlcikKClR1ZSBTZXAgMjUgMDc6Mzc6MjQgQ0VTVCAyMDA3CnJ1bm5pbmc6IGNh
dCAvcHJvYy94ZW5vbWFpL2ZhdWx0cwpUUkFQICAgICAgICAgQ1BVMAogIDA6ICAgICAgICAgICAg
MCAgICAoRGl2aWRlIGVycm9yKQogIDE6ICAgICAgICAgICAgMCAgICAoRGVidWcpCiAgMzogICAg
ICAgICAgICAwICAgIChJbnQzKQogIDQ6ICAgICAgICAgICAgMCAgICAoT3ZlcmZsb3cpCiAgNTog
ICAgICAgICAgICAwICAgIChCb3VuZHMpCiAgNjogICAgICAgICAgICAwICAgIChJbnZhbGlkIG9w
Y29kZSkKICA3OiAgICAgICAgICAgIDAgICAgKEZQVSBub3QgYXZhaWxhYmxlKQogIDg6ICAgICAg
ICAgICAgMCAgICAoRG91YmxlIGZhdWx0KQogIDk6ICAgICAgICAgICAgMCAgICAoRlBVIHNlZ21l
bnQgb3ZlcnJ1bikKIDEwOiAgICAgICAgICAgIDAgICAgKEludmFsaWQgVFNTKQogMTE6ICAgICAg
ICAgICAgMCAgICAoU2VnbWVudCBub3QgcHJlc2VudCkKIDEyOiAgICAgICAgICAgIDAgICAgKFN0
YWNrIHNlZ21lbnQpCiAxMzogICAgICAgICAgICAwICAgIChHZW5lcmFsIHByb3RlY3Rpb24pCiAx
NDogICAgICAgICAgICAwICAgIChQYWdlIGZhdWx0KQogMTU6ICAgICAgICAgICAgMCAgICAoU3B1
cmlvdXMgaW50ZXJydXB0KQogMTY6ICAgICAgICAgICAgMCAgICAoRlBVIGVycm9yKQogMTc6ICAg
ICAgICAgICAgMCAgICAoQWxpZ25tZW50IGNoZWNrKQogMTg6ICAgICAgICAgICAgMCAgICAoTWFj
aGluZSBjaGVjaykKIDE5OiAgICAgICAgICAgIDAgICAgKFNJTUQgZXJyb3IpCgpUdWUgU2VwIDI1
IDA3OjM3OjI0IENFU1QgMjAwNwpydW5uaW5nOiBjYXQgL3Byb2MveGVub21haS9oYWwKMS44LTA4
CgpUdWUgU2VwIDI1IDA3OjM3OjI0IENFU1QgMjAwNwpydW5uaW5nOiBjYXQgL3Byb2MveGVub21h
aS9oZWFwCnNpemU9MTMwNTYwOnVzZWQ9NjQ6cGFnZXN6PTUxMgoKVHVlIFNlcCAyNSAwNzozNzoy
NCBDRVNUIDIwMDcKcnVubmluZzogY2F0IC9wcm9jL3hlbm9tYWkvaXJxCklSUSAgICAgICAgIENQ
VTAKMjMwOiAgICAgICAgICAgMAoyMzM6ICAgICAgICA3NTA2ICAgICAgICAgW3RpbWVyXQoyMzQ6
ICAgICAgICAgICAwCjI1ODogICAgICAgICAgIDAgICAgICAgICBbdmlydHVhbF0KClR1ZSBTZXAg
MjUgMDc6Mzc6MjQgQ0VTVCAyMDA3CnJ1bm5pbmc6IGNhdCAvcHJvYy94ZW5vbWFpL2xhdGVuY3kK
MjY5OQoKVHVlIFNlcCAyNSAwNzozNzoyNCBDRVNUIDIwMDcKcnVubmluZzogY2F0IC9wcm9jL3hl
bm9tYWkvc2NoZWQKQ1BVICBQSUQgICAgUFJJICAgICAgUEVSSU9EICAgVElNRU9VVCAgICBTVEFU
ICAgICAgIE5BTUUKICAwICAwICAgICAgIC0xICAgICAgMCAgICAgICAgMCAgICAgICAgICBSICAg
ICAgICAgIFJPT1QvMAoKVHVlIFNlcCAyNSAwNzozNzoyNCBDRVNUIDIwMDcKcnVubmluZzogY2F0
IC9wcm9jL3hlbm9tYWkvc3RhdApDUFUgIFBJRCAgICBNU1cgICAgICAgIENTVyAgICAgICAgUEYg
ICAgU1RBVCAgICAgICAlQ1BVICBOQU1FCiAgMCAgMCAgICAgIDAgICAgICAgICAgMCAgICAgICAg
ICAwICAgICAwMDUwMDA4MCAgMTAwLjAgIFJPT1QvMAogIDAgIDAgICAgICAwICAgICAgICAgIDc1
MDYgICAgICAgMCAgICAgMDAwMDAwMDAgICAgMC4wICBJUlEyMzM6IFt0aW1lcl0KClR1ZSBTZXAg
MjUgMDc6Mzc6MjQgQ0VTVCAyMDA3CnJ1bm5pbmc6IGNhdCAvcHJvYy94ZW5vbWFpL3RpbWVyCnN0
YXR1cz1vbmVzaG90K3dhdGNoZG9nOnNldHVwPTg0OnRpY2t2YWw9MTpqaWZmaWVzPTM3NzIxMTAy
NjgxODUKClR1ZSBTZXAgMjUgMDc6Mzc6MjQgQ0VTVCAyMDA3CnJ1bm5pbmc6IGNhdCAvcHJvYy94
ZW5vbWFpL3ZlcnNpb24KMi4zLjMKClR1ZSBTZXAgMjUgMDc6Mzc6MjQgQ0VTVCAyMDA3CnJ1bm5p
bmc6IGNhdCAvcHJvYy94ZW5vbWFpL2ludGVyZmFjZXMvbmF0aXZlCjAKClR1ZSBTZXAgMjUgMDc6
Mzc6MjQgQ0VTVCAyMDA3CnJ1bm5pbmc6IGNhdCAvcHJvYy94ZW5vbWFpL2ludGVyZmFjZXMvcG9z
aXgKMAoKVHVlIFNlcCAyNSAwNzozNzoyNCBDRVNUIDIwMDcKcnVubmluZzogY2F0IC9wcm9jL3hl
bm9tYWkvaW50ZXJmYWNlcy9ydGRtCjAKClR1ZSBTZXAgMjUgMDc6Mzc6MjQgQ0VTVCAyMDA3CnJ1
bm5pbmc6IGNhdCAvcHJvYy94ZW5vbWFpL2ludGVyZmFjZXMvc3lzCjAKClR1ZSBTZXAgMjUgMDc6
Mzc6MjQgQ0VTVCAyMDA3CnJ1bm5pbmc6IGNhdCAvcHJvYy94ZW5vbWFpL3J0ZG0vZmlsZGVzCnRv
dGFsPTEyODpvcGVuPTA6ZnJlZT0xMjgKClR1ZSBTZXAgMjUgMDc6Mzc6MjQgQ0VTVCAyMDA3CnJ1
bm5pbmc6IGNhdCAvcHJvYy94ZW5vbWFpL3J0ZG0vbmFtZWRfZGV2aWNlcwpIYXNoCU5hbWUJCQkJ
RHJpdmVyCQkvcHJvYwoKVHVlIFNlcCAyNSAwNzozNzoyNCBDRVNUIDIwMDcKcnVubmluZzogY2F0
IC9wcm9jL3hlbm9tYWkvcnRkbS9vcGVuX2ZpbGRlcwpJbmRleAlMb2NrZWQJRGV2aWNlCgpUdWUg
U2VwIDI1IDA3OjM3OjI0IENFU1QgMjAwNwpydW5uaW5nOiBjYXQgL3Byb2MveGVub21haS9ydGRt
L3Byb3RvY29sX2RldmljZXMKSGFzaAlQcm90b2NvbEZhbWlseTpTb2NrZXRUeXBlCURyaXZlcgkJ
L3Byb2MKClR1ZSBTZXAgMjUgMDc6Mzc6MjQgQ0VTVCAyMDA3CnJ1bm5pbmc6IHRvcCAtYm4xYwp0
b3AgLSAwNzozNzoyNCB1cCAgMTowMiwgIDIgdXNlcnMsICBsb2FkIGF2ZXJhZ2U6IDAuMTAsIDAu
MDUsIDAuMDMKVGFza3M6IDEwOCB0b3RhbCwgICAxIHJ1bm5pbmcsIDEwNyBzbGVlcGluZywgICAw
IHN0b3BwZWQsICAgMCB6b21iaWUKQ3B1KHMpOiAgMC44JXVzLCAgMC4zJXN5LCAgMC4yJW5pLCA5
NC4zJWlkLCAgNC40JXdhLCAgMC4wJWhpLCAgMC4wJXNpLCAgMC4wJXN0Ck1lbTogICAgNTA2NTc2
ayB0b3RhbCwgICA0MDMzODBrIHVzZWQsICAgMTAzMTk2ayBmcmVlLCAgICA4ODI4OGsgYnVmZmVy
cwpTd2FwOiAgMTQ3Nzk0MGsgdG90YWwsICAgICAgICAwayB1c2VkLCAgMTQ3Nzk0MGsgZnJlZSwg
ICAxNDQ4OTZrIGNhY2hlZAoKICBQSUQgVVNFUiAgICAgIFBSICBOSSAgVklSVCAgUkVTICBTSFIg
UyAlQ1BVICVNRU0gICAgVElNRSsgIENPTU1BTkQgICAgICAgICAgICAKICAgIDEgcm9vdCAgICAg
IDE4ICAgMCAgMjQ3MiAxNTM2ICA1ODggUyAgMC4wICAwLjMgICAwOjAxLjYzIC9zYmluL2luaXQg
ICAgICAgICAKICAgIDIgcm9vdCAgICAgIFJUICAgMCAgICAgMCAgICAwICAgIDAgUyAgMC4wICAw
LjAgICAwOjAwLjAwIFttaWdyYXRpb24vMF0gICAgICAKICAgIDMgcm9vdCAgICAgIDM0ICAxOSAg
ICAgMCAgICAwICAgIDAgUyAgMC4wICAwLjAgICAwOjAwLjAwIFtrc29mdGlycWQvMF0gICAgICAK
Y2xlYW51cF9sb2FkOiBubyBkZF9qb2JzIGZvdW5kCnhlbm8tdGVzdDogZmluaXNoZWQK

--0__=4EBBF9F3DFADB5BF8f9e8a93df938690918c4EBBF9F3DFADB5BF--


