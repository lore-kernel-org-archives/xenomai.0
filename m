Message-ID: <48AECCAD.7030405@domain.hid>
Date: Fri, 22 Aug 2008 16:26:53 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <48AEBA77.2040608@domain.hid> <48AEC742.4090902@domain.hid>
	<48AEC8DC.20406@domain.hid>
In-Reply-To: <48AEC8DC.20406@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] userspace: Make CONFIG_SMP default
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
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> Disabling SMP (on platforms where this isn't off by design already) is
>>> an optimization. In contrast, not enabling it by default is doomed to
>>> cause problems for users that run ./configure without looking into each
>>> and every switch - now that CONFIG_SMP is very important for all the
>>> fast locking stuff.
>> I would consider setting CONFIG_SMP by default on x86... because on some
>> other architectures like arm, it is not even yet a valid configuration.
> 
> But it is on PowerPC or IA64. Would it cause troubles for the
> non-SMP-ready archs? Then we can disable it on those selectively.

Are you sure that the lock prefix on an UP x86 or lsync on an UP powerpc
is hamrless ?

-- 
                                                 Gilles.

