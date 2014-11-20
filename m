From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Thu, 20 Nov 2014 17:38:17 -0500
Message-ID: <20141120223817.GO24110@csclub.uwaterloo.ca>
References: <20141118192846.GE3177@sisyphus.hd.free.fr>
 <20141118202833.GH3177@sisyphus.hd.free.fr>
 <20141118205303.GD24110@csclub.uwaterloo.ca>
 <20141118205624.GK3177@sisyphus.hd.free.fr>
 <20141118211713.GL3177@sisyphus.hd.free.fr>
 <20141118213931.GE24110@csclub.uwaterloo.ca>
 <20141119171204.GI24110@csclub.uwaterloo.ca>
 <20141119223848.GF7011@sisyphus.hd.free.fr>
 <20141120200133.GN24110@csclub.uwaterloo.ca>
 <20141120200639.GF4545@sisyphus.hd.free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141120200639.GF4545@sisyphus.hd.free.fr>
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

On Thu, Nov 20, 2014 at 09:06:39PM +0100, Gilles Chanteperdrix wrote:
> Then we have a problem, because once the irq has been enabled for
> Xenomai, it is almost certainly wrong for a power management call to
> change its register. So, probably power management should be
> disabled like on x86.

Perhaps, but TI's code doesn't compile if you turn it off at the moment.

> Yes that I what I meant, getting back the pointer to the structure
> needed by the hwmod layer is going to be hard, since this pointer is
> well hidden under the carpet.
> 
> Anyway, if anyone wants a better solution, he will implement it, I
> will merge your patch in the current version of the I-pipe patch
> (3.16.0).

I was even thinking of sending it upstream for suggestions.  Others using
linux might want fast interrupts too.  But certainly useful for ipipe
users so far.

-- 
Len Sorensen

