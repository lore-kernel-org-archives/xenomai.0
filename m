Date: Tue, 15 Dec 2015 14:59:34 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151215135934.GA30622@hermes.click-hack.org>
References: <2396B4D2166B62479FBBE370D4A7C1F30A716140@mb2010-1.intra.tut.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2396B4D2166B62479FBBE370D4A7C1F30A716140@mb2010-1.intra.tut.fi>
Subject: Re: [Xenomai] Switching to secondary mode despite of use of mmap
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Umair Ali <ali.umair@tut.fi>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Tue, Dec 15, 2015 at 11:28:02AM +0000, Umair Ali wrote:
> Hello,
> 
> I am reading a file of size 600 MB using the mmap function and
> mlockall(). My question is that is it possible that mmap has not
> loaded whole file in the memory and if the whole file is not
> loaded then is it changing to secondary mode while reading the
> file.

Unless you have not passed MCL_CURRENT | MCL_FUTURE to mlockall or
did not check mlockall return value and mlockall in fact failed, this
is impossible.

>The size of system heap is 256KB in the menuconfig for the
> compiling kernel.

The size of the system heap has nothing to do with mlockall.

> If the problem, i think, i have is true then how
> i can load the such big files using mmap. The output of slackspot
> is attached with this email. My system specs are Memory 3.1GiB and
> processor is intel P4 3.2GHz x 2.

The slackspot trace you show only contains calls to timerfd_create
and socket. Yes, timerfd_create and socket cause a switch to
secondary mode.

-- 
					    Gilles.
https://click-hack.org

