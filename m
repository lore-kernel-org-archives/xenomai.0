Sender: Piotr Piorkowski <qba100@gmail.com>
Date: Thu, 21 Dec 2017 10:13:06 +0100
From: =?utf-8?Q?Piotr_Pi=C3=B3rkowski?= <piotr.piorkow@gmail.com>
Message-ID: <local-8ffba3d7-6f1c@qba-msi>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Xenomai]  bad syscall / Illegal instruction on arm
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "=?utf-8?Q?Xenomai=40xenomai.org?=" <Xenomai@xenomai.org>

Hi

I have problem when I try run any program using Xenomai.
I get a massege: Illegal instruction and in dmesg i get:
[Xenomai] bad syscall <0xff7000af>
[Xenomai] bad syscall <0xff7000ae>
[Xenomai] bad syscall <0xff7000af>
[Xenomai] bad syscall <0xff7000f0>
[Xenomai] bad syscall <0xff700005>
[Xenomai] bad syscall <0xff700092>
[Xenomai] bad syscall <0xff7000c0>
[Xenomai] bad syscall <0xff7000af>
[Xenomai] bad syscall <0xff7000af>
[Xenomai] bad syscall <0xff700014>
[Xenomai] bad syscall <0xff7000e0>
[Xenomai] bad syscall <0xff70010c>
[Xenomai] bad syscall <0xff7000af>
[Xenomai] bad syscall <0xff7000ae>
[Xenomai] bad syscall <0xff7000af>
[Xenomai] bad syscall <0xff700014>
[Xenomai] bad syscall <0xff7000e0>
[Xenomai] bad syscall <0xff70010c>
[Xenomai] bad syscall <0xff7000af>

I have Xenomai 3.0.6 and kernel 4.1.21 on rpi3 (arm).

Best Regards
Piotr
