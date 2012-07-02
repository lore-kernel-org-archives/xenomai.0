Message-ID: <4FF1497F.8080909@logilin.fr>
Date: Mon, 02 Jul 2012 09:10:54 +0159
From: Christophe Blaess <mailist@logilin.fr>
MIME-Version: 1.0
References: <CAKKWdte1Yg5fEUN=jqVgyTkRTHwY62WrMdw99ZgqOZZdAnAm+w@mail.gmail.com>	<4FEED882.9070307@xenomai.org>	<4FEF2EB1.3050600@logilin.fr>
	<4FEF31AC.2000403@xenomai.org> <4FF09E30.5050400@logilin.fr>
	<4FF0A625.7070408@xenomai.org> <4FF13B93.1040302@logilin.fr>
In-Reply-To: <4FF13B93.1040302@logilin.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] question: XENO_OPT_TIMING_SCHEDLAT
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On 02/07/2012 08:12, Christophe Blaess wrote:
>
> But, there's still something weird (I run on a stock xenomai 2.6.0 
> with adeos-ipipe-2.6.38.8-arm-1.18-04.patch, I'll try on a 2.6 git 
> kernel)
>
> [Panda]#*echo 2388 > /proc/xenomai/latency*
> [Panda]#*cat /proc/xenomai/latency*
> 2386
> [Panda]#*echo 2386 > /proc/xenomai/latency*
> [Panda]#*cat /proc/xenomai/latency*
> 2384
> [Panda]#*echo 2384 > /proc/xenomai/latency*
> [Panda]#*cat /proc/xenomai/latency*
> 2382
> [Panda]#
>
> I suspect something wrong in xnarch_tsc_to_ns()/xnarch_ns_to_tsc() 
> maybe in xnarch_llimd(). I'll investigate more this afternoon.
>
>

I see the same behaviour with xenomai 2.6 from git source, using 
adeos-ipipe-2.6.38.8-arm-1.18-08.patch



