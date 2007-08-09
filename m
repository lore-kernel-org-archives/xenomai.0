Mime-Version: 1.0 (Apple Message framework v752.3)
Message-Id: <3DF4E126-156D-4C0D-89A0-240509FD50BA@comcast.net>
Content-Type: multipart/alternative; boundary=Apple-Mail-117-62664075
From: ckreider <ckreider@domain.hid>
Date: Thu, 9 Aug 2007 12:09:37 -0400
Subject: [Xenomai-help] WTF???
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


--Apple-Mail-117-62664075
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed


I realize that is seems off topic, but it results from changing from  
RTLinux to Xenomai.  I need to change a dozen uses of mbuff to user  
space shared memory (yes, they are all user space processes using  
kernel memory) and want to use Posix stuff because all the code  
assumes names like "ANALOG" or "DIAG".  My test code works on an  
unpatched 2.4.32 kernel, an rtlinux patched 2.4.29 kernel, but not on  
an ipipe patched 2.6.20 kernel.  Both have tmpfs enabled. In both  
cases, tmpfs is mounted.  The only change from one to the other is  
the kernel selected with grub at boot time.  Does anyone know what is  
different with the 2.6.xx kernels that causes this behavior?  Two  
hours of googling has not yielded any clues.

---
Carl Kreider
ckreider@domain.hid




--Apple-Mail-117-62664075
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=ISO-8859-1

<HTML><BODY style=3D"word-wrap: break-word; -khtml-nbsp-mode: space; =
-khtml-line-break: after-white-space; "><DIV><BR =
class=3D"khtml-block-placeholder"></DIV>I realize that is seems off =
topic, but it results from changing from RTLinux to Xenomai.=A0 I need =
to change a dozen uses of mbuff to user space shared memory (yes, they =
are all user space processes using kernel memory) and want to use Posix =
stuff because all the code assumes names like "ANALOG" or "DIAG".=A0 My =
test code works on an unpatched 2.4.32 kernel, an rtlinux patched 2.4.29 =
kernel, but not on an ipipe patched 2.6.20 kernel.=A0 Both have tmpfs =
enabled. In both cases, tmpfs is mounted.=A0 The only change from one to =
the other is the kernel selected with grub at boot time.=A0 Does anyone =
know what is different with the 2.6.xx kernels that causes this =
behavior?=A0 Two hours of googling has not yielded any =
clues.<DIV><BR><DIV> <SPAN class=3D"Apple-style-span" =
style=3D"border-collapse: separate; border-spacing: 0px 0px; color: =
rgb(0, 0, 0); font-family: Palatino; font-size: 14px; font-style: =
normal; font-variant: normal; font-weight: normal; letter-spacing: =
normal; line-height: normal; text-align: auto; =
-khtml-text-decorations-in-effect: none; text-indent: 0px; =
-apple-text-size-adjust: auto; text-transform: none; orphans: 2; =
white-space: normal; widows: 2; word-spacing: 0px; "><SPAN =
class=3D"Apple-style-span" style=3D"border-collapse: separate; =
border-spacing: 0px 0px; color: rgb(0, 0, 0); font-family: Palatino; =
font-size: 14px; font-style: normal; font-variant: normal; font-weight: =
normal; letter-spacing: normal; line-height: normal; text-align: auto; =
-khtml-text-decorations-in-effect: none; text-indent: 0px; =
-apple-text-size-adjust: auto; text-transform: none; orphans: 2; =
white-space: normal; widows: 2; word-spacing: 0px; =
"><DIV>---</DIV><DIV>Carl Kreider</DIV><DIV><A =
href=3D"mailto:ckreider@domain.hid">ckreider@domain.hid</A></DIV><DIV><B=
R class=3D"khtml-block-placeholder"></DIV><BR =
class=3D"Apple-interchange-newline"></SPAN></SPAN> =
</DIV><BR></DIV></BODY></HTML>=

--Apple-Mail-117-62664075--

