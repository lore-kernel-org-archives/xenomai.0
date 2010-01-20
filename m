MIME-Version: 1.0
Date: Wed, 20 Jan 2010 20:45:44 +0530
Message-ID: <1aa9845a1001200715l326fa5e8kd5c09cc1dff52298@domain.hid>
From: Saravanan S <sarans1987@domain.hid>
Content-Type: multipart/alternative; boundary=0016e64dd71a73790a047d9a0f09
Subject: [Xenomai-help] Is true task parallelism possible in Xenomai??
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

--0016e64dd71a73790a047d9a0f09
Content-Type: text/plain; charset=ISO-8859-1

Hi,
    Is it possible to run two xenomai user space real time tasks in parallel
on say two different cores(assuming the threads are not contending for same
memory resources at the same time)?? I have tried  giving two real time
tasks equal priorities of 99 and using T_CPU to bind them to different cores
.Is this enough???
Does T_CPU(x) guarantee that my task will be run always on CPU x or does it
just increase the chances of running on CPU x??

How do i know which core my real time task is running ??Is some tool
available for real time monitoring of threads and the cores they are running
on ??

Thanks in advance.

With Regards,

S Saravanan

--0016e64dd71a73790a047d9a0f09
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br>=A0=A0=A0 Is it possible to run two xenomai user space real time tas=
ks in parallel on say two different cores(assuming the threads are not cont=
ending for same memory resources at the same time)?? I have tried=A0 giving=
 two real time tasks equal priorities of 99 and using T_CPU to bind them to=
 different cores .Is this enough???<br>
Does T_CPU(x) guarantee that my task will be run always on CPU x or does it=
=A0 just increase the chances of running on CPU x??<br><br>How do i know wh=
ich core my real time task is running ??Is some tool available for real tim=
e monitoring of threads and the cores they are running on ??<br>
<br>Thanks in advance.<br><br>With Regards,<br><br>S Saravanan<br>

--0016e64dd71a73790a047d9a0f09--

