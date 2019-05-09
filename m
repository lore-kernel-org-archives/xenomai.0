MIME-Version: 1.0
References: <VpFdLbJqKpBKdxuwpEr9vxR2VBu2j4uXIps1EM68ktxueh7Q9bRQeHRA56sFDKeY1xbPcvb6TuGG01MVtxNt03OdF6N1b3YIEPjJnzbRjqk=@codecraftsmen.org>
In-Reply-To: <VpFdLbJqKpBKdxuwpEr9vxR2VBu2j4uXIps1EM68ktxueh7Q9bRQeHRA56sFDKeY1xbPcvb6TuGG01MVtxNt03OdF6N1b3YIEPjJnzbRjqk=@codecraftsmen.org>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Thu, 9 May 2019 10:19:34 -0400
Message-ID: <CALLqZ8TJt66aooCz+wCFhg_k3+xwoQ6BFqc+7TvFtA+Au71zzw@mail.gmail.com>
Subject: Re: select() unblocks when no data to read()
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jeff Webb <w1@codecraftsmen.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Tue, May 7, 2019 at 9:54 PM Jeff Webb via Xenomai
<xenomai@xenomai.org> wrote:
>
> I am having trouble using select() to perform a timed wait on a UDD file descriptor to detect interrupts from a custom PCI card.  After some searching, I came across this thread from 2017 that describes my exact issue:
>
> https://xenomai.org/pipermail/xenomai/2017-July/037494.html
>
> I am using x86-64 instead of ARM, but I am having the same trouble.  The original poster did a great job of describing the problem, so I won't repeat it.  If I use only read() without select(), things work as expected, but I need to implement a timeout.
>
> It sounds like Philippe was going to look into the issue further.  Has any progress on this issue been made since the last post in this thread?
>
> Thanks,
>
> -Jeff Webb
>
>

There was a fix posted to the list a while ago but it wasn't a patch
it was the whole c file.  I don't think a patch was ever made, I'll
see if I can dig it up.

-Greg

