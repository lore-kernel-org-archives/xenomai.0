MIME-Version: 1.0
Date: Mon, 2 Nov 2009 15:16:13 +0800
Message-ID: <ba9b368a0911012316h393aae27y7418e74b2c8a8428@domain.hid>
From: Daniel Adams <dadams81@domain.hid>
Content-Type: multipart/alternative; boundary=000e0cd2549c1ceb2704775e2734
Subject: [Xenomai-help] A few questions about rt_printf
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

--000e0cd2549c1ceb2704775e2734
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I was looking at using the rt_printf / rt_fprintf for doing deferred logging
and I have a few questions.

1) I was reading through the source and I noticed there is no locking of the
buffer write_pos between tasks during the initial snprint into the buffer.
Is the rt_printf service thread safe? There are calls to
xnarch_read_memory_barrier() and xnarch_write_memory_barrier(), but I'm
assuming they are for SMP and IO ordering although I'm not 100% on what the
barriers imply as I'm fairly new to this kind of hardware.

2) Can the service be called from Linux tasks and Xenomai tasks? We were
trying to get away with a common logging interface (wrapping the service)
which would allow writing to different streams. If it can't be called from a
Linux process then we will have an issue if we try to write to the same
stream from different write tasks.

3) Why is there multiple buffers allowing multiple FIFO's. I've read the
code and can't really see how the extra buffers are used from a users
perspective (I can see how the service prints / manages them). It appears
that whatever buffer you create with rt_print_init or rt_auto_init is the
buffer that get's used for writing too. Is there a way to select the buffer
you want to write to? Also a call to rt_print_init causes a pre-existing
buffer to be written to io from within the callers context and then creates
a new buffer / ring buffer, so that no matter what you are always writing to
the head of the linked list of buffers. How do I get access to an old buffer
once it has been printed? Is there something I'm missing?

I really think I must be missing something, sorry if these are obvious
questions.

Thanks

Dan Adams

--000e0cd2549c1ceb2704775e2734
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>I was looking at using the rt_printf / rt_fprintf for doing defe=
rred logging and I have a few questions. <br><br>1) I was reading through t=
he source and I noticed there is no locking of the buffer write_pos between=
 tasks during the initial snprint into the buffer. Is the rt_printf service=
 thread safe? There are calls to xnarch_read_memory_barrier() and xnarch_wr=
ite_memory_barrier(), but I&#39;m assuming they are for SMP and IO ordering=
 although I&#39;m not 100% on what the barriers imply as I&#39;m fairly new=
 to this kind of hardware. <br>
<br>2) Can the service be called from Linux tasks and Xenomai tasks? We wer=
e trying to get away with a common logging interface (wrapping the service)=
 which would allow writing to different streams. If it can&#39;t be called =
from a Linux process then we will have an issue if we try to write to the s=
ame stream from different write tasks.<br>
<br>3) Why is there multiple buffers allowing multiple FIFO&#39;s. I&#39;ve=
 read the code and can&#39;t really see how the extra buffers are used from=
 a users perspective (I can see how the service prints / manages them). It =
appears that whatever buffer you create with rt_print_init or rt_auto_init =
is the buffer that get&#39;s used for writing too. Is there a way to select=
 the buffer you want to write to? Also a call to rt_print_init causes a pre=
-existing buffer to be written to io from within the callers context and th=
en creates a new buffer / ring buffer, so that no matter what you are alway=
s writing to the head of the linked list of buffers. How do I get access to=
 an old buffer once it has been printed? Is there something I&#39;m missing=
?<br>
<br>I really think I must be missing something, sorry if these are obvious =
questions.<br><br>Thanks<br><br>Dan Adams<br>

--000e0cd2549c1ceb2704775e2734--

