From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17957.2778.801915.659858@domain.hid>
Date: Tue, 17 Apr 2007 19:58:50 +0200
In-Reply-To: <17957.2183.25570.823923@domain.hid>
References: <899865CA54E4444DAF2E3639C04C5F4805EC70@domain.hid>
	<17957.2183.25570.823923@domain.hid>
Subject: Re: [Xenomai-core] [Adeos-main] [PATCH] Adeos support for IXP4xx
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Richard Cochran <richard.cochran@domain.hid>, adeos-main@gna.org, xenomai@xenomai.org

Gilles Chanteperdrix wrote:
 > 		*IXP4XX_OSRT1 = LATCH | ONE_SHOT_ENABLE;

In fact, should not this be:

                *IXP4XX_OSRT1 = 
                  (last_jiffy_time + LATCH - *IXP4XX_OSTS) | ONE_SHOT_ENABLE;
?


-- 


					    Gilles Chanteperdrix.

