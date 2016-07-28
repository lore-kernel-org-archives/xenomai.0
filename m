References: <CAL7Yi3Q+zWjueMj84vxOv4J633nBe_JmENnW=Pi8e_nnwth-QA@mail.gmail.com>
 <4dd9bd1e-3fd3-4c70-aac6-be6e012738fc@xenomai.org>
 <CAL7Yi3Qw_npN+uQ9kAANev30=N_jW3fC2gUw+qpvcGoyErJ5sw@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <676822ba-d630-f498-76e3-4ba9014cd803@xenomai.org>
Date: Thu, 28 Jul 2016 23:58:16 +0200
MIME-Version: 1.0
In-Reply-To: <CAL7Yi3Qw_npN+uQ9kAANev30=N_jW3fC2gUw+qpvcGoyErJ5sw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai ported to ARMv8 NXP QorIQ SDK?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Tracy Smith <tsmithdsc99@gmail.com>
Cc: Xenomai@xenomai.org

On 07/28/2016 11:40 PM, Tracy Smith wrote:
> The Xenomai 3 Mercury core does not require I-Pipe and can even run on
> the kernel with no real-time support, correct?
> 
> http://xenomai.org/installing-xenomai-3-x/#Installing_the_Mercury_core
> 

Correct.

> 
> So the simplest route would be to take it and integrate Xenomai 3.0
> Mercury core into the NXP SDK and build.
>

Using Xenomai/mercury only makes sense if you need to run an RTOS
emulator (vxworks, psos) or the alchemy API, and can cope with higher
latencies than those obtained with a dual kernel system.

The simplest route for plain POSIX-based applications with no strict
real-time requirements is to leave Xenomai aside, unless you plan for
switching to a dual kernel system (using POSIX or whatever API) over
Xenomai/cobalt at some point.

> I-Pipe for ARMv8 has not been released yet so backporting it from
> mainline 4.1.18 to 4.1.8+rt may not be so simple, do you agree?
>

Not trivial, but manageable for people familiar with Xenomai in dual
kernel mode.

> One of our engineers had to do it to get  Xenomai 2 running on Raspberry
> Pi for a custom distro and it wasn't that trivial.
> 

I can't comment, I don't know which issues popped up, and how familiar
your engineer was with dual kernel systems and specifically with the
I-pipe when starting this task.

-- 
Philippe.

