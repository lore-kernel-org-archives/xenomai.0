Message-ID: <50144E93.5050109@xenomai.org>
Date: Sat, 28 Jul 2012 22:41:55 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <500FEB0F.9000308@xenomai.org>
	<201207282127.33575.paul_c@tuxcnc.org>
In-Reply-To: <201207282127.33575.paul_c@tuxcnc.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Heads up: I-pipe patch status on ARM
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Paul <paul_c@tuxcnc.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 07/28/2012 10:27 PM, Paul wrote:

> 
> Thanks for the timely update Gilles - Just finished work on an 
> (unsupported) ARM1176 SoC running at 700MHz and the documents came in 
> handy. Only a rough draft at the moment and some of the kernel options 
> need tuning, but as a starting point, it looks quite reasonable.
> 
> Running a 3.2.21 kernel and Xenomai-2.6.1, graphed the latency test over 
> a 60 minute run. 


It does not look that bad. However, "dohell 3600" does not do much. If
you want to improve the latencies, use "-p 100" instead of "-p 1000" ;-)

How do you get the fancy grid with gnuplot? We could add the option to
scripts/histo.gp. Note that I prefer to draw graphs with a log scale, I
find they are more meanningful, otherwise, you do not really see how the
graph ends.


> Look forward to testing a 3.4 series kernel to see if

> the results can be improved upon.


I am running some tests on omap3 and omap4, so far with not much
success. My next try will be to simply disable CONFIG_MULTI_IRQ_HANDLER
and the irq domains, to see if I can get the same latencies as 3.2

> 
> Regards, Paul.
> 
> 
> 
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: latency-t0.png
> Type: image/png
> Size: 5702 bytes
> Desc: not available
> URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20120728/b789c62a/attachment.png>
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: latency-t1.png
> Type: image/png
> Size: 5423 bytes
> Desc: not available
> URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20120728/b789c62a/attachment-0001.png>
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: latency-t2.png
> Type: image/png
> Size: 5224 bytes
> Desc: not available
> URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20120728/b789c62a/attachment-0002.png>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
> 



-- 
                                                                Gilles.

