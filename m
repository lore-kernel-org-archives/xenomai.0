From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Wed, 2 Apr 2014 10:38:09 -0400
Message-ID: <20140402143809.GJ17765@csclub.uwaterloo.ca>
References: <533B270F.4060702@xenomai.org>
 <20140401214539.GD17765@csclub.uwaterloo.ca>
 <20140402023531.GE17765@csclub.uwaterloo.ca>
 <533BB83F.5040301@xenomai.org>
 <20140402132401.GF17765@csclub.uwaterloo.ca>
 <533C100A.7050501@xenomai.org>
 <20140402134017.GG17765@csclub.uwaterloo.ca>
 <20140402134133.GH17765@csclub.uwaterloo.ca>
 <20140402134609.GI17765@csclub.uwaterloo.ca>
 <533C1709.3090305@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <533C1709.3090305@xenomai.org>
Subject: Re: [Xenomai] Porting xenomai 2.6.3 and ipipe to 3.12 kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Wed, Apr 02, 2014 at 03:56:25PM +0200, Gilles Chanteperdrix wrote:
> On 04/02/2014 03:46 PM, Lennart Sorensen wrote:
> >On Wed, Apr 02, 2014 at 09:41:34AM -0400, Lennart Sorensen wrote:
> >>Here is the argv array it is getting:
> >>
> >>argv=[/usr/lib/xenomai/testsuite/xeno-test-run][/usr/bin/xeno-regression-test][xeno-regression-test][-l][/usr/lib/xenomai/testsuite/dohell -s 10.200.19.25 -m /mnt -l /mnt]
> >>
> >>No wonder it isn't working.
> >
> >Found it.  it can happen when the user isn't capable of operating cut and paste:
> >
> >root@omap5:/mnt/xenomai-2.6.3# xeno-regression-test xeno-regression-test -l "/usr/lib/xenomai/testsuite/dohell -s 10.200.19.25 -m /mnt -l /mnt" -t 2
> >
> >Lets try fixing that shall we...
> 
> PEBKAC then. Ok, -t 2 measures the irq latency, it may not be what you want.

I don't know what I want.  I just wanted to run something to check
xenomai is actually working.

It would appear it is.

So is there a time this test will run for or do I have to kill it at
some point?

-- 
Len Sorensen

