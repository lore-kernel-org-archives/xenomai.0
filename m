Date: Thu, 31 Mar 2016 18:22:35 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160331162235.GD4744@hermes.click-hack.org>
References: <47132d04b76942d8bd15c82a5a460f7b@EDB3.wapice.localdomain>
 <20160331104409.GC4744@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160331104409.GC4744@hermes.click-hack.org>
Subject: Re: [Xenomai] A fix to few generic issues in rttcp stack
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Matti Suominen <matti.suominen@wapice.com>
Cc: Lassi =?iso-8859-1?Q?Niemist=F6?= <lassi.niemisto@wapice.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On Thu, Mar 31, 2016 at 12:44:09PM +0200, Gilles Chanteperdrix wrote:
> TCP is disabled in Xenomai 3 rtnet. The main problem is that
> creating a socket in Xenomai 3 requires switching to secondary mode,
> so the "accept" service seems hard to implement without leaving
> primary mode. Given the fact that TCP can not be a deterministic
> protocol, I planned to drop TCP support in the next RTnet iteration.
> If you require to send messages over TCP from a thread running in
> primary mode, you should rather pass the message using an XDDP
> socket to a thread running in secondary mode and using plain linux
> TCP sockets. You will not get more determinism with TCP in RTnet.

The question I guess, is, why do you need rttcp ? If you really need
it, then we will have to find a solution for the "accept" problem.
Keeping a pool of sockets ready for instance.

-- 
					    Gilles.
https://click-hack.org

