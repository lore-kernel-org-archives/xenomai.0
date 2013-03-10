Message-ID: <513CE8FD.7060604@xenomai.org>
Date: Sun, 10 Mar 2013 21:11:41 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <513CDF10.8000305@xenomai.org> <513CE48D.60304@web.de>
In-Reply-To: <513CE48D.60304@web.de>
Content-Type: text/plain; charset=UTF-8
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
To: Jan Kiszka <jan.kiszka@web.de>
Cc: Xenomai <xenomai@xenomai.org>

On 03/10/2013 08:52 PM, Jan Kiszka wrote:

> On 2013-03-10 20:29, Gilles Chanteperdrix wrote:
>>
>> Hi,
>>
>> I get this warning when compiling Xenomai based on Linux 3.8 for ARM:
>>
>> kernel/ipipe/Kconfig:1:error: recursive dependency detected!
>> kernel/ipipe/Kconfig:1: symbol IPIPE is selected by XENOMAI
>> init/Kconfig:1763:      symbol XENOMAI depends on IPIPE_CORE
>> kernel/ipipe/Kconfig:16:        symbol IPIPE_CORE depends on IPIPE
>>
>> Any idea how to avoid this?
> 
> Did you try my Xenomai upstream queue for 3.8? This should resolve the
> cyclic dependency:
> http://git.xenomai.org/?p=xenomai-jki.git;a=commitdiff;h=ba0fcc1736c4e3ad05389b74ffbef50f7096a1df


You mean, I missed a pull request ?


-- 
                                                                Gilles.

