From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18498.60991.572819.581076@domain.hid>
Date: Sun, 1 Jun 2008 20:45:19 +0200
Subject: [Xenomai-core] enum rtdm_selecttype
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org


Hi Jan,

when compiling xenomai v2.4.x for ARM with gcc 4.2.1, I get plenty of
warnings like:
xenomai-arm/kernel/xenomai/skins/posix/syscall.c:38:
xenomai-arm/include/xenomai/rtdm/rtdm_driver.h:206: warning: parameter has incomplete type

So it seems gcc 4.2.1 does not like the enum being used in function
prototypes without being defines. So, could we move the enum definition
before the functions using it ?

-- 


					    Gilles.

