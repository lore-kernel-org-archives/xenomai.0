From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15826.39948.417701.712466@domain.hid>
Date: Wed, 13 Nov 2002 19:38:04 +0100
Subject: [Adeos-main] Adeos snapshot 20021113
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

A new snapshot (adeos-20021113) is available from our download area
(http://savannah.nongnu.org/download/adeos/snapshots/adeos-20021113.tar.gz/).

It includes the recently modularized layout (Adeos core base + driver)
and the new "mutex" feature (available as a compile-time support
option).

Adeos mutexes allow multiple domains running on different priority
levels to enter a common critical section safely, while still enabling
interrupt delivery for higher priority domains. This should be of some
use when implementing concurrent o/s domains over Adeos.

Regards,

Philippe.


