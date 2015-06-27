From: Michael Haberler <haberlerm@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Message-Id: <C31C0BF8-AC9A-442B-8A2F-4576ACF1F817@gmail.com>
Date: Sat, 27 Jun 2015 14:22:09 +0200
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: [Xenomai] Q on xenomai2/3 userland coexistence
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

ATM we're sorting through the machinekit xenomai3 transition on debian

I assume that users will continue to run xenomai2 kernels for a long =
time, so we work towards separate (but hopefully coexisting-in-peace) =
packages for Xenomai2 and Xenomai3 (startup is driven by kernel =
autodetection, so booting a different kernel chooses the right runtime)

The libxenomai-dev and libxenomai1 in debian are all xenomai2 atm, but I =
assume Xenomai3 equivalents will appear eventually

I hope these will be able to co-reside on the same host?

Ideally suggesting the Xenomai3 packages would be separate, be named =
differently, and not supersede any installed Xenomai2 packages?


(or am I blundering and I can run applications linked against the =
Xenomai3 libraries on a Xenomai2 kernel? my tests so far indicate - not)


thanks in advance,

Michael


btw: a working 3.14 Xenomai3 kernel for the Beaglebone (and likely X15) =
appeared the other day in "deb [arch=3Darmhf] =
http://repos.rcn-ee.net/debian/ jessie main" , thanks to Robert Nelson!

mah@epig:~/machinekit/src$ apt-cache search 3.14.45-ti-xenomai-r69

linux-firmware-image-3.14.45-ti-xenomai-r69 - Linux kernel firmware, =
version 3.14.45-ti-xenomai-r69
linux-image-3.14.45-ti-xenomai-r69 - Linux kernel, version =
3.14.45-ti-xenomai-r69
mt7601u-modules-3.14.45-ti-xenomai-r69 - mt7601u modules
ti-sgx-es8-modules-3.14.45-ti-xenomai-r69 - ti-sgx es8 modules
ti-sgx-es9-modules-3.14.45-ti-xenomai-r69 - ti-sgx es9 modules
linux-headers-3.14.45-ti-xenomai-r69 - Linux kernel headers for =
3.14.45-ti-xenomai-r69 on armhf

[    2.732701] [Xenomai] Cobalt v3.0-rc4 (Exact Zero) [DEBUG]


