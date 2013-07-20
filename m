Message-ID: <51EA7539.3000805@xenomai.org>
Date: Sat, 20 Jul 2013 13:32:09 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <51B73421.3050506@siemens.com>
In-Reply-To: <51B73421.3050506@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Stable update for ipipe-3.8
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On 06/11/2013 04:28 PM, Jan Kiszka wrote:

> Hi all,
>
> I've merged 3.8.13 into our stable 3.8 branch. This triggered some minor
> conflicts in generic and ARM code. Please see
>
> git://git.xenomai.org/ipipe-jki for-upstream/3.8
>
> for details. The result works fine for x86, and if it's also OK for the
> other arch, I'd propose this to be merged into the official 3.8 stable
> branch.


Hi Jan,

I am not so sure 3.8.13. I am having random segfaults when running:

xeno-regression-test -l "dohell -s 192.168.0.5 -m /mnt -l /ltp" -p 1000

on geode and at91. I have first focused on at91 because the "unlocked 
context switch" features is a usual suspect, but:
- the hardware pgd is in sync with the software pgd, which means that 
the unlocked context switch did not mess up the hardware pgd;
-  going back to 3.5, I am unable to trigger the faults, despite the 
fact that the mm switch code is the same for this type of machine.

So, could you run this same test on your x86 machines to see if you have 
any issue?

Regards.

-- 
                                                                 Gilles.

