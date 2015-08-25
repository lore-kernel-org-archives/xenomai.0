MIME-Version: 1.0
Date: Mon, 24 Aug 2015 17:13:48 -0700
Message-ID: <CAJqUr7ybpmgOev-iPaQ-iMEAF8SBocn54vyYSbLcm9spMY=FBg@mail.gmail.com>
From: Don Mahurin <don@mperpetuo.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] xenomai/ipipe arm64 port
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi all,

We would like to submit our current work on the arm64 port of
ipipe/xenomai. We hope that this contribution will encourage further
development of arm64 support in ipipe/xenomai.

This port was largely developed on ipipe-3.10 as a base, so it is likely to
be the most well tested there. Though recently, we have also ported these
changes to ipipe-3.14.44. ( We noticed that 3.10 is missing from rc7. Is
this intended, or will 3.10 support return? )

At the end of this message are the relevant git repos and branches for the
arm64 port. Also included is a build script to build a minimal busybox
linux system which may be ran using qemu (arm64 virt).


Development status:

The 3.14 port is missing the fast-syscall changes (in entry.S) from armv7,
and instead contains the 3.10 entry.S changes forward ported to 3.14.

FPU support is incomplete.

Smokey tests:

3.10/rc6 smokey tests all pass
3.14/rc6 smokey tests all pass
3.14/rc7 smokey tests sched-quota and sched-tp fail


git repos:

https://gitlab.mperpetuo.com/it/xenomai-3.git
https://gitlab.mperpetuo.com/it/ipipe.git
https://gitlab.mperpetuo.com/it/build-scripts.git

ipipe/xenomai arm64 branches:

ipipe-core-3.10.32-arm-10-arm64-2c, v3.0-rc6-arm64-1c
ipipe-core-3.14.44-arm-11-arm64-2, v3.0-rc6-arm64-1c
ipipe-core-3.14.44-arm-12-arm64-2, v3.0-rc7-arm64-1c


The system is built with the following commands.
git clone https://gitlab.mperpetuo.com/it/build-scripts.git
mkdir -p build
cd build
../build-scripts/build_linux_emulator-arm64.sh
or
../build-scripts/build_linux_emulator-arm64.sh --314-rc6
or
../build-scripts/build_linux_emulator-arm64.sh --314-rc7

To run the resulting build:
sudo apt-get install qemu-system-arm
( cd out/target/product/xenomai_arm64; ./run.sh )


We look forward to any feedback or questions. Please let us know how we may
continue to contribute to move this arm64 port forward.

-Don Mahurin
