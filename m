From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Wed, 30 May 2012 13:57:54 -0400
Message-ID: <20120530175754.GL32727@csclub.uwaterloo.ca>
References: <CAKKWdtc6Py7A9YuJ1nNzwmq0SiEcrP_D8pztoo_eNWsp9EAsFg@mail.gmail.com>
	<4FC637EB.90908@xenomai.org> <4FC63C53.3020805@xenomai.org>
	<20120530155743.GK32727@csclub.uwaterloo.ca>
	<4FC6506C.9090609@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4FC6506C.9090609@xenomai.org>
Subject: Re: [Xenomai] a question about ADEOS
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Wed, May 30, 2012 at 06:53:00PM +0200, Gilles Chanteperdrix wrote:
> You can see for yourself with the xenomai-forge branch. It is already in
> a usable state. I do not buy the scheduler argument: the linux scheduler
> does pretty much the same separation between real-time and non real-time
> tasks as the separation which happens with xenomai. And the scheduler
> for real-time tasks is simple, it does not need to know much more than
> the tasks priorities, I do not see what more you would like to control.

I have been looking at it a bit.  Maybe I should give it a try soon.

Based on what I have seen for the real time linux patches, you can set
priorities of kernel threads as well, which would be nice at times.

Perhaps our use is just not normal, in that we ahve an application that
uses realtime, but has some work to do that is very low priority (and
not in need of realtime) but needs to share memory space and resources
with the stuff that does have to be real time, which makes it hard to
make linux tasks run before the less important stuff in the xenomai
application runs.  It works using an idle priority thread, but it would
be nice to have better control of it, which I hope the rt patches for
linux would allow.  Maybe I am hoping for too much.

Is there anywhere that has the current status of the xenomai-forge branch?
Like what is expected to work already and what isn't working.

> It depends on your definition of "nice". It ends up being a relatively
> simple implementation which provides good latency results.

That is true.  It does end up easliy making linux unhappy though.
Of course that is always going to be an issue when you want realtime
for some things.

-- 
Len Sorensen

