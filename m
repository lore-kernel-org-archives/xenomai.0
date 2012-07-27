Message-ID: <50129907.5040306@siemens.com>
Date: Fri, 27 Jul 2012 15:35:03 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <CALH4WdYdUKfMrsJUHqQYTh84GgMWErpCYUJMmZVtxxngdNoStQ@mail.gmail.com>
In-Reply-To: <CALH4WdYdUKfMrsJUHqQYTh84GgMWErpCYUJMmZVtxxngdNoStQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
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
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2012-07-27 15:04, Frederik Bayart wrote:
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

It's a FAQ: This is not possible with current Linux. It will lock up
quite quickly if kernel helper threads for RCU or work queues cannot run
once in a while. Also, time keeping will be affected. Due to the latter,
you should release the core to Linux once every scheduling tick.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux



