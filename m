MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18368.23256.85461.492726@domain.hid>
Date: Sat, 23 Feb 2008 18:41:44 +0100
In-Reply-To: <47C02113.7070005@domain.hid>
References: <47C020A9.3050704@domain.hid>
	<47C02113.7070005@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] [PATCH 2/4] Fix and optimize xnlock_put
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
Cc: Xenomai-core@domain.hid

Jan Kiszka wrote:
 > As the #ifdef forest was cut down, I once again looked at xnlock_put.
 > Why do you have this safety check for the owner also in production code?

Because only one broken xnlock_put could entail a chain reaction of
broken xnlock sections with code on multiple CPU violating critical
sections. With the test, we prevent the chain reaction. But I agree this
check should not be silent.

-- 


					    Gilles Chanteperdrix.

