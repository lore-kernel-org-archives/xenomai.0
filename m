Message-ID: <5176DB44.2050906@xenomai.org>
Date: Tue, 23 Apr 2013 21:04:36 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5176A9B0.6080601@siemens.com> <5176D357.5000308@xenomai.org>
	<5176D4C2.2090908@siemens.com>
In-Reply-To: <5176D4C2.2090908@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Rework of mlockall and dlopen handling
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

On 04/23/2013 08:36 PM, Jan Kiszka wrote:

> On 2013-04-23 20:30, Gilles Chanteperdrix wrote:
>> On 04/23/2013 05:33 PM, Jan Kiszka wrote:
>>
>>> Hi,
>>>
>>> I've coded down what we discussed and pushed it into 'for-upstream'.
>>> This does not yet remove redundant mlockall from included userspace
>>> code or change the docs, but the core mechanisms are ready. Patch list
>>> below summarizes the steps.
>>
>>
>> I would have been a bit less extreme, and simply inverted the default
>> value of --enable-dlopen-skins and --enable-*-auto-mlockall, but what
>> you did is fine by me.
>>
>> Maybe we could keep --disable-dlopen-skins though?
> 
> ...and translate it to --with-__thread? Or what should be the semantics?


Yes, you are right, it is useless.

-- 
                                                                Gilles.

