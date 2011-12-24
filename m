MIME-Version: 1.0
Date: Sat, 24 Dec 2011 10:10:35 +0800
Message-ID: <CADwQ9Q51ze5gtxU9ObHqGxW8nJpM--eQhWvzmf5y2MhcxN0xXQ@mail.gmail.com>
From: =?GB2312?B?s8LP/g==?= <chenzl92@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai-help] How to Adapt ARM I-pipe patch to S3C6410
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

sorry for the mistake,my ipipe-patch is
adeos-ipipe-2.6.37.6-arm-1.18-03   ,and where can I get the new
"HowTo" as it maybe out of date.
As I said,I add the printascii function in the begin of
start_kernel(),but it didn't print out ,so I believe it didn't go to
the start_kernel. I also add the printascii function to the
arch/arm/kernel/head.S,I found when it run to "enable the mmu" it
stopped. I believe the .config file works well before I patch the
xenomai .I also believe the xenomai has nothing to do with the setup
of hardware before the kernel startup.

