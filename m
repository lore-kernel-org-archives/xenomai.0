Message-ID: <511293EB.1080502@siemens.com>
Date: Wed, 06 Feb 2013 18:33:31 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <51128CE4.4020303@siemens.com> <51128E3E.808@xenomai.org>
In-Reply-To: <51128E3E.808@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] ipipe/x86: do not restore during context switch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 2013-02-06 18:09, Gilles Chanteperdrix wrote:
> On 02/06/2013 06:03 PM, Jan Kiszka wrote:
> 
>> Gilles,
>>
>> do you remember if this core-3.4 change was a performance optimization
>> or a necessary fix? Also, I'm not yet understanding why we need all the
>> #ifdefs except for the first one which forces fpu.preload to 0.
> 
> 
> It is a performance optimization, without it, we systematically hit the
> maximum latency when the timer would tick during a context switch which
> restores the FPU. Note that if you change that, you will probably break
> -forge.

According to the Intel folks who introduced eagerfpu, xsave, or at least
xsaveopt (which I didn't implemented yet) is now faster than serializing
clts/stts. On the other hand, the worst case is a full SSE + AVX restore
while the target RT task is not depending on the FPU.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux

