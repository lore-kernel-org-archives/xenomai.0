Date: Tue, 21 Apr 2015 16:14:27 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150421141427.GU7109@hermes.click-hack.org>
References: <1429625014.4018.13.camel@rt10.zhou>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1429625014.4018.13.camel@rt10.zhou>
Subject: Re: [Xenomai] Is idle=poll the right way to decrease jitter ?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Zhoupeng <zhoupeng1982@qq.com>
Cc: xenomai <xenomai@xenomai.org>

On Tue, Apr 21, 2015 at 10:03:34PM +0800, Zhoupeng wrote:
> As conclusion in "POWERLINK and Realtime linux": the jitter was so high
> on an idle system and gets smaller if the CPU is heavily loaded.
> 
> This is probably due to power optimization when hlt is called, as
> discussed before.
> 
> "idle=poll" will waste more power, but jitter decrease from 30us to less
> than 10us in my test. Is this the right way ?

Are you sure the worst case latency is not more than 30us on a
loaded system? Usurally, the worst case latency is best approximated
on a loaded system than on an idle system.

-- 
					    Gilles.

