Message-ID: <45C89FEC.1090704@domain.hid>
Date: Tue, 06 Feb 2007 16:34:04 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] I-pipe patch for linux 2.6.19 on ARM.
References: <45BF08D8.5050208@domain.hid> <45BF17CE.9030808@domain.hid>
	<45C89F17.5040306@domain.hid>
In-Reply-To: <45C89F17.5040306@domain.hid>
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
>>>here comes the I-pipe patch for linux 2.6.19 on ARM. In addition to the
>>>upgrade to linux 2.6.19, the AT91 port is improved:
> 
> 
> Using vanilla 2.6.19, your new patch and xenomai from SVN as of yesterday
> the test programm "latency" hangs randomly after a while ...
> 
> Did you test with "latency"?

Yes, latency hangs if the period is too small. latency -p 1000 runs fine.

-- 
                                                 Gilles Chanteperdrix

