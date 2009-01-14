Message-ID: <496DEB16.5060803@domain.hid>
Date: Wed, 14 Jan 2009 13:39:34 +0000
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Clock drift.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai core <Xenomai-core@domain.hid>


Hi,

I run clocktest on a system here, not running NTP, using
CONFIG_GENERIC_CLOCKEVENT, with a systematic drift of 3us/s. How can
this happen? Does it come from the error due to the multiply and shift
used for tsc to/from ns conversions ?

TIA,

-- 
                                                 Gilles.

