Message-ID: <4FFF2C70.7080509@bollue.de>
Date: Thu, 12 Jul 2012 21:58:40 +0200
From: Kai <mlist1@bollue.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Subject: [Xenomai] Pool memory leak when writing to full queue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

I have a problem using rt_queue_write() (native skin):
As far as I understand, the function wraps around rt_queue_send() by =

allocating pool memory first and memcpy-ing the user-supplied buffer =

into it.
Problem: If sending fails because the queue is full (w.r.t. the number =

of queued messages), the error is returned to the caller, but the =

allocated pool memory is never freed.
The attached program shows how the pool memory gets almost completely =

filled without any messages left in the queue.

The following patch seems to fix it:

--- xenomai-2.6.1/ksrc/skins/native/syscall_old.c       2012-07-12 =

19:53:48.464968791 +0200
+++ xenomai-2.6.1/ksrc/skins/native/syscall.c   2012-07-12 =

19:48:34.174968603 +0200
@@ -2358,6 +2358,8 @@
         ret =3D rt_queue_send(q, mbuf, size, mode);
         if (ret =3D=3D 0 && (mode & Q_BROADCAST))
                 rt_queue_free(q, mbuf); /* Nobody received, free the =

buffer. */
+       if (ret < 0) /* Send failed */
+               rt_queue_free(q, mbuf);

         return ret;
  }

Regards,
Kai
-------------- next part --------------
A non-text attachment was scrubbed...
Name: QueueWriteTest.cpp
Type: text/x-c++src
Size: 1906 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20120712/45ef7ba=
0/attachment.cpp>
