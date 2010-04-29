MIME-Version: 1.0
Date: Thu, 29 Apr 2010 14:09:31 +0800
Message-ID: <i2z48abf2c21004282309r50f047bck4be213c0aac6efe1@domain.hid>
From: Peter Pan <pppeterpppan@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai-help] cyclictest gives out segmentation fault with xenomai
	2.5.2 in powerpc arch
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

I downloaded the ipipe-2.6 from git.denx.de, head	is
"ipipe-2.6.32-powerpc". Then I downloaded xenomai-2.5.2 and patch the
kernel. Then I install the xenomai applications into our rootfs. I
just run cyclictest in /usr/xenomai/share/xenomai/testsuit/cyclic/run,
it gives out following line:

*
*
* Type ^C to stop this application.
*
*
0.00 0.05 0.03 2/24 1010

T: 0 (    0) P:99 I: 1000000 C:       0 Min: 1000000 Act:       0 Avg:
      0 Max:-1000000
Segmentation fault

