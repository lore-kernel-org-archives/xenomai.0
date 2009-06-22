From: Sebastian Smolorz <smolorz@domain.hid>
Date: Mon, 22 Jun 2009 12:45:04 +0200
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200906221245.04890.smolorz@domain.hid>
Subject: [Xenomai-core] [BUG] [xenomai-head] xeno_posix.ko cannot be built
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hi Philippe,

with latest head it is not possible to build the POSIX skin as module. It 
gives:

ERROR: "xnarch_divrem_billion" [kernel/xenomai/skins/posix/xeno_posix.ko] 
undefined!

Obviously an

EXPORT_SYMBOL(xnarch_divrem_billion);

is missing.

-- 
Sebastian


