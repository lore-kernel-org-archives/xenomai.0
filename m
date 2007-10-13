MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18192.65086.370530.147036@domain.hid>
Date: Sat, 13 Oct 2007 19:19:58 +0200
In-Reply-To: <4710E252.8050405@domain.hid>
References: <4710E252.8050405@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] [minor BUG] ARM: __check_kvm_seq undefined
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
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
 > Hi Gilles,
 > 
 > building the nucleus (SVN head) as a module for ARM (2.6.20.20,
 > ipipe-1.7-06) fails due to undefined __check_kvm_seq. Not sure is anyone
 > will choose such a setup on embedded systems, but who knows... Is this
 > symbol actually required or just accidentally included?

It seems this symbol is used by switch_mm, so, we should export it in
the I-pipe patch.

-- 


					    Gilles Chanteperdrix.

