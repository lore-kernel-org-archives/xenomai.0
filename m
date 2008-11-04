Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C93EA0.FD761650"
Date: Tue, 4 Nov 2008 18:15:50 +0100
Message-ID: <406CC9939904F143B9D42CEEA3E56E565DA7FA@oab1mx1.oneaccess.intra>
From: "Filip Van Rillaer" <Filip.VanRillaer@domain.hid>
Subject: [Xenomai-help] xenomai on blackfin svn4240
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

This is a multi-part message in MIME format.

------_=_NextPart_001_01C93EA0.FD761650
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Hello,
=20
Starting from subversion revision 4240, xenomai is not compiling anymore
for blackfin.
I think that part of the problem is the absence of following parts in
usermode (I mean not __KERNEL__) in the file asm-blackfin/atomic.h :
 - typedef for xnarch_atomic_t is missing
 - xnarch_atomic_get is missing
 - xnarch_atomic_set is missing
 - xnarch_atomic_cmpxchg is missing
=20
I also had to make the function xeno_init_current_mode (file bind.h) as
<<static inline>> to avoid a problem with multiple definitions when
linking my user-application (it includes functions of native and rtdm
library).
=20
Finally rt_task_shadow fails and returns  EFAULT (but that problem can
be caused by my own dummy implementation for the functions mentioned)
=20
Best regards,
Filip

------_=_NextPart_001_01C93EA0.FD761650
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.6000.16735" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D267502410-04112008>Hello,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D267502410-04112008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D267502410-04112008>Starting from=20
subversion revision 4240, xenomai is not compiling anymore for=20
blackfin.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D267502410-04112008>I =
think that part of=20
the problem is the absence of&nbsp;following parts&nbsp;in usermode (I =
mean not=20
__KERNEL__) in the file asm-blackfin/atomic.h :</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D267502410-04112008>&nbsp;- typedef for=20
xnarch_atomic_t is missing</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D267502410-04112008>&nbsp;-=20
xnarch_atomic_get is missing</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D267502410-04112008>&nbsp;-=20
xnarch_atomic_set is missing</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D267502410-04112008>&nbsp;-=20
xnarch_atomic_cmpxchg is missing</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D267502410-04112008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D267502410-04112008>I also =
had to make=20
the function xeno_init_current_mode (file bind.h) as &lt;&lt;static=20
inline&gt;&gt; to avoid a problem with multiple definitions when =
linking&nbsp;my=20
user-application (it&nbsp;includes functions of native and rtdm=20
library).</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D267502410-04112008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D267502410-04112008>Finally=20
rt_task_shadow&nbsp;fails and returns &nbsp;EFAULT (but that problem can =
be=20
caused by my own dummy implementation for the functions=20
mentioned)</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D267502410-04112008></SPAN></FONT><FONT=20
face=3DArial size=3D2><SPAN =
class=3D267502410-04112008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D267502410-04112008>Best=20
regards,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D267502410-04112008>Filip</SPAN></FONT></DIV></BODY></HTML>

------_=_NextPart_001_01C93EA0.FD761650--

