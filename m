From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Mon, 17 Nov 2014 15:43:31 -0500
Message-ID: <20141117204331.GV24110@csclub.uwaterloo.ca>
References: <20141001142416.GA4435@csclub.uwaterloo.ca>
 <20141107182600.GS24110@csclub.uwaterloo.ca>
 <545D12D2.2020104@xenomai.org>
 <20141117191237.GS24110@csclub.uwaterloo.ca>
 <20141117201435.GH31920@sisyphus.hd.free.fr>
 <20141117202425.GU24110@csclub.uwaterloo.ca>
 <20141117203017.GJ31920@sisyphus.hd.free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141117203017.GJ31920@sisyphus.hd.free.fr>
Subject: Re: [Xenomai] I-pipe error when requesting irq that is on omap gpio
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Mon, Nov 17, 2014 at 09:30:17PM +0100, Gilles Chanteperdrix wrote:
> Also note that I was kind of waiting for confirmation that it did
> actually work, which so far has not happened.

Well your syscall.c changes got rid of the warning when registering the
irq, and it did make the interrupt response time we see a lot better
(although still not what we were hoping for).

So so far I intend to use your patch.  It seems to definitely be much
better.

-- 
Len Sorensen

