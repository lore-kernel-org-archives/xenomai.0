MIME-Version: 1.0
Date: Fri, 21 Oct 2011 14:04:48 -0200
Message-ID: <CAMwkeZxmX1dU-5d2zDiYqv_SRcFqyDF+gmp+i8t=q1G6NXrmbg@domain.hid>
From: =?UTF-8?Q?Fernando_Herrero_Carr=C3=B3n?= <elferdo@domain.hid>
Content-Type: multipart/alternative; boundary=bcaec520f08588956604afd13b70
Subject: [Xenomai-help] rt_task_wait_period returns an undocumented value
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai-help@domain.hid

--bcaec520f08588956604afd13b70
Content-Type: text/plain; charset=UTF-8

Dear list,

I am running xenomai-2.6-rc4 on an amd64 linux kernel version 2.6.38.8.

I am setting up a periodic task using

rt_task_set_periodic(NULL, TM_NOW, 11500);

For period values smaller than 11450 I get an EINVAL return value. I've got
one question regarding this, and it's how is this threshold calculated?

However, further down the program, supposing rt_task_set_periodic() failed
with the above result, calling

rt_task_wait_period()

will return EAGAIN, which is not documented in
http://www.xenomai.org/documentation/trunk/html/api/group__task.html#ga1645d3a072ef3cefeed3bcbb27dcf108
.

Best regards,
Fernando

--bcaec520f08588956604afd13b70
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Dear list,<br><br>I am running xenomai-2.6-rc4 on an amd64 linux kernel ver=
sion 2.6.38.8.<br><br>I am setting up a periodic task using<br><br><div sty=
le=3D"margin-left: 40px;">rt_task_set_periodic(NULL, TM_NOW, 11500);<br><br=
>
</div>For period values smaller than 11450 I get an EINVAL return value. I&=
#39;ve got one question regarding this, and it&#39;s how is this threshold =
calculated?<br><br>However, further down the program, supposing rt_task_set=
_periodic() failed with the above result, calling<br>
<br><div style=3D"margin-left: 40px;">rt_task_wait_period()<br><br></div>wi=
ll return EAGAIN, which is not documented in <a href=3D"http://www.xenomai.=
org/documentation/trunk/html/api/group__task.html#ga1645d3a072ef3cefeed3bcb=
b27dcf108">http://www.xenomai.org/documentation/trunk/html/api/group__task.=
html#ga1645d3a072ef3cefeed3bcbb27dcf108</a>.<br>
<br>Best regards,<br>Fernando<br>

--bcaec520f08588956604afd13b70--

