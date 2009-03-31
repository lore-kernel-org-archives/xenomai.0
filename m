Message-ID: <49D1EA0B.2020300@domain.hid>
Date: Tue, 31 Mar 2009 12:01:47 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <17B3FD74-07D0-4F36-9836-8E03943DF917@domain.hid>
In-Reply-To: <17B3FD74-07D0-4F36-9836-8E03943DF917@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] geode gx1 latencies
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Steven Seeger <steven.seeger@domain.hid>
Cc: xenomai@xenomai.org

Steven Seeger wrote:
> Per Gilles's suggestion, Mark at Stellartech ran latency and klatency  
> with the TSC enabled "the hack" and without the TSC enabled. He also  
> posted the CPU task measurements with our app running without the  
> hack, which is horrible compared to when the TSC is on.
> 
> It looks like we are better off with the TSC. The worst case is much  
> better, anyway.

I do not understand these results. In the "nohack" case, is
CONFIG_X86_TSC enabled ? In this case, you should not observe any
difference.

-- 
                                                 Gilles.

