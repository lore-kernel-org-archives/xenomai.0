From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Thu, 18 Sep 2014 12:49:00 -0400
Message-ID: <20140918164900.GP17690@csclub.uwaterloo.ca>
References: <B89CCBE86D4F62448EE4F6367C6D3C891DACCB0F@USMLVA0EM24MSX.ww017.siemens.net>
 <53E14B37.2040202@xenomai.org>
 <1410537098.19920.YahooMailNeo@web142606.mail.bf1.yahoo.com>
 <B89CCBE86D4F62448EE4F6367C6D3C891DAD9615@USMLVA0EM24MSX.ww017.siemens.net>
 <B89CCBE86D4F62448EE4F6367C6D3C891DAD962F@USMLVA0EM24MSX.ww017.siemens.net>
 <54135D7D.30104@xenomai.org>
 <20140914024450.GK17690@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140914024450.GK17690@csclub.uwaterloo.ca>
Subject: Re: [Xenomai] Question regarding rt_sem_p
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Sat, Sep 13, 2014 at 10:44:50PM -0400, Lennart Sorensen wrote:
> Well 3.12 did pass the xenomai testsuite.
> 
> Unfortunately TI isn't quite done moving their patches to the 3.14
> branch yet, so we are still stuck at 3.12 (And the 3.8 branch was way
> too unstable to use for anything at all even before considering xenomai).
> Problem with new chips is that they aren't merged into the official
> kernel yet, so jumping to a new kernel version isn't trivial.
> 
> I will be checking if the 3.14 branch has enough to boot on Monday
> (A lot of stuff was merged in yesterday so it might be getting close now).

Still no bootable 3.14 kernel for the dra7xx.

So instead I backported the ipipe-3.14 branch to 3.12.27 and so far it
is running and I haven't seen any issues with it yet, so time to test
if that solves any of the issues we have seen.

And I updated xenomai to the latest xenomai-2.6 git tree while at it too.

Running the xeno-regression-test on it now, although it passed before
so who knows.

-- 
Len Sorensen

