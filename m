Message-ID: <513DA08D.9000209@xenomai.org>
Date: Mon, 11 Mar 2013 10:14:53 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <513CDF10.8000305@xenomai.org> <513CE48D.60304@web.de>
	<513CE9F0.5000107@xenomai.org>
In-Reply-To: <513CE9F0.5000107@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] recursive dependency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@web.de>, Xenomai <xenomai@xenomai.org>

On 03/10/2013 09:15 PM, Gilles Chanteperdrix wrote:
> On 03/10/2013 08:52 PM, Jan Kiszka wrote:
>
>> On 2013-03-10 20:29, Gilles Chanteperdrix wrote:
>>>
>>> Hi,
>>>
>>> I get this warning when compiling Xenomai based on Linux 3.8 for ARM:
>>>
>>> kernel/ipipe/Kconfig:1:error: recursive dependency detected!
>>> kernel/ipipe/Kconfig:1: symbol IPIPE is selected by XENOMAI
>>> init/Kconfig:1763:      symbol XENOMAI depends on IPIPE_CORE
>>> kernel/ipipe/Kconfig:16:        symbol IPIPE_CORE depends on IPIPE
>>>
>>> Any idea how to avoid this?
>>
>> Did you try my Xenomai upstream queue for 3.8? This should resolve the
>> cyclic dependency:
>> http://git.xenomai.org/?p=xenomai-jki.git;a=commitdiff;h=ba0fcc1736c4e3ad05389b74ffbef50f7096a1df
>>
>> Jan
>>
>>
>
> No luck, it is anothe issue. It is probably caused by the ARM Kconfig,
> will have a look at it.
>

I had to fix this on -forge too:
5f481e0 cobalt/nucleus: fix recursive dependency on IPIPE symbols


-- 
Philippe.

