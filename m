MIME-Version: 1.0
Date: Fri, 27 Jul 2012 15:04:03 +0200
Message-ID: <CALH4WdYdUKfMrsJUHqQYTh84GgMWErpCYUJMmZVtxxngdNoStQ@mail.gmail.com>
From: Frederik Bayart <frederik.bayart@triphase.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] cpu usage
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I'm running Xenomai 2.6.0 on Linux 2.6.38

I have a dual core processor.
When I run a busywait loop on cpu 0 (see source in attachment), I
can't do anything anymore on the computer although cpu 1 is almost
entirely idle. I can't interrupt the busywait loop, login, type
something in a shell, ...
This is even the case if I run linux entirely on cpu 1 (by using
isolcpus=3D0 as kernel parameter)

How can this be explained ?

Is it possible to use cpu 0 at 100% for a xenomai tasks and cpu 1 for
normal linux tasks so that you can still work on the computer ?

Regards,

Frederik
-------------- next part --------------
A non-text attachment was scrubbed...
Name: busywaitd.c
Type: text/x-csrc
Size: 1349 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20120727/4179016=
2/attachment.c>
