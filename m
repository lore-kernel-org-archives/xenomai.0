Date: Thu, 14 May 2015 18:28:31 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150514162831.GH3759@hermes.click-hack.org>
References: <20150513203301.GC6169@csclub.uwaterloo.ca>
 <20150513203743.GG3759@hermes.click-hack.org>
 <20150513203833.GD6169@csclub.uwaterloo.ca>
 <20150514162351.GE6169@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150514162351.GE6169@csclub.uwaterloo.ca>
Subject: Re: [Xenomai] 3.14 hangs with ipipe patch applied
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: xenomai@xenomai.org

On Thu, May 14, 2015 at 12:23:51PM -0400, Lennart Sorensen wrote:
> On Wed, May 13, 2015 at 04:38:33PM -0400, Lennart Sorensen wrote:
> > On Wed, May 13, 2015 at 10:37:43PM +0200, Gilles Chanteperdrix wrote:
> > > On Wed, May 13, 2015 at 04:33:01PM -0400, Lennart Sorensen wrote:
> > > > Any suggestion for what part of the code to look at to explain what
> > > > could be happening right after the timer is enabled?
> > > 
> > > Sorry, nothing more to suggest than what is already in the porting guide.
> > 
> > I am trying to check that the 3.12 and 3.14 configs don't have some
> > stupid difference I missed.
> 
> OK it is getting stuck here:
> 
> static bool hvc_dcc_check(void)
> {
>         unsigned long time = jiffies + (HZ / 10);
> 
>         /* Write a test character to check if it is handled */
>         __dcc_putchar('\n');
> 
> // it gets here
>         while (time_is_after_jiffies(time)) {
>                 if (!(__dcc_getstatus() & DCC_STATUS_TX))
>                         return true;
>         }
> // it never gets here
> 
>         return false;
> }
> 
> Any idea how the ipipe patch (even with CONFIG_IPIPE=n) causes that look
> to get stuck forever?

The DCC should not be used with SMP for the obvious reason shown by
this code. I observed bugs on Zynq without the I-pipe patch.

Now the second obvious thing is that if time_is_after_jiffies() does
not make progress, it is because the timer does not tick. Once
again, how to debug this is explained in the troubleshooting section
of the porting guide.

-- 
					    Gilles.

