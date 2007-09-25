In-Reply-To: <2ff1a98a0709250152m5d96437br8e98ba405fd4d471@domain.hid>
Message-ID: <OF905A8D7D.169331D8-ONC1257361.003BBCD9-C1257361.0046E005@domain.hid>
From: juergen.lanner@domain.hid
Date: Tue, 25 Sep 2007 14:54:30 +0200
MIME-Version: 1.0
Content-type: multipart/mixed; 
	Boundary="0__=4EBBF9F2DFA83A498f9e8a93df938690918c4EBBF9F2DFA83A49"
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

--0__=4EBBF9F2DFA83A498f9e8a93df938690918c4EBBF9F2DFA83A49
Content-type: multipart/related; 
	Boundary="1__=4EBBF9F2DFA83A498f9e8a93df938690918c4EBBF9F2DFA83A49"

--1__=4EBBF9F2DFA83A498f9e8a93df938690918c4EBBF9F2DFA83A49
Content-type: multipart/alternative; 
	Boundary="2__=4EBBF9F2DFA83A498f9e8a93df938690918c4EBBF9F2DFA83A49"

--2__=4EBBF9F2DFA83A498f9e8a93df938690918c4EBBF9F2DFA83A49
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: quoted-printable


Hi Gilles!


Yes, you're right, it was the SMP option that hid the LAPIC.

Unfortunately switching it on and enabling it at boot gives the same re=
sult
as before, although the startup log seems ok as well.
(see here complete boot log: (See attached file:
boot_with_lapic_on_in_kernel_and_boot.txt))


Deactivating LAPIC in kernel: same problem, no change
(see here the complete boot log:(See attached file:
boot_with_lapic_off_in_kernel.txt) )

=3D=3D> maybe LAPIC is not really an issue here?
At least it doesn't change anything if active or not.




Maybe that is important:
 I saw that when installing the kernel there were some messages due to
files not found.

The funny thing is that I am using xenomai 2.3.3, not 2.3.0
Could the problem be due to this?

root@domain.hid# dpkg -i
linux-image-2.6.20.19-lapic-on-adeos-xenomai2.3.0
_2.6.20.19-lapic-on-adeos-xenomai2.3.0-10.00.Custom_i386.deb
Selecting previously deselected package
linux-image-2.6.20.19-lapic-on-adeos-xenomai2.3.0.
(Reading database ... 117228 files and directories currently installed.=
)
Unpacking linux-image-2.6.20.19-lapic-on-adeos-xenomai2.3.0 (from
linux-image-2.6.20.19-lapic-on-adeos-xenomai2.3.0
_2.6.20.19-lapic-on-adeos-xenomai2.3.0-10.00.Custom_i386.deb) ...
Done.
Setting up linux-image-2.6.20.19-lapic-on-adeos-xenomai2.3.0
(2.6.20.19-lapic-on-adeos-xenomai2.3.0-10.00.Custom) ...
Running depmod.
update-initramfs: Generating
/boot/initrd.img-2.6.20.19-lapic-on-adeos-xenomai2.3.0
find: /lib/firmware/2.6.20.19-lapic-on-adeos-xenomai2.3.0: No such file=
 or
directory
find: /lib/firmware/2.6.20.19-lapic-on-adeos-xenomai2.3.0: No such file=
 or
directory
find: /lib/firmware/2.6.20.19-lapic-on-adeos-xenomai2.3.0: No such file=
 or
directory
find: /lib/firmware/2.6.20.19-lapic-on-adeos-xenomai2.3.0: No such file=
 or
directory
find: /lib/firmware/2.6.20.19-lapic-on-adeos-xenomai2.3.0: No such file=
 or
directory
find: /lib/firmware/2.6.20.19-lapic-on-adeos-xenomai2.3.0: No such file=
 or
directory
Running postinst hook script /sbin/update-grub.
You shouldn't call /sbin/update-grub. Please call /usr/sbin/update-grub=

instead!

Searching for GRUB installation directory ... found: /boot/grub
Testing for an existing GRUB menu.lst file ... found: /boot/grub/menu.l=
st
Searching for splash image ... none found, skipping ...
Found kernel: /boot/vmlinuz-2.6.20-15-generic
Found kernel: /boot/memtest86+.bin
Updating /boot/grub/menu.lst ... done



Thanks for your help!

Juergen





                                                                       =
    
             "Gilles                                                   =
    
             Chanteperdrix"                                            =
    
             <gilles.chanteper                                         =
 To 
             drix@domain.hid>           "juergen.lanner@domain.hid"     =
    
                                       <juergen.lanner@domain.hid>     =
    
             25.09.2007 10:52                                          =
 cc 
                                       xenomai@xenomai.org            =
    
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
    




On 9/25/07, juergen.lanner@domain.hid <juergen.lanner@domain.hid> wrote=
:
>
>
>
> Hello Gilles!
>
>  Thank you very much for your reponse.
>
>  LAPIC is disabled in BIOS, so "make menuconfig" does not even give m=
e
the possibility to change it at all.
>  in the .config file I could find CONFIG_X86_LOCAL_APIC=3Dy.
>  I f I set it to =3Dn and start "make menuconfig" again, it resets it=
 to y
even if I do not change anything manually.

The reason why make menuconfig does not let you change the LAPIC
setting is that you selected the "SMP" option. Since your box only has
one CPU, you should disable SMP. Then you will be able to enable or
disable the local APIC. Note that if your box has an APIC, using it
gives better performances.

--
                                               Gilles Chanteperdrix
=

--2__=4EBBF9F2DFA83A498f9e8a93df938690918c4EBBF9F2DFA83A49
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline
Content-transfer-encoding: quoted-printable

<html><body>
<p><font face=3D"Arial">Hi Gilles!</font><br>
<br>
<br>
<font face=3D"Arial">Yes, you're right, it was the SMP option that hid =
the LAPIC.</font><br>
<br>
<font face=3D"Arial">Unfortunately switching it on and enabling it at b=
oot gives the same result as before, although the startup log seems ok =
as well.</font><br>
<font face=3D"Arial">(see here complete boot log: </font><i>(See attach=
ed file: boot_with_lapic_on_in_kernel_and_boot.txt)</i><font face=3D"Ar=
ial">)</font><br>
<br>
<br>
<font face=3D"Arial">Deactivating LAPIC in kernel: same problem, no cha=
nge</font><br>
<font face=3D"Arial">(see here the complete boot log:</font><i>(See att=
ached file: boot_with_lapic_off_in_kernel.txt)</i><font face=3D"Arial">=
 )</font><br>
<br>
<font face=3D"Arial">=3D=3D&gt; maybe LAPIC is not really an issue here=
?</font><br>
<font face=3D"Arial">At least it doesn't change anything if active or n=
ot.</font><br>
<br>
<br>
<br>
<br>
<font face=3D"Arial">Maybe that is important: </font><br>
<font face=3D"Arial"> I saw that when installing the kernel there were =
some messages due to files not found.</font><br>
<br>
<font face=3D"Arial">The funny thing is that I am using xenomai 2.3.3, =
not 2.3.0</font><br>
<font face=3D"Arial">Could the problem be due to this?</font><br>
<br>
<font face=3D"Arial">root@domain.hid# dpkg -i linux-image-2.=
6.20.19-lapic-on-adeos-xenomai2.3.0_2.6.20.19-lapic-on-adeos-xenomai2.3=
.0-10.00.Custom_i386.deb</font><br>
<font face=3D"Arial">Selecting previously deselected package linux-imag=
e-2.6.20.19-lapic-on-adeos-xenomai2.3.0.</font><br>
<font face=3D"Arial">(Reading database ... 117228 files and directories=
 currently installed.)</font><br>
<font face=3D"Arial">Unpacking linux-image-2.6.20.19-lapic-on-adeos-xen=
omai2.3.0 (from linux-image-2.6.20.19-lapic-on-adeos-xenomai2.3.0_2.6.2=
0.19-lapic-on-adeos-xenomai2.3.0-10.00.Custom_i386.deb) ...</font><br>
<font face=3D"Arial">Done.</font><br>
<font face=3D"Arial">Setting up linux-image-2.6.20.19-lapic-on-adeos-xe=
nomai2.3.0 (2.6.20.19-lapic-on-adeos-xenomai2.3.0-10.00.Custom) ...</fo=
nt><br>
<font face=3D"Arial">Running depmod.</font><br>
<font face=3D"Arial">update-initramfs: Generating /boot/initrd.img-2.6.=
20.19-lapic-on-adeos-xenomai2.3.0</font><br>
<font face=3D"Arial">find: /lib/firmware/2.6.20.19-lapic-on-adeos-xenom=
ai2.3.0: No such file or directory</font><br>
<font face=3D"Arial">find: /lib/firmware/2.6.20.19-lapic-on-adeos-xenom=
ai2.3.0: No such file or directory</font><br>
<font face=3D"Arial">find: /lib/firmware/2.6.20.19-lapic-on-adeos-xenom=
ai2.3.0: No such file or directory</font><br>
<font face=3D"Arial">find: /lib/firmware/2.6.20.19-lapic-on-adeos-xenom=
ai2.3.0: No such file or directory</font><br>
<font face=3D"Arial">find: /lib/firmware/2.6.20.19-lapic-on-adeos-xenom=
ai2.3.0: No such file or directory</font><br>
<font face=3D"Arial">find: /lib/firmware/2.6.20.19-lapic-on-adeos-xenom=
ai2.3.0: No such file or directory</font><br>
<font face=3D"Arial">Running postinst hook script /sbin/update-grub.</f=
ont><br>
<font face=3D"Arial">You shouldn't call /sbin/update-grub. Please call =
/usr/sbin/update-grub instead!</font><br>
<br>
<font face=3D"Arial">Searching for GRUB installation directory ... foun=
d: /boot/grub</font><br>
<font face=3D"Arial">Testing for an existing GRUB menu.lst file ... fou=
nd: /boot/grub/menu.lst</font><br>
<font face=3D"Arial">Searching for splash image ... none found, skippin=
g ...</font><br>
<font face=3D"Arial">Found kernel: /boot/vmlinuz-2.6.20-15-generic</fon=
t><br>
<font face=3D"Arial">Found kernel: /boot/memtest86+.bin</font><br>
<font face=3D"Arial">Updating /boot/grub/menu.lst ... done</font><br>
<br>
<br>
<br>
<font face=3D"Arial">Thanks for your help!</font><br>
<br>
<font face=3D"Arial">Juergen</font><br>
<font face=3D"Arial"><br>
<br>
</font><br>
<img width=3D"16" height=3D"16" src=3D"cid:3__=3D4EBBF9F2DFA83A498f9e8a=
93df938@domain.hid" border=3D"0" alt=3D"Inactive hide details for &quot=
;Gilles Chanteperdrix&quot; &lt;gilles.chanteperdrix@xenomai.org&gt;">&qu=
ot;Gilles Chanteperdrix&quot; &lt;gilles.chanteperdrix@xenomai.org&gt;<br=
>
<br>
<br>

<table width=3D"100%" border=3D"0" cellspacing=3D"0" cellpadding=3D"0">=

<tr valign=3D"top"><td style=3D"background-image:url(cid:4__=3D4EBBF9F2=
DFA83A498f9e8a93df938@domain.hid); background-repeat: no-repeat; " widt=
h=3D"40%">
<ul>
<ul>
<ul>
<ul><b><font size=3D"2">&quot;Gilles Chanteperdrix&quot; &lt;gilles.cha=
nteperdrix@domain.hid&gt;</font></b><font size=3D"2"> </font>
<p><font size=3D"2">25.09.2007 10:52</font></ul>
</ul>
</ul>
</ul>
</td><td width=3D"60%">
<table width=3D"100%" border=3D"0" cellspacing=3D"0" cellpadding=3D"0">=

<tr valign=3D"top"><td width=3D"1%" valign=3D"middle"><img width=3D"58"=
 height=3D"1" src=3D"cid:5__=3D4EBBF9F2DFA83A498f9e8a93df938@domain.hid=
" border=3D"0" alt=3D""><br>
<div align=3D"right"><font size=3D"2">To</font></div></td><td width=3D"=
100%"><img width=3D"1" height=3D"1" src=3D"cid:5__=3D4EBBF9F2DFA83A498f=
9e8a93df938@domain.hid" border=3D"0" alt=3D""><br>
<font size=3D"2">&quot;juergen.lanner@domain.hid&quot; &lt;juergen.lann=
er@domain.hid&gt;</font></td></tr>

<tr valign=3D"top"><td width=3D"1%" valign=3D"middle"><img width=3D"58"=
 height=3D"1" src=3D"cid:5__=3D4EBBF9F2DFA83A498f9e8a93df938@domain.hid=
" border=3D"0" alt=3D""><br>
<div align=3D"right"><font size=3D"2">cc</font></div></td><td width=3D"=
100%"><img width=3D"1" height=3D"1" src=3D"cid:5__=3D4EBBF9F2DFA83A498f=
9e8a93df938@domain.hid" border=3D"0" alt=3D""><br>
<font size=3D"2">xenomai@xenomai.org</font></td></tr>

<tr valign=3D"top"><td width=3D"1%" valign=3D"middle"><img width=3D"58"=
 height=3D"1" src=3D"cid:5__=3D4EBBF9F2DFA83A498f9e8a93df938@domain.hid=
" border=3D"0" alt=3D""><br>
<div align=3D"right"><font size=3D"2">Subject</font></div></td><td widt=
h=3D"100%"><img width=3D"1" height=3D"1" src=3D"cid:5__=3D4EBBF9F2DFA83=
A498f9e8a93df938@domain.hid" border=3D"0" alt=3D""><br>
<font size=3D"2">Re: [Xenomai-help] POSIX skin or CONFIG_XENO_OPT_PERVA=
SIVE disabled</font></td></tr>
</table>

<table border=3D"0" cellspacing=3D"0" cellpadding=3D"0">
<tr valign=3D"top"><td width=3D"58"><img width=3D"1" height=3D"1" src=3D=
"cid:5__=3D4EBBF9F2DFA83A498f9e8a93df938@domain.hid" border=3D"0" alt=3D=
""></td><td width=3D"336"><img width=3D"1" height=3D"1" src=3D"cid:5__=3D=
4EBBF9F2DFA83A498f9e8a93df938@domain.hid" border=3D"0" alt=3D""></td></=
tr>
</table>
</td></tr>
</table>
<br>
<tt>On 9/25/07, juergen.lanner@domain.hid &lt;juergen.lanner@domain.hid=
&gt; wrote:<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Hello Gilles!<br>
&gt;<br>
&gt; &nbsp;Thank you very much for your reponse.<br>
&gt;<br>
&gt; &nbsp;LAPIC is disabled in BIOS, so &quot;make menuconfig&quot; do=
es not even give me the possibility to change it at all.<br>
&gt; &nbsp;in the .config file I could find CONFIG_X86_LOCAL_APIC=3Dy.<=
br>
&gt; &nbsp;I f I set it to =3Dn and start &quot;make menuconfig&quot; a=
gain, it resets it to y even if I do not change anything manually.<br>
<br>
The reason why make menuconfig does not let you change the LAPIC<br>
setting is that you selected the &quot;SMP&quot; option. Since your box=
 only has<br>
one CPU, you should disable SMP. Then you will be able to enable or<br>=

disable the local APIC. Note that if your box has an APIC, using it<br>=

gives better performances.<br>
<br>
-- <br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; Gilles Chanteperdrix<br>
</tt><br>
</body></html>=


--2__=4EBBF9F2DFA83A498f9e8a93df938690918c4EBBF9F2DFA83A49--


--1__=4EBBF9F2DFA83A498f9e8a93df938690918c4EBBF9F2DFA83A49
Content-type: image/gif; 
	name="graycol.gif"
Content-Disposition: inline; filename="graycol.gif"
Content-ID: <3__=4EBBF9F2DFA83A498f9e8a93df938@domain.hid>
Content-transfer-encoding: base64

R0lGODlhEAAQAKECAMzMzAAAAP///wAAACH5BAEAAAIALAAAAAAQABAAAAIXlI+py+0PopwxUbpu
ZRfKZ2zgSJbmSRYAIf4fT3B0aW1pemVkIGJ5IFVsZWFkIFNtYXJ0U2F2ZXIhAAA7

--1__=4EBBF9F2DFA83A498f9e8a93df938690918c4EBBF9F2DFA83A49
Content-type: image/gif; 
	name="pic21457.gif"
Content-Disposition: inline; filename="pic21457.gif"
Content-ID: <4__=4EBBF9F2DFA83A498f9e8a93df938@domain.hid>
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

--1__=4EBBF9F2DFA83A498f9e8a93df938690918c4EBBF9F2DFA83A49
Content-type: image/gif; 
	name="ecblank.gif"
Content-Disposition: inline; filename="ecblank.gif"
Content-ID: <5__=4EBBF9F2DFA83A498f9e8a93df938@domain.hid>
Content-transfer-encoding: base64

R0lGODlhEAABAIAAAAAAAP///yH5BAEAAAEALAAAAAAQAAEAAAIEjI8ZBQA7


--1__=4EBBF9F2DFA83A498f9e8a93df938690918c4EBBF9F2DFA83A49--


--0__=4EBBF9F2DFA83A498f9e8a93df938690918c4EBBF9F2DFA83A49
Content-type: application/octet-stream; 
	name="boot_with_lapic_on_in_kernel_and_boot.txt"
Content-Disposition: attachment; filename="boot_with_lapic_on_in_kernel_and_boot.txt"
Content-ID: <1__=4EBBF9F2DFA83A498f9e8a93df938@domain.hid>
Content-transfer-encoding: base64

WyAgICAwLjAwMDAwMF0gTGludXggdmVyc2lvbiAyLjYuMjAuMTktbGFwaWMtb24tYWRlb3MteGVu
b21haTIuMy4wIChyb290QGduY3UtZGVza3RvcCkgKGdjYyB2ZXJzaW9uIDQuMS4yIChVYnVudHUg
NC4xLjItMHVidW50dTQpKSAjMSBUdWUgU2VwIDI1IDExOjE4OjQzIENFU1QgMjAwNwpbICAgIDAu
MDAwMDAwXSBCSU9TLXByb3ZpZGVkIHBoeXNpY2FsIFJBTSBtYXA6ClsgICAgMC4wMDAwMDBdIHNh
bml0aXplIHN0YXJ0ClsgICAgMC4wMDAwMDBdIHNhbml0aXplIGVuZApbICAgIDAuMDAwMDAwXSBj
b3B5X2U4MjBfbWFwKCkgc3RhcnQ6IDAwMDAwMDAwMDAwMDAwMDAgc2l6ZTogMDAwMDAwMDAwMDA5
ZjgwMCBlbmQ6IDAwMDAwMDAwMDAwOWY4MDAgdHlwZTogMQpbICAgIDAuMDAwMDAwXSBjb3B5X2U4
MjBfbWFwKCkgdHlwZSBpcyBFODIwX1JBTQpbICAgIDAuMDAwMDAwXSBjb3B5X2U4MjBfbWFwKCkg
c3RhcnQ6IDAwMDAwMDAwMDAwOWY4MDAgc2l6ZTogMDAwMDAwMDAwMDAwMDgwMCBlbmQ6IDAwMDAw
MDAwMDAwYTAwMDAgdHlwZTogMgpbICAgIDAuMDAwMDAwXSBjb3B5X2U4MjBfbWFwKCkgc3RhcnQ6
IDAwMDAwMDAwMDAwY2UwMDAgc2l6ZTogMDAwMDAwMDAwMDAwMjAwMCBlbmQ6IDAwMDAwMDAwMDAw
ZDAwMDAgdHlwZTogMgpbICAgIDAuMDAwMDAwXSBjb3B5X2U4MjBfbWFwKCkgc3RhcnQ6IDAwMDAw
MDAwMDAwZTAwMDAgc2l6ZTogMDAwMDAwMDAwMDAyMDAwMCBlbmQ6IDAwMDAwMDAwMDAxMDAwMDAg
dHlwZTogMgpbICAgIDAuMDAwMDAwXSBjb3B5X2U4MjBfbWFwKCkgc3RhcnQ6IDAwMDAwMDAwMDAx
MDAwMDAgc2l6ZTogMDAwMDAwMDAxZjVlMDAwMCBlbmQ6IDAwMDAwMDAwMWY2ZTAwMDAgdHlwZTog
MQpbICAgIDAuMDAwMDAwXSBjb3B5X2U4MjBfbWFwKCkgdHlwZSBpcyBFODIwX1JBTQpbICAgIDAu
MDAwMDAwXSBjb3B5X2U4MjBfbWFwKCkgc3RhcnQ6IDAwMDAwMDAwMWY2ZTAwMDAgc2l6ZTogMDAw
MDAwMDAwMDAwYTAwMCBlbmQ6IDAwMDAwMDAwMWY2ZWEwMDAgdHlwZTogMwpbICAgIDAuMDAwMDAw
XSBjb3B5X2U4MjBfbWFwKCkgc3RhcnQ6IDAwMDAwMDAwMWY2ZWEwMDAgc2l6ZTogMDAwMDAwMDAw
MDAxNjAwMCBlbmQ6IDAwMDAwMDAwMWY3MDAwMDAgdHlwZTogNApbICAgIDAuMDAwMDAwXSBjb3B5
X2U4MjBfbWFwKCkgc3RhcnQ6IDAwMDAwMDAwMWY3MDAwMDAgc2l6ZTogMDAwMDAwMDAwMDkwMDAw
MCBlbmQ6IDAwMDAwMDAwMjAwMDAwMDAgdHlwZTogMgpbICAgIDAuMDAwMDAwXSBjb3B5X2U4MjBf
bWFwKCkgc3RhcnQ6IDAwMDAwMDAwZmVjMTAwMDAgc2l6ZTogMDAwMDAwMDAwMDAxMDAwMCBlbmQ6
IDAwMDAwMDAwZmVjMjAwMDAgdHlwZTogMgpbICAgIDAuMDAwMDAwXSBjb3B5X2U4MjBfbWFwKCkg
c3RhcnQ6IDAwMDAwMDAwZmY4MDAwMDAgc2l6ZTogMDAwMDAwMDAwMDQwMDAwMCBlbmQ6IDAwMDAw
MDAwZmZjMDAwMDAgdHlwZTogMgpbICAgIDAuMDAwMDAwXSBjb3B5X2U4MjBfbWFwKCkgc3RhcnQ6
IDAwMDAwMDAwZmZmZmZjMDAgc2l6ZTogMDAwMDAwMDAwMDAwMDQwMCBlbmQ6IDAwMDAwMDAxMDAw
MDAwMDAgdHlwZTogMgpbICAgIDAuMDAwMDAwXSAgQklPUy1lODIwOiAwMDAwMDAwMDAwMDAwMDAw
IC0gMDAwMDAwMDAwMDA5ZjgwMCAodXNhYmxlKQpbICAgIDAuMDAwMDAwXSAgQklPUy1lODIwOiAw
MDAwMDAwMDAwMDlmODAwIC0gMDAwMDAwMDAwMDBhMDAwMCAocmVzZXJ2ZWQpClsgICAgMC4wMDAw
MDBdICBCSU9TLWU4MjA6IDAwMDAwMDAwMDAwY2UwMDAgLSAwMDAwMDAwMDAwMGQwMDAwIChyZXNl
cnZlZCkKWyAgICAwLjAwMDAwMF0gIEJJT1MtZTgyMDogMDAwMDAwMDAwMDBlMDAwMCAtIDAwMDAw
MDAwMDAxMDAwMDAgKHJlc2VydmVkKQpbICAgIDAuMDAwMDAwXSAgQklPUy1lODIwOiAwMDAwMDAw
MDAwMTAwMDAwIC0gMDAwMDAwMDAxZjZlMDAwMCAodXNhYmxlKQpbICAgIDAuMDAwMDAwXSAgQklP
Uy1lODIwOiAwMDAwMDAwMDFmNmUwMDAwIC0gMDAwMDAwMDAxZjZlYTAwMCAoQUNQSSBkYXRhKQpb
ICAgIDAuMDAwMDAwXSAgQklPUy1lODIwOiAwMDAwMDAwMDFmNmVhMDAwIC0gMDAwMDAwMDAxZjcw
MDAwMCAoQUNQSSBOVlMpClsgICAgMC4wMDAwMDBdICBCSU9TLWU4MjA6IDAwMDAwMDAwMWY3MDAw
MDAgLSAwMDAwMDAwMDIwMDAwMDAwIChyZXNlcnZlZCkKWyAgICAwLjAwMDAwMF0gIEJJT1MtZTgy
MDogMDAwMDAwMDBmZWMxMDAwMCAtIDAwMDAwMDAwZmVjMjAwMDAgKHJlc2VydmVkKQpbICAgIDAu
MDAwMDAwXSAgQklPUy1lODIwOiAwMDAwMDAwMGZmODAwMDAwIC0gMDAwMDAwMDBmZmMwMDAwMCAo
cmVzZXJ2ZWQpClsgICAgMC4wMDAwMDBdICBCSU9TLWU4MjA6IDAwMDAwMDAwZmZmZmZjMDAgLSAw
MDAwMDAwMTAwMDAwMDAwIChyZXNlcnZlZCkKWyAgICAwLjAwMDAwMF0gME1CIEhJR0hNRU0gYXZh
aWxhYmxlLgpbICAgIDAuMDAwMDAwXSA1MDJNQiBMT1dNRU0gYXZhaWxhYmxlLgpbICAgIDAuMDAw
MDAwXSBFbnRlcmluZyBhZGRfYWN0aXZlX3JhbmdlKDAsIDAsIDEyODczNikgMCBlbnRyaWVzIG9m
IDI1NiB1c2VkClsgICAgMC4wMDAwMDBdIFpvbmUgUEZOIHJhbmdlczoKWyAgICAwLjAwMDAwMF0g
ICBETUEgICAgICAgICAgICAgMCAtPiAgICAgNDA5NgpbICAgIDAuMDAwMDAwXSAgIE5vcm1hbCAg
ICAgICA0MDk2IC0+ICAgMTI4NzM2ClsgICAgMC4wMDAwMDBdICAgSGlnaE1lbSAgICAxMjg3MzYg
LT4gICAxMjg3MzYKWyAgICAwLjAwMDAwMF0gZWFybHlfbm9kZV9tYXBbMV0gYWN0aXZlIFBGTiBy
YW5nZXMKWyAgICAwLjAwMDAwMF0gICAgIDA6ICAgICAgICAwIC0+ICAgMTI4NzM2ClsgICAgMC4w
MDAwMDBdIE9uIG5vZGUgMCB0b3RhbHBhZ2VzOiAxMjg3MzYKWyAgICAwLjAwMDAwMF0gICBETUEg
em9uZTogMzIgcGFnZXMgdXNlZCBmb3IgbWVtbWFwClsgICAgMC4wMDAwMDBdICAgRE1BIHpvbmU6
IDAgcGFnZXMgcmVzZXJ2ZWQKWyAgICAwLjAwMDAwMF0gICBETUEgem9uZTogNDA2NCBwYWdlcywg
TElGTyBiYXRjaDowClsgICAgMC4wMDAwMDBdICAgTm9ybWFsIHpvbmU6IDk3MyBwYWdlcyB1c2Vk
IGZvciBtZW1tYXAKWyAgICAwLjAwMDAwMF0gICBOb3JtYWwgem9uZTogMTIzNjY3IHBhZ2VzLCBM
SUZPIGJhdGNoOjMxClsgICAgMC4wMDAwMDBdICAgSGlnaE1lbSB6b25lOiAwIHBhZ2VzIHVzZWQg
Zm9yIG1lbW1hcApbICAgIDAuMDAwMDAwXSBETUkgbm90IHByZXNlbnQgb3IgaW52YWxpZC4KWyAg
ICAwLjAwMDAwMF0gQWxsb2NhdGluZyBQQ0kgcmVzb3VyY2VzIHN0YXJ0aW5nIGF0IDMwMDAwMDAw
IChnYXA6IDIwMDAwMDAwOmRlYzEwMDAwKQpbICAgIDAuMDAwMDAwXSBEZXRlY3RlZCA4OTcuMTgz
IE1IeiBwcm9jZXNzb3IuClsgICAxNy4xMTMwNTVdIEJ1aWx0IDEgem9uZWxpc3RzLiAgVG90YWwg
cGFnZXM6IDEyNzczMQpbICAgMTcuMTEzMDYwXSBLZXJuZWwgY29tbWFuZCBsaW5lOiByb290PVVV
SUQ9ZTEwN2E5OTgtNjA5Yi00YzYzLWJkZDItNDA4OGJlOWUzMTFiIHJvIHNpbmdsZSBsYXBpYz0x
ClsgICAxNy4xMTM1OTFdIExvY2FsIEFQSUMgZGlzYWJsZWQgYnkgQklPUyAtLSByZWVuYWJsaW5n
LgpbICAgMTcuMTEzNTk1XSBGb3VuZCBhbmQgZW5hYmxlZCBsb2NhbCBBUElDIQpbICAgMTcuMTEz
NjAxXSBtYXBwZWQgQVBJQyB0byBmZmZmZDAwMCAoZmVlMDAwMDApClsgICAxNy4xMTM2MDZdIEVu
YWJsaW5nIGZhc3QgRlBVIHNhdmUgYW5kIHJlc3RvcmUuLi4gZG9uZS4KWyAgIDE3LjExMzYwOV0g
RW5hYmxpbmcgdW5tYXNrZWQgU0lNRCBGUFUgZXhjZXB0aW9uIHN1cHBvcnQuLi4gZG9uZS4KWyAg
IDE3LjExMzYyMl0gSW5pdGlhbGl6aW5nIENQVSMwClsgICAxNy4xMTM3MTRdIFBJRCBoYXNoIHRh
YmxlIGVudHJpZXM6IDIwNDggKG9yZGVyOiAxMSwgODE5MiBieXRlcykKWyAgIDE3LjExMzg2Nl0g
SS1waXBlIDEuOC0wODogcGlwZWxpbmUgZW5hYmxlZC4KWyAgIDE3LjExNTgwMl0gQ29uc29sZTog
Y29sb3VyIFZHQSsgODB4MjUKWyAgIDE3LjEyMDA3NV0gRGVudHJ5IGNhY2hlIGhhc2ggdGFibGUg
ZW50cmllczogNjU1MzYgKG9yZGVyOiA2LCAyNjIxNDQgYnl0ZXMpClsgICAxNy4xMjA1MThdIElu
b2RlLWNhY2hlIGhhc2ggdGFibGUgZW50cmllczogMzI3NjggKG9yZGVyOiA1LCAxMzEwNzIgYnl0
ZXMpClsgICAxNy4xNDA2NjVdIE1lbW9yeTogNTAwNjMyay81MTQ5NDRrIGF2YWlsYWJsZSAoMTc0
OWsga2VybmVsIGNvZGUsIDEzNzg4ayByZXNlcnZlZCwgODE5ayBkYXRhLCAyNTZrIGluaXQsIDBr
IGhpZ2htZW0pClsgICAxNy4xNDA3OTNdIHZpcnR1YWwga2VybmVsIG1lbW9yeSBsYXlvdXQ6Clsg
ICAxNy4xNDA3OTVdICAgICBmaXhtYXAgIDogMHhmZmZhZTAwMCAtIDB4ZmZmZmYwMDAgICAoIDMy
NCBrQikKWyAgIDE3LjE0MDc5OF0gICAgIHBrbWFwICAgOiAweGZmODAwMDAwIC0gMHhmZmMwMDAw
MCAgICg0MDk2IGtCKQpbICAgMTcuMTQwODAxXSAgICAgdm1hbGxvYyA6IDB4ZTAwMDAwMDAgLSAw
eGZmN2ZlMDAwICAgKCA1MDMgTUIpClsgICAxNy4xNDA4MDNdICAgICBsb3dtZW0gIDogMHhjMDAw
MDAwMCAtIDB4ZGY2ZTAwMDAgICAoIDUwMiBNQikKWyAgIDE3LjE0MDgwNl0gICAgICAgLmluaXQg
OiAweGMwMzg2MDAwIC0gMHhjMDNjNjAwMCAgICggMjU2IGtCKQpbICAgMTcuMTQwODA4XSAgICAg
ICAuZGF0YSA6IDB4YzAyYjU3NmQgLSAweGMwMzgyNDE0ICAgKCA4MTkga0IpClsgICAxNy4xNDA4
MTFdICAgICAgIC50ZXh0IDogMHhjMDEwMDAwMCAtIDB4YzAyYjU3NmQgICAoMTc0OSBrQikKWyAg
IDE3LjE0MTQ5MF0gQ2hlY2tpbmcgaWYgdGhpcyBwcm9jZXNzb3IgaG9ub3VycyB0aGUgV1AgYml0
IGV2ZW4gaW4gc3VwZXJ2aXNvciBtb2RlLi4uIE9rLgpbICAgMTcuMjAxNjY2XSBDYWxpYnJhdGlu
ZyBkZWxheSB1c2luZyB0aW1lciBzcGVjaWZpYyByb3V0aW5lLi4gMTc5NC40NyBCb2dvTUlQUyAo
bHBqPTg5NzIzOCkKWyAgIDE3LjIwMTg4M10gU2VjdXJpdHkgRnJhbWV3b3JrIHYxLjAuMCBpbml0
aWFsaXplZApbICAgMTcuMjAxOTk0XSBNb3VudC1jYWNoZSBoYXNoIHRhYmxlIGVudHJpZXM6IDUx
MgpbICAgMTcuMjAyMjI5XSBDUFU6IEFmdGVyIGdlbmVyaWMgaWRlbnRpZnksIGNhcHM6IGE3ZTlm
YmJmIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMTgwIDAwMDAwMDAwIDAwMDAwMDAw
ClsgICAxNy4yMDIyNDddIENQVTogTDEgSSBjYWNoZTogMzJLLCBMMSBEIGNhY2hlOiAzMksKWyAg
IDE3LjIwMjM5Nl0gQ1BVOiBMMiBjYWNoZTogMTAyNEsKWyAgIDE3LjIwMjQ4MF0gQ1BVOiBBZnRl
ciBhbGwgaW5pdHMsIGNhcHM6IGE3ZTlmYmJmIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAyMDQwIDAw
MDAwMTgwIDAwMDAwMDAwIDAwMDAwMDAwClsgICAxNy4yMDI0OTNdIENvbXBhdCB2RFNPIG1hcHBl
ZCB0byBmZmZmZTAwMC4KWyAgIDE3LjIwMjU4Nl0gQ1BVOiBJbnRlbCBNb2JpbGUgR2VudWluZSBJ
bnRlbChSKSBwcm9jZXNzb3IgICAgICAgMTEwME1IeiBzdGVwcGluZyAwNQpbICAgMTcuMjAyODg3
XSBDaGVja2luZyAnaGx0JyBpbnN0cnVjdGlvbi4uLiBPSy4KWyAgIDE3LjMwODk3MV0gTkVUOiBS
ZWdpc3RlcmVkIHByb3RvY29sIGZhbWlseSAxNgpbICAgMTcuMzA5MTU5XSBFSVNBIGJ1cyByZWdp
c3RlcmVkClsgICAxNy4zMTA2NjBdIFBDSTogUENJIEJJT1MgcmV2aXNpb24gMi4xMCBlbnRyeSBh
dCAweGZkOTU0LCBsYXN0IGJ1cz0zClsgICAxNy4zMTA3NDhdIFBDSTogVXNpbmcgY29uZmlndXJh
dGlvbiB0eXBlIDEKWyAgIDE3LjMxMDgzMl0gU2V0dGluZyB1cCBzdGFuZGFyZCBQQ0kgcmVzb3Vy
Y2VzClsgICAxNy4zMzE3MjldIExpbnV4IFBsdWcgYW5kIFBsYXkgU3VwcG9ydCB2MC45NyAoYykg
QWRhbSBCZWxheQpbICAgMTcuMzMxODI3XSBQblBCSU9TOiBTY2FubmluZyBzeXN0ZW0gZm9yIFBu
UCBCSU9TIHN1cHBvcnQuLi4KWyAgIDE3LjMzMTkxN10gUG5QQklPUzogRm91bmQgUG5QIEJJT1Mg
aW5zdGFsbGF0aW9uIHN0cnVjdHVyZSBhdCAweGMwMGY2NjUwClsgICAxNy4zMzIwMDhdIFBuUEJJ
T1M6IFBuUCBCSU9TIHZlcnNpb24gMS4wLCBlbnRyeSAweGYwMDAwOjB4YWE3ZCwgZHNlZyAweDQw
MApbICAgMTcuMzM0MjU1XSBQTlBCSU9TIGZhdWx0Li4gYXR0ZW1wdGluZyByZWNvdmVyeS4KWyAg
IDE3LjMzNDM0MF0gUG5QQklPUzogV2FybmluZyEgWW91ciBQblAgQklPUyBjYXVzZWQgYSBmYXRh
bCBlcnJvci4gQXR0ZW1wdGluZyB0byBjb250aW51ZQpbICAgMTcuMzM0NDQ2XSBQblBCSU9TOiBZ
b3UgbWF5IG5lZWQgdG8gcmVib290IHdpdGggdGhlICJwbnBiaW9zPW9mZiIgb3B0aW9uIHRvIG9w
ZXJhdGUgc3RhYmx5ClsgICAxNy4zMzQ1NTNdIFBuUEJJT1M6IENoZWNrIHdpdGggeW91ciB2ZW5k
b3IgZm9yIGFuIHVwZGF0ZWQgQklPUwpbICAgMTcuMzM0NjYyXSBQblBCSU9TOiBnZXRfZGV2X25v
ZGU6IHVuZXhwZWN0ZWQgc3RhdHVzIDB4MzcKWyAgIDE3LjMzNDc1MV0gUG5QQklPUzogMTUgbm9k
ZXMgcmVwb3J0ZWQgYnkgUG5QIEJJT1M7IDE1IHJlY29yZGVkIGJ5IGRyaXZlcgpbICAgMTcuMzM0
ODgyXSBQQ0k6IFByb2JpbmcgUENJIGhhcmR3YXJlClsgICAxNy4zMzQ5NjZdIFBDSTogUHJvYmlu
ZyBQQ0kgaGFyZHdhcmUgKGJ1cyAwMCkKWyAgIDE3LjMzNTEyOV0gQm9vdCB2aWRlbyBkZXZpY2Ug
aXMgMDAwMDowMDowMi4wClsgICAxNy4zMzU0MTNdIFBDSSBxdWlyazogcmVnaW9uIDEwMDAtMTA3
ZiBjbGFpbWVkIGJ5IElDSDQgQUNQSS9HUElPL1RDTwpbICAgMTcuMzM1NTAyXSBQQ0kgcXVpcms6
IHJlZ2lvbiAxMTgwLTExYmYgY2xhaW1lZCBieSBJQ0g0IEdQSU8KWyAgIDE3LjMzNTgzNV0gUENJ
OiBGaXJtd2FyZSBsZWZ0IDAwMDA6MDI6MDQuMCBlMTAwIGludGVycnVwdHMgZW5hYmxlZCwgZGlz
YWJsaW5nClsgICAxNy4zMzYwNThdIFBDSTogRmlybXdhcmUgbGVmdCAwMDAwOjAyOjA4LjAgZTEw
MCBpbnRlcnJ1cHRzIGVuYWJsZWQsIGRpc2FibGluZwpbICAgMTcuMzM2MjE3XSBQQ0k6IFRyYW5z
cGFyZW50IGJyaWRnZSAtIDAwMDA6MDA6MWUuMApbICAgMTcuMzM2MzY5XSBQQ0k6IEZpcm13YXJl
IGxlZnQgMDAwMDowMzowNy4wIGUxMDAgaW50ZXJydXB0cyBlbmFibGVkLCBkaXNhYmxpbmcKWyAg
IDE3LjMzNjUzN10gUENJOiBGaXJtd2FyZSBsZWZ0IDAwMDA6MDM6MDguMCBlMTAwIGludGVycnVw
dHMgZW5hYmxlZCwgZGlzYWJsaW5nClsgICAxNy4zMzc4MjFdIFBDSTogVXNpbmcgSVJRIHJvdXRl
ciBQSUlYL0lDSCBbODA4Ni8yNGMwXSBhdCAwMDAwOjAwOjFmLjAKWyAgIDE3LjMzNzkzMV0gUENJ
OiBzZXR0aW5nIElSUSA5IGFzIGxldmVsLXRyaWdnZXJlZApbICAgMTcuMzM3OTM2XSBQQ0k6IEZv
dW5kIElSUSA5IGZvciBkZXZpY2UgMDAwMDowMDoxZi4xClsgICAxNy4zMzgwMzhdIFBDSTogU2hh
cmluZyBJUlEgOSB3aXRoIDAwMDA6MDI6MDUuMApbICAgMTcuMzQ1Mjk4XSBORVQ6IFJlZ2lzdGVy
ZWQgcHJvdG9jb2wgZmFtaWx5IDgKWyAgIDE3LjM0NTM4M10gTkVUOiBSZWdpc3RlcmVkIHByb3Rv
Y29sIGZhbWlseSAyMApbICAgMTcuMzQ1NTI3XSBwbnA6IDAwOjA5OiBpb3BvcnQgcmFuZ2UgMHhm
ZTAwLTB4ZmUwMSBoYXMgYmVlbiByZXNlcnZlZApbICAgMTcuMzQ1NjI1XSBwbnA6IDAwOjBiOiBp
b3BvcnQgcmFuZ2UgMHg0ZDAtMHg0ZDEgaGFzIGJlZW4gcmVzZXJ2ZWQKWyAgIDE3LjM0NTcxNF0g
cG5wOiAwMDowYjogaW9wb3J0IHJhbmdlIDB4MTAwMC0weDEwNWYgaGFzIGJlZW4gcmVzZXJ2ZWQK
WyAgIDE3LjM0NTgwNF0gcG5wOiAwMDowYjogaW9wb3J0IHJhbmdlIDB4MTA2MC0weDEwN2YgaGFz
IGJlZW4gcmVzZXJ2ZWQKWyAgIDE3LjM0NTg5NV0gcG5wOiAwMDowYjogaW9wb3J0IHJhbmdlIDB4
MTE4MC0weDExYmYgaGFzIGJlZW4gcmVzZXJ2ZWQKWyAgIDE3LjM0NjI5Ml0gUENJOiBJZ25vcmUg
Ym9ndXMgcmVzb3VyY2UgNiBbMDowXSBvZiAwMDAwOjAwOjAyLjAKWyAgIDE3LjM0NjM5NF0gUENJ
OiBCcmlkZ2U6IDAwMDA6MDI6MDcuMApbICAgMTcuMzQ2NDc3XSAgIElPIHdpbmRvdzogNDAwMC00
ZmZmClsgICAxNy4zNDY1NjNdICAgTUVNIHdpbmRvdzogZTAzMDAwMDAtZTAzZmZmZmYKWyAgIDE3
LjM0NjY2MF0gICBQUkVGRVRDSCB3aW5kb3c6IDMwMDAwMDAwLTMwMGZmZmZmClsgICAxNy4zNDY3
NDhdIFBDSTogQnJpZGdlOiAwMDAwOjAwOjFlLjAKWyAgIDE3LjM0NjgzMl0gICBJTyB3aW5kb3c6
IDMwMDAtNGZmZgpbICAgMTcuMzQ2OTIxXSAgIE1FTSB3aW5kb3c6IGUwMjAwMDAwLWUwM2ZmZmZm
ClsgICAxNy4zNDcwMDddICAgUFJFRkVUQ0ggd2luZG93OiAzMDAwMDAwMC0zMDFmZmZmZgpbICAg
MTcuMzQ3MTA0XSBQQ0k6IFNldHRpbmcgbGF0ZW5jeSB0aW1lciBvZiBkZXZpY2UgMDAwMDowMDox
ZS4wIHRvIDY0ClsgICAxNy4zNDcxNDddIE5FVDogUmVnaXN0ZXJlZCBwcm90b2NvbCBmYW1pbHkg
MgpbICAgMTcuMzU2NjQxXSBJUCByb3V0ZSBjYWNoZSBoYXNoIHRhYmxlIGVudHJpZXM6IDQwOTYg
KG9yZGVyOiAyLCAxNjM4NCBieXRlcykKWyAgIDE3LjM1NjgzNF0gVENQIGVzdGFibGlzaGVkIGhh
c2ggdGFibGUgZW50cmllczogMTYzODQgKG9yZGVyOiA0LCA2NTUzNiBieXRlcykKWyAgIDE3LjM1
NzAxM10gVENQIGJpbmQgaGFzaCB0YWJsZSBlbnRyaWVzOiA4MTkyIChvcmRlcjogMywgMzI3Njgg
Ynl0ZXMpClsgICAxNy4zNTcxNTRdIFRDUDogSGFzaCB0YWJsZXMgY29uZmlndXJlZCAoZXN0YWJs
aXNoZWQgMTYzODQgYmluZCA4MTkyKQpbICAgMTcuMzU3MjQwXSBUQ1AgcmVubyByZWdpc3RlcmVk
ClsgICAxNy4zNTk3NjddIGNoZWNraW5nIGlmIGltYWdlIGlzIGluaXRyYW1mcy4uLiBpdCBpcwpb
ICAgMTguNDMxNzIyXSBGcmVlaW5nIGluaXRyZCBtZW1vcnk6IDU5MTVrIGZyZWVkClsgICAxOC40
MzIyODNdIGF1ZGl0OiBpbml0aWFsaXppbmcgbmV0bGluayBzb2NrZXQgKGRpc2FibGVkKQpbICAg
MTguNDMyMzg5XSBhdWRpdCgxMTkwNzE4NzQyLjUxMDoxKTogaW5pdGlhbGl6ZWQKWyAgIDE4LjQz
MjUyM10gSS1waXBlOiBEb21haW4gWGVub21haSByZWdpc3RlcmVkLgpbICAgMTguNDMyNjE1XSBY
ZW5vbWFpOiBoYWwveDg2IHN0YXJ0ZWQuClsgICAxOC40MzU2NzVdIFhlbm9tYWk6IHJlYWwtdGlt
ZSBudWNsZXVzIHYyLjMuMyAoU3VtbWVyIFNvbmcpIGxvYWRlZC4KWyAgIDE4LjQzNTg3MF0gWGVu
b21haTogU01JLWVuYWJsZWQgY2hpcHNldCBmb3VuZCBidXQgU01JIHdvcmthcm91bmQgbm90IGVu
YWJsZWQgKGNoZWNrClsgICAxOC40MzU4NzRdICAgICAgICAgIENPTkZJR19YRU5PX0hXX1NNSV9X
T1JLQVJPVU5EKS4gWW91IG1heSBlbmNvdW50ZXIgaGlnaApbICAgMTguNDM1ODc3XSAgICAgICAg
ICBpbnRlcnJ1cHQgbGF0ZW5jaWVzIQpbICAgMTguNDM3MjUzXSBYZW5vbWFpOiBzdGFydGluZyBu
YXRpdmUgQVBJIHNlcnZpY2VzLgpbICAgMTguNDM3MzM4XSBYZW5vbWFpOiBzdGFydGluZyBQT1NJ
WCBzZXJ2aWNlcy4KWyAgIDE4LjQzNzQ2OF0gWGVub21haTogc3RhcnRpbmcgUlRETSBzZXJ2aWNl
cy4KWyAgIDE4LjQzNzcwOV0gVkZTOiBEaXNrIHF1b3RhcyBkcXVvdF82LjUuMQpbICAgMTguNDM3
ODIxXSBEcXVvdC1jYWNoZSBoYXNoIHRhYmxlIGVudHJpZXM6IDEwMjQgKG9yZGVyIDAsIDQwOTYg
Ynl0ZXMpClsgICAxOC40MzgwMzVdIGlvIHNjaGVkdWxlciBub29wIHJlZ2lzdGVyZWQKWyAgIDE4
LjQzODE4NF0gaW8gc2NoZWR1bGVyIGFudGljaXBhdG9yeSByZWdpc3RlcmVkClsgICAxOC40Mzgz
MjldIGlvIHNjaGVkdWxlciBkZWFkbGluZSByZWdpc3RlcmVkClsgICAxOC40Mzg0ODNdIGlvIHNj
aGVkdWxlciBjZnEgcmVnaXN0ZXJlZCAoZGVmYXVsdCkKWyAgIDIzLjkzNDg3M10gMDAwMDowMDox
ZC43IEVIQ0k6IEJJT1MgaGFuZG9mZiBmYWlsZWQgKEJJT1MgYnVnID8pIDAxMDEwMDAxClsgICAy
My45MzUzNzVdIGlzYXBucDogU2Nhbm5pbmcgZm9yIFBuUCBjYXJkcy4uLgpbICAgMjQuMjkyMTU1
XSBpc2FwbnA6IE5vIFBsdWcgJiBQbGF5IGRldmljZSBmb3VuZApbICAgMjQuMzI4Mjc1XSBSZWFs
IFRpbWUgQ2xvY2sgRHJpdmVyIHYxLjEyYWMKWyAgIDI0LjMyODM5MF0gaW50ZWxfcm5nOiBGV0gg
bm90IGRldGVjdGVkClsgICAyNC4zMjg0ODVdIFNlcmlhbDogODI1MC8xNjU1MCBkcml2ZXIgJFJl
dmlzaW9uOiAxLjkwICQgNCBwb3J0cywgSVJRIHNoYXJpbmcgZW5hYmxlZApbICAgMjQuMzI4NzE5
XSBzZXJpYWw4MjUwOiB0dHlTMCBhdCBJL08gMHgzZjggKGlycSA9IDQpIGlzIGEgMTY1NTBBClsg
ICAyNC4zMjg5NzZdIHNlcmlhbDgyNTA6IHR0eVMxIGF0IEkvTyAweDJmOCAoaXJxID0gMykgaXMg
YSAxNjU1MEEKWyAgIDI0LjMyOTI0MF0gc2VyaWFsODI1MDogdHR5UzIgYXQgSS9PIDB4M2U4IChp
cnEgPSA0KSBpcyBhIDE2NTUwQQpbICAgMjQuMzI5NTExXSBzZXJpYWw4MjUwOiB0dHlTMyBhdCBJ
L08gMHgyZTggKGlycSA9IDMpIGlzIGEgMTY1NTBBClsgICAyNC4zMzA4MzddIFJBTURJU0sgZHJp
dmVyIGluaXRpYWxpemVkOiAxNiBSQU0gZGlza3Mgb2YgNjU1MzZLIHNpemUgMTAyNCBibG9ja3Np
emUKWyAgIDI0LjMzMTEwM10gVW5pZm9ybSBNdWx0aS1QbGF0Zm9ybSBFLUlERSBkcml2ZXIgUmV2
aXNpb246IDcuMDBhbHBoYTIKWyAgIDI0LjMzMTE5MV0gaWRlOiBBc3N1bWluZyAzM01IeiBzeXN0
ZW0gYnVzIHNwZWVkIGZvciBQSU8gbW9kZXM7IG92ZXJyaWRlIHdpdGggaWRlYnVzPXh4ClsgICAy
NC4zMzE2ODNdIFBOUDogUFMvMiBDb250cm9sbGVyIFtQTlAwMzAzXSBhdCAweDYwLDB4NjQgaXJx
IDEKWyAgIDI0LjMzMTc3NF0gUE5QOiBQUy8yIGNvbnRyb2xsZXIgZG9lc24ndCBoYXZlIEFVWCBp
cnE7IHVzaW5nIGRlZmF1bHQgMTIKWyAgIDI0LjMzNDYwM10gc2VyaW86IGk4MDQyIEtCRCBwb3J0
IGF0IDB4NjAsMHg2NCBpcnEgMQpbICAgMjQuMzM0Njk3XSBzZXJpbzogaTgwNDIgQVVYIHBvcnQg
YXQgMHg2MCwweDY0IGlycSAxMgpbICAgMjQuMzM0OTI4XSBtaWNlOiBQUy8yIG1vdXNlIGRldmlj
ZSBjb21tb24gZm9yIGFsbCBtaWNlClsgICAyNC4zMzUxNDhdIEVJU0E6IFByb2JpbmcgYnVzIDAg
YXQgZWlzYS4wClsgICAyNC4zMzUyMzVdIENhbm5vdCBhbGxvY2F0ZSByZXNvdXJjZSBmb3IgRUlT
QSBzbG90IDEKWyAgIDI0LjMzNTMyMl0gQ2Fubm90IGFsbG9jYXRlIHJlc291cmNlIGZvciBFSVNB
IHNsb3QgMgpbICAgMjQuMzM1NDA3XSBDYW5ub3QgYWxsb2NhdGUgcmVzb3VyY2UgZm9yIEVJU0Eg
c2xvdCAzClsgICAyNC4zMzU0OTNdIENhbm5vdCBhbGxvY2F0ZSByZXNvdXJjZSBmb3IgRUlTQSBz
bG90IDQKWyAgIDI0LjMzNTYwMF0gRUlTQTogRGV0ZWN0ZWQgMCBjYXJkcy4KWyAgIDI0LjMzNTgx
Nl0gVENQIGN1YmljIHJlZ2lzdGVyZWQKWyAgIDI0LjMzNTkwM10gTkVUOiBSZWdpc3RlcmVkIHBy
b3RvY29sIGZhbWlseSAxClsgICAyNC4zMzYwMTZdIFRlc3RpbmcgTk1JIHdhdGNoZG9nIC4uLiBP
Sy4KWyAgIDI0LjM0NjE1NF0gVXNpbmcgSVBJIFNob3J0Y3V0IG1vZGUKWyAgIDI0LjM0NjQ1M10g
RnJlZWluZyB1bnVzZWQga2VybmVsIG1lbW9yeTogMjU2ayBmcmVlZApbICAgMjQuMzQ2NjQxXSBU
aW1lOiB0c2MgY2xvY2tzb3VyY2UgaGFzIGJlZW4gaW5zdGFsbGVkLgpbICAgMjQuMzc1NzI2XSBp
bnB1dDogQVQgVHJhbnNsYXRlZCBTZXQgMiBrZXlib2FyZCBhcyAvY2xhc3MvaW5wdXQvaW5wdXQw
ClsgICAyNS4zMTAxODRdIHVzYmNvcmU6IHJlZ2lzdGVyZWQgbmV3IGludGVyZmFjZSBkcml2ZXIg
dXNiZnMKWyAgIDI1LjMxMDMwMl0gdXNiY29yZTogcmVnaXN0ZXJlZCBuZXcgaW50ZXJmYWNlIGRy
aXZlciBodWIKWyAgIDI1LjMxMDQ0MV0gdXNiY29yZTogcmVnaXN0ZXJlZCBuZXcgZGV2aWNlIGRy
aXZlciB1c2IKWyAgIDI1LjMxMjY5MV0gVVNCIFVuaXZlcnNhbCBIb3N0IENvbnRyb2xsZXIgSW50
ZXJmYWNlIGRyaXZlciB2My4wClsgICAyNS4zMTI4NDFdIFBDSTogc2V0dGluZyBJUlEgNSBhcyBs
ZXZlbC10cmlnZ2VyZWQKWyAgIDI1LjMxMjg0Nl0gUENJOiBGb3VuZCBJUlEgNSBmb3IgZGV2aWNl
IDAwMDA6MDA6MWQuMApbICAgMjUuMzEyOTM1XSBQQ0k6IFNoYXJpbmcgSVJRIDUgd2l0aCAwMDAw
OjAwOjAyLjAKWyAgIDI1LjMxMzAyOF0gUENJOiBTaGFyaW5nIElSUSA1IHdpdGggMDAwMDowMjow
My4wClsgICAyNS4zMTMxMzhdIFBDSTogU2V0dGluZyBsYXRlbmN5IHRpbWVyIG9mIGRldmljZSAw
MDAwOjAwOjFkLjAgdG8gNjQKWyAgIDI1LjMxMzE0NF0gdWhjaV9oY2QgMDAwMDowMDoxZC4wOiBV
SENJIEhvc3QgQ29udHJvbGxlcgpbICAgMjUuMzEzNDI3XSB1aGNpX2hjZCAwMDAwOjAwOjFkLjA6
IG5ldyBVU0IgYnVzIHJlZ2lzdGVyZWQsIGFzc2lnbmVkIGJ1cyBudW1iZXIgMQpbICAgMjUuMzEz
NTUyXSB1aGNpX2hjZCAwMDAwOjAwOjFkLjA6IGlycSA1LCBpbyBiYXNlIDB4MDAwMDFjMDAKWyAg
IDI1LjMxMzc3Nl0gdXNiIHVzYjE6IGNvbmZpZ3VyYXRpb24gIzEgY2hvc2VuIGZyb20gMSBjaG9p
Y2UKWyAgIDI1LjMxMzg5NV0gaHViIDEtMDoxLjA6IFVTQiBodWIgZm91bmQKWyAgIDI1LjMxMzk4
MV0gaHViIDEtMDoxLjA6IDIgcG9ydHMgZGV0ZWN0ZWQKWyAgIDI1LjQ4NDk3OV0gZTEwMDogSW50
ZWwoUikgUFJPLzEwMCBOZXR3b3JrIERyaXZlciwgMy41LjE3LWsyLU5BUEkKWyAgIDI1LjQ4NTA3
OV0gZTEwMDogQ29weXJpZ2h0KGMpIDE5OTktMjAwNiBJbnRlbCBDb3Jwb3JhdGlvbgpbICAgMjUu
NTI3MTk0XSBQQ0k6IHNldHRpbmcgSVJRIDcgYXMgbGV2ZWwtdHJpZ2dlcmVkClsgICAyNS41Mjcy
MDFdIFBDSTogRm91bmQgSVJRIDcgZm9yIGRldmljZSAwMDAwOjAwOjFkLjcKWyAgIDI1LjUyNzM0
MV0gUENJOiBTZXR0aW5nIGxhdGVuY3kgdGltZXIgb2YgZGV2aWNlIDAwMDA6MDA6MWQuNyB0byA2
NApbICAgMjUuNTI3MzQ3XSBlaGNpX2hjZCAwMDAwOjAwOjFkLjc6IEVIQ0kgSG9zdCBDb250cm9s
bGVyClsgICAyNS41Mjc0NjRdIGVoY2lfaGNkIDAwMDA6MDA6MWQuNzogbmV3IFVTQiBidXMgcmVn
aXN0ZXJlZCwgYXNzaWduZWQgYnVzIG51bWJlciAyClsgICAyNS41Mjc2MDZdIGVoY2lfaGNkIDAw
MDA6MDA6MWQuNzogZGVidWcgcG9ydCAxClsgICAyNS41Mjc2OTFdIFBDSTogY2FjaGUgbGluZSBz
aXplIG9mIDMyIGlzIG5vdCBzdXBwb3J0ZWQgYnkgZGV2aWNlIDAwMDA6MDA6MWQuNwpbICAgMjUu
NTI3NzA1XSBlaGNpX2hjZCAwMDAwOjAwOjFkLjc6IGlycSA3LCBpbyBtZW0gMHhlMDEwMDAwMApb
ICAgMjUuNTMxNjYxXSBlaGNpX2hjZCAwMDAwOjAwOjFkLjc6IFVTQiAyLjAgc3RhcnRlZCwgRUhD
SSAxLjAwLCBkcml2ZXIgMTAgRGVjIDIwMDQKWyAgIDI1LjUzMTg3MV0gdXNiIHVzYjI6IGNvbmZp
Z3VyYXRpb24gIzEgY2hvc2VuIGZyb20gMSBjaG9pY2UKWyAgIDI1LjUzMjAwMF0gaHViIDItMDox
LjA6IFVTQiBodWIgZm91bmQKWyAgIDI1LjUzMjA5MF0gaHViIDItMDoxLjA6IDQgcG9ydHMgZGV0
ZWN0ZWQKWyAgIDI1LjY1NzkyNF0gSUNINDogSURFIGNvbnRyb2xsZXIgYXQgUENJIHNsb3QgMDAw
MDowMDoxZi4xClsgICAyNS42NTgwMzFdIFBDSTogRW5hYmxpbmcgZGV2aWNlIDAwMDA6MDA6MWYu
MSAoMDAwNSAtPiAwMDA3KQpbICAgMjUuNjU4MTI3XSBQQ0k6IEZvdW5kIElSUSA5IGZvciBkZXZp
Y2UgMDAwMDowMDoxZi4xClsgICAyNS42NTgyMzNdIFBDSTogU2hhcmluZyBJUlEgOSB3aXRoIDAw
MDA6MDI6MDUuMApbICAgMjUuNjU4MzI5XSBJQ0g0OiBjaGlwc2V0IHJldmlzaW9uIDIKWyAgIDI1
LjY1ODQxNF0gSUNINDogbm90IDEwMCUgbmF0aXZlIG1vZGU6IHdpbGwgcHJvYmUgaXJxcyBsYXRl
cgpbICAgMjUuNjU4NTA5XSAgICAgaWRlMDogQk0tRE1BIGF0IDB4MjQwMC0weDI0MDcsIEJJT1Mg
c2V0dGluZ3M6IGhkYTpETUEsIGhkYjpwaW8KWyAgIDI1LjY1ODc0MF0gUHJvYmluZyBJREUgaW50
ZXJmYWNlIGlkZTAuLi4KWyAgIDI1Ljg2MDgwN10gdXNiIDItMjogbmV3IGhpZ2ggc3BlZWQgVVNC
IGRldmljZSB1c2luZyBlaGNpX2hjZCBhbmQgYWRkcmVzcyAyClsgICAyNS45MjE5MTddIGhkYTog
U0FNU1VORyBNUDA0MDJILCBBVEEgRElTSyBkcml2ZQpbICAgMjUuOTc1NjgyXSB1c2IgMi0yOiBj
b25maWd1cmF0aW9uICMxIGNob3NlbiBmcm9tIDEgY2hvaWNlClsgICAyNi4xODE2MTJdIHVzYiAy
LTQ6IG5ldyBoaWdoIHNwZWVkIFVTQiBkZXZpY2UgdXNpbmcgZWhjaV9oY2QgYW5kIGFkZHJlc3Mg
MwpbICAgMjYuMzQ2MDkxXSB1c2IgMi00OiBjb25maWd1cmF0aW9uICMyIGNob3NlbiBmcm9tIDEg
Y2hvaWNlClsgICAyNi4zNDgyNDZdIHVzYmNvcmU6IHJlZ2lzdGVyZWQgbmV3IGludGVyZmFjZSBk
cml2ZXIgbGlidXN1YWwKWyAgIDI2LjM3MDM4MF0gU0NTSSBzdWJzeXN0ZW0gaW5pdGlhbGl6ZWQK
WyAgIDI2LjM3NDU1MF0gSW5pdGlhbGl6aW5nIFVTQiBNYXNzIFN0b3JhZ2UgZHJpdmVyLi4uClsg
ICAyNi40NTE1NjVdIHNjc2kwIDogU0NTSSBlbXVsYXRpb24gZm9yIFVTQiBNYXNzIFN0b3JhZ2Ug
ZGV2aWNlcwpbICAgMjYuNDUxNzMyXSB1c2Itc3RvcmFnZTogZGV2aWNlIGZvdW5kIGF0IDIKWyAg
IDI2LjQ1MTczNl0gdXNiLXN0b3JhZ2U6IHdhaXRpbmcgZm9yIGRldmljZSB0byBzZXR0bGUgYmVm
b3JlIHNjYW5uaW5nClsgICAyNi40NTE3ODBdIHNjc2kxIDogU0NTSSBlbXVsYXRpb24gZm9yIFVT
QiBNYXNzIFN0b3JhZ2UgZGV2aWNlcwpbICAgMjYuNDUxOTEzXSB1c2Itc3RvcmFnZTogZGV2aWNl
IGZvdW5kIGF0IDMKWyAgIDI2LjQ1MTkxNl0gdXNiLXN0b3JhZ2U6IHdhaXRpbmcgZm9yIGRldmlj
ZSB0byBzZXR0bGUgYmVmb3JlIHNjYW5uaW5nClsgICAyNi40NTE5MjhdIHVzYmNvcmU6IHJlZ2lz
dGVyZWQgbmV3IGludGVyZmFjZSBkcml2ZXIgdXNiLXN0b3JhZ2UKWyAgIDI2LjQ1MjAxN10gVVNC
IE1hc3MgU3RvcmFnZSBzdXBwb3J0IHJlZ2lzdGVyZWQuClsgICAyNi41MzM1OTZdIGlkZTAgYXQg
MHgxZjAtMHgxZjcsMHgzZjYgb24gaXJxIDE0ClsgICAyNi41NTE2MjBdIGxpYmF0YSB2ZXJzaW9u
IDIuMDAgbG9hZGVkLgpbICAgMjYuNTYxODYzXSBQQ0k6IEZvdW5kIElSUSA5IGZvciBkZXZpY2Ug
MDAwMDowMjowNC4wClsgICAyNi41NjE5NzBdIFBDSTogU2hhcmluZyBJUlEgOSB3aXRoIDAwMDA6
MDA6MWYuMwpbICAgMjYuNTg1NDMyXSBlMTAwOiBldGgwOiBlMTAwX3Byb2JlOiBhZGRyIDB4ZTAy
MTkwMDAsIGlycSA5LCBNQUMgYWRkciAwMDowMDo1QjowMDpGOTo2RApbICAgMjYuNTg1NTU5XSBQ
Q0k6IHNldHRpbmcgSVJRIDE1IGFzIGxldmVsLXRyaWdnZXJlZApbICAgMjYuNTg1NTYzXSBQQ0k6
IEZvdW5kIElSUSAxNSBmb3IgZGV2aWNlIDAwMDA6MDI6MDguMApbICAgMjYuNjA4OTQ3XSBQQ0k6
IEZvdW5kIElSUSAxNSBmb3IgZGV2aWNlIDAwMDA6MDA6MWQuMQpbICAgMjYuNjA5MDU3XSBQQ0k6
IFNldHRpbmcgbGF0ZW5jeSB0aW1lciBvZiBkZXZpY2UgMDAwMDowMDoxZC4xIHRvIDY0ClsgICAy
Ni42MDkwNjRdIHVoY2lfaGNkIDAwMDA6MDA6MWQuMTogVUhDSSBIb3N0IENvbnRyb2xsZXIKWyAg
IDI2LjYwOTE4OV0gdWhjaV9oY2QgMDAwMDowMDoxZC4xOiBuZXcgVVNCIGJ1cyByZWdpc3RlcmVk
LCBhc3NpZ25lZCBidXMgbnVtYmVyIDMKWyAgIDI2LjYwOTMxNV0gdWhjaV9oY2QgMDAwMDowMDox
ZC4xOiBpcnEgMTUsIGlvIGJhc2UgMHgwMDAwMjAwMApbICAgMjYuNjA5NTYxXSB1c2IgdXNiMzog
Y29uZmlndXJhdGlvbiAjMSBjaG9zZW4gZnJvbSAxIGNob2ljZQpbICAgMjYuNjA5Njk0XSBodWIg
My0wOjEuMDogVVNCIGh1YiBmb3VuZApbICAgMjYuNjA5NzgzXSBodWIgMy0wOjEuMDogMiBwb3J0
cyBkZXRlY3RlZApbICAgMjYuNjEwMTQzXSBlMTAwOiBldGgxOiBlMTAwX3Byb2JlOiBhZGRyIDB4
ZTAyMWEwMDAsIGlycSAxNSwgTUFDIGFkZHIgMDA6RTA6NEI6MTk6QzQ6NDgKWyAgIDI2LjYzNTc4
MF0gZTEwMDogZXRoMjogZTEwMF9wcm9iZTogYWRkciAweGUwMzQwMDAwLCBpcnEgMTUsIE1BQyBh
ZGRyIDAwOjAwOjVCOjAwOkY5OjZFClsgICAyNi42NjE0MTVdIGUxMDA6IGV0aDM6IGUxMDBfcHJv
YmU6IGFkZHIgMHhlMDM0MTAwMCwgaXJxIDUsIE1BQyBhZGRyIDAwOjAwOjVCOjAwOkY5OjZGClsg
ICAyNi42NzQ2MzZdIGhkYTogbWF4IHJlcXVlc3Qgc2l6ZTogNTEyS2lCClsgICAyNy4xMzQ4Njhd
IGhkYTogNzgyNDI5NzYgc2VjdG9ycyAoNDAwNjAgTUIpIHcvODE5MktpQiBDYWNoZSwgQ0hTPTE2
MzgzLzI1NS82MywgVURNQSgzMykKWyAgIDI3LjEzNTY0OV0gaGRhOiBjYWNoZSBmbHVzaGVzIHN1
cHBvcnRlZApbICAgMjcuMTM1Nzg4XSAgaGRhOiBoZGExIGhkYTIgPCBoZGE1ID4KWyAgIDI3LjQ4
NzE5Nl0ga2pvdXJuYWxkIHN0YXJ0aW5nLiAgQ29tbWl0IGludGVydmFsIDUgc2Vjb25kcwpbICAg
MjcuNDg3MzAwXSBFWFQzLWZzOiBtb3VudGVkIGZpbGVzeXN0ZW0gd2l0aCBvcmRlcmVkIGRhdGEg
bW9kZS4KWyAgIDMxLjQ0OTMyMV0gc2NzaSAwOjA6MDowOiBEaXJlY3QtQWNjZXNzICAgICBDQk0g
ICAgICBGbGFzaCBEaXNrICAgICAgIDQuMDAgUFE6IDAgQU5TSTogMgpbICAgMzEuNDQ5ODE2XSB1
c2Itc3RvcmFnZTogZGV2aWNlIHNjYW4gY29tcGxldGUKWyAgIDMxLjU1MDU4M10gdXNiIDItNDog
cmVzZXQgaGlnaCBzcGVlZCBVU0IgZGV2aWNlIHVzaW5nIGVoY2lfaGNkIGFuZCBhZGRyZXNzIDMK
WyAgIDMxLjY1MjUyNV0gdXNiIDItNDogZGV2aWNlIGRlc2NyaXB0b3IgcmVhZC82NCwgZXJyb3Ig
LTcxClsgICAzMS44NTU0MTFdIHVzYiAyLTQ6IGRldmljZSBkZXNjcmlwdG9yIHJlYWQvNjQsIGVy
cm9yIC03MQpbICAgMzIuMDU4Mjk1XSB1c2IgMi00OiByZXNldCBoaWdoIHNwZWVkIFVTQiBkZXZp
Y2UgdXNpbmcgZWhjaV9oY2QgYW5kIGFkZHJlc3MgMwpbICAgMzIuMTYwMjM3XSB1c2IgMi00OiBk
ZXZpY2UgZGVzY3JpcHRvciByZWFkLzY0LCBlcnJvciAtNzEKWyAgIDMyLjM2MzEyMV0gdXNiIDIt
NDogZGV2aWNlIGRlc2NyaXB0b3IgcmVhZC82NCwgZXJyb3IgLTcxClsgICAzMi41NjYwMDhdIHVz
YiAyLTQ6IHJlc2V0IGhpZ2ggc3BlZWQgVVNCIGRldmljZSB1c2luZyBlaGNpX2hjZCBhbmQgYWRk
cmVzcyAzClsgICAzMi42OTk5MzNdIHVzYiAyLTQ6IHJlc2V0IGhpZ2ggc3BlZWQgVVNCIGRldmlj
ZSB1c2luZyBlaGNpX2hjZCBhbmQgYWRkcmVzcyAzClsgICAzMi44MDE4NzRdIHVzYiAyLTQ6IGRl
dmljZSBkZXNjcmlwdG9yIHJlYWQvNjQsIGVycm9yIC03MQpbICAgMzMuMDA0NzU5XSB1c2IgMi00
OiBkZXZpY2UgZGVzY3JpcHRvciByZWFkLzY0LCBlcnJvciAtNzEKWyAgIDMzLjIwNzY0Nl0gdXNi
IDItNDogcmVzZXQgaGlnaCBzcGVlZCBVU0IgZGV2aWNlIHVzaW5nIGVoY2lfaGNkIGFuZCBhZGRy
ZXNzIDMKWyAgIDMzLjMwOTU4OF0gdXNiIDItNDogZGV2aWNlIGRlc2NyaXB0b3IgcmVhZC82NCwg
ZXJyb3IgLTcxClsgICAzMy41MTI0NzRdIHVzYiAyLTQ6IGRldmljZSBkZXNjcmlwdG9yIHJlYWQv
NjQsIGVycm9yIC03MQpbICAgMzMuNzE1MzYwXSB1c2IgMi00OiByZXNldCBoaWdoIHNwZWVkIFVT
QiBkZXZpY2UgdXNpbmcgZWhjaV9oY2QgYW5kIGFkZHJlc3MgMwpbICAgMzMuODQ5Mjg1XSB1c2Ig
Mi00OiByZXNldCBoaWdoIHNwZWVkIFVTQiBkZXZpY2UgdXNpbmcgZWhjaV9oY2QgYW5kIGFkZHJl
c3MgMwpbICAgMzMuOTUxMjI2XSB1c2IgMi00OiBkZXZpY2UgZGVzY3JpcHRvciByZWFkLzY0LCBl
cnJvciAtNzEKWyAgIDM0LjE1NDExMV0gdXNiIDItNDogZGV2aWNlIGRlc2NyaXB0b3IgcmVhZC82
NCwgZXJyb3IgLTcxClsgICAzNC4zNTY5OThdIHVzYiAyLTQ6IHJlc2V0IGhpZ2ggc3BlZWQgVVNC
IGRldmljZSB1c2luZyBlaGNpX2hjZCBhbmQgYWRkcmVzcyAzClsgICAzNC40NTg5NDBdIHVzYiAy
LTQ6IGRldmljZSBkZXNjcmlwdG9yIHJlYWQvNjQsIGVycm9yIC03MQpbICAgMzQuNjYxODI2XSB1
c2IgMi00OiBkZXZpY2UgZGVzY3JpcHRvciByZWFkLzY0LCBlcnJvciAtNzEKWyAgIDM0Ljg2NDcx
Ml0gdXNiIDItNDogcmVzZXQgaGlnaCBzcGVlZCBVU0IgZGV2aWNlIHVzaW5nIGVoY2lfaGNkIGFu
ZCBhZGRyZXNzIDMKWyAgIDM0Ljk5NzYzN10gdXNiIDItNDogcmVzZXQgaGlnaCBzcGVlZCBVU0Ig
ZGV2aWNlIHVzaW5nIGVoY2lfaGNkIGFuZCBhZGRyZXNzIDMKWyAgIDM1LjA5OTU3OV0gdXNiIDIt
NDogZGV2aWNlIGRlc2NyaXB0b3IgcmVhZC82NCwgZXJyb3IgLTcxClsgICAzNS4zMDI0NjVdIHVz
YiAyLTQ6IGRldmljZSBkZXNjcmlwdG9yIHJlYWQvNjQsIGVycm9yIC03MQpbICAgMzUuNTA1MzUw
XSB1c2IgMi00OiByZXNldCBoaWdoIHNwZWVkIFVTQiBkZXZpY2UgdXNpbmcgZWhjaV9oY2QgYW5k
IGFkZHJlc3MgMwpbICAgMzUuNjA3MjkyXSB1c2IgMi00OiBkZXZpY2UgZGVzY3JpcHRvciByZWFk
LzY0LCBlcnJvciAtNzEKWyAgIDM1LjgxMDE5M10gdXNiIDItNDogZGV2aWNlIGRlc2NyaXB0b3Ig
cmVhZC82NCwgZXJyb3IgLTcxClsgICAzNi4wMTMwODVdIHVzYiAyLTQ6IHJlc2V0IGhpZ2ggc3Bl
ZWQgVVNCIGRldmljZSB1c2luZyBlaGNpX2hjZCBhbmQgYWRkcmVzcyAzClsgICAzNi4wNDUyMzJd
IHVzYi1zdG9yYWdlOiBkZXZpY2Ugc2NhbiBjb21wbGV0ZQpbICAgMzcuMDgwNjcxXSBlMTAwOiBl
dGgwOiBlMTAwX3dhdGNoZG9nOiBsaW5rIHVwLCAxMDBNYnBzLCBmdWxsLWR1cGxleApbICAgMzgu
NTY1MTAyXSBORVQ6IFJlZ2lzdGVyZWQgcHJvdG9jb2wgZmFtaWx5IDE3ClsgICAzOS41NjM0OThd
IExpbnV4IGFncGdhcnQgaW50ZXJmYWNlIHYwLjEwMSAoYykgRGF2ZSBKb25lcwpbICAgMzkuOTkz
MzMyXSBwY2lfaG90cGx1ZzogUENJIEhvdCBQbHVnIFBDSSBDb3JlIHZlcnNpb246IDAuNQpbICAg
NDAuMDQ1MTcxXSBzaHBjaHA6IFN0YW5kYXJkIEhvdCBQbHVnIFBDSSBDb250cm9sbGVyIERyaXZl
ciB2ZXJzaW9uOiAwLjQKWyAgIDQwLjA3NzcyNF0gYWdwZ2FydDogRGV0ZWN0ZWQgYW4gSW50ZWwg
ODU1IENoaXBzZXQuClsgICA0MC4wNzgyMjNdIGFncGdhcnQ6IERldGVjdGVkIDgwNjBLIHN0b2xl
biBtZW1vcnkuClsgICA0MC4wODk5NzldIGFncGdhcnQ6IEFHUCBhcGVydHVyZSBpcyAxMjhNIEAg
MHhlODAwMDAwMApbICAgNDAuOTExNjY0XSBpbnB1dDogR2VuUFMvMiBHZW5pdXMgTW91c2UgYXMg
L2NsYXNzL2lucHV0L2lucHV0MQpbICAgNDAuOTQ4MTcxXSBTQ1NJIGRldmljZSBzZGE6IDI0OTA4
NyA1MTItYnl0ZSBoZHdyIHNlY3RvcnMgKDEyOCBNQikKWyAgIDQwLjk0OTU1N10gc2RhOiBXcml0
ZSBQcm90ZWN0IGlzIG9mZgpbICAgNDAuOTQ5NjQyXSBzZGE6IE1vZGUgU2Vuc2U6IDAwIDAwIDAw
IDAwClsgICA0MC45NDk2NDddIHNkYTogYXNzdW1pbmcgZHJpdmUgY2FjaGU6IHdyaXRlIHRocm91
Z2gKWyAgIDQxLjA0MjQyM10gU0NTSSBkZXZpY2Ugc2RhOiAyNDkwODcgNTEyLWJ5dGUgaGR3ciBz
ZWN0b3JzICgxMjggTUIpClsgICA0MS4wNDMxMDRdIHNkYTogV3JpdGUgUHJvdGVjdCBpcyBvZmYK
WyAgIDQxLjA0MzE4OF0gc2RhOiBNb2RlIFNlbnNlOiAwMCAwMCAwMCAwMApbICAgNDEuMDQzMTky
XSBzZGE6IGFzc3VtaW5nIGRyaXZlIGNhY2hlOiB3cml0ZSB0aHJvdWdoClsgICA0MS4wNDMyODVd
ICBzZGE6IHNkYTEKWyAgIDQxLjA0NDg0Ml0gc2QgMDowOjA6MDogQXR0YWNoZWQgc2NzaSByZW1v
dmFibGUgZGlzayBzZGEKWyAgIDQxLjA2NDQxOF0gc2QgMDowOjA6MDogQXR0YWNoZWQgc2NzaSBn
ZW5lcmljIHNnMCB0eXBlIDAKWyAgIDQxLjIxMDMwMV0gZnVzZSBpbml0IChBUEkgdmVyc2lvbiA3
LjgpClsgICA0MS4yNzY3OTddIGxwOiBkcml2ZXIgbG9hZGVkIGJ1dCBubyBkZXZpY2VzIGZvdW5k
ClsgICA0MS4zNDU1NDZdIEFkZGluZyAxNDc3OTQwayBzd2FwIG9uIC9kZXYvZGlzay9ieS11dWlk
L2E4NDRmZWVkLTk1YTgtNDc4MC05ZjcyLTVjNzI1YzE0MTI3OC4gIFByaW9yaXR5Oi0xIGV4dGVu
dHM6MSBhY3Jvc3M6MTQ3Nzk0MGsKWyAgIDQxLjQ4NjQ4NF0gRVhUMyBGUyBvbiBoZGExLCBpbnRl
cm5hbCBqb3VybmFsClsgICA0MS42NDg1ODRdIE5FVDogUmVnaXN0ZXJlZCBwcm90b2NvbCBmYW1p
bHkgMTAKWyAgIDQxLjY0ODcxOV0gbG86IERpc2FibGVkIFByaXZhY3kgRXh0ZW5zaW9ucwpbICAg
NDEuNjQ4ODg5XSBBRERSQ09ORihORVRERVZfVVApOiBldGgxOiBsaW5rIGlzIG5vdCByZWFkeQpb
ICAgNDEuNjQ4ODkzXSBBRERSQ09ORihORVRERVZfVVApOiBldGgyOiBsaW5rIGlzIG5vdCByZWFk
eQpbICAgNDEuNjQ4ODk3XSBBRERSQ09ORihORVRERVZfVVApOiBldGgzOiBsaW5rIGlzIG5vdCBy
ZWFkeQpbICAgNTIuMzUyODQ0XSBldGgwOiBubyBJUHY2IHJvdXRlcnMgcHJlc2VudApbICAgNTUu
MDA2MjA3XSBDYXBhYmlsaXR5IExTTSBpbml0aWFsaXplZApbICAgNTUuOTM4NDY1XSBwcGRldjog
dXNlci1zcGFjZSBwYXJhbGxlbCBwb3J0IGRyaXZlcgpbICAgNTcuMDc1MTk3XSBbZHJtXSBJbml0
aWFsaXplZCBkcm0gMS4xLjAgMjAwNjA4MTAKWyAgIDU3LjEyMjY2Nl0gUENJOiBGb3VuZCBJUlEg
NSBmb3IgZGV2aWNlIDAwMDA6MDA6MDIuMApbICAgNTcuMTIyOTc0XSBQQ0k6IFNoYXJpbmcgSVJR
IDUgd2l0aCAwMDAwOjAwOjFkLjAKWyAgIDU3LjEyMzE4Ml0gUENJOiBTaGFyaW5nIElSUSA1IHdp
dGggMDAwMDowMjowMy4wClsgICA1Ny4xMjY3NzZdIFtkcm1dIEluaXRpYWxpemVkIGk5MTUgMS42
LjAgMjAwNjAxMTkgb24gbWlub3IgMApbICAgNTcuMTI3NTk5XSBbZHJtXSBJbml0aWFsaXplZCBp
OTE1IDEuNi4wIDIwMDYwMTE5IG9uIG1pbm9yIDEKWyAgIDYwLjY0ODgzN10gQmx1ZXRvb3RoOiBD
b3JlIHZlciAyLjExClsgICA2MC42NDkzMjldIE5FVDogUmVnaXN0ZXJlZCBwcm90b2NvbCBmYW1p
bHkgMzEKWyAgIDYwLjY0OTMzNF0gQmx1ZXRvb3RoOiBIQ0kgZGV2aWNlIGFuZCBjb25uZWN0aW9u
IG1hbmFnZXIgaW5pdGlhbGl6ZWQKWyAgIDYwLjY0OTM0MF0gQmx1ZXRvb3RoOiBIQ0kgc29ja2V0
IGxheWVyIGluaXRpYWxpemVkClsgICA2MS4xODMxMzZdIEJsdWV0b290aDogTDJDQVAgdmVyIDIu
OApbICAgNjEuMTgzMTQzXSBCbHVldG9vdGg6IEwyQ0FQIHNvY2tldCBsYXllciBpbml0aWFsaXpl
ZApbICAgNjEuODYwNzA0XSBCbHVldG9vdGg6IFJGQ09NTSBzb2NrZXQgbGF5ZXIgaW5pdGlhbGl6
ZWQKWyAgIDYxLjg2MTAzMV0gQmx1ZXRvb3RoOiBSRkNPTU0gVFRZIGxheWVyIGluaXRpYWxpemVk
ClsgICA2MS44NjEwMzZdIEJsdWV0b290aDogUkZDT01NIHZlciAxLjgKWyAgIDcxLjkwODgxN10g
ZXRoMDogbm8gSVB2NiByb3V0ZXJzIHByZXNlbnQK

--0__=4EBBF9F2DFA83A498f9e8a93df938690918c4EBBF9F2DFA83A49
Content-type: application/octet-stream; 
	name="boot_with_lapic_off_in_kernel.txt"
Content-Disposition: attachment; filename="boot_with_lapic_off_in_kernel.txt"
Content-ID: <2__=4EBBF9F2DFA83A498f9e8a93df938@domain.hid>
Content-transfer-encoding: base64

WyAgICAwLjAwMDAwMF0gTGludXggdmVyc2lvbiAyLjYuMjAuMTktbGFwaWMtb2ZmLWFkZW9zLXhl
bm9tYWkyLjMuMCAocm9vdEBnbmN1LWRlc2t0b3ApIChnY2MgdmVyc2lvbiA0LjEuMiAoVWJ1bnR1
IDQuMS4yLTB1YnVudHU0KSkgIzEgVHVlIFNlcCAyNSAxMzo0MzoxMyBDRVNUIDIwMDcKWyAgICAw
LjAwMDAwMF0gQklPUy1wcm92aWRlZCBwaHlzaWNhbCBSQU0gbWFwOgpbICAgIDAuMDAwMDAwXSBz
YW5pdGl6ZSBzdGFydApbICAgIDAuMDAwMDAwXSBzYW5pdGl6ZSBlbmQKWyAgICAwLjAwMDAwMF0g
Y29weV9lODIwX21hcCgpIHN0YXJ0OiAwMDAwMDAwMDAwMDAwMDAwIHNpemU6IDAwMDAwMDAwMDAw
OWY4MDAgZW5kOiAwMDAwMDAwMDAwMDlmODAwIHR5cGU6IDEKWyAgICAwLjAwMDAwMF0gY29weV9l
ODIwX21hcCgpIHR5cGUgaXMgRTgyMF9SQU0KWyAgICAwLjAwMDAwMF0gY29weV9lODIwX21hcCgp
IHN0YXJ0OiAwMDAwMDAwMDAwMDlmODAwIHNpemU6IDAwMDAwMDAwMDAwMDA4MDAgZW5kOiAwMDAw
MDAwMDAwMGEwMDAwIHR5cGU6IDIKWyAgICAwLjAwMDAwMF0gY29weV9lODIwX21hcCgpIHN0YXJ0
OiAwMDAwMDAwMDAwMGNlMDAwIHNpemU6IDAwMDAwMDAwMDAwMDIwMDAgZW5kOiAwMDAwMDAwMDAw
MGQwMDAwIHR5cGU6IDIKWyAgICAwLjAwMDAwMF0gY29weV9lODIwX21hcCgpIHN0YXJ0OiAwMDAw
MDAwMDAwMGUwMDAwIHNpemU6IDAwMDAwMDAwMDAwMjAwMDAgZW5kOiAwMDAwMDAwMDAwMTAwMDAw
IHR5cGU6IDIKWyAgICAwLjAwMDAwMF0gY29weV9lODIwX21hcCgpIHN0YXJ0OiAwMDAwMDAwMDAw
MTAwMDAwIHNpemU6IDAwMDAwMDAwMWY1ZTAwMDAgZW5kOiAwMDAwMDAwMDFmNmUwMDAwIHR5cGU6
IDEKWyAgICAwLjAwMDAwMF0gY29weV9lODIwX21hcCgpIHR5cGUgaXMgRTgyMF9SQU0KWyAgICAw
LjAwMDAwMF0gY29weV9lODIwX21hcCgpIHN0YXJ0OiAwMDAwMDAwMDFmNmUwMDAwIHNpemU6IDAw
MDAwMDAwMDAwMGEwMDAgZW5kOiAwMDAwMDAwMDFmNmVhMDAwIHR5cGU6IDMKWyAgICAwLjAwMDAw
MF0gY29weV9lODIwX21hcCgpIHN0YXJ0OiAwMDAwMDAwMDFmNmVhMDAwIHNpemU6IDAwMDAwMDAw
MDAwMTYwMDAgZW5kOiAwMDAwMDAwMDFmNzAwMDAwIHR5cGU6IDQKWyAgICAwLjAwMDAwMF0gY29w
eV9lODIwX21hcCgpIHN0YXJ0OiAwMDAwMDAwMDFmNzAwMDAwIHNpemU6IDAwMDAwMDAwMDA5MDAw
MDAgZW5kOiAwMDAwMDAwMDIwMDAwMDAwIHR5cGU6IDIKWyAgICAwLjAwMDAwMF0gY29weV9lODIw
X21hcCgpIHN0YXJ0OiAwMDAwMDAwMGZlYzEwMDAwIHNpemU6IDAwMDAwMDAwMDAwMTAwMDAgZW5k
OiAwMDAwMDAwMGZlYzIwMDAwIHR5cGU6IDIKWyAgICAwLjAwMDAwMF0gY29weV9lODIwX21hcCgp
IHN0YXJ0OiAwMDAwMDAwMGZmODAwMDAwIHNpemU6IDAwMDAwMDAwMDA0MDAwMDAgZW5kOiAwMDAw
MDAwMGZmYzAwMDAwIHR5cGU6IDIKWyAgICAwLjAwMDAwMF0gY29weV9lODIwX21hcCgpIHN0YXJ0
OiAwMDAwMDAwMGZmZmZmYzAwIHNpemU6IDAwMDAwMDAwMDAwMDA0MDAgZW5kOiAwMDAwMDAwMTAw
MDAwMDAwIHR5cGU6IDIKWyAgICAwLjAwMDAwMF0gIEJJT1MtZTgyMDogMDAwMDAwMDAwMDAwMDAw
MCAtIDAwMDAwMDAwMDAwOWY4MDAgKHVzYWJsZSkKWyAgICAwLjAwMDAwMF0gIEJJT1MtZTgyMDog
MDAwMDAwMDAwMDA5ZjgwMCAtIDAwMDAwMDAwMDAwYTAwMDAgKHJlc2VydmVkKQpbICAgIDAuMDAw
MDAwXSAgQklPUy1lODIwOiAwMDAwMDAwMDAwMGNlMDAwIC0gMDAwMDAwMDAwMDBkMDAwMCAocmVz
ZXJ2ZWQpClsgICAgMC4wMDAwMDBdICBCSU9TLWU4MjA6IDAwMDAwMDAwMDAwZTAwMDAgLSAwMDAw
MDAwMDAwMTAwMDAwIChyZXNlcnZlZCkKWyAgICAwLjAwMDAwMF0gIEJJT1MtZTgyMDogMDAwMDAw
MDAwMDEwMDAwMCAtIDAwMDAwMDAwMWY2ZTAwMDAgKHVzYWJsZSkKWyAgICAwLjAwMDAwMF0gIEJJ
T1MtZTgyMDogMDAwMDAwMDAxZjZlMDAwMCAtIDAwMDAwMDAwMWY2ZWEwMDAgKEFDUEkgZGF0YSkK
WyAgICAwLjAwMDAwMF0gIEJJT1MtZTgyMDogMDAwMDAwMDAxZjZlYTAwMCAtIDAwMDAwMDAwMWY3
MDAwMDAgKEFDUEkgTlZTKQpbICAgIDAuMDAwMDAwXSAgQklPUy1lODIwOiAwMDAwMDAwMDFmNzAw
MDAwIC0gMDAwMDAwMDAyMDAwMDAwMCAocmVzZXJ2ZWQpClsgICAgMC4wMDAwMDBdICBCSU9TLWU4
MjA6IDAwMDAwMDAwZmVjMTAwMDAgLSAwMDAwMDAwMGZlYzIwMDAwIChyZXNlcnZlZCkKWyAgICAw
LjAwMDAwMF0gIEJJT1MtZTgyMDogMDAwMDAwMDBmZjgwMDAwMCAtIDAwMDAwMDAwZmZjMDAwMDAg
KHJlc2VydmVkKQpbICAgIDAuMDAwMDAwXSAgQklPUy1lODIwOiAwMDAwMDAwMGZmZmZmYzAwIC0g
MDAwMDAwMDEwMDAwMDAwMCAocmVzZXJ2ZWQpClsgICAgMC4wMDAwMDBdIDBNQiBISUdITUVNIGF2
YWlsYWJsZS4KWyAgICAwLjAwMDAwMF0gNTAyTUIgTE9XTUVNIGF2YWlsYWJsZS4KWyAgICAwLjAw
MDAwMF0gRW50ZXJpbmcgYWRkX2FjdGl2ZV9yYW5nZSgwLCAwLCAxMjg3MzYpIDAgZW50cmllcyBv
ZiAyNTYgdXNlZApbICAgIDAuMDAwMDAwXSBab25lIFBGTiByYW5nZXM6ClsgICAgMC4wMDAwMDBd
ICAgRE1BICAgICAgICAgICAgIDAgLT4gICAgIDQwOTYKWyAgICAwLjAwMDAwMF0gICBOb3JtYWwg
ICAgICAgNDA5NiAtPiAgIDEyODczNgpbICAgIDAuMDAwMDAwXSAgIEhpZ2hNZW0gICAgMTI4NzM2
IC0+ICAgMTI4NzM2ClsgICAgMC4wMDAwMDBdIGVhcmx5X25vZGVfbWFwWzFdIGFjdGl2ZSBQRk4g
cmFuZ2VzClsgICAgMC4wMDAwMDBdICAgICAwOiAgICAgICAgMCAtPiAgIDEyODczNgpbICAgIDAu
MDAwMDAwXSBPbiBub2RlIDAgdG90YWxwYWdlczogMTI4NzM2ClsgICAgMC4wMDAwMDBdICAgRE1B
IHpvbmU6IDMyIHBhZ2VzIHVzZWQgZm9yIG1lbW1hcApbICAgIDAuMDAwMDAwXSAgIERNQSB6b25l
OiAwIHBhZ2VzIHJlc2VydmVkClsgICAgMC4wMDAwMDBdICAgRE1BIHpvbmU6IDQwNjQgcGFnZXMs
IExJRk8gYmF0Y2g6MApbICAgIDAuMDAwMDAwXSAgIE5vcm1hbCB6b25lOiA5NzMgcGFnZXMgdXNl
ZCBmb3IgbWVtbWFwClsgICAgMC4wMDAwMDBdICAgTm9ybWFsIHpvbmU6IDEyMzY2NyBwYWdlcywg
TElGTyBiYXRjaDozMQpbICAgIDAuMDAwMDAwXSAgIEhpZ2hNZW0gem9uZTogMCBwYWdlcyB1c2Vk
IGZvciBtZW1tYXAKWyAgICAwLjAwMDAwMF0gRE1JIG5vdCBwcmVzZW50IG9yIGludmFsaWQuClsg
ICAgMC4wMDAwMDBdIEFsbG9jYXRpbmcgUENJIHJlc291cmNlcyBzdGFydGluZyBhdCAzMDAwMDAw
MCAoZ2FwOiAyMDAwMDAwMDpkZWMxMDAwMCkKWyAgICAwLjAwMDAwMF0gRGV0ZWN0ZWQgODk3LjE0
OCBNSHogcHJvY2Vzc29yLgpbICAgMTcuNjc2MTcxXSBCdWlsdCAxIHpvbmVsaXN0cy4gIFRvdGFs
IHBhZ2VzOiAxMjc3MzEKWyAgIDE3LjY3NjE3NV0gS2VybmVsIGNvbW1hbmQgbGluZTogcm9vdD1V
VUlEPWUxMDdhOTk4LTYwOWItNGM2My1iZGQyLTQwODhiZTllMzExYiBybyBzaW5nbGUKWyAgIDE3
LjY3NjU2M10gRW5hYmxpbmcgZmFzdCBGUFUgc2F2ZSBhbmQgcmVzdG9yZS4uLiBkb25lLgpbICAg
MTcuNjc2NTY3XSBFbmFibGluZyB1bm1hc2tlZCBTSU1EIEZQVSBleGNlcHRpb24gc3VwcG9ydC4u
LiBkb25lLgpbICAgMTcuNjc2NTgwXSBJbml0aWFsaXppbmcgQ1BVIzAKWyAgIDE3LjY3NjY0N10g
UElEIGhhc2ggdGFibGUgZW50cmllczogMjA0OCAob3JkZXI6IDExLCA4MTkyIGJ5dGVzKQpbICAg
MTcuNjc2NzUyXSBJLXBpcGUgMS44LTA4OiBwaXBlbGluZSBlbmFibGVkLgpbICAgMTcuNjc4Njk2
XSBDb25zb2xlOiBjb2xvdXIgVkdBKyA4MHgyNQpbICAgMTcuNjgyNzY1XSBEZW50cnkgY2FjaGUg
aGFzaCB0YWJsZSBlbnRyaWVzOiA2NTUzNiAob3JkZXI6IDYsIDI2MjE0NCBieXRlcykKWyAgIDE3
LjY4MzIxMl0gSW5vZGUtY2FjaGUgaGFzaCB0YWJsZSBlbnRyaWVzOiAzMjc2OCAob3JkZXI6IDUs
IDEzMTA3MiBieXRlcykKWyAgIDE3LjcwMzkwMV0gTWVtb3J5OiA1MDA3OTJrLzUxNDk0NGsgYXZh
aWxhYmxlICgxNzMwayBrZXJuZWwgY29kZSwgMTM2MjhrIHJlc2VydmVkLCA3NDhrIGRhdGEsIDI0
MGsgaW5pdCwgMGsgaGlnaG1lbSkKWyAgIDE3LjcwNDAyOF0gdmlydHVhbCBrZXJuZWwgbWVtb3J5
IGxheW91dDoKWyAgIDE3LjcwNDAzMV0gICAgIGZpeG1hcCAgOiAweGZmZmVmMDAwIC0gMHhmZmZm
ZjAwMCAgICggIDY0IGtCKQpbICAgMTcuNzA0MDMzXSAgICAgcGttYXAgICA6IDB4ZmY4MDAwMDAg
LSAweGZmYzAwMDAwICAgKDQwOTYga0IpClsgICAxNy43MDQwMzZdICAgICB2bWFsbG9jIDogMHhl
MDAwMDAwMCAtIDB4ZmY3ZmUwMDAgICAoIDUwMyBNQikKWyAgIDE3LjcwNDAzOV0gICAgIGxvd21l
bSAgOiAweGMwMDAwMDAwIC0gMHhkZjZlMDAwMCAgICggNTAyIE1CKQpbICAgMTcuNzA0MDQxXSAg
ICAgICAuaW5pdCA6IDB4YzAzNmUwMDAgLSAweGMwM2FhMDAwICAgKCAyNDAga0IpClsgICAxNy43
MDQwNDRdICAgICAgIC5kYXRhIDogMHhjMDJiMDk0MSAtIDB4YzAzNmJhOTQgICAoIDc0OCBrQikK
WyAgIDE3LjcwNDA0Nl0gICAgICAgLnRleHQgOiAweGMwMTAwMDAwIC0gMHhjMDJiMDk0MSAgICgx
NzMwIGtCKQpbICAgMTcuNzA0NzE2XSBDaGVja2luZyBpZiB0aGlzIHByb2Nlc3NvciBob25vdXJz
IHRoZSBXUCBiaXQgZXZlbiBpbiBzdXBlcnZpc29yIG1vZGUuLi4gT2suClsgICAxNy43NjQ2MDBd
IENhbGlicmF0aW5nIGRlbGF5IHVzaW5nIHRpbWVyIHNwZWNpZmljIHJvdXRpbmUuLiAxNzk0LjQ4
IEJvZ29NSVBTIChscGo9ODk3MjQzKQpbICAgMTcuNzY0ODE0XSBTZWN1cml0eSBGcmFtZXdvcmsg
djEuMC4wIGluaXRpYWxpemVkClsgICAxNy43NjQ5MjFdIE1vdW50LWNhY2hlIGhhc2ggdGFibGUg
ZW50cmllczogNTEyClsgICAxNy43NjUxNTJdIENQVTogQWZ0ZXIgZ2VuZXJpYyBpZGVudGlmeSwg
Y2FwczogYTdlOWY5YmYgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAxODAgMDAwMDAw
MDAgMDAwMDAwMDAKWyAgIDE3Ljc2NTE2OV0gQ1BVOiBMMSBJIGNhY2hlOiAzMkssIEwxIEQgY2Fj
aGU6IDMySwpbICAgMTcuNzY1MzE1XSBDUFU6IEwyIGNhY2hlOiAxMDI0SwpbICAgMTcuNzY1Mzk2
XSBDUFU6IEFmdGVyIGFsbCBpbml0cywgY2FwczogYTdlOWY5YmYgMDAwMDAwMDAgMDAwMDAwMDAg
MDAwMDIwNDAgMDAwMDAxODAgMDAwMDAwMDAgMDAwMDAwMDAKWyAgIDE3Ljc2NTQwOV0gQ29tcGF0
IHZEU08gbWFwcGVkIHRvIGZmZmZlMDAwLgpbICAgMTcuNzY1NTA2XSBDUFU6IEludGVsIE1vYmls
ZSBHZW51aW5lIEludGVsKFIpIHByb2Nlc3NvciAgICAgICAxMTAwTUh6IHN0ZXBwaW5nIDA1Clsg
ICAxNy43NjU3OThdIENoZWNraW5nICdobHQnIGluc3RydWN0aW9uLi4uIE9LLgpbICAgMTcuNzcw
MTY5XSBORVQ6IFJlZ2lzdGVyZWQgcHJvdG9jb2wgZmFtaWx5IDE2ClsgICAxNy43NzAzNTVdIEVJ
U0EgYnVzIHJlZ2lzdGVyZWQKWyAgIDE3Ljc3MTg0OV0gUENJOiBQQ0kgQklPUyByZXZpc2lvbiAy
LjEwIGVudHJ5IGF0IDB4ZmQ5NTQsIGxhc3QgYnVzPTMKWyAgIDE3Ljc3MTkzM10gUENJOiBVc2lu
ZyBjb25maWd1cmF0aW9uIHR5cGUgMQpbICAgMTcuNzcyMDE3XSBTZXR0aW5nIHVwIHN0YW5kYXJk
IFBDSSByZXNvdXJjZXMKWyAgIDE3Ljc5MjkzNF0gTGludXggUGx1ZyBhbmQgUGxheSBTdXBwb3J0
IHYwLjk3IChjKSBBZGFtIEJlbGF5ClsgICAxNy43OTMwMjZdIFBuUEJJT1M6IFNjYW5uaW5nIHN5
c3RlbSBmb3IgUG5QIEJJT1Mgc3VwcG9ydC4uLgpbICAgMTcuNzkzMTIyXSBQblBCSU9TOiBGb3Vu
ZCBQblAgQklPUyBpbnN0YWxsYXRpb24gc3RydWN0dXJlIGF0IDB4YzAwZjY2NTAKWyAgIDE3Ljc5
MzIxNV0gUG5QQklPUzogUG5QIEJJT1MgdmVyc2lvbiAxLjAsIGVudHJ5IDB4ZjAwMDA6MHhhYTdk
LCBkc2VnIDB4NDAwClsgICAxNy43OTU0NDZdIFBOUEJJT1MgZmF1bHQuLiBhdHRlbXB0aW5nIHJl
Y292ZXJ5LgpbICAgMTcuNzk1NTI4XSBQblBCSU9TOiBXYXJuaW5nISBZb3VyIFBuUCBCSU9TIGNh
dXNlZCBhIGZhdGFsIGVycm9yLiBBdHRlbXB0aW5nIHRvIGNvbnRpbnVlClsgICAxNy43OTU2NjFd
IFBuUEJJT1M6IFlvdSBtYXkgbmVlZCB0byByZWJvb3Qgd2l0aCB0aGUgInBucGJpb3M9b2ZmIiBv
cHRpb24gdG8gb3BlcmF0ZSBzdGFibHkKWyAgIDE3Ljc5NTc3MF0gUG5QQklPUzogQ2hlY2sgd2l0
aCB5b3VyIHZlbmRvciBmb3IgYW4gdXBkYXRlZCBCSU9TClsgICAxNy43OTU4NjFdIFBuUEJJT1M6
IGdldF9kZXZfbm9kZTogdW5leHBlY3RlZCBzdGF0dXMgMHgzNwpbICAgMTcuNzk1OTQ2XSBQblBC
SU9TOiAxNSBub2RlcyByZXBvcnRlZCBieSBQblAgQklPUzsgMTUgcmVjb3JkZWQgYnkgZHJpdmVy
ClsgICAxNy43OTYwNzhdIFBDSTogUHJvYmluZyBQQ0kgaGFyZHdhcmUKWyAgIDE3Ljc5NjE2Ml0g
UENJOiBQcm9iaW5nIFBDSSBoYXJkd2FyZSAoYnVzIDAwKQpbICAgMTcuNzk2MzI4XSBCb290IHZp
ZGVvIGRldmljZSBpcyAwMDAwOjAwOjAyLjAKWyAgIDE3Ljc5NjY0MF0gUENJIHF1aXJrOiByZWdp
b24gMTAwMC0xMDdmIGNsYWltZWQgYnkgSUNINCBBQ1BJL0dQSU8vVENPClsgICAxNy43OTY3Mjdd
IFBDSSBxdWlyazogcmVnaW9uIDExODAtMTFiZiBjbGFpbWVkIGJ5IElDSDQgR1BJTwpbICAgMTcu
Nzk3MDIwXSBQQ0k6IEZpcm13YXJlIGxlZnQgMDAwMDowMjowNC4wIGUxMDAgaW50ZXJydXB0cyBl
bmFibGVkLCBkaXNhYmxpbmcKWyAgIDE3Ljc5NzI0NV0gUENJOiBGaXJtd2FyZSBsZWZ0IDAwMDA6
MDI6MDguMCBlMTAwIGludGVycnVwdHMgZW5hYmxlZCwgZGlzYWJsaW5nClsgICAxNy43OTc0MDRd
IFBDSTogVHJhbnNwYXJlbnQgYnJpZGdlIC0gMDAwMDowMDoxZS4wClsgICAxNy43OTc1NjJdIFBD
STogRmlybXdhcmUgbGVmdCAwMDAwOjAzOjA3LjAgZTEwMCBpbnRlcnJ1cHRzIGVuYWJsZWQsIGRp
c2FibGluZwpbICAgMTcuNzk3NzQzXSBQQ0k6IEZpcm13YXJlIGxlZnQgMDAwMDowMzowOC4wIGUx
MDAgaW50ZXJydXB0cyBlbmFibGVkLCBkaXNhYmxpbmcKWyAgIDE3Ljc5OTAxOF0gUENJOiBVc2lu
ZyBJUlEgcm91dGVyIFBJSVgvSUNIIFs4MDg2LzI0YzBdIGF0IDAwMDA6MDA6MWYuMApbICAgMTcu
Nzk5MTI0XSBQQ0k6IHNldHRpbmcgSVJRIDkgYXMgbGV2ZWwtdHJpZ2dlcmVkClsgICAxNy43OTkx
MjhdIFBDSTogRm91bmQgSVJRIDkgZm9yIGRldmljZSAwMDAwOjAwOjFmLjEKWyAgIDE3Ljc5OTIz
MV0gUENJOiBTaGFyaW5nIElSUSA5IHdpdGggMDAwMDowMjowNS4wClsgICAxNy44MDY0NjNdIE5F
VDogUmVnaXN0ZXJlZCBwcm90b2NvbCBmYW1pbHkgOApbICAgMTcuODA2NTUxXSBORVQ6IFJlZ2lz
dGVyZWQgcHJvdG9jb2wgZmFtaWx5IDIwClsgICAxNy44MDY3MDBdIHBucDogMDA6MDk6IGlvcG9y
dCByYW5nZSAweGZlMDAtMHhmZTAxIGhhcyBiZWVuIHJlc2VydmVkClsgICAxNy44MDY3OTNdIHBu
cDogMDA6MGI6IGlvcG9ydCByYW5nZSAweDRkMC0weDRkMSBoYXMgYmVlbiByZXNlcnZlZApbICAg
MTcuODA2ODgxXSBwbnA6IDAwOjBiOiBpb3BvcnQgcmFuZ2UgMHgxMDAwLTB4MTA1ZiBoYXMgYmVl
biByZXNlcnZlZApbICAgMTcuODA2OTczXSBwbnA6IDAwOjBiOiBpb3BvcnQgcmFuZ2UgMHgxMDYw
LTB4MTA3ZiBoYXMgYmVlbiByZXNlcnZlZApbICAgMTcuODA3MDU5XSBwbnA6IDAwOjBiOiBpb3Bv
cnQgcmFuZ2UgMHgxMTgwLTB4MTFiZiBoYXMgYmVlbiByZXNlcnZlZApbICAgMTcuODA3NDY0XSBQ
Q0k6IElnbm9yZSBib2d1cyByZXNvdXJjZSA2IFswOjBdIG9mIDAwMDA6MDA6MDIuMApbICAgMTcu
ODA3NTYyXSBQQ0k6IEJyaWRnZTogMDAwMDowMjowNy4wClsgICAxNy44MDc2NDldICAgSU8gd2lu
ZG93OiA0MDAwLTRmZmYKWyAgIDE3LjgwNzczNF0gICBNRU0gd2luZG93OiBlMDMwMDAwMC1lMDNm
ZmZmZgpbICAgMTcuODA3ODE4XSAgIFBSRUZFVENIIHdpbmRvdzogMzAwMDAwMDAtMzAwZmZmZmYK
WyAgIDE3LjgwNzkwMV0gUENJOiBCcmlkZ2U6IDAwMDA6MDA6MWUuMApbICAgMTcuODA3OTg1XSAg
IElPIHdpbmRvdzogMzAwMC00ZmZmClsgICAxNy44MDgwNjldICAgTUVNIHdpbmRvdzogZTAyMDAw
MDAtZTAzZmZmZmYKWyAgIDE3LjgwODE1N10gICBQUkVGRVRDSCB3aW5kb3c6IDMwMDAwMDAwLTMw
MWZmZmZmClsgICAxNy44MDgyNTRdIFBDSTogU2V0dGluZyBsYXRlbmN5IHRpbWVyIG9mIGRldmlj
ZSAwMDAwOjAwOjFlLjAgdG8gNjQKWyAgIDE3LjgwODI5NV0gTkVUOiBSZWdpc3RlcmVkIHByb3Rv
Y29sIGZhbWlseSAyClsgICAxNy44MTY2MzVdIElQIHJvdXRlIGNhY2hlIGhhc2ggdGFibGUgZW50
cmllczogNDA5NiAob3JkZXI6IDIsIDE2Mzg0IGJ5dGVzKQpbICAgMTcuODE2ODI5XSBUQ1AgZXN0
YWJsaXNoZWQgaGFzaCB0YWJsZSBlbnRyaWVzOiAxNjM4NCAob3JkZXI6IDQsIDY1NTM2IGJ5dGVz
KQpbICAgMTcuODE3MDEyXSBUQ1AgYmluZCBoYXNoIHRhYmxlIGVudHJpZXM6IDgxOTIgKG9yZGVy
OiAzLCAzMjc2OCBieXRlcykKWyAgIDE3LjgxNzE0OV0gVENQOiBIYXNoIHRhYmxlcyBjb25maWd1
cmVkIChlc3RhYmxpc2hlZCAxNjM4NCBiaW5kIDgxOTIpClsgICAxNy44MTcyNDFdIFRDUCByZW5v
IHJlZ2lzdGVyZWQKWyAgIDE3LjgxOTc1OF0gY2hlY2tpbmcgaWYgaW1hZ2UgaXMgaW5pdHJhbWZz
Li4uIGl0IGlzClsgICAxOC44ODI3ODBdIEZyZWVpbmcgaW5pdHJkIG1lbW9yeTogNTkxNGsgZnJl
ZWQKWyAgIDE4Ljg4MzMzNF0gYXVkaXQ6IGluaXRpYWxpemluZyBuZXRsaW5rIHNvY2tldCAoZGlz
YWJsZWQpClsgICAxOC44ODM0NDJdIGF1ZGl0KDExOTA3MjM5OTkuNTAxOjEpOiBpbml0aWFsaXpl
ZApbICAgMTguODgzNTQ3XSBJLXBpcGU6IERvbWFpbiBYZW5vbWFpIHJlZ2lzdGVyZWQuClsgICAx
OC44ODM2NDRdIFhlbm9tYWk6IGhhbC94ODYgc3RhcnRlZC4KWyAgIDE4LjkwNTEwM10gWGVub21h
aTogcmVhbC10aW1lIG51Y2xldXMgdjIuMy4zIChTdW1tZXIgU29uZykgbG9hZGVkLgpbICAgMTgu
OTA1Mjk4XSBYZW5vbWFpOiBTTUktZW5hYmxlZCBjaGlwc2V0IGZvdW5kIGJ1dCBTTUkgd29ya2Fy
b3VuZCBub3QgZW5hYmxlZCAoY2hlY2sKWyAgIDE4LjkwNTMwMV0gICAgICAgICAgQ09ORklHX1hF
Tk9fSFdfU01JX1dPUktBUk9VTkQpLiBZb3UgbWF5IGVuY291bnRlciBoaWdoClsgICAxOC45MDUz
MDRdICAgICAgICAgIGludGVycnVwdCBsYXRlbmNpZXMhClsgICAxOC45MDU2MDFdIFhlbm9tYWk6
IHN0YXJ0aW5nIG5hdGl2ZSBBUEkgc2VydmljZXMuClsgICAxOC45MDU2ODhdIFhlbm9tYWk6IHN0
YXJ0aW5nIFBPU0lYIHNlcnZpY2VzLgpbICAgMTguOTA1ODIwXSBYZW5vbWFpOiBzdGFydGluZyBS
VERNIHNlcnZpY2VzLgpbICAgMTguOTA2MDYwXSBWRlM6IERpc2sgcXVvdGFzIGRxdW90XzYuNS4x
ClsgICAxOC45MDYxNzVdIERxdW90LWNhY2hlIGhhc2ggdGFibGUgZW50cmllczogMTAyNCAob3Jk
ZXIgMCwgNDA5NiBieXRlcykKWyAgIDE4LjkwNjMzMl0gaW8gc2NoZWR1bGVyIG5vb3AgcmVnaXN0
ZXJlZApbICAgMTguOTA2NDgwXSBpbyBzY2hlZHVsZXIgYW50aWNpcGF0b3J5IHJlZ2lzdGVyZWQK
WyAgIDE4LjkwNjY2OF0gaW8gc2NoZWR1bGVyIGRlYWRsaW5lIHJlZ2lzdGVyZWQKWyAgIDE4Ljkw
NjgyM10gaW8gc2NoZWR1bGVyIGNmcSByZWdpc3RlcmVkIChkZWZhdWx0KQpbICAgMjQuNDA0Njkw
XSAwMDAwOjAwOjFkLjcgRUhDSTogQklPUyBoYW5kb2ZmIGZhaWxlZCAoQklPUyBidWcgPykgMDEw
MTAwMDEKWyAgIDI0LjQwNTE5Nl0gaXNhcG5wOiBTY2FubmluZyBmb3IgUG5QIGNhcmRzLi4uClsg
ICAyNC43NjE5OTddIGlzYXBucDogTm8gUGx1ZyAmIFBsYXkgZGV2aWNlIGZvdW5kClsgICAyNC43
OTkxMTldIFJlYWwgVGltZSBDbG9jayBEcml2ZXIgdjEuMTJhYwpbICAgMjQuNzk5MjM1XSBpbnRl
bF9ybmc6IEZXSCBub3QgZGV0ZWN0ZWQKWyAgIDI0Ljc5OTMyOV0gU2VyaWFsOiA4MjUwLzE2NTUw
IGRyaXZlciAkUmV2aXNpb246IDEuOTAgJCA0IHBvcnRzLCBJUlEgc2hhcmluZyBlbmFibGVkClsg
ICAyNC43OTk1ODRdIHNlcmlhbDgyNTA6IHR0eVMwIGF0IEkvTyAweDNmOCAoaXJxID0gNCkgaXMg
YSAxNjU1MEEKWyAgIDI0Ljc5OTg0M10gc2VyaWFsODI1MDogdHR5UzEgYXQgSS9PIDB4MmY4IChp
cnEgPSAzKSBpcyBhIDE2NTUwQQpbICAgMjQuODAwMTA4XSBzZXJpYWw4MjUwOiB0dHlTMiBhdCBJ
L08gMHgzZTggKGlycSA9IDQpIGlzIGEgMTY1NTBBClsgICAyNC44MDAzODBdIHNlcmlhbDgyNTA6
IHR0eVMzIGF0IEkvTyAweDJlOCAoaXJxID0gMykgaXMgYSAxNjU1MEEKWyAgIDI0LjgwMTcxNF0g
UkFNRElTSyBkcml2ZXIgaW5pdGlhbGl6ZWQ6IDE2IFJBTSBkaXNrcyBvZiA2NTUzNksgc2l6ZSAx
MDI0IGJsb2Nrc2l6ZQpbICAgMjQuODAxOTc3XSBVbmlmb3JtIE11bHRpLVBsYXRmb3JtIEUtSURF
IGRyaXZlciBSZXZpc2lvbjogNy4wMGFscGhhMgpbICAgMjQuODAyMDY5XSBpZGU6IEFzc3VtaW5n
IDMzTUh6IHN5c3RlbSBidXMgc3BlZWQgZm9yIFBJTyBtb2Rlczsgb3ZlcnJpZGUgd2l0aCBpZGVi
dXM9eHgKWyAgIDI0LjgwMjU1OV0gUE5QOiBQUy8yIENvbnRyb2xsZXIgW1BOUDAzMDNdIGF0IDB4
NjAsMHg2NCBpcnEgMQpbICAgMjQuODAyNjQ3XSBQTlA6IFBTLzIgY29udHJvbGxlciBkb2Vzbid0
IGhhdmUgQVVYIGlycTsgdXNpbmcgZGVmYXVsdCAxMgpbICAgMjQuODA1MzA3XSBzZXJpbzogaTgw
NDIgS0JEIHBvcnQgYXQgMHg2MCwweDY0IGlycSAxClsgICAyNC44MDUzOThdIHNlcmlvOiBpODA0
MiBBVVggcG9ydCBhdCAweDYwLDB4NjQgaXJxIDEyClsgICAyNC44MDU2NTFdIG1pY2U6IFBTLzIg
bW91c2UgZGV2aWNlIGNvbW1vbiBmb3IgYWxsIG1pY2UKWyAgIDI0LjgwNTg3Ml0gRUlTQTogUHJv
YmluZyBidXMgMCBhdCBlaXNhLjAKWyAgIDI0LjgwNTk2M10gQ2Fubm90IGFsbG9jYXRlIHJlc291
cmNlIGZvciBFSVNBIHNsb3QgMQpbICAgMjQuODA2MDUwXSBDYW5ub3QgYWxsb2NhdGUgcmVzb3Vy
Y2UgZm9yIEVJU0Egc2xvdCAyClsgICAyNC44MDYxMzZdIENhbm5vdCBhbGxvY2F0ZSByZXNvdXJj
ZSBmb3IgRUlTQSBzbG90IDMKWyAgIDI0LjgwNjIyMl0gQ2Fubm90IGFsbG9jYXRlIHJlc291cmNl
IGZvciBFSVNBIHNsb3QgNApbICAgMjQuODA2MzI3XSBFSVNBOiBEZXRlY3RlZCAwIGNhcmRzLgpb
ICAgMjQuODA2NTM3XSBUQ1AgY3ViaWMgcmVnaXN0ZXJlZApbICAgMjQuODA2NjM1XSBORVQ6IFJl
Z2lzdGVyZWQgcHJvdG9jb2wgZmFtaWx5IDEKWyAgIDI0LjgwNjc1M10gVXNpbmcgSVBJIFNob3J0
Y3V0IG1vZGUKWyAgIDI0LjgwNzA0MV0gRnJlZWluZyB1bnVzZWQga2VybmVsIG1lbW9yeTogMjQw
ayBmcmVlZApbICAgMjQuODA3NTU1XSBUaW1lOiB0c2MgY2xvY2tzb3VyY2UgaGFzIGJlZW4gaW5z
dGFsbGVkLgpbICAgMjQuODQyNjY0XSBpbnB1dDogQVQgVHJhbnNsYXRlZCBTZXQgMiBrZXlib2Fy
ZCBhcyAvY2xhc3MvaW5wdXQvaW5wdXQwClsgICAyNS43MTE4OTBdIElDSDQ6IElERSBjb250cm9s
bGVyIGF0IFBDSSBzbG90IDAwMDA6MDA6MWYuMQpbICAgMjUuNzExOTkwXSBQQ0k6IEVuYWJsaW5n
IGRldmljZSAwMDAwOjAwOjFmLjEgKDAwMDUgLT4gMDAwNykKWyAgIDI1LjcxMjA4NV0gUENJOiBG
b3VuZCBJUlEgOSBmb3IgZGV2aWNlIDAwMDA6MDA6MWYuMQpbICAgMjUuNzEyMTkxXSBQQ0k6IFNo
YXJpbmcgSVJRIDkgd2l0aCAwMDAwOjAyOjA1LjAKWyAgIDI1LjcxMjI5MV0gSUNINDogY2hpcHNl
dCByZXZpc2lvbiAyClsgICAyNS43MTIzNzRdIElDSDQ6IG5vdCAxMDAlIG5hdGl2ZSBtb2RlOiB3
aWxsIHByb2JlIGlycXMgbGF0ZXIKWyAgIDI1LjcxMjQ2OV0gICAgIGlkZTA6IEJNLURNQSBhdCAw
eDI0MDAtMHgyNDA3LCBCSU9TIHNldHRpbmdzOiBoZGE6RE1BLCBoZGI6cGlvClsgICAyNS43MTI3
MDBdIFByb2JpbmcgSURFIGludGVyZmFjZSBpZGUwLi4uClsgICAyNS44NjUxMjVdIHVzYmNvcmU6
IHJlZ2lzdGVyZWQgbmV3IGludGVyZmFjZSBkcml2ZXIgdXNiZnMKWyAgIDI1Ljg2NTI2MV0gdXNi
Y29yZTogcmVnaXN0ZXJlZCBuZXcgaW50ZXJmYWNlIGRyaXZlciBodWIKWyAgIDI1Ljg2NTM5OF0g
dXNiY29yZTogcmVnaXN0ZXJlZCBuZXcgZGV2aWNlIGRyaXZlciB1c2IKWyAgIDI1Ljg2NzY0MF0g
VVNCIFVuaXZlcnNhbCBIb3N0IENvbnRyb2xsZXIgSW50ZXJmYWNlIGRyaXZlciB2My4wClsgICAy
NS45NjgzMDFdIGUxMDA6IEludGVsKFIpIFBSTy8xMDAgTmV0d29yayBEcml2ZXIsIDMuNS4xNy1r
Mi1OQVBJClsgICAyNS45NjgzOTddIGUxMDA6IENvcHlyaWdodChjKSAxOTk5LTIwMDYgSW50ZWwg
Q29ycG9yYXRpb24KWyAgIDI2LjA0NTM1NV0gaGRhOiBTQU1TVU5HIE1QMDQwMkgsIEFUQSBESVNL
IGRyaXZlClsgICAyNi42NTcxMDddIGlkZTAgYXQgMHgxZjAtMHgxZjcsMHgzZjYgb24gaXJxIDE0
ClsgICAyNi42NzY4NjBdIFNDU0kgc3Vic3lzdGVtIGluaXRpYWxpemVkClsgICAyNi42OTI5MDRd
IGxpYmF0YSB2ZXJzaW9uIDIuMDAgbG9hZGVkLgpbICAgMjYuNzAzMTExXSBQQ0k6IHNldHRpbmcg
SVJRIDUgYXMgbGV2ZWwtdHJpZ2dlcmVkClsgICAyNi43MDMxMThdIFBDSTogRm91bmQgSVJRIDUg
Zm9yIGRldmljZSAwMDAwOjAwOjFkLjAKWyAgIDI2LjcwMzIwOF0gUENJOiBTaGFyaW5nIElSUSA1
IHdpdGggMDAwMDowMDowMi4wClsgICAyNi43MDMzMDNdIFBDSTogU2hhcmluZyBJUlEgNSB3aXRo
IDAwMDA6MDI6MDMuMApbICAgMjYuNzAzNDA4XSBQQ0k6IFNldHRpbmcgbGF0ZW5jeSB0aW1lciBv
ZiBkZXZpY2UgMDAwMDowMDoxZC4wIHRvIDY0ClsgICAyNi43MDM0MTRdIHVoY2lfaGNkIDAwMDA6
MDA6MWQuMDogVUhDSSBIb3N0IENvbnRyb2xsZXIKWyAgIDI2LjcwMzcyN10gdWhjaV9oY2QgMDAw
MDowMDoxZC4wOiBuZXcgVVNCIGJ1cyByZWdpc3RlcmVkLCBhc3NpZ25lZCBidXMgbnVtYmVyIDEK
WyAgIDI2LjcwMzg1Nl0gdWhjaV9oY2QgMDAwMDowMDoxZC4wOiBpcnEgNSwgaW8gYmFzZSAweDAw
MDAxYzAwClsgICAyNi43MDQxMjRdIHVzYiB1c2IxOiBjb25maWd1cmF0aW9uICMxIGNob3NlbiBm
cm9tIDEgY2hvaWNlClsgICAyNi43MDQyNDRdIGh1YiAxLTA6MS4wOiBVU0IgaHViIGZvdW5kClsg
ICAyNi43MDQzMzBdIGh1YiAxLTA6MS4wOiAyIHBvcnRzIGRldGVjdGVkClsgICAyNi43MTU5MzRd
IGhkYTogbWF4IHJlcXVlc3Qgc2l6ZTogNTEyS2lCClsgICAyNi44MDUwMzldIFBDSTogc2V0dGlu
ZyBJUlEgMTUgYXMgbGV2ZWwtdHJpZ2dlcmVkClsgICAyNi44MDUwNDddIFBDSTogRm91bmQgSVJR
IDE1IGZvciBkZXZpY2UgMDAwMDowMDoxZC4xClsgICAyNi44MDUxNzNdIFBDSTogU2V0dGluZyBs
YXRlbmN5IHRpbWVyIG9mIGRldmljZSAwMDAwOjAwOjFkLjEgdG8gNjQKWyAgIDI2LjgwNTE3OV0g
dWhjaV9oY2QgMDAwMDowMDoxZC4xOiBVSENJIEhvc3QgQ29udHJvbGxlcgpbICAgMjYuODA1Mjk2
XSB1aGNpX2hjZCAwMDAwOjAwOjFkLjE6IG5ldyBVU0IgYnVzIHJlZ2lzdGVyZWQsIGFzc2lnbmVk
IGJ1cyBudW1iZXIgMgpbICAgMjYuODA1NDI4XSB1aGNpX2hjZCAwMDAwOjAwOjFkLjE6IGlycSAx
NSwgaW8gYmFzZSAweDAwMDAyMDAwClsgICAyNi44MDU2NDldIHVzYiB1c2IyOiBjb25maWd1cmF0
aW9uICMxIGNob3NlbiBmcm9tIDEgY2hvaWNlClsgICAyNi44MDU3NjldIGh1YiAyLTA6MS4wOiBV
U0IgaHViIGZvdW5kClsgICAyNi44MDU4NjZdIGh1YiAyLTA6MS4wOiAyIHBvcnRzIGRldGVjdGVk
ClsgICAyNi45MDcwNTldIFBDSTogc2V0dGluZyBJUlEgNyBhcyBsZXZlbC10cmlnZ2VyZWQKWyAg
IDI2LjkwNzA2N10gUENJOiBGb3VuZCBJUlEgNyBmb3IgZGV2aWNlIDAwMDA6MDA6MWQuNwpbICAg
MjYuOTA3MTk2XSBQQ0k6IFNldHRpbmcgbGF0ZW5jeSB0aW1lciBvZiBkZXZpY2UgMDAwMDowMDox
ZC43IHRvIDY0ClsgICAyNi45MDcyMDJdIGVoY2lfaGNkIDAwMDA6MDA6MWQuNzogRUhDSSBIb3N0
IENvbnRyb2xsZXIKWyAgIDI2LjkwNzMyMV0gZWhjaV9oY2QgMDAwMDowMDoxZC43OiBuZXcgVVNC
IGJ1cyByZWdpc3RlcmVkLCBhc3NpZ25lZCBidXMgbnVtYmVyIDMKWyAgIDI2LjkwNzQ2Ml0gZWhj
aV9oY2QgMDAwMDowMDoxZC43OiBkZWJ1ZyBwb3J0IDEKWyAgIDI2LjkwNzU0OF0gUENJOiBjYWNo
ZSBsaW5lIHNpemUgb2YgMzIgaXMgbm90IHN1cHBvcnRlZCBieSBkZXZpY2UgMDAwMDowMDoxZC43
ClsgICAyNi45MDc1NjFdIGVoY2lfaGNkIDAwMDA6MDA6MWQuNzogaXJxIDcsIGlvIG1lbSAweGUw
MTAwMDAwClsgICAyNi45MTE1MzVdIGVoY2lfaGNkIDAwMDA6MDA6MWQuNzogVVNCIDIuMCBzdGFy
dGVkLCBFSENJIDEuMDAsIGRyaXZlciAxMCBEZWMgMjAwNApbICAgMjYuOTExNzM4XSB1c2IgdXNi
MzogY29uZmlndXJhdGlvbiAjMSBjaG9zZW4gZnJvbSAxIGNob2ljZQpbICAgMjYuOTExODY0XSBo
dWIgMy0wOjEuMDogVVNCIGh1YiBmb3VuZApbICAgMjYuOTExOTU2XSBodWIgMy0wOjEuMDogNCBw
b3J0cyBkZXRlY3RlZApbICAgMjcuMDEzMDYyXSBQQ0k6IEZvdW5kIElSUSA5IGZvciBkZXZpY2Ug
MDAwMDowMjowNC4wClsgICAyNy4wMTMxNzRdIFBDSTogU2hhcmluZyBJUlEgOSB3aXRoIDAwMDA6
MDA6MWYuMwpbICAgMjcuMDM2NzMxXSBlMTAwOiBldGgwOiBlMTAwX3Byb2JlOiBhZGRyIDB4ZTAy
MTkwMDAsIGlycSA5LCBNQUMgYWRkciAwMDowMDo1QjowMDpGOTo2RApbICAgMjcuMDM2ODYxXSBQ
Q0k6IEZvdW5kIElSUSAxNSBmb3IgZGV2aWNlIDAwMDA6MDI6MDguMApbICAgMjcuMDYwNTY3XSBl
MTAwOiBldGgxOiBlMTAwX3Byb2JlOiBhZGRyIDB4ZTAyMWEwMDAsIGlycSAxNSwgTUFDIGFkZHIg
MDA6RTA6NEI6MTk6QzQ6NDgKWyAgIDI3LjA4NjMyMV0gZTEwMDogZXRoMjogZTEwMF9wcm9iZTog
YWRkciAweGUwMzQwMDAwLCBpcnEgMTUsIE1BQyBhZGRyIDAwOjAwOjVCOjAwOkY5OjZFClsgICAy
Ny4xMTIwODhdIGUxMDA6IGV0aDM6IGUxMDBfcHJvYmU6IGFkZHIgMHhlMDM0MTAwMCwgaXJxIDUs
IE1BQyBhZGRyIDAwOjAwOjVCOjAwOkY5OjZGClsgICAyNy4xNTczNjddIGhkYTogNzgyNDI5NzYg
c2VjdG9ycyAoNDAwNjAgTUIpIHcvODE5MktpQiBDYWNoZSwgQ0hTPTE2MzgzLzI1NS82MywgVURN
QSgzMykKWyAgIDI3LjE1ODE1Ml0gaGRhOiBjYWNoZSBmbHVzaGVzIHN1cHBvcnRlZApbICAgMjcu
MTU4Mjg4XSAgaGRhOiBoZGExIGhkYTIgPCBoZGE1ID4KWyAgIDI3LjIzOTcyN10gdXNiIDMtMjog
bmV3IGhpZ2ggc3BlZWQgVVNCIGRldmljZSB1c2luZyBlaGNpX2hjZCBhbmQgYWRkcmVzcyAyClsg
ICAyNy4zNTQ3MjFdIHVzYiAzLTI6IGNvbmZpZ3VyYXRpb24gIzEgY2hvc2VuIGZyb20gMSBjaG9p
Y2UKWyAgIDI3LjQ1NTcxNV0ga2pvdXJuYWxkIHN0YXJ0aW5nLiAgQ29tbWl0IGludGVydmFsIDUg
c2Vjb25kcwpbICAgMjcuNDU1ODE4XSBFWFQzLWZzOiBtb3VudGVkIGZpbGVzeXN0ZW0gd2l0aCBv
cmRlcmVkIGRhdGEgbW9kZS4KWyAgIDI3LjU2NzYxMV0gdXNiIDMtNDogbmV3IGhpZ2ggc3BlZWQg
VVNCIGRldmljZSB1c2luZyBlaGNpX2hjZCBhbmQgYWRkcmVzcyAzClsgICAyNy43MzIwOTddIHVz
YiAzLTQ6IGNvbmZpZ3VyYXRpb24gIzIgY2hvc2VuIGZyb20gMSBjaG9pY2UKWyAgIDI3LjczMjQ2
M10gdXNiY29yZTogcmVnaXN0ZXJlZCBuZXcgaW50ZXJmYWNlIGRyaXZlciBsaWJ1c3VhbApbICAg
MjguMzI4OTM2XSBJbml0aWFsaXppbmcgVVNCIE1hc3MgU3RvcmFnZSBkcml2ZXIuLi4KWyAgIDI4
LjMyOTE1MF0gc2NzaTAgOiBTQ1NJIGVtdWxhdGlvbiBmb3IgVVNCIE1hc3MgU3RvcmFnZSBkZXZp
Y2VzClsgICAyOC4zMjkzMDJdIHVzYi1zdG9yYWdlOiBkZXZpY2UgZm91bmQgYXQgMgpbICAgMjgu
MzI5MzA2XSB1c2Itc3RvcmFnZTogd2FpdGluZyBmb3IgZGV2aWNlIHRvIHNldHRsZSBiZWZvcmUg
c2Nhbm5pbmcKWyAgIDI4LjMyOTM1OV0gc2NzaTEgOiBTQ1NJIGVtdWxhdGlvbiBmb3IgVVNCIE1h
c3MgU3RvcmFnZSBkZXZpY2VzClsgICAyOC4zMjk0ODddIHVzYi1zdG9yYWdlOiBkZXZpY2UgZm91
bmQgYXQgMwpbICAgMjguMzI5NDkxXSB1c2Itc3RvcmFnZTogd2FpdGluZyBmb3IgZGV2aWNlIHRv
IHNldHRsZSBiZWZvcmUgc2Nhbm5pbmcKWyAgIDI4LjMyOTUwMl0gdXNiY29yZTogcmVnaXN0ZXJl
ZCBuZXcgaW50ZXJmYWNlIGRyaXZlciB1c2Itc3RvcmFnZQpbICAgMjguMzI5NTkwXSBVU0IgTWFz
cyBTdG9yYWdlIHN1cHBvcnQgcmVnaXN0ZXJlZC4KWyAgIDMzLjMyNzI3N10gc2NzaSAwOjA6MDow
OiBEaXJlY3QtQWNjZXNzICAgICBDQk0gICAgICBGbGFzaCBEaXNrICAgICAgIDQuMDAgUFE6IDAg
QU5TSTogMgpbICAgMzMuMzI3ODA4XSB1c2Itc3RvcmFnZTogZGV2aWNlIHNjYW4gY29tcGxldGUK
WyAgIDMzLjQyOTU3M10gdXNiIDMtNDogcmVzZXQgaGlnaCBzcGVlZCBVU0IgZGV2aWNlIHVzaW5n
IGVoY2lfaGNkIGFuZCBhZGRyZXNzIDMKWyAgIDMzLjUzMTUzNV0gdXNiIDMtNDogZGV2aWNlIGRl
c2NyaXB0b3IgcmVhZC82NCwgZXJyb3IgLTcxClsgICAzMy43MzQ0NjVdIHVzYiAzLTQ6IGRldmlj
ZSBkZXNjcmlwdG9yIHJlYWQvNjQsIGVycm9yIC03MQpbICAgMzMuOTM3Mzk1XSB1c2IgMy00OiBy
ZXNldCBoaWdoIHNwZWVkIFVTQiBkZXZpY2UgdXNpbmcgZWhjaV9oY2QgYW5kIGFkZHJlc3MgMwpb
ICAgMzQuMDM5MzU5XSB1c2IgMy00OiBkZXZpY2UgZGVzY3JpcHRvciByZWFkLzY0LCBlcnJvciAt
NzEKWyAgIDM0LjI0MjI4OV0gdXNiIDMtNDogZGV2aWNlIGRlc2NyaXB0b3IgcmVhZC82NCwgZXJy
b3IgLTcxClsgICAzNC40NDUyMTldIHVzYiAzLTQ6IHJlc2V0IGhpZ2ggc3BlZWQgVVNCIGRldmlj
ZSB1c2luZyBlaGNpX2hjZCBhbmQgYWRkcmVzcyAzClsgICAzNC44NDcwNzZdIHVzYiAzLTQ6IGRl
dmljZSBub3QgYWNjZXB0aW5nIGFkZHJlc3MgMywgZXJyb3IgLTcxClsgICAzNC45NDkwNDRdIHVz
YiAzLTQ6IHJlc2V0IGhpZ2ggc3BlZWQgVVNCIGRldmljZSB1c2luZyBlaGNpX2hjZCBhbmQgYWRk
cmVzcyAzClsgICAzNS4zNTA5MDJdIHVzYiAzLTQ6IGRldmljZSBub3QgYWNjZXB0aW5nIGFkZHJl
c3MgMywgZXJyb3IgLTcxClsgICAzNS4zNTEwMjFdIHVzYiAzLTQ6IFVTQiBkaXNjb25uZWN0LCBh
ZGRyZXNzIDMKWyAgIDM1LjM1MTQ2NV0gdXNiLXN0b3JhZ2U6IGRldmljZSBzY2FuIGNvbXBsZXRl
ClsgICAzNS40NTI4ODJdIHVzYiAzLTQ6IG5ldyBoaWdoIHNwZWVkIFVTQiBkZXZpY2UgdXNpbmcg
ZWhjaV9oY2QgYW5kIGFkZHJlc3MgNApbICAgMzUuNTU0ODM2XSB1c2IgMy00OiBkZXZpY2UgZGVz
Y3JpcHRvciByZWFkLzY0LCBlcnJvciAtNzEKWyAgIDM1Ljc1Nzc2NV0gdXNiIDMtNDogZGV2aWNl
IGRlc2NyaXB0b3IgcmVhZC82NCwgZXJyb3IgLTcxClsgICAzNS45NjA2OTRdIHVzYiAzLTQ6IG5l
dyBoaWdoIHNwZWVkIFVTQiBkZXZpY2UgdXNpbmcgZWhjaV9oY2QgYW5kIGFkZHJlc3MgNQpbICAg
MzYuMDYyNjU4XSB1c2IgMy00OiBkZXZpY2UgZGVzY3JpcHRvciByZWFkLzY0LCBlcnJvciAtNzEK
WyAgIDM2LjI2NTYxM10gdXNiIDMtNDogZGV2aWNlIGRlc2NyaXB0b3IgcmVhZC82NCwgZXJyb3Ig
LTcxClsgICAzNi40Njg1NDJdIHVzYiAzLTQ6IG5ldyBoaWdoIHNwZWVkIFVTQiBkZXZpY2UgdXNp
bmcgZWhjaV9oY2QgYW5kIGFkZHJlc3MgNgpbICAgMzYuODcwMzg1XSB1c2IgMy00OiBkZXZpY2Ug
bm90IGFjY2VwdGluZyBhZGRyZXNzIDYsIGVycm9yIC03MQpbICAgMzYuOTcyMzQ5XSB1c2IgMy00
OiBuZXcgaGlnaCBzcGVlZCBVU0IgZGV2aWNlIHVzaW5nIGVoY2lfaGNkIGFuZCBhZGRyZXNzIDcK
WyAgIDM3LjM3NDIyMV0gdXNiIDMtNDogZGV2aWNlIG5vdCBhY2NlcHRpbmcgYWRkcmVzcyA3LCBl
cnJvciAtNzEKWyAgIDM3LjUwNzM2OV0gZTEwMDogZXRoMDogZTEwMF93YXRjaGRvZzogbGluayB1
cCwgMTAwTWJwcywgZnVsbC1kdXBsZXgKWyAgIDM4Ljg5MjI1M10gTkVUOiBSZWdpc3RlcmVkIHBy
b3RvY29sIGZhbWlseSAxNwpbICAgNDAuMDUzNDgxXSBMaW51eCBhZ3BnYXJ0IGludGVyZmFjZSB2
MC4xMDEgKGMpIERhdmUgSm9uZXMKWyAgIDQwLjIyOTkyNV0gYWdwZ2FydDogRGV0ZWN0ZWQgYW4g
SW50ZWwgODU1IENoaXBzZXQuClsgICA0MC4yMzAzNDRdIGFncGdhcnQ6IERldGVjdGVkIDgwNjBL
IHN0b2xlbiBtZW1vcnkuClsgICA0MC4yNDAwOTldIGFncGdhcnQ6IEFHUCBhcGVydHVyZSBpcyAx
MjhNIEAgMHhlODAwMDAwMApbICAgNDAuMjU0ODc4XSBwY2lfaG90cGx1ZzogUENJIEhvdCBQbHVn
IFBDSSBDb3JlIHZlcnNpb246IDAuNQpbICAgNDAuMjU5NTE0XSBzaHBjaHA6IFN0YW5kYXJkIEhv
dCBQbHVnIFBDSSBDb250cm9sbGVyIERyaXZlciB2ZXJzaW9uOiAwLjQKWyAgIDQwLjg1NzE3OF0g
aW5wdXQ6IEdlblBTLzIgR2VuaXVzIE1vdXNlIGFzIC9jbGFzcy9pbnB1dC9pbnB1dDEKWyAgIDQx
LjE0MzI2Nl0gU0NTSSBkZXZpY2Ugc2RhOiAyNDkwODcgNTEyLWJ5dGUgaGR3ciBzZWN0b3JzICgx
MjggTUIpClsgICA0MS4xNzk5MTVdIHNkYTogV3JpdGUgUHJvdGVjdCBpcyBvZmYKWyAgIDQxLjE4
MDAwNl0gc2RhOiBNb2RlIFNlbnNlOiAwMCAwMCAwMCAwMApbICAgNDEuMTgwMDEwXSBzZGE6IGFz
c3VtaW5nIGRyaXZlIGNhY2hlOiB3cml0ZSB0aHJvdWdoClsgICA0MS4yNjE3NzBdIFNDU0kgZGV2
aWNlIHNkYTogMjQ5MDg3IDUxMi1ieXRlIGhkd3Igc2VjdG9ycyAoMTI4IE1CKQpbICAgNDEuMjcz
MzY3XSBzZGE6IFdyaXRlIFByb3RlY3QgaXMgb2ZmClsgICA0MS4yNzM0NTldIHNkYTogTW9kZSBT
ZW5zZTogMDAgMDAgMDAgMDAKWyAgIDQxLjI3MzQ2M10gc2RhOiBhc3N1bWluZyBkcml2ZSBjYWNo
ZTogd3JpdGUgdGhyb3VnaApbICAgNDEuMjczNTUzXSAgc2RhOiBzZGExClsgICA0MS4yNzUxNzZd
IHNkIDA6MDowOjA6IEF0dGFjaGVkIHNjc2kgcmVtb3ZhYmxlIGRpc2sgc2RhClsgICA0MS4yOTEy
NDldIHNkIDA6MDowOjA6IEF0dGFjaGVkIHNjc2kgZ2VuZXJpYyBzZzAgdHlwZSAwClsgICA0MS40
NzQwOTNdIGZ1c2UgaW5pdCAoQVBJIHZlcnNpb24gNy44KQpbICAgNDEuNTM3NjcwXSBscDogZHJp
dmVyIGxvYWRlZCBidXQgbm8gZGV2aWNlcyBmb3VuZApbICAgNDEuNTczODAzXSBBZGRpbmcgMTQ3
Nzk0MGsgc3dhcCBvbiAvZGV2L2Rpc2svYnktdXVpZC9hODQ0ZmVlZC05NWE4LTQ3ODAtOWY3Mi01
YzcyNWMxNDEyNzguICBQcmlvcml0eTotMSBleHRlbnRzOjEgYWNyb3NzOjE0Nzc5NDBrClsgICA0
MS43MzEyMzJdIEVYVDMgRlMgb24gaGRhMSwgaW50ZXJuYWwgam91cm5hbApbICAgNDEuOTMxMzg3
XSBORVQ6IFJlZ2lzdGVyZWQgcHJvdG9jb2wgZmFtaWx5IDEwClsgICA0MS45MzE1MTddIGxvOiBE
aXNhYmxlZCBQcml2YWN5IEV4dGVuc2lvbnMKWyAgIDQxLjkzMTY4Nl0gQUREUkNPTkYoTkVUREVW
X1VQKTogZXRoMTogbGluayBpcyBub3QgcmVhZHkKWyAgIDQxLjkzMTY5MV0gQUREUkNPTkYoTkVU
REVWX1VQKTogZXRoMjogbGluayBpcyBub3QgcmVhZHkKWyAgIDQxLjkzMTY5NV0gQUREUkNPTkYo
TkVUREVWX1VQKTogZXRoMzogbGluayBpcyBub3QgcmVhZHkKWyAgIDUyLjQzNDk4OV0gZXRoMDog
bm8gSVB2NiByb3V0ZXJzIHByZXNlbnQKWyAgMTMwLjE0NjU0Nl0gQ2FwYWJpbGl0eSBMU00gaW5p
dGlhbGl6ZWQKWyAgMTMxLjE5NzE4M10gcHBkZXY6IHVzZXItc3BhY2UgcGFyYWxsZWwgcG9ydCBk
cml2ZXIKWyAgMTMyLjQxMTAxN10gW2RybV0gSW5pdGlhbGl6ZWQgZHJtIDEuMS4wIDIwMDYwODEw
ClsgIDEzMi40MjM5MzRdIFBDSTogRm91bmQgSVJRIDUgZm9yIGRldmljZSAwMDAwOjAwOjAyLjAK
WyAgMTMyLjQyNDIyMl0gUENJOiBTaGFyaW5nIElSUSA1IHdpdGggMDAwMDowMDoxZC4wClsgIDEz
Mi40MjQ0MjldIFBDSTogU2hhcmluZyBJUlEgNSB3aXRoIDAwMDA6MDI6MDMuMApbICAxMzIuNDI1
MDIwXSBbZHJtXSBJbml0aWFsaXplZCBpOTE1IDEuNi4wIDIwMDYwMTE5IG9uIG1pbm9yIDAKWyAg
MTMyLjQyNTYxMl0gW2RybV0gSW5pdGlhbGl6ZWQgaTkxNSAxLjYuMCAyMDA2MDExOSBvbiBtaW5v
ciAxClsgIDEzNS43NDQ2NDZdIEJsdWV0b290aDogQ29yZSB2ZXIgMi4xMQpbICAxMzUuNzQ1Mzgx
XSBORVQ6IFJlZ2lzdGVyZWQgcHJvdG9jb2wgZmFtaWx5IDMxClsgIDEzNS43NDUzODZdIEJsdWV0
b290aDogSENJIGRldmljZSBhbmQgY29ubmVjdGlvbiBtYW5hZ2VyIGluaXRpYWxpemVkClsgIDEz
NS43NDUzOTJdIEJsdWV0b290aDogSENJIHNvY2tldCBsYXllciBpbml0aWFsaXplZApbICAxMzYu
MDQ1NDc5XSBCbHVldG9vdGg6IEwyQ0FQIHZlciAyLjgKWyAgMTM2LjA0NTQ4Nl0gQmx1ZXRvb3Ro
OiBMMkNBUCBzb2NrZXQgbGF5ZXIgaW5pdGlhbGl6ZWQKWyAgMTM2LjEwMzYyNV0gQmx1ZXRvb3Ro
OiBSRkNPTU0gc29ja2V0IGxheWVyIGluaXRpYWxpemVkClsgIDEzNi4xMDM5MThdIEJsdWV0b290
aDogUkZDT01NIFRUWSBsYXllciBpbml0aWFsaXplZApbICAxMzYuMTAzOTI0XSBCbHVldG9vdGg6
IFJGQ09NTSB2ZXIgMS44ClsgIDE0Ny44MjY5OTJdIGV0aDA6IG5vIElQdjYgcm91dGVycyBwcmVz
ZW50Cg==

--0__=4EBBF9F2DFA83A498f9e8a93df938690918c4EBBF9F2DFA83A49--


