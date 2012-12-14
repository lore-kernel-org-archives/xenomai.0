From: Tim Niemeyer <tim.niemeyer@corscience.de>
In-Reply-To: <50CB3347.8060000@gmail.com>
References: <50CB3347.8060000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 14 Dec 2012 15:27:00 +0100
Message-ID: <1355495220.2190.6.camel@herbert.er.corscience.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] How does the adeos and xenomai project stay
 synchronized with the linux kernel project?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: hauptmech <hauptmech@gmail.com>
Cc: xenomai@xenomai.org

Hi

Am Freitag, den 14.12.2012, 15:10 +0100 schrieb hauptmech:
> I've used and followed Xenomai off and on since it forked from RTAI. I'm 
> building a new xenomai x86 system after a few years of doing other 
> things. I'm noticing that the adeos patches are few and relatively old 
> compared to the kernel for the x86 architecture. Kernel version 3.2 has 
> moved from .21 to .35 for instance. Meanwhile my (non-rt) systems all 
> use 3.4 or 3.6.

I use 3.4 on my rt system. You can find the adeos work from the
Xenomai-Team here:
http://git.xenomai.org/?p=ipipe-gch.git;a=shortlog;h=refs/heads/for-core-3.4

It was quite confused to get it working on 3.4.14. As the work is based
on 3.4.6.

There is also a branch 'for-core-3.5'.

-- 
Tim Niemeyer

Corscience GmbH & Co. KG
Henkestr. 91
D-91052 Erlangen
Germany

e-mail: tim.niemeyer@corscience.de
Internet: www.corscience.de


