MIME-Version: 1.0
From: Pintu Kumar <pintu.ping@gmail.com>
Date: Tue, 26 Jun 2018 12:52:37 +0530
Message-ID: <CAOuPNLias38WgrA7SeQxC-Nh47q7kM8vRVR=ex_yFzQT1pnDZg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] beaglebone: arm: xeno-test gives segmentation fault -
	test dlopen failed
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,
I am using Kernel 4.9.51 for beagle bone black with xenomai patches
from xenomai-next repo.

I have installed xenomai-3-next using below:
# ./scripts/bootstrap
# ./configure --with-pic --with-core=cobalt --enable-smp --disable-tls
--enable-dlopen-libs
# make
# make install

After that when I run xeno-test I get below error, and the test stopped.

# root@bdk:~# /usr/xenomai/bin/xeno-test
....
....
vdso_access OK
xddp skipped (no kernel support)
Segmentation fault
/usr/xenomai/bin/smokey: test dlopen failed: Unknown error -1

If you have any clue about this error, please let me know.


Thanks,
Pintu

