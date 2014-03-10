MIME-Version: 1.0
Date: Mon, 10 Mar 2014 18:31:30 +0330
Message-ID: <CAKKWdtdSNQ1BHnqfOQjQcXHVAztzqkCu2qd60DOVwvtYJxcx+Q@mail.gmail.com>
From: ali hagigat <hagigatali@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] a question about rt_mutex_acquire()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

rt_mutex_acquire() creates a segmentation fault, why?
-------------- next part --------------
./examp1
inside task2
Segmentation fault (core dumped)


dmesg -c
xtask2[12314]: segfault at 0 ip b7703b38 sp b76ea2a0 error 4 in libnative.s=
o.3.0.0[b7700000+6000]


-------------- next part --------------
A non-text attachment was scrubbed...
Name: examp1.c
Type: text/x-csrc
Size: 1131 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140310/7cb2f3c=
d/attachment.c>
