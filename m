Message-ID: <51D863D7.3040503@xenomai.org>
Date: Sat, 06 Jul 2013 20:37:11 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <E1UvVpi-0006VC-NT@xenomai.org> <51D84E91.8030304@xenomai.org>
In-Reply-To: <51D84E91.8030304@xenomai.org>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 07/06/2013 07:06 PM, Gilles Chanteperdrix wrote:
> Le 06/07/2013 18:59, git repository hosting a écrit :
>> Module: xenomai-forge
>> Branch: next
>> Commit: 3f2346392969710381545906be4e16a6d4ca2f97
>> URL:
>> http://git.xenomai.org/?p=xenomai-forge.git;a=commit;h=3f2346392969710381545906be4e16a6d4ca2f97
>>
>>
>> Author: Philippe Gerum <rpm@xenomai.org>
>> Date:   Sat Jul  6 15:51:01 2013 +0200
>>
>> lib/cobalt: unexport asm/xenomai/tsc.h
>
> Since tsc may be used to measure really short durations, so with the
> least possible overhead, maybe it makes sense to continue exporting
> __xn_rdtsc for such uses.
>

There is no users of such interface at application level. Inner code 
from lib/cobalt or copperplate do access this helper inline though.

-- 
Philippe.

