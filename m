Message-ID: <4FC6506C.9090609@xenomai.org>
Date: Wed, 30 May 2012 18:53:00 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAKKWdtc6Py7A9YuJ1nNzwmq0SiEcrP_D8pztoo_eNWsp9EAsFg@mail.gmail.com>
	<4FC637EB.90908@xenomai.org> <4FC63C53.3020805@xenomai.org>
	<20120530155743.GK32727@csclub.uwaterloo.ca>
In-Reply-To: <20120530155743.GK32727@csclub.uwaterloo.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] a question about ADEOS
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: xenomai@xenomai.org

On 05/30/2012 05:57 PM, Lennart Sorensen wrote:
> On Wed, May 30, 2012 at 05:27:15PM +0200, Gilles Chanteperdrix wrote:
>> If the question is: why is not Adeos integrated in the mainline kernel ?
>> the answer is that the kernel community has chosen another solution to
>> enable real-time, and is not interested in integrating the Adeos patch.
> 
> As a user of adeos and xenomai, I do look forward to the day xenomai works
> with the other option so that a single scheduler can handle everything
> and give much better control over things.  But there is much work to be
> done before that happens as far as I can tell.

You can see for yourself with the xenomai-forge branch. It is already in
a usable state. I do not buy the scheduler argument: the linux scheduler
does pretty much the same separation between real-time and non real-time
tasks as the separation which happens with xenomai. And the scheduler
for real-time tasks is simple, it does not need to know much more than
the tasks priorities, I do not see what more you would like to control.

> 
> ipipe is an interesting solution, although not a particularly nice one.
> 

It depends on your definition of "nice". It ends up being a relatively
simple implementation which provides good latency results.

-- 
					    Gilles.

