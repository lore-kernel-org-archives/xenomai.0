Message-ID: <4FE88C80.9050002@xenomai.org>
Date: Mon, 25 Jun 2012 18:06:24 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAKKWdtczsEk=XA+7J5z-8N1AKMh223dr3tTkh2-prK1QPLb7SQ@mail.gmail.com>
In-Reply-To: <CAKKWdtczsEk=XA+7J5z-8N1AKMh223dr3tTkh2-prK1QPLb7SQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] memory size
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: ali hagigat <hagigatali@gmail.com>
Cc: xenomai@xenomai.org

On 06/25/2012 04:21 PM, ali hagigat wrote:
> My computer has 3G bytes RAM. I have disabled "high memory", PAE and
> 64-bit memory and I/O resources for the Xenomai kernel and the memory
> size is nearly 900M (Why the memory size became smaller than 1G? By
> disabling those options the size should be still 3G!) :

This question is not related at all to Xenomai. You will find better
answers on other mailing lists than this one.

> 
> /root> cat /proc/meminfo
> MemTotal:         894660 kB
> MemFree:           56472 kB
> Buffers:          110264 kB
> Cached:           329584 kB
> SwapCached:        47844 kB
> Active:           327936 kB
> Inactive:         417484 kB
> Active(anon):     142080 kB
> Inactive(anon):   166236 kB
> Active(file):     185856 kB
> Inactive(file):   251248 kB
> Unevictable:           0 kB
> Mlocked:               0 kB
> SwapTotal:       5144572 kB
> SwapFree:        5014556 kB
> 
> I did it according to an Intel white paper for Xenomai. Why is it
> necessary? The total memory is below 1G bytes now. Does it make the
> scheduling latency higher in general? (Because I think bigger size of
> the memory makes the latencies smaller. Is that right?)

It is not necessary. And since we did not write the intel white paper,
we have no idea why this paper gives this advice.

> 
> 
> Regards
> 
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
> 


-- 
					    Gilles.

