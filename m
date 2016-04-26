Date: Tue, 26 Apr 2016 16:20:28 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160426142028.GD27058@hermes.click-hack.org>
References: <4318702e-51ea-f276-55b0-490fdc13fffd@isir.upmc.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4318702e-51ea-f276-55b0-490fdc13fffd@isir.upmc.fr>
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

On Tue, Apr 26, 2016 at 04:08:47PM +0200, Florian Richer wrote:
> Hello,
> 
> I'm using Xenomai 2.6.4 over Lubuntu 12.04 w/ 3.14.17 kernel on a 
> pentium M 1300.
> Most of the time the latency test runs fine (min around 0 and max around 
> 25us), but sometimes this happens :
> 
> ...
> RTD|      4.335|      4.625|     17.371|       0|     0| 2.562|     21.872
> RTD|      4.337|      4.623|     14.882|       0|     0| 2.562|     21.872
> RTD|    -91.983|     71.921|     89.862|   33040|     0| -91.983|     89.862
> RTD|     81.154|     81.440|     90.628|   33040|     0| -91.983|     90.628
> RTD|     81.165|     81.442|     91.584|   33040|     0| -91.983|     91.584
> ...

This is very much likely the issue fixed by this patch:
https://git.xenomai.org/xenomai-3.git/commit/?h=stable-3.0.x&id=b4188f68e9ac7c9e9da25cf57d9756f0ccb78f4d

You may want to try Xenomai 3.0.2 to see if you still have the
problem.

Note that if it is the problem, the real problem is that you have
latencies close to 100us, which should not happen on such a
processor.

To get useful traces with the I-pipe tracer, you should increase the
number of "back trace points".

-- 
					    Gilles.
https://click-hack.org

