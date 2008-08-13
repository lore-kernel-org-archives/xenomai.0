Message-ID: <48A34929.9090204@domain.hid>
Date: Wed, 13 Aug 2008 22:50:49 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <0B45E93C5FF65740AEAE690BF3848B7AD38352@domain.hid>
	<48A3139B.8020506@domain.hid>
In-Reply-To: <48A3139B.8020506@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] Fix stat overruns on 64-bit
 (was:	[Xenomai-help] Kernel panic: not syncing)
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Fillod Stephane wrote:
>> Jan Kiszka wrote:
>>> /proc/xenomai/stat output is strange. Probably some type cast error, 
>>> because 18446744071739514846 = 0xFFFFFFFF8A939FDE and the appropriate 
>>> value perhaps should be 0x000000008A939FDE = 2324930526.
>> [...]
>>
>> Reminds me that other pending patch for /proc/xenomai/faults:
>> https://mail.gna.org/public/xenomai-core/2007-12/msg00064.html
> 
> december 2007? Oh dear! You should remind us more often when we
> forg^H^H^H^H take so much time to include your patches.
> 

Well, technically, this patch was not forgotten, but was, mmff... "swapped out".
Fact is that my swapper-in sometimes gets swapped out as well. Working on it.

-- 
Philippe.

