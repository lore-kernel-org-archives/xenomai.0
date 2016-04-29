Date: Fri, 29 Apr 2016 21:42:12 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160429194212.GP1881@hermes.click-hack.org>
References: <4318702e-51ea-f276-55b0-490fdc13fffd@isir.upmc.fr>
 <20160426142028.GD27058@hermes.click-hack.org>
 <4e3bc939-1942-1e78-9551-fffe95204fef@isir.upmc.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e3bc939-1942-1e78-9551-fffe95204fef@isir.upmc.fr>
Subject: Re: [Xenomai] Latency test shows weird results
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Florian Richer <richer@isir.upmc.fr>
Cc: Xenomai@xenomai.org

On Thu, Apr 28, 2016 at 05:03:59PM +0200, Florian Richer wrote:
> Hello,
> > This is very much likely the issue fixed by this patch:
> > https://git.xenomai.org/xenomai-3.git/commit/?h=stable-3.0.x&id=b4188f68e9ac7c9e9da25cf57d9756f0ccb78f4d
> >
> > You may want to try Xenomai 3.0.2 to see if you still have the
> > problem.
> Xenomai 3.0.2 does indeed correct the "offset" caused by the overrun.
> > Note that if it is the problem, the real problem is that you have
> > latencies close to 100us, which should not happen on such a
> > processor.
> My latencies were probably caused by CONFIG_COMPACTION, which is now 
> disabled; After a full day of latency testing my maximum latencies are 
> now fine, but the min was at around -1000000us (-1s), any idea where 
> that could come from ? (dmesg and .config attached if it helps)
> > To get useful traces with the I-pipe tracer, you should increase the
> > number of "back trace points".
> Thanks for your help !

Has the minimum drifted slowly over time, or is this an isolated
spot?

-- 
					    Gilles.
https://click-hack.org

