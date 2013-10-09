Message-ID: <5255BDB8.5070701@xenomai.org>
Date: Wed, 09 Oct 2013 22:34:00 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20131009154629.56216CA3@centrum.cz>
In-Reply-To: <20131009154629.56216CA3@centrum.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Latency peaks without IPIPE_DEBUG_INTERNAL
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Petr Cervenka <grugh@centrum.cz>
Cc: Xenomai <xenomai@xenomai.org>

On 10/09/2013 03:46 PM, Petr Cervenka wrote:
> Hello everyone.
> I have very high latency peaks (~400us) with my configuration when IPIPE_DEBUG and IPIPE_DEBUG_INTERNAL are !NOT! switched on.
> Way to reproduce the issue is to run the latency test (tried with high priority):
> $ sudo /usr/xenomai/bin/latency -P 99
> and in another terminal to list xenomai statistics couple of times:
> $ cat /proc/xenomai/stat
> 
> versions:
> kernel 3.5.7
> xenomai 2.6.2.1 and 2.6.3
> tried on different (but similar) intel based hw (Core2Duo E7400, Xeon E3-1220,  i5-2500K)
> 
> Do you have any idea what could be wrong?

I would say /proc/xenomai/stat holds the nklock for too long.

-- 
                                                                Gilles.

