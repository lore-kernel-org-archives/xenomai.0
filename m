Date: Wed, 29 Oct 2008 16:19:54 +0100
From: Tom Schouten <tom@domain.hid>
Message-ID: <20081029151954.GB13565@domain.hid>
References: <20081029141527.GA13565@domain.hid> <490873B2.2020809@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <490873B2.2020809@domain.hid>
Subject: Re: [Xenomai-help] rt_sem_p() -> -ESRCH
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On Wed, Oct 29, 2008 at 03:31:14PM +0100, Philippe Gerum wrote:
> Tom Schouten wrote:
> > Hello list,
> > 
> > What's the meaning of rt_sem_p() returning -ESRCH (No such process) ?
> > This return value doesn't seem to be in the list of documented values..
> > 
> > This appeared after upgrading to current SVN trunk.
> >
> 
> There is likely a mismatch between your userland support and the kernel bits.
> The ABI changed once more in the trunk recently, did you rebuild the userland
> Xenomai libs to match the new one?
>

Yes, they are both at the same version.  (btw current svn revision 4288 has 
a missing header file in the test suite: outofline.h)

I'll see if I can make a simple example to reproduce the failure.

