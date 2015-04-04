From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Sat, 4 Apr 2015 10:14:26 -0400
Message-ID: <20150404141426.GY29558@csclub.uwaterloo.ca>
References: <CAJqUr7yKoXNCpEZ0_oo=U9koMyido2G1kxF5HPupvrvBkadjtQ@mail.gmail.com>
 <20150404135615.GC18543@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150404135615.GC18543@hermes.click-hack.org>
Subject: Re: [Xenomai] tsc on armv8
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

On Sat, Apr 04, 2015 at 03:56:15PM +0200, Gilles Chanteperdrix wrote:
> I believe cortex A15 has the same counter, and this is what I-pipe
> uses. About the tsc architecture on ARM, it was made to allow the
> different counters available on different arm processors while
> keeping a unique kernel/user ABI. If the counter you are talking
> about is guaranteed to be available on all armv8 based processors
> and you are sure nobody will ever want a better counter (from what I
> could test on cortex a15, this counter has a rather low resolution,
> around 1us), then you can avoid the arm tsc architecture altogether.

If you mean the master counter, then from what I have seen it usually runs
at 5 to 6 MHz range, so a bit better than 1us, but certainly not 0.1us.

-- 
Len Sorensen

