MIME-Version: 1.0
Date: Fri, 7 Aug 2009 11:08:15 +0100
Message-ID: <28c396720908070308t544c6cb7y45ed53c11dfee30c@domain.hid>
From: Yang <hegallis@domain.hid>
Content-Type: multipart/alternative; boundary=0016e6d77ec723a9b204708a6ad1
Subject: [Xenomai-help] Interrupt workqueue and Xenomai 2.4.0
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

--0016e6d77ec723a9b204708a6ad1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi

I am working on BF527 at the moment while we queue work item upon GPI
interrupt to a work queue as delayed work. This kernel driver works fine
without Xenomai patch turned on. However, it stops working after applying
Xenomai patch. It appears that the interrupt handler was triggered but the
work item in the work queue is not being processing (by kernel thread which
is supposed to work on).


my assumption was that ipipe should pass through non-rt interrupts to Linux
domain. Linux kernel tasks such as work queue will still be handled in the
same way by kthread. However, it seems that

1. the interrupt line never gets cleared

2. kthread which handles work structure in the work queue not doing its work
(or cannot switch to linux kthread context I suspect)

Any suggestions?


Thanks

--0016e6d77ec723a9b204708a6ad1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<span class=3D"Apple-style-span" style=3D"font-family: Tahoma; font-size: 1=
4px; color: rgb(90, 90, 137); line-height: 16px; -webkit-border-horizontal-=
spacing: 1px; -webkit-border-vertical-spacing: 1px; "><p style=3D"margin-to=
p: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; padding-to=
p: 0px; padding-right: 0px; padding-bottom: 10px; padding-left: 0px; ">
Hi</p><p style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; m=
argin-left: 0px; padding-top: 0px; padding-right: 0px; padding-bottom: 10px=
; padding-left: 0px; ">I am working on BF527 at the moment while we queue w=
ork item upon GPI interrupt to a work queue as delayed work. This kernel dr=
iver works fine without Xenomai patch turned on. However, it stops working =
after applying Xenomai patch. It appears that the interrupt handler was tri=
ggered but the work item in the work queue is not being processing (by kern=
el thread which is supposed to work on).</p>
<p style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-=
left: 0px; padding-top: 0px; padding-right: 0px; padding-bottom: 10px; padd=
ing-left: 0px; "><br></p><p style=3D"margin-top: 0px; margin-right: 0px; ma=
rgin-bottom: 0px; margin-left: 0px; padding-top: 0px; padding-right: 0px; p=
adding-bottom: 10px; padding-left: 0px; ">
</p><p style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; mar=
gin-left: 0px; padding-top: 0px; padding-right: 0px; padding-bottom: 10px; =
padding-left: 0px; ">my assumption was that ipipe should pass through non-r=
t interrupts to Linux domain. Linux kernel tasks such as work queue will st=
ill be handled in the same way by kthread. However, it seems that</p>
<p style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-=
left: 0px; padding-top: 0px; padding-right: 0px; padding-bottom: 10px; padd=
ing-left: 0px; ">1. the interrupt line never gets cleared</p><p style=3D"ma=
rgin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; pad=
ding-top: 0px; padding-right: 0px; padding-bottom: 10px; padding-left: 0px;=
 ">
2. kthread which handles work structure in the work queue not doing its wor=
k (or cannot switch to linux kthread context I suspect)</p><p style=3D"marg=
in-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; paddi=
ng-top: 0px; padding-right: 0px; padding-bottom: 10px; padding-left: 0px; "=
>
Any suggestions?</p><p style=3D"margin-top: 0px; margin-right: 0px; margin-=
bottom: 0px; margin-left: 0px; padding-top: 0px; padding-right: 0px; paddin=
g-bottom: 10px; padding-left: 0px; "><br></p><p style=3D"margin-top: 0px; m=
argin-right: 0px; margin-bottom: 0px; margin-left: 0px; padding-top: 0px; p=
adding-right: 0px; padding-bottom: 10px; padding-left: 0px; ">
Thanks</p><p style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0p=
x; margin-left: 0px; padding-top: 0px; padding-right: 0px; padding-bottom: =
10px; padding-left: 0px; "><br></p><p></p></span>

--0016e6d77ec723a9b204708a6ad1--

