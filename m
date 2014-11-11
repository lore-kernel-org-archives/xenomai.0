Date: Tue, 11 Nov 2014 18:46:52 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141111174652.GK17476@sisyphus.hd.free.fr>
References: <04e5e7e2fab241a5916e4e48f9d9b325@EX132MBOX1B.de2.local>
 <20141109155351.GH17476@sisyphus.hd.free.fr>
 <28083d9b9cc34fce9a6d308e8d12fbc6@EX132MBOX1B.de2.local>
 <20141110124308.GK17476@sisyphus.hd.free.fr>
 <b258eccb6b124aaf91fd1b35c9ccbf30@EX132MBOX1B.de2.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b258eccb6b124aaf91fd1b35c9ccbf30@EX132MBOX1B.de2.local>
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

On Tue, Nov 11, 2014 at 05:33:55PM +0000, Stoidner, Christoph wrote:
> 
> Hi Gilles,
> 
> > Also, for the "scheduling while atomic", it may happen if you call
> > some Linux service which reschedules from primary mode, you can try
> > enabling I-pipe debugging, and in fact all Xenomai debugging, to try
> > and catch such mistakes. This is especially important if you are
> > running a custom skin.
> 
> you are completely right, we have implemented our own skin. Using
> the debugging functionality mentioned above we have identified a
> function-call that leads to exact the behaviour as described in your post.
> 
> Hopefully solving that issue solves our application crash.
> 
> Thanks for your fast and helpful support!

You are welcome. As a side note, if you have followed the
discussion, CONFIG_TRACE_IRQFLAGS is broken on ARM, Jan hopes to be
able to fix it, but for the time being, you should  disable it, or
you risk to create other issues.

-- 
					    Gilles.

