Resent-Message-ID: <17672.2610.144170.797310@domain.hid>
Resent-To: xenomai@xenomai.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17672.2276.571408.549554@domain.hid>
In-Reply-To: <4507F838.3040604@domain.hid>
References: <4507F838.3040604@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] switchtest on systems without FPU 
Date: Wed, 13 Sep 2006 15:34:28 +0200
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>

Wolfgang Grandegger wrote:
 > Hello,
 > 
 > I tried to run "switchtest -n" on a AMCC 440GX, which does not have an 
 > FPU and get an "illegal instruction" in "sleeper". It seems to call FPU 
 > instruction even with option "-n".
 > 
 > Thanks.

This should be fixed by commit 1603. Thanks for reporting.

-- 


					    Gilles Chanteperdrix.

