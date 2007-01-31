Message-ID: <45C05207.1090105@domain.hid>
Date: Wed, 31 Jan 2007 09:23:35 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] I-pipe patch for linux 2.6.19 on ARM.
References: <45BF08D8.5050208@domain.hid> <45BF8A92.8010900@domain.hid>
In-Reply-To: <45BF8A92.8010900@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
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
To: Steven Scholz <steven.scholz@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Steven Scholz wrote:
> Gilles,
> 
> 
>>here comes the I-pipe patch for linux 2.6.19 on ARM. In addition to the
>>upgrade to linux 2.6.19, the AT91 port is improved:
> 
> 
> Thanks very much.
> 
> 
>>I have not tested the other ports, so, please test the patch on the ARM
>>you use if you can.
> 
> 
> Did you actually try this patch against a vanilla 2.6.19 + 2.6.19-at91.patch.gz?

No, the patch is intended to be used with a vanilla 2.6.19, this make
the I-pipe patch for ARM much easier to maintain.

> c) Kernel with adoes-ipipe compiles (after fixing the above), but xenomai
> does not compile and bails out with

You must get recent xenomai sources from svn trunk or v2.3.x branch.

-- 
                                                 Gilles Chanteperdrix

