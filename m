MIME-Version: 1.0
Date: Thu, 29 Jan 2009 15:27:06 +0900
Message-ID: <ba9b368a0901282227i705ebe80oe75782ccc5cdc17f@domain.hid>
From: Daniel Adams <dadams81@domain.hid>
Content-Type: multipart/alternative; boundary=0016e648d474699d360461992d85
Subject: [Xenomai-help] Problem using sem_open and rt_sem_create
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

--0016e648d474699d360461992d85
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi *,

I'm fairly new to Xenomai and am having a few issues and was wondering if
anyone could provide me with help

I have written some code to create a process which waits on a named
semaphore and then there is another process which posts to it. I originally
developed the code using the posix interface under a standard Linux
environment and have proved it works.
I have since ported the code so that the waiting half creates and waits on
the semaphore using the native skin and the posting half uses the posix
skin.

I tried naming the semaphore using the leading '/' as the posix standard
suggests, but found that using the '/' causes the rt_sem_create(&rt_sem,
SEM_NAME, 0, S_PULSE)  to return EINVAL. Removing the '/' allows the
semaphore to be created but now when I try to open the semaphore
with sem_open(SEM_NAME, O_EXCL), I get an error that the file doesn't exist.
Is there something that I'm missing? I've check the registry and the
semaphore appears under /proc/xenomai/registry/native/semaphores/.

Thanks,

Dan Adams

--0016e648d474699d360461992d85
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi *,<br><br>I&#39;m fairly new to Xenomai and am having a few issues and w=
as wondering if anyone could provide me with help<br><br>I have written som=
e code to create a process which waits on a named semaphore and then there =
is another process which posts to it. I originally developed the code using=
 the posix interface under a standard Linux environment and have proved it =
works.<br>

I have since ported the code so that the waiting half creates and waits on =
the semaphore using the native skin and the posting half uses the posix ski=
n.<br><br>I tried naming the semaphore using the leading &#39;/&#39; as the=
 posix standard suggests, but found that using the &#39;/&#39; causes the r=
t_sem_create(&amp;rt_sem, SEM_NAME, 0, S_PULSE)&nbsp; to return EINVAL. Rem=
oving the &#39;/&#39; allows the semaphore to be created but now when I try=
 to open the semaphore<br>

with sem_open(SEM_NAME, O_EXCL), I get an error that the file doesn&#39;t e=
xist. Is there something that I&#39;m missing? I&#39;ve check the registry =
and the semaphore appears under /proc/xenomai/registry/native/semaphores/.<=
br>
<br>Thanks,<br><br>Dan Adams<br>

--0016e648d474699d360461992d85--

