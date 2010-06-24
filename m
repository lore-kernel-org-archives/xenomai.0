MIME-Version: 1.0
Date: Thu, 24 Jun 2010 09:30:17 +0200
Message-ID: <AANLkTik_lbFNx1L6vYAYLVZDnEWG7IdQnAq7-4z2pLiy@domain.hid>
From: Charles Clerdan <charles.clerdan@domain.hid>
Content-Type: multipart/alternative; boundary=0016e6ddab5641cae30489c1a0ff
Subject: [Xenomai-help] Some questions about Xenomai
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

--0016e6ddab5641cae30489c1a0ff
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I'm actually working on an academic project about Real-Time on Xenomai.
I have some questions about Xenomai (for all of them, the application is in
user-space).

How can we use gdb with a RT application? (I understand that, a Xenomai
thread has no PID because it's use a TASK descriptor instead but gdb needs a
PID to attach with)

How can I detect that a Xenomai thread is in secondary mode (I try to use
RT_TASK_INFO but the value is always 0 even if I do non-RT call) ? And does
a mecanism like assertion exist in order to prevent this?

I want to make an IT server as exemple, how can I get back some IT or
generate them from the ADEOS' I-pipe ?

Thanks.

Charles

--0016e6ddab5641cae30489c1a0ff
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>I&#39;m actually working on an academic project about Real-Time =
on Xenomai.<br>I have some questions about Xenomai (for all of them, the ap=
plication is in user-space).<br><br>How can we use gdb with a RT applicatio=
n? (I understand that, a Xenomai thread has no PID because it&#39;s use a T=
ASK descriptor instead but gdb needs a PID to attach with)<br>
<br>How can I detect that a Xenomai thread is in secondary mode (I try to u=
se RT_TASK_INFO but the value is always 0 even if I do non-RT call) ? And d=
oes a mecanism like assertion exist in order to prevent this?<br><br>I want=
 to make an IT server as exemple, how can I get back some IT or generate th=
em from the ADEOS&#39; I-pipe ?<br>
<br>Thanks.<br><br>Charles<br>

--0016e6ddab5641cae30489c1a0ff--

