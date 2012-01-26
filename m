Message-ID: <4F2173AB.80905@domain.hid>
Date: Thu, 26 Jan 2012 16:39:23 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4F202C11.70908@domain.hid>
	<4F202F4E.6000708@domain.hid>	<4F203237.2010102@domain.hid>
	<4F203353.8030302@domain.hid>	<4F2035B6.6090105@domain.hid>
	<4F203771.6070708@domain.hid>	<4F203F7F.70509@domain.hid>
	<4F204466.1040603@domain.hid> <4F212CC4.6060001@domain.hid>
	<4F2136E0.4010200@domain.hid> <4F214D7A.5020901@domain.hid>
	<4F2164D4.2050501@domain.hid>
In-Reply-To: <4F2164D4.2050501@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] Add sigdebug unit test
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 2012-01-26 15:36, Jan Kiszka wrote:
> Regarding testability of the second watchdog state: We could add a
> syscall to sigtest_module e.g which has the current rt_timer_spin
> semantics.

Do you think this makes sense? Or some other testing driver?
Then I would go that direction.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

