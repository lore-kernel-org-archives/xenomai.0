Message-ID: <435D45DC.3010304@domain.hid>
Date: Mon, 24 Oct 2005 22:36:44 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] problem and solution
	with	adeos-ipipe-2.6.13-ppc-1.0-03.patch
References: <1CFEB358338412458B21FAA0D78FE86D4F0E3F@rennsmail02.eu.thmulti.com>
	<20051024175649.GR15211@domain.hid>
In-Reply-To: <20051024175649.GR15211@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Aristeu Sergio Rozanski Filho <aris@domain.hid>
Cc: xenomai@xenomai.org

Aristeu Sergio Rozanski Filho wrote:
>>Hi,
>>
>>The adeos-ipipe-2.6.13-ppc-1.0-03.patch file in Xenomai-2.0 dist appears
>>to be broken. The unified diff format is wrong on
>>include/asm-ppc/ipipe.h,
>>which breaks include/asm-ppc/mmu_context.h. I've found the problem while
>>
>>applying the patch on a Linux 2.6.13 kernel.
>>Line 1664 (no pun :), instead of @@ -0,1 +1,178 @@, the following solves
>>the problem here: @@ -0,0 +1,177 @@
>>
>>Does somebody else encountered the problem?
> 
> I did.
> maybe it's a good reason for 2.01?
> 

Maybe as we need to put perfectly buildable stuff on-line before making some 
noise as Jan's put it. Time for discovering other rough edges before 2.0.1 is 
rolled out, I guess.

-- 

Philippe.

