From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Thu, 21 May 2015 13:26:24 -0400
Message-ID: <20150521172624.GR6169@csclub.uwaterloo.ca>
References: <20150514193433.GG6169@csclub.uwaterloo.ca>
 <20150521163208.GL6169@csclub.uwaterloo.ca>
 <20150521163440.GM10686@hermes.click-hack.org>
 <20150521165913.GM6169@csclub.uwaterloo.ca>
 <20150521170301.GN10686@hermes.click-hack.org>
 <20150521170432.GN6169@csclub.uwaterloo.ca>
 <20150521170716.GO6169@csclub.uwaterloo.ca>
 <20150521171018.GO10686@hermes.click-hack.org>
 <20150521171641.GQ6169@csclub.uwaterloo.ca>
 <20150521172058.GP10686@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150521172058.GP10686@hermes.click-hack.org>
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

On Thu, May 21, 2015 at 07:20:58PM +0200, Gilles Chanteperdrix wrote:
> Of course, you should keep the addition of ipipe_lock/unlock irq.
> which is the point of patching these functions.

Yes those I am not changing.

> If you are working with something more recent like 3.16 or 3.18,
> please post as a patch to these.

I am stuck at 3.14 since that's the current tree TI works with for
the am572x.

But I could generate a patch for the other ones, even if I can't test
it yet.

Should I send patches as a new thread?

-- 
Len Sorensen

