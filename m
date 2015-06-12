From: Michael Haberler <haberlerm@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Message-Id: <F89CBA55-43A8-4AE5-A859-BFE111D40561@gmail.com>
Date: Fri, 12 Jun 2015 23:41:21 +0200
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: [Xenomai] RTDM-native mainlining - status?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

Q - can I assume "RTDM-native" will be part of RT-PREEMPT if/when that =
goes mainline?

or must I assume this will remain a Xenomai-specific way of doing things =
which will not be available via a torvalds kernel?


- Michael

background - since we have a portable RT application, investing into =
RTDM drivers makes a lot more sense if both RT kernel flavors can make =
use of them (in fact three if a vanilla kernel is used - which is good =
enough for certain applications)


