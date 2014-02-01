MIME-Version: 1.0
Date: Sat, 1 Feb 2014 07:36:01 -0500
Message-ID: <CAKKWdtc5QWhvcOwp2fjkUMHB1jTV9gV-hXf+3vzt0McLZ433fQ@mail.gmail.com>
From: ali hagigat <hagigatali@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] installing a signal handler
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

It seems that signal handler does not execute...
-------------- next part --------------
> cat /proc/xenomai/sched
CPU  PID    CLASS  PRI      TIMEOUT   TIMEBASE   STAT       NAME
  0  0      idle    -1      -         master     R          ROOT/0
  1  0      idle    -1      -         master     R          ROOT/1
  2  0      idle    -1      -         master     R          ROOT/2
  3  0      idle    -1      -         master     R          ROOT/3
  0  0      rt      50      -         master     Df         KTask1
  0  0      rt      50      -         master     Df         KTask2


> dmesg
notify is successful...


-------------- next part --------------
A non-text attachment was scrubbed...
Name: kerneltask7.c
Type: text/x-csrc
Size: 1227 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140201/7a88158=
2/attachment.c>
