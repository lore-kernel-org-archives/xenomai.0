Date: Wed, 20 Jul 2016 19:29:12 +0200
From: Gilles Chanteperdrix <gilles@click-hack.org>
Message-ID: <20160720172911.GX6751@hermes.click-hack.org>
References: <7d0df99eb5c44c1fb444a3d5642001bc@lujp1svwi090222.corp.mooginc.com>
 <20160720141745.GW6751@hermes.click-hack.org>
 <loom.20160720T190837-320@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <loom.20160720T190837-320@post.gmane.org>
Subject: Re: [Xenomai] [RFC] [PATCH] Add C_CAN/D_CAN driver
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Andy Haydon <ahaydon@moog.com>
Cc: xenomai@xenomai.org

On Wed, Jul 20, 2016 at 05:23:14PM +0000, Andy Haydon wrote:
> Gilles Chanteperdrix <gilles <at> click-hack.org> writes:
> 
> > 
> > On Wed, Jul 20, 2016 at 02:10:27PM +0000, Haydon, Andrew wrote:
> > > Hi,
> > > 
> > > I have updated the C_CAN patch submitted by Stephen Battazzo:
> > > http://xenomai.org/pipermail/xenomai/2015-July/034690.html
> > > 
> > > This update is for Xenomai 3.0.x and also updates the driver to the one
> > > used in Linux v3.18.20. I've also backported a couple of bug fixes from
> > > later kernel versions. I haven't ported the PCI support because I have 
> no
> > > way of testing this.
> > > The RTDM port is largely the same as in Stephen's patch.
> > > 
> > > I'm not sure whether my use of "rtdm_task_busy_sleep" is correct. The
> > > Linux driver uses udelay here.
> > 
> > It is if not called in the middle of a section protected by a mutex,
> > spinlock or with irqs off. The fact that the hardware has large
> > latencies may be unavoidable, the fact that it causes the rest of
> > the system to experience high latencies is not acceptable however.
> > 
> 
> OK
> 
> > > 
> > > At the moment I have only done very limited testing on this driver in
> > > Xenomai, but it seems to work OK as far as I have tested it so far. I do
> > > know that the Linux driver works well for me using the D_CAN interface 
> on
> > > the Cyclone V.
> > 
> > Your patch is not indented correctly, as such it can not be
> > accepted, and it makes the review uselessly hard. So, please resend
> > a correctly indented patch.
> > 
> 
> Sorry - Outlook removed all the tabs
> Below is the patch with indentation:

I am afraid your MUA added line breaks, which makes the patch
unusable. Can not you use git send-email ?

-- 
					    Gilles.

