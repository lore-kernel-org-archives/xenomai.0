From: Philippe Gerum <philippe.gerum@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15805.29685.210293.7530@domain.hid>
Date: Mon, 28 Oct 2002 18:29:25 +0100
Subject: [Adeos-main] Patch 2.4.19-r6c1 (modular)
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <http://mail.nongnu.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: <adeos-main.nongnu.org>
List-Unsubscribe: <http://mail.nongnu.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <http://mail.nongnu.org/pipermail/adeos-main/>
To: adeos-main@gna.org

The first revision of a modularized Adeos nanokernel (x86) is
available in the CVS as a candidate patch (r6c1) against 2.4.19.
Starting from this version, the interrupt pipelining can be
enabled/disabled dynamically upon (internal) request.

A minimalistic Adeos core component remains statically bound to the
Linux kernel to provide the necessary hooks, while most of the
pipelining logic is now in a driver (see linux/drivers/adeos). As
previously indicated, fully static (in-kernel) inclusion remains
available using the proper kernel configuration option.

Just "insmod/rmmod adeos" to load/unload the nanokernel from a patched
Linux kernel which has been configured with a modular Adeos support.

Regards,

Philippe.


