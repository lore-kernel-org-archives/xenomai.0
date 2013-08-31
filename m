Message-ID: <5221F666.5030907@xenomai.org>
Date: Sat, 31 Aug 2013 15:57:58 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5221D88B.90108@xenomai.org> <5221F614.9060909@xenomai.org>
In-Reply-To: <5221F614.9060909@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] CONFIG_CONTEXT_TRACKING
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 08/31/2013 03:56 PM, Philippe Gerum wrote:
> On 08/31/2013 01:50 PM, Gilles Chanteperdrix wrote:
>>
>> Hi,
>>
>> this new option popped up in ARM's entry.S, what do other arches do, do
>> we support it? or do we forbid the option with CONFIG_IPIPE?
>>
> 
> Full nohz is desirable for an increasing number of users who have 
> requirements on power consumption, so enabling context tracking for our 
> supported archs seems desirable too.
> 

Is replacing the test

if (in_interrupt())

in user_enter and user_exit with

if (ipipe_root_p == 0 || in_interrupt())

sufficient? Or do we want to also track user context for tasks running
in Xenomai domain.

-- 
                                                                Gilles.

