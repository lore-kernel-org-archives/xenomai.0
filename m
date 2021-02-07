From: Philippe Gerum <rpm@xenomai.org>
Subject: [Dovetail] ARM test version available (kernel v5.10)
Date: Sun, 07 Feb 2021 19:06:01 +0100
Message-ID: <87o8gvoira.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org


The initial port of the Cobalt core to Dovetail/ARM is available from
[1]. The port to Dovetail/arm64 should follow next week.

How to test this:

- clone Xenomai from [1], switch to branch for-upstream/dovetail
- clone the Dovetail tree (v5.10) from [2], switch to branch dovetail/master
- run scripts/prepare-kernel.sh available from [1] into [2] (usual procedure)
  for ARM, that would be: .../scripts/prepare-kernel.sh --arch=arm
- build your kernel using the sources from [2]

There is no user-visible Kconfig change compared to an I-pipe based
version.

Alternatively, the Xenomai code base in [1] can also run on top of the
I-pipe. prepare-kernel.sh detects which pipeline flavour is there, and
prepares the source tree accordingly.

This code is being gradually merged into Xenomai's -next branch, and
will be at the core of Xenomai 3.2. Testing and feedback appreciated.

Thanks,

[1] https://lab.xenomai.org/xenomai-rpm.git, "for-upstream/dovetail" branch
[2] https://git.evlproject.org/linux-evl.git, "dovetail/master" branch

-- 
Philippe.

