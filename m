Message-ID: <501295E3.2030808@xenomai.org>
Date: Fri, 27 Jul 2012 15:21:39 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CALH4WdYdUKfMrsJUHqQYTh84GgMWErpCYUJMmZVtxxngdNoStQ@mail.gmail.com>
In-Reply-To: <CALH4WdYdUKfMrsJUHqQYTh84GgMWErpCYUJMmZVtxxngdNoStQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] cpu usage
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Frederik Bayart <frederik.bayart@triphase.com>
Cc: xenomai@xenomai.org

On 07/27/2012 03:04 PM, Frederik Bayart wrote:

> I'm running Xenomai 2.6.0 on Linux 2.6.38
> 
> I have a dual core processor.
> When I run a busywait loop on cpu 0 (see source in attachment), I
> can't do anything anymore on the computer although cpu 1 is almost
> entirely idle. I can't interrupt the busywait loop, login, type
> something in a shell, ...
> This is even the case if I run linux entirely on cpu 1 (by using
> isolcpus=0 as kernel parameter)
> 
> How can this be explained ?
> 
> Is it possible to use cpu 0 at 100% for a xenomai tasks and cpu 1 for
> normal linux tasks so that you can still work on the computer ?


Is it an issue worth investigating? If a xenomai task uses 100% of the
cpu, it is a bug, enable the watchdog, and you will avoid the lockup. If
it is by design, then it really looks like a bad design.

-- 
                                                                Gilles.

