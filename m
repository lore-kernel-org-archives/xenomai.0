Message-ID: <4F3BE9F7.2060707@domain.hid>
Date: Wed, 15 Feb 2012 11:23:03 -0600
From: Jeff Webb <jeff.webb@domain.hid>
MIME-Version: 1.0
References: <4F3BD76C.1040703@domain.hid> <4F3BDC1E.9090707@domain.hid>
In-Reply-To: <4F3BDC1E.9090707@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] signal handling in Xenomai 2.6.0
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai help <xenomai@xenomai.org>

On 02/15/2012 10:23 AM, Gilles Chanteperdrix wrote:
> On 02/15/2012 05:03 PM, Jeff Webb wrote:
>> I am not able to block signals using pthread_sigmask or sigprocmask
>> on my Xenomai 2.6.0 system.  If I compile my test program without
>> Xenomai, it works as I intended and blocks the requested signals.  If
>> I compile it for Xenomai, the requested signals are not blocked.
>>...
>> Can someone confirm that this code works on Xenomai 2.6.0?
>
> Please try the following patch:
> ...

Thanks, Gilles.  That seems to have fixed the problem.  I had to add "#include <signal.h>" at the top of rt_print.c to get your patched version to compile.   I just rebuilt my userspace packages, not the kernel.

Thanks again for the quick response.

-Jeff

