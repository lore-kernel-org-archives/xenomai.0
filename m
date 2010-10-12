Message-ID: <4CB41FF2.9030602@domain.hid>
Date: Tue, 12 Oct 2010 10:44:34 +0200
From: Daniele Nicolodi <daniele@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Analogy regressions in xenomai 2.5.5.1
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hello, I just installed xenomai 2.5.5 on a 2.6.35.7 kernel and I'm
noticing serious regressions on analogy basic features:

1. Buffer management is badly broken. It is not possible to run any
acquisition command that wraps around in the ring buffer. That can be
simply reproduced with:

cmd_read -v d analogy0 -s 0 -S 0

after a while it will fail with: "cmd_read: a4l_read failed (ret=-32)".
In dmesg the driver reports: "Analogy: MITE: DME overwrite of free area".

2. Buffer is kept memory mapped after the mapping process dies. If a
process mapping a device buffer dies before un-mapping the buffer, it is
not possible to reconfigure the bnuffer. a4l_set_bufsize fails with
error code 32 and dmesg read "Analogy: a4l_ioctl_bufcfg: please unmap
before configuring buffer". Sinche the mapping process died I do not
know how to do this.

When I proposed some easy changes to the analogy API, to make it much
less confusing with trivial changes, Alexis expressed concerns about API
stability. What about functional stability? I think the reported ones
are major problems easily catch with simple pre-release tests...

Cheers,
Daniele

