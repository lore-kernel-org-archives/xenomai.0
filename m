Message-ID: <50CCF6C4.80408@xenomai.org>
Date: Sat, 15 Dec 2012 23:16:36 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50CCEA7E.1080000__518.307140055363$1355606686$gmane$org@xenomai.org>
	<50CCF3B8.5000201@linux-kernel.net>
In-Reply-To: <50CCF3B8.5000201@linux-kernel.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] core-3.5 for x86
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wolfgang Mauerer <wm@linux-kernel.net>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, "Mauerer,
	Wolfgang" <wolfgang.mauerer@siemens.com>, xenomai@xenomai.org

On 12/15/2012 11:03 PM, Wolfgang Mauerer wrote:

> Hi Gilles,
> 
> On 15/12/2012 22:24, Gilles Chanteperdrix wrote:
> 
>> I see some (recent) activity on this git repository:
>> https://github.com/siemens/ipipe/commits/core-3.5_for-upstream
>>
>> In what state is this branch, can I pull from it?
> please don't pull yet, I need to port a few more patches forward
> and fix one known issue with the tree. But I'll try to send a
> pull/discussion request next week.
> 
>> At least the changes allowing preempt_disable()/preempt_enable() to be
>> called from non-root context look dubious.
> are you referring to 767f0d43fe3? This one still carries a TODO
> item in the description to remind me to check with which
> non-x86 archs this can cause problems, and what we can do about
> them.


Actually, we already have ipipe_safe_current(), so I guess what you need
is ipipe_safe_current_thread_info() ?

-- 
                                                                Gilles.

