MIME-Version: 1.0
From: Norbert Lange <nolange79@gmail.com>
Date: Wed, 9 Aug 2017 16:21:02 +0200
Message-ID: <CADYdroNR6zjbKrPKPm3d_7+55Rg2SDbmpxiNR-xu78QNHSrr9g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] Won`t build on new Debian Stable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hello,

Building the xenomai package won`t work because debian now defaults to
using pie, and the linker will complain with "ld: -r and -pie may not
be used together"

A workaround for now is to add the flags manually:
../xenomai-3.0.5/configure LDFLAGS=-no-pie CFLAGS="-fno-PIE -fno-pie
-no-pie"

A real fix would be similar to
http://lists.gnu.org/archive/html/bug-grub/2016-11/msg00011.html
(no-pie is not supported on old and other compilers)

Kind regards,
Norbert

