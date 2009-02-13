MIME-Version: 1.0
Date: Fri, 13 Feb 2009 15:46:48 -0200
Message-ID: <57e813c90902130946p362eeb18m3141b31fc6aee873@domain.hid>
From: Zara Tustra <zarawesome@domain.hid>
Content-Type: multipart/alternative; boundary=0016e64987c0d4ec0a0462d06b7c
Subject: [Xenomai-help] Confusion regarding linux/xenomai tasks
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

--0016e64987c0d4ec0a0462d06b7c
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

I've read some information regarding the difficulty of communication between
Linux threads and Xenomai tasks, and I've had some misinformation fired at
me from co-workers. I just want to make some points clear:

1) Can a Linux application launch Xenomai tasks, or I've horribly misread
things somewhere? My understanding is that Xenomai tasks are commonly
activated by a Linux process.

2) Can real-time Xenomai tasks started by a Linux application communicate
with it through the global variables of that application?

3) What happens if I make a syscall or similar non-real-time call from a
Xenomai task? Is the task automatically 'demoted' to non-real-time? How can
I tell?

--0016e64987c0d4ec0a0462d06b7c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I&#39;ve read some information regarding the difficulty of communication be=
tween Linux threads and Xenomai tasks, and I&#39;ve had some misinformation=
 fired at me from co-workers. I just want to make some points clear:<br>
<br>1) Can a Linux application launch Xenomai tasks, or I&#39;ve horribly m=
isread things somewhere? My understanding is that Xenomai tasks are commonl=
y activated by a Linux process.<br><br>2) Can real-time Xenomai tasks start=
ed by a Linux application communicate with it through the global variables =
of that application?<br>
<br>3) What happens if I make a syscall or similar non-real-time call from =
a Xenomai task? Is the task automatically &#39;demoted&#39; to non-real-tim=
e? How can I tell?<br>

--0016e64987c0d4ec0a0462d06b7c--

