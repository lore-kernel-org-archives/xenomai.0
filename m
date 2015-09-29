Date: Tue, 29 Sep 2015 07:44:27 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150929054426.GD15767@hermes.click-hack.org>
References: <5490C06F.4080901@nta-inc.net>
 <20141217102910.GA7151@hermes.click-hack.org>
 <20141217105915.GC7151@hermes.click-hack.org>
 <54934E5E.2090203@nta-inc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54934E5E.2090203@nta-inc.net>
Subject: Re: [Xenomai] rtnet issue with xenomai-3.git next branch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jeff Webb <jeff.webb@nta-inc.net>
Cc: Xenomai <xenomai@xenomai.org>

On Thu, Dec 18, 2014 at 03:59:58PM -0600, Jeff Webb wrote:
> On 12/17/2014 04:59 AM, Gilles Chanteperdrix wrote:
> > On Wed, Dec 17, 2014 at 11:29:10AM +0100, Gilles Chanteperdrix wrote:
> >> On Tue, Dec 16, 2014 at 05:29:51PM -0600, Jeff Webb wrote:
> >>> I am testing the rtnet functionality in the 'next' branch of xenomai-3.git.  (I now also have Xenomai-2.6.4/rtnet.git running on the same machine for comparison.)  I am able to bring up the real-time interface (rt_e1000e) and use rtping as expected. As mentioned before, I have a primary non-rt ethernet interface running simultaneously (using the e1000e driver).   When I try to remove all the rtnet modules, I am unable to remove rtnet and rtipv4:
> >>>
> >>> $ rmmod rtipv4 rtnet
> >>> rmmod: ERROR: Module rtipv4 is in use
> >>> rmmod: ERROR: Module rtnet is in use by: rtipv4
> >>>
> >>> The messages are the same if I try to remove them individually.  This behavior does not occur with Xenomai-2.6.4/rtnet.git.
> >>
> >> To avoid nasty side effects, every module which registers an
> >> interface (whether rtnet or linux interface) now requires the
> >> interface to be down before the module can be removed. The handling
> >> of rtnet module counts was significantly reworked when importing
> >> into 3.x, it is possible that some bug remains.
> >
> > Also note that you need this commits in the I-pipe kernel for
> > 3.14 for module count to work correctly from xenomai domain:
> >
> > https://git.xenomai.org/ipipe-gch.git/commit/?h=for-ipipe-3.14.17&id=f009149cf8ca8f956194e4fd852b0d97b7c76886
> >
> 
> For what its worth, I rebuilt everything using your "for-ipipe-3.14.17" branch that has that commit.  That branch has the same issue, and I think your assessment of the problem is correct.  For instance, this works:
> 
> ifconfig eth0 down
> ifconfig eth1 down
> rmmod e1000e
> modprobe rtnet
> modprobe rtipv4
> modprobe rt_e1000e
> rtifconfig rteth1 up 172.18.14.209
> rtifconfig
> rtifconfig rteth1 down
> rmmod rt_e1000e
> rmmod rtipv4
> 
> But, if I actually use the interface, I can no longer remove the rtipv4 module:
> 
> modprobe rtipv4
> modprobe rt_e1000e
> rtifconfig rteth1 up 172.18.14.209
> rtifconfig
> rtroute solicit 172.18.14.210 dev rteth1
> rtroute
> rtifconfig rteth1 down
> rmmod rt_e1000e
> rmmod rtipv4

Hi Jeff,

sorry for the long delay. This issue should be fixed in the
"for-forge" branch in xenomai-gch.git repository.

Regards.

-- 
					    Gilles.
https://click-hack.org

