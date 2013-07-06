Message-ID: <51D84E91.8030304@xenomai.org>
Date: Sat, 06 Jul 2013 19:06:25 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E1UvVpi-0006VC-NT@xenomai.org>
In-Reply-To: <E1UvVpi-0006VC-NT@xenomai.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] [Xenomai-git] Philippe Gerum : lib/cobalt: unexport
	asm/xenomai/tsc.h
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Le 06/07/2013 18:59, git repository hosting a écrit :
> Module: xenomai-forge
> Branch: next
> Commit: 3f2346392969710381545906be4e16a6d4ca2f97
> URL:    http://git.xenomai.org/?p=xenomai-forge.git;a=commit;h=3f2346392969710381545906be4e16a6d4ca2f97
>
> Author: Philippe Gerum <rpm@xenomai.org>
> Date:   Sat Jul  6 15:51:01 2013 +0200
>
> lib/cobalt: unexport asm/xenomai/tsc.h

Since tsc may be used to measure really short durations, so with the 
least possible overhead, maybe it makes sense to continue exporting 
__xn_rdtsc for such uses.

-- 
Gilles.

