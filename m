Message-ID: <50FDCD39.2000603@xenomai.org>
Date: Tue, 22 Jan 2013 00:20:25 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1358804184.96123.YahooMailNeo@web172102.mail.ir2.yahoo.com>
In-Reply-To: <1358804184.96123.YahooMailNeo@web172102.mail.ir2.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Building xenomai with latest buildroot snapshot.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: bifferos <bifferos@yahoo.co.uk>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 01/21/2013 10:36 PM, bifferos wrote:

> 
> 
> I was able to compile Xenomai under buildroot 2011.11 without too much trouble, however I'm now trying 
> 
> to do the same with the latest buildroot snapshot.  Unfortunately it seems buildroot no longer has an
> easy option to select a kernel compatible with Xenomai.  I looked in xenomai-2.6.1/ksrc/arch/x86/patches
> 
> and there are three of them
> 
> adeos-ipipe-2.6.37.6-x86-2.9-02.patch
> adeos-ipipe-2.6.38.8-x86-2.11-01.patch
> ipipe-core-3.2.21-x86-1.patch
> 
> 
> Can someone please explain what this ipipe-core thing is?


I am desperately looking for a mail from Philippe where he explained it,
but can not find it back. Maybe he can give some explanations.

> Are these interchangeable (they are similar

> sizes)? 


Yes.

> Do I have to stick to 2.6.37.6 kernel to stand any chance of getting this working?


The newer versions should work, though I would recommend to wait for the
next release which should happen in the next few days.

Also note that I guess you are using Xenomai on the bifferboard, since I
also guess the processor on this board does not have a tsc, it will be
emulated using the PIT, which is slow, so, unless you can provide
another hardware timer with a lower latency, which will work starting
with the I-pipe core for Linux 3.4, you should turn off
CONFIG_XENO_OPT_STATS to improve latencies.

-- 
                                                                Gilles.

