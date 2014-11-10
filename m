Date: Mon, 10 Nov 2014 13:44:09 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141110124409.GL17476@sisyphus.hd.free.fr>
References: <04e5e7e2fab241a5916e4e48f9d9b325@EX132MBOX1B.de2.local>
 <20141109155351.GH17476@sisyphus.hd.free.fr>
 <28083d9b9cc34fce9a6d308e8d12fbc6@EX132MBOX1B.de2.local>
 <c9fed148f1f54c4aaa2aaa5d7b107f24@EX132MBOX1B.de2.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9fed148f1f54c4aaa2aaa5d7b107f24@EX132MBOX1B.de2.local>
Subject: Re: [Xenomai] "inconsistent lock state" on boot-up
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Stoidner, Christoph" <c.stoidner@arvero.de>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Mon, Nov 10, 2014 at 12:33:40PM +0000, Stoidner, Christoph wrote:
> 
> Hi again,
> 
> now I have disabled CONFIG_XENOMAI but still enabled CONFIG_IPIPE. The error messages on boot-up is still given.
> 
> Since no one else has reported that problem I assume it happens only on a specific architecture (for me: i.MX28 => ARMv5). Is there something ARMv5 architecture specific in ipipe's locking mechanism?

This error message probably happens to anyone enabling lockdep with
I-pipe on ARM. You are not the first to report it.

-- 
					    Gilles.

