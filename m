Message-ID: <4FCB97A0.2020400@xenomai.org>
Date: Sun, 03 Jun 2012 18:58:08 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4FC8F8EE.4010901@xenomai.org> <4FC8FBD0.3020206@siemens.com>
In-Reply-To: <4FC8FBD0.3020206@siemens.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] x86_32 mayday
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

On 06/01/2012 07:28 PM, Jan Kiszka wrote:
> On 2012-06-01 19:16, Gilles Chanteperdrix wrote:
>>
>> Hi,
>>
>> with the current tip of xenomai 2.6 branch, the "sigdebug" test testing
>> the "mayday" code ends up with a segfault on x86_32. I tried to have a
>> look at it, but could not really understand what happens: the register
>> on return from the syscall are ok, but the segfault happens after return
>> from the signal handler, when returning from the interrupted function.
>> It looks like either ebp, or the function return adress are wrong.
>>
>> If anyone wants to have a look at it... Jan maybe?
>
> Can't promise, but will try to find a slot.
>
> I think I didn't test on x86-32 so far. Is this a regression or did you
> run the test for the first time as well?

This could not have worked reliably on x86_32, my bad. We must save 
ss:esp across the mayday transition to return to userland sanely.
I'll be pushing a patch shortly.

-- 
Philippe.

