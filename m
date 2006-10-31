MIME-Version: 1.0
Message-ID: <OF46135D04.DC659798-ONC1257218.0026EC51@domain.hid>
From: "Thomas Necker" <Thomas.Necker@domain.hid>
Date: Tue, 31 Oct 2006 08:12:47 +0100
Content-Type: text/plain; charset="us-ascii"
Subject: [Xenomai-help] Increasing UVMs heap size
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

I tried to increase the heap size for UVM. I did so by using
--enable-uvm-heapsz=512 when compiling the user space parts
and also setting CONFIG_XENO_OPT_SYS_HEAPSZ=512 in the
kernel configuration. Somehow it seems to work, at least I now can
create a lot more pSOS skin queues than before. However, if I do
a "cat /proc/xenomai/heap" I still get "size=131072:used=16:pagesz=512".
So, why can't I see the increased heap size here? Thanks.

Thomas

