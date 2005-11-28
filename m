Message-ID: <ae7121c60511280858g7d25f4d9y28de0688053ad51d@domain.hid>
Date: Mon, 28 Nov 2005 17:58:31 +0100
From: Panagiotis Issaris <panagiotis@domain.hid>
Subject: Re: [Xenomai-core] Latest snapshot (182) not compiling (kernel)
In-Reply-To: <ae7121c60511280857l26c080b7g299c6cae93a8afed@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_9726_8160817.1133197111840"
References: <438743FC.6070007@domain.hid>
	<ae7121c60511280857l26c080b7g299c6cae93a8afed@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

------=_Part_9726_8160817.1133197111840
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I'm also having issues compiling the latest Xenomai tree.


On 11/25/05, Ignacio Garc=EDa P=E9rez <iggarpe@domain.hid > wrote:
>
> Hi,
>
> I dunno what's changed, but I updated my xenomai snapshot to the latest
> revision (182) and the kernel no longer compiles (fails due to some
> xnpod_* undefined symbols).
>
> Revision 179 compiled fine.



I'm using revision 199 on a x86 Ubuntu 5.10 system with GCC 4.0.1 (is anyon=
e
else using that one?).


  LD      init/built-in.o
  LD      .tmp_vmlinux1
kernel/built-in.o: In function `disengage_irq_shield':
/usr/local/src/linux-2.6.14/kernel/xenomai/nucleus/shadow.c:176: undefined
reference to `__raw_write_lock'
/usr/local/src/linux-2.6.14/kernel/xenomai/nucleus/shadow.c:207: undefined
reference to `__raw_write_unlock'
/usr/local/src/linux-2.6.14/kernel/xenomai/nucleus/shadow.c:186: undefined
reference to `__raw_write_unlock'
kernel/built-in.o: In function `xnshadow_reset_shield':
/usr/local/src/linux-2.6.14/kernel/xenomai/nucleus/shadow.c:152: undefined
reference to `__raw_read_lock'
/usr/local/src/linux-2.6.14/kernel/xenomai/nucleus/shadow.c:158: undefined
reference to `__raw_read_unlock'
kernel/built-in.o: In function `lostage_handler':
/usr/local/src/linux-2.6.14/kernel/xenomai/nucleus/shadow.c:152: undefined
reference to `__raw_read_lock'
/usr/local/src/linux-2.6.14/kernel/xenomai/nucleus/shadow.c:158: undefined
reference to `__raw_read_unlock'
kernel/built-in.o: In function `xnshadow_relax':
/usr/local/src/linux-2.6.14/kernel/xenomai/nucleus/shadow.c:152: undefined
reference to `__raw_read_lock'
/usr/local/src/linux-2.6.14/kernel/xenomai/nucleus/shadow.c:158: undefined
reference to `__raw_read_unlock'
kernel/built-in.o: In function `schedule_event':
/usr/local/src/linux-2.6.14/kernel/xenomai/nucleus/shadow.c:152: undefined
reference to `__raw_read_lock'
/usr/local/src/linux-2.6.14/kernel/xenomai/nucleus/shadow.c:158: undefined
reference to `__raw_read_unlock'
make[1]: *** [.tmp_vmlinux1] Error 1
make: *** [_all] Error 2


With friendly regards,
Takis

------=_Part_9726_8160817.1133197111840
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<span class=3D"gmail_quote"></span>Hi,<br><br>I'm also having issues compil=
ing the latest Xenomai tree.<br><br><br><div><span class=3D"q"><span class=
=3D"gmail_quote">On 11/25/05, <b class=3D"gmail_sendername">Ignacio Garc=ED=
a P=E9rez</b>
 &lt;<a href=3D"mailto:iggarpe@domain.hid" target=3D"_blank" onclick=3D"retur=
n top.js.OpenExtLink(window,event,this)">iggarpe@domain.hid
</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" style=3D"border-lef=
t: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1=
ex;">Hi,<br><br>I dunno what's changed, but I updated my xenomai snapshot t=
o the latest
<br>revision (182) and the kernel no longer compiles (fails due to some<br>=
xnpod_* undefined symbols).<br><br>Revision 179 compiled fine.</blockquote>=
</span><div><br><br>I'm using revision 199 on a x86 Ubuntu 5.10 system with=
 GCC=20
4.0.1 (is anyone else using that one?).<br><br><br>&nbsp; LD&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; init/built-in.o<br>&nbsp; LD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
.tmp_vmlinux1<br>kernel/built-in.o: In function `disengage_irq_shield':<br>=
/usr/local/src/linux-2.6.14/kernel/xenomai/nucleus/shadow.c:176: undefined =
reference to `__raw_write_lock'
<br>/usr/local/src/linux-2.6.14/kernel/xenomai/nucleus/shadow.c:207: undefi=
ned reference to `__raw_write_unlock'<br>/usr/local/src/linux-2.6.14/kernel=
/xenomai/nucleus/shadow.c:186: undefined reference to `__raw_write_unlock'
<br>kernel/built-in.o: In function `xnshadow_reset_shield':<br>/usr/local/s=
rc/linux-2.6.14/kernel/xenomai/nucleus/shadow.c:152: undefined reference to=
 `__raw_read_lock'<br>/usr/local/src/linux-2.6.14/kernel/xenomai/nucleus/sh=
adow.c:158: undefined reference to `__raw_read_unlock'
<br>kernel/built-in.o: In function `lostage_handler':<br>/usr/local/src/lin=
ux-2.6.14/kernel/xenomai/nucleus/shadow.c:152: undefined reference to `__ra=
w_read_lock'<br>/usr/local/src/linux-2.6.14/kernel/xenomai/nucleus/shadow.c=
:158: undefined reference to `__raw_read_unlock'
<br>kernel/built-in.o: In function `xnshadow_relax':<br>/usr/local/src/linu=
x-2.6.14/kernel/xenomai/nucleus/shadow.c:152: undefined reference to `__raw=
_read_lock'<br>/usr/local/src/linux-2.6.14/kernel/xenomai/nucleus/shadow.c:=
158: undefined reference to `__raw_read_unlock'
<br>kernel/built-in.o: In function `schedule_event':<br>/usr/local/src/linu=
x-2.6.14/kernel/xenomai/nucleus/shadow.c:152: undefined reference to `__raw=
_read_lock'<br>/usr/local/src/linux-2.6.14/kernel/xenomai/nucleus/shadow.c:=
158: undefined reference to `__raw_read_unlock'
<br>make[1]: *** [.tmp_vmlinux1] Error 1<br>make: *** [_all] Error 2<br></d=
iv></div><br><br>With friendly regards,<br>Takis<br>


------=_Part_9726_8160817.1133197111840--

