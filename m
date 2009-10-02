MIME-Version: 1.0
In-Reply-To: <71396b5b0910010109h5cb5912el7eee9d071ed23cda@domain.hid>
References: <71396b5b0910010109h5cb5912el7eee9d071ed23cda@domain.hid>
From: Gilles FRITZ <gillou365@domain.hid>
Date: Fri, 2 Oct 2009 09:21:31 +0200
Message-ID: <71396b5b0910020021n44f2bc22md97b14e389128486@domain.hid>
Content-Type: multipart/alternative; boundary=0016364ed5202502560474ee9e3a
Subject: [Xenomai-help] Strange issue : high latency for kernel task when a
	user task is stop
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

--0016364ed5202502560474ee9e3a
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

I use Xenomai since not very long, but I have seen a strange behavior : whe=
n
I stop a user-space task, my in-kernel task have a latency of about 500=B5s=
.

I have observed that on Xenomai 2.4.8 and 2.3.4, on kernel 2.6.25.19 and
2.6.28.9.

To observe that, I launch two latency test : one in user-space and the
second in kernel-space
latency -p 50 -t 1
latency -p 70

When I stop the second latency (in user-space), I can observe a latency of
at least 500ms in the in-kernel task.

I do not know if this is normal or not.

Have you an explanation for that?

--=20
Regards,
Gilles FRITZ



--=20
Cordialement,
Gilles FRITZ

--0016364ed5202502560474ee9e3a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">Hi,<br><br>I use Xenomai since not very long, bu=
t I have seen a strange behavior : when I stop a user-space task, my in-ker=
nel task have a latency  of about 500=B5s.<br><br>I have observed that on X=
enomai 2.4.8 and 2.3.4, on kernel 2.6.25.19 and 2.6.28.9.<br>


<br>To observe that, I launch two latency test : one in user-space and the =
second in kernel-space<br>latency -p 50 -t 1<br>latency -p 70<br><br>When I=
 stop the second latency (in user-space), I can observe a latency of at lea=
st 500ms in the in-kernel task.<br>


<br>I do not know if this is normal or not. <br><br>Have you an explanation=
 for that?<br clear=3D"all"><br>-- <br>Regards,<br><font color=3D"#888888">=
Gilles FRITZ<br>
</font></div><br><br clear=3D"all"><br>-- <br>Cordialement,<br>Gilles FRITZ=
<br>

--0016364ed5202502560474ee9e3a--

