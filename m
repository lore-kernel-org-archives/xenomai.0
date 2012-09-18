Message-ID: <50588458.1010802@xenomai.org>
Date: Tue, 18 Sep 2012 16:25:28 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50588110.6030701@siemens.com>
In-Reply-To: <50588110.6030701@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [GIT PULL] core-5 for x86
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wolfgang Mauerer <wolfgang.mauerer@siemens.com>
Cc: "Kiszka, Jan" <jan.kiszka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 09/18/2012 04:11 PM, Wolfgang Mauerer wrote:
> Dear all,
> 
> here's a rebase of the x86-specific bits of core-4 to core-5. I've
> included all x86 specific changes that are not yet in core-5, and
> also added the patches I sent earlier for core-4. I did not include a
> separate patch for the mechanical changes required to apply the
> x86 base patch on top of core-5, but can surely do so if desired.

I am not quite finished with x86 on 3.4. So, I would like to start 3.5
from the finishing point on 3.4. There are already commits in my branch
which you did not take:

http://git.xenomai.org/?p=ipipe-gch.git;a=shortlog;h=refs/heads/for-core-3.4

This is assuming that I am the (flaky subsitute for a) maintainer of the
x86 architecture. Of course, if someone wants to take over the
maintenance of the x86 architecture, I am gladly returning to the ARMs.


4-x86 applied to core-5
>       x86/ipipe: Make io_apic_level_ack_pending available for ipipe

What is this commit? Neither the text nor the diff are very explicit.

-- 
					    Gilles.

