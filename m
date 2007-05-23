Message-ID: <4653FAE0.90707@domain.hid>
Date: Wed, 23 May 2007 10:27:12 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <20070522145243.94232353428@domain.hid>
	<1179907535.6119.14.camel@domain.hid>
In-Reply-To: <1179907535.6119.14.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] ppc crosscompilation, missing headers
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Peter Feuerer <peter.feuerer@domain.hid>
Cc: xenomai@xenomai.org

Peter Feuerer wrote:
> Hi,
> 
> History:
> https://mail.gna.org/public/xenomai-help/2007-05/msg00260.html
> 
>> Please see FAQ 14.1.4. ELDK Include Files Missing
>> http://www.denx.de/wiki/view/DULG/ELDKIncludeFilesMissing
> 
> After doing this workaround, I'm able to compile the userspace part of
> Xenomai, but now I can't compile any little kernelmodule using the
> xenomai api. I attached the Makefile and the sourcecode of my little
> example.
> 
> When trying to compile it cannot find headers like asm/param.h or
> asm/types.h (because they are not in krnsrc/include/asm-ppc/ and the
> workaround just added the userspace/libc headers). I guess there must be
> something wrong with the Makefile, but I cannot find the problem.

Just add ARCH=ppc to you make command.

Wolfgang.

