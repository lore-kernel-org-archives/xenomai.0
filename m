MIME-Version: 1.0
Date: Mon, 3 Oct 2011 04:46:27 -0400
Message-ID: <CAGc_wL01jfmJQTzLeC0i8TdBmrF+TyFrzea0Z+QVrDbqXFUUag@domain.hid>
From: Julien Delange <julien.delange@domain.hid>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai-help] Using -rc3 or -rc4 with the 2.6.38 kernel
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>

Dear all,

I currently try to use the latest Xenomai -rc version with the
2.6.38.8. I am able to both compile and build my kernel. However, when
trying to use it with QEMU, it seems it does not work.
If I look at the errors, it seems that udev reports a timeout. After
investigating a little bit, it seems this is related to a regression
in the 2.6.38 kernel on the IDE ATA layer[1] and that the ide layer
generates a lot of IRQ. As a result, the system (a stable debian)
takes at least 5 minutes to boot, waiting for udev to timeout.

Does anyone already experienced that kind of issue when testing the
latest version of xenomai with this kernel version ? If so, how did
you get rid of this error ?

Thanks for any comment or suggestion regarding that problem.

[1] : https://lkml.org/lkml/2011/4/12/538

