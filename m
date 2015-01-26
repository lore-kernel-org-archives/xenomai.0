Date: Mon, 26 Jan 2015 13:08:24 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150126120824.GF12812@hermes.click-hack.org>
References: <129277905.Ag2XebZWbK@soho>
 <2B26277C-0A61-4059-8776-994BFC297530@alaxarxa.net>
 <54C53188.4020108@xenomai.org> <8367559.zdLagntR1r@indiana>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8367559.zdLagntR1r@indiana>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Packaging Xenomai-3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
Cc: xenomai@xenomai.org

On Sun, Jan 25, 2015 at 07:43:21PM +0100, Leopold Palomo-Avellaneda wrote:
> El Diumenge, 25 de gener de 2015, a les 19:10:16, Philippe Gerum va escriure:
> > On 01/25/2015 12:14 PM, Leopold Palomo-Avellaneda wrote:
> > > But I was thinking in performance aspects comparing a system with cobalt
> > > vs a system with mercury.
> > 
> > Yes, but the results are now outdated (2011). This said, such benchmark
> > hardly reflected a use case. It was more a Xenomai 2.6.x vs 3.x analysis
> > of basic mechanisms (event notification, serialization, buffer exchange
> > etc) for measuring the impact of moving most of the real-time API
> > implementation to user-space, only keeping the core resource management
> > in kernel space. It proved to be positive.
> > 
> > Mercury vs Cobalt was only a by-product of those tests, specifically on
> > x86_32.
> 
> After this thread, I think more firmly that the libs should be renamed in the 
> manner that they could be co-installed in the same root, standard places.
> 
> Please upstream, could you think about it?

This is a decision that upstream should not impose to all users.
Only users with your specific needs should do what you want. And
in fact, I believe simply using the configure script options, it is
possible to install libraries in different directories. Maybe even
the --program* options apply to libraries too.

-- 
					    Gilles.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 811 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20150126/471515b7/attachment.sig>
