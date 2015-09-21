MIME-Version: 1.0
Date: Tue, 22 Sep 2015 00:15:31 +1200
Message-ID: <CAFkYNwZV3xY_QU5E+zdFNGeeM=O4jo897wppbGCg40HumoojBQ@mail.gmail.com>
From: vibnwis <vibnwis@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Xenomai tests
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Having managed to compile Xenomai apps and libs, I went to install them on
target. The way I installed is by creating a xenomai directory in /usr and
set PATH to /usr/xenomai/bin, /usr/xenomai/lib etc.
However, when I ran latency I got this error message
  0"000.000| BUG in low_init(): [main] mlockall: Cannot allocate memory

and when I ran xeno latency -T 25, I got these error messages,

Xenomai: /dev/rtheap is missing
(chardev, major=10 minor=254)

In the installed directory, it does not have dev direcotry but bin, etc,
sbin, lib, share, demo, include. The target does not have rtheap dev as
well. Where and how it is created?

The dmesg | grep -i xenomai produced

[    0.666100] [Xenomai] scheduling class idle registered.
[    0.666112] [Xenomai] scheduling class rt registered.
[    0.666309] I-pipe: head domain Xenomai registered.
[    0.668400] [Xenomai] Cobalt v3.0-rc7 (Exact Zero)


Appreciate any comments, please.

thank you
