From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Thu, 14 May 2015 12:23:51 -0400
Message-ID: <20150514162351.GE6169@csclub.uwaterloo.ca>
References: <20150513203301.GC6169@csclub.uwaterloo.ca>
 <20150513203743.GG3759@hermes.click-hack.org>
 <20150513203833.GD6169@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150513203833.GD6169@csclub.uwaterloo.ca>
Subject: Re: [Xenomai] 3.14 hangs with ipipe patch applied
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Wed, May 13, 2015 at 04:38:33PM -0400, Lennart Sorensen wrote:
> On Wed, May 13, 2015 at 10:37:43PM +0200, Gilles Chanteperdrix wrote:
> > On Wed, May 13, 2015 at 04:33:01PM -0400, Lennart Sorensen wrote:
> > > Any suggestion for what part of the code to look at to explain what
> > > could be happening right after the timer is enabled?
> > 
> > Sorry, nothing more to suggest than what is already in the porting guide.
> 
> I am trying to check that the 3.12 and 3.14 configs don't have some
> stupid difference I missed.

OK it is getting stuck here:

static bool hvc_dcc_check(void)
{
        unsigned long time = jiffies + (HZ / 10);

        /* Write a test character to check if it is handled */
        __dcc_putchar('\n');

// it gets here
        while (time_is_after_jiffies(time)) {
                if (!(__dcc_getstatus() & DCC_STATUS_TX))
                        return true;
        }
// it never gets here

        return false;
}

Any idea how the ipipe patch (even with CONFIG_IPIPE=n) causes that look
to get stuck forever?

-- 
Len Sorensen

