From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17227.51979.437655.440790@domain.hid>
Date: Tue, 11 Oct 2005 16:24:11 +0200
Subject: Re: [Xenomai-core] rt_timer_ticks2ns
In-Reply-To: <BF7115CA.17CC%steve@domain.hid>
References: <BF7115CA.17CC%steve@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Steven Seeger <steve@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Steven Seeger wrote:
 > In periodic mode, rt_timer_ticks2ns should convert ticks to periodic
 > jiffies. However, it always seems to return 0.

Did you call rt_timer_start before rt_timer_tick2ns ?

-- 


					    Gilles Chanteperdrix.

