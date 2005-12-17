From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17316.16329.895671.929282@domain.hid>
Date: Sat, 17 Dec 2005 17:41:45 +0100
Subject: Re: [Xenomai-core] [PATCH] debug_maxlat as module_param
In-Reply-To: <43A436A1.5070509@domain.hid>
References: <43A436A1.5070509@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
 > Hi,
 > 
 > this tiny patch exports the NMI watchdog's threshold as module parameter
 > "debug_maxlat" of xeno_hal. This means that one can either override the
 > value via a kernel parameter or in sysfs/modules/xeno_hal/parameters
 > (before activating the hal).

rthal_maxlat_tsc should be updated when rthal_maxlat_us_arg changes.

-- 


					    Gilles Chanteperdrix.

