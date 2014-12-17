Date: Wed, 17 Dec 2014 11:59:15 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141217105915.GC7151@hermes.click-hack.org>
References: <5490C06F.4080901@nta-inc.net>
 <20141217102910.GA7151@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141217102910.GA7151@hermes.click-hack.org>
Subject: Re: [Xenomai] rtnet issue with xenomai-3.git next branch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jeff Webb <jeff.webb@nta-inc.net>
Cc: Xenomai <xenomai@xenomai.org>

On Wed, Dec 17, 2014 at 11:29:10AM +0100, Gilles Chanteperdrix wrote:
> On Tue, Dec 16, 2014 at 05:29:51PM -0600, Jeff Webb wrote:
> > I am testing the rtnet functionality in the 'next' branch of xenomai-3.git.  (I now also have Xenomai-2.6.4/rtnet.git running on the same machine for comparison.)  I am able to bring up the real-time interface (rt_e1000e) and use rtping as expected. As mentioned before, I have a primary non-rt ethernet interface running simultaneously (using the e1000e driver).   When I try to remove all the rtnet modules, I am unable to remove rtnet and rtipv4:
> > 
> > $ rmmod rtipv4 rtnet
> > rmmod: ERROR: Module rtipv4 is in use
> > rmmod: ERROR: Module rtnet is in use by: rtipv4
> > 
> > The messages are the same if I try to remove them individually.  This behavior does not occur with Xenomai-2.6.4/rtnet.git.
> 
> To avoid nasty side effects, every module which registers an
> interface (whether rtnet or linux interface) now requires the
> interface to be down before the module can be removed. The handling
> of rtnet module counts was significantly reworked when importing
> into 3.x, it is possible that some bug remains.

Also note that you need this commits in the I-pipe kernel for
3.14 for module count to work correctly from xenomai domain:

https://git.xenomai.org/ipipe-gch.git/commit/?h=for-ipipe-3.14.17&id=f009149cf8ca8f956194e4fd852b0d97b7c76886

-- 
					    Gilles.

