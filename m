Message-ID: <5191360D.6070801@xenomai.org>
Date: Mon, 13 May 2013 20:50:53 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAD1Etoj5_mKnmQGvSXtdrasx7Fz8niYQCYhPAbaxiKSUg0GgcA@mail.gmail.com>
In-Reply-To: <CAD1Etoj5_mKnmQGvSXtdrasx7Fz8niYQCYhPAbaxiKSUg0GgcA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] timeline for 2.6.2.2?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Daniel M. Drucker, Ph.D." <dmd@interactive-motion.com>
Cc: xenomai@xenomai.org

On 05/13/2013 05:18 PM, Daniel M. Drucker, Ph.D. wrote:

> Is there a planned 2.6.2.2? Could there be?
> 
> There are a few fixes since 2.6.2.1 we want, and it would ease our release
> process a huge amount if we could use a released version instead of git
> head.


2.6.3 is the next release. A todo list has been published here:
http://www.xenomai.org/pipermail/xenomai/2013-April/028147.html
the remaining item on the list is to update the manual pages
Then there are also some changes to be made on the debian packaging,
which should not take long, see:
http://www.xenomai.org/pipermail/xenomai/2013-April/028176.html

There is this new bug, which needs fixing:
http://www.xenomai.org/pipermail/xenomai/2013-May/028487.html
when that is done, we can issue a new I-pipe patch, then this I-pipe
patch whill have to be re-tested on all the test platforms we have. We
will then ask Paul to regenerate the Raspberry pre and post patches, as
he asked here:
http://www.xenomai.org/pipermail/xenomai/2013-April/028283.html

In parallel, we have another bug which needs fixing:
http://www.xenomai.org/pipermail/xenomai/2013-May/028453.html

When this is all fixed, we can compile and test the debian packages on
x86 platforms, with some luck, the linuxCNC guys will want to test them
as well on their platforms.

And when all this is done, we can release 2.6.3.

Regards.

-- 
                                                                Gilles.

