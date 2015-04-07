MIME-Version: 1.0
Date: Tue, 7 Apr 2015 16:43:18 +0430
Message-ID: <CAKKWdtcq_Cj7keL4rkpsLwUX1zHg7Cu0CQUwEYAG=o5ZUbPCJQ@mail.gmail.com>
From: ali hagigat <hagigatali@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] clocktest
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

What are the meanings of the following items for clocktest utility:
ToD offset
ToD drift
wraps
max delta

Besides I have some wraps and delta for the following system, are they
OK? while there was no wraps or delta for a x86 desktop
computer+xenomai-2.6.4:

linux-3.16.7.tar.xz
ipipe-core-3.16.7-arm-5.patch  + xenomai user space applications and libraries
target-board: wandboard-quad

# clocktest
== Tested clock: 0 (CLOCK_REALTIME)
CPU      ToD offset [us] ToD drift [us/s]      warps max delta [us]
--- -------------------- ---------------- ---------- --------------
  0            1548388.7           -0.002          0            0.0
  0            1548389.5            0.004          1            0.1
  1            1548389.1           -0.000          3            0.3
  2            1548388.9            0.000          1            0.1
  3            1548389.0           -0.000          1            0.1

