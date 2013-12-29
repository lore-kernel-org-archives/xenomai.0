MIME-Version: 1.0
Date: Sun, 29 Dec 2013 03:15:54 -0500
Message-ID: <CAKKWdtdP_fvvMwzC8YpZriL6mC_QbwRkmjzpPYVB8Ue8yBFt5Q@mail.gmail.com>
From: ali hagigat <hagigatali@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] kernel panic for rt_task_add_hook
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

I am using a 32 bit Fedora 13, linux kernel 3.5.7 and xenomai-2.6.3.
Please do the followings:

1) insmod ./kerneltask2.ko
2) rmmod kerneltask2

The first time is OK. The second time the computer freezes and i have
a kernel panic and carsh dump every time.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: config1
Type: application/octet-stream
Size: 131428 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20131229/4101774=
7/attachment.obj>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: kerneltask2.c
Type: text/x-csrc
Size: 1201 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20131229/4101774=
7/attachment.c>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: Makefile
Type: application/octet-stream
Size: 2338 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20131229/4101774=
7/attachment-0001.obj>
