Message-ID: <50352C12.2020307@xenomai.org>
Date: Wed, 22 Aug 2012 20:59:30 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <2211797.6MhXv49D68@valtin-rt> <5035228B.1050905@xenomai.org>
In-Reply-To: <5035228B.1050905@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Scicos/Xcos Code Generation
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Markus Valtin <valtin@control.tu-berlin.de>
Cc: xenomai@xenomai.org

On 08/22/2012 08:18 PM, Gilles Chanteperdrix wrote:

> On 08/22/2012 06:28 PM, Markus Valtin wrote:
> 
>> Hello all,
>>
>> i have a question regarding automated code generation from Scilab Xcos/Scicos.
>>
>> Is this possible? And if yes, how is the necessary setup.
>>
>> Background:
>>
>> We currently use RTAI for hard realtime but we want to use recent Kernel 
>> versions, so Xenomai with his RTAI skin seamed promising.
>>
>> However I read that the RTAI emulation was removed from version 2.6.0 because 
>> of lack of feedback / lack of LXRT emulation.
>>
>> So, is there another way like the native Xenomai Support as suggested on
>> http://www.evidence.eu.com/scilabscicos-code-generator-xenomai.html
> 
> 
> Googling a bit shows that other projects are using scicos with Xenomai:
> http://www.scilab-linux.com/
> http://rtss.sourceforge.net
> 
> I do not know, however, if this is what you are looking for.
> 
> You may want to reintegrate an RTAI skin to Xenomai, but in that case,
> please find someone to maintain it.
> 
> It makes probably more sense to simply change the tools to generate
> xenomai native skin calls instead of RTAI calls.
> 
> Also if the tools are able to generate code for Linux, chances are that
> it is even possible to use the generated code to run with Xenomai posix
> skin.


And if the code runs in kernel-space, it should use the RTDM skin.

-- 
                                                                Gilles.

