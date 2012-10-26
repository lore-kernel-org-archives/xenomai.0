Message-ID: <508AC31B.8070805@xenomai.org>
Date: Fri, 26 Oct 2012 19:06:35 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAMVghhVFiQNbPLgS5zpLw7Bu5t9mxdY5U9htVOOrRxQt_RWgVQ@mail.gmail.com>	<CAHzTO8nxt5KcK_mekgArQXqdLGQC=d3bWFBse=H6cZmpRvon-A@mail.gmail.com>	<CAMVghhVXP=VckoAcgSjYBxO=2i2gsAse-or0xvBbNJNuodu2yA@mail.gmail.com>	<508AA828.8050702@xenomai.org>
	<CAMVghhUq3KUEEK32aSfap3jKbsgaZCDMErQqhzpeOSJ8pYz3Ng@mail.gmail.com>
In-Reply-To: <CAMVghhUq3KUEEK32aSfap3jKbsgaZCDMErQqhzpeOSJ8pYz3Ng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Seeking recommendations for SBC with precision timer
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Howard Lee Harkness <howard.lee.harkness@gmail.com>
Cc: Xenomai@xenomai.org

On 10/26/2012 06:34 PM, Howard Lee Harkness wrote:
> Ah, that looks like it might be the solution. Need to dig a bit deeper on
> this subject.

If you use the the RTDM API, you would use the rtdm_task_busy_sleep 
routine:
http://www.xenomai.org/documentation/xenomai-2.6/html/api/group__rtdmtask.html#gaa3940cfff7cc72d7bc064a3e279d74ac

> 
> Back last time I was doing this sort of thing, I was using a 286, which
> didn't have a TSC. Plus I only had to do about 500 us resolution on the
> timings. I contracted with a friend to do a simple countdown timer for the
> PC bus, which did the trick. That was more than 15 years ago. The
> semiconductor testing business has gotten a little more complex since then.

I have to admit that when I had a 286, I was still in high-school
and programming it in Turbo Pascal for plotting function graphs
for my math assignments...

-- 
					    Gilles.

