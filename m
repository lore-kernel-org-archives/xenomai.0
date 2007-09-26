In-Reply-To: <2ff1a98a0709250625y5bfc46e0k9ac41d04c8d68270@domain.hid>
Message-ID: <OF6A62BF46.D2513C20-ONC1257362.001F7DB0-C1257362.001FB75C@datacon.at>
From: juergen.lanner@domain.hid
Date: Wed, 26 Sep 2007 07:46:47 +0200
MIME-Version: 1.0
Content-type: multipart/related; 
	Boundary="0__=4EBBF9F1DF8CFB208f9e8a93df938690918c4EBBF9F1DF8CFB20"
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

--0__=4EBBF9F1DF8CFB208f9e8a93df938690918c4EBBF9F1DF8CFB20
Content-type: multipart/alternative; 
	Boundary="1__=4EBBF9F1DF8CFB208f9e8a93df938690918c4EBBF9F1DF8CFB20"

--1__=4EBBF9F1DF8CFB208f9e8a93df938690918c4EBBF9F1DF8CFB20
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: quoted-printable


Please, could you give me some sort if a hint?
I'm not so familiar with kernel features and don't know where to start.=


Thanx

Juergen







On 9/25/07, juergen.lanner@domain.hid <juergen.lanner@domain.hid> wrote=
:
>
>
>
> Hi Gilles!
>
>
>  Yes, you're right, it was the SMP option that hid the LAPIC.
>
>  Unfortunately switching it on and enabling it at boot gives the same=

result as before, although the startup log seems ok as well.
>  (see here complete boot log: (See attached file:
boot_with_lapic_on_in_kernel_and_boot.txt))
>
>
>  Deactivating LAPIC in kernel: same problem, no change
>  (see here the complete boot log:(See attached file:
boot_with_lapic_off_in_kernel.txt) )
>
>  =3D=3D> maybe LAPIC is not really an issue here?
>  At least it doesn't change anything if active or not.
>
>
>
>
>  Maybe that is important:
>   I saw that when installing the kernel there were some messages due =
to
files not found.
>
>  The funny thing is that I am using xenomai 2.3.3, not 2.3.0
>  Could the problem be due to this?

This 2.3.0 comes from your kernel configuration, it should not matter.

But there is something in your kernel configuration that prevents
Xenomai syscalls from working properly. In order to find what it is,
could you try and start from a minimal kernel configuration and enable
additional features one by one ?

--
                                               Gilles Chanteperdrix
=

--1__=4EBBF9F1DF8CFB208f9e8a93df938690918c4EBBF9F1DF8CFB20
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline
Content-transfer-encoding: quoted-printable

<html><body>
<p><font face=3D"Arial">Please, could you give me some sort if a hint?<=
/font><br>
<font face=3D"Arial">I'm not so familiar with kernel features and don't=
 know where to start.</font><br>
<br>
<font face=3D"Arial">Thanx<br>
</font><br>
<font face=3D"Arial">Juergen</font><br>
<br>
<font face=3D"Arial"><br>
</font><br>
<img width=3D"16" height=3D"16" src=3D"cid:1__=3D4EBBF9F1DF8CFB208f9e8a=
93df938@domain.hid" border=3D"0" alt=3D"Inactive hide details for &quot=
;Gilles Chanteperdrix&quot; &lt;gilles.chanteperdrix@xenomai.org&gt;">&qu=
ot;Gilles Chanteperdrix&quot; &lt;gilles.chanteperdrix@xenomai.org&gt;<br=
>
<br>
<br>
<br>
<tt>On 9/25/07, juergen.lanner@domain.hid &lt;juergen.lanner@domain.hid=
&gt; wrote:<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Hi Gilles!<br>
&gt;<br>
&gt;<br>
&gt; &nbsp;Yes, you're right, it was the SMP option that hid the LAPIC.=
<br>
&gt;<br>
&gt; &nbsp;Unfortunately switching it on and enabling it at boot gives =
the same result as before, although the startup log seems ok as well.<b=
r>
&gt; &nbsp;(see here complete boot log: (See attached file: boot_with_l=
apic_on_in_kernel_and_boot.txt))<br>
&gt;<br>
&gt;<br>
&gt; &nbsp;Deactivating LAPIC in kernel: same problem, no change<br>
&gt; &nbsp;(see here the complete boot log:(See attached file: boot_wit=
h_lapic_off_in_kernel.txt) )<br>
&gt;<br>
&gt; &nbsp;=3D=3D&gt; maybe LAPIC is not really an issue here?<br>
&gt; &nbsp;At least it doesn't change anything if active or not.<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; &nbsp;Maybe that is important:<br>
&gt; &nbsp; I saw that when installing the kernel there were some messa=
ges due to files not found.<br>
&gt;<br>
&gt; &nbsp;The funny thing is that I am using xenomai 2.3.3, not 2.3.0<=
br>
&gt; &nbsp;Could the problem be due to this?<br>
<br>
This 2.3.0 comes from your kernel configuration, it should not matter.<=
br>
<br>
But there is something in your kernel configuration that prevents<br>
Xenomai syscalls from working properly. In order to find what it is,<br=
>
could you try and start from a minimal kernel configuration and enable<=
br>
additional features one by one ?<br>
<br>
-- <br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; Gilles Chanteperdrix<br>
</tt><br>
</body></html>=


--1__=4EBBF9F1DF8CFB208f9e8a93df938690918c4EBBF9F1DF8CFB20--


--0__=4EBBF9F1DF8CFB208f9e8a93df938690918c4EBBF9F1DF8CFB20
Content-type: image/gif; 
	name="graycol.gif"
Content-Disposition: inline; filename="graycol.gif"
Content-ID: <1__=4EBBF9F1DF8CFB208f9e8a93df938@domain.hid>
Content-transfer-encoding: base64

R0lGODlhEAAQAKECAMzMzAAAAP///wAAACH5BAEAAAIALAAAAAAQABAAAAIXlI+py+0PopwxUbpu
ZRfKZ2zgSJbmSRYAIf4fT3B0aW1pemVkIGJ5IFVsZWFkIFNtYXJ0U2F2ZXIhAAA7

--0__=4EBBF9F1DF8CFB208f9e8a93df938690918c4EBBF9F1DF8CFB20--


