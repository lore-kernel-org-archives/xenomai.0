Message-ID: <52F2123A.2070607@siemens.com>
Date: Wed, 05 Feb 2014 11:28:10 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <E1WAhle-0006kB-0q@sd-51317.dedibox.fr>
 <52F1172B.2080500@xenomai.org> <52F11F94.9000309@siemens.com>
 <52F1231A.7080603@xenomai.org> <52F12442.3040301@xenomai.org>
 <52F125E8.6020200@xenomai.org> <52F12700.3020400@xenomai.org>
 <52F12800.1030500@xenomai.org> <52F12937.3050105@xenomai.org>
 <52F12B7A.4060408@siemens.com> <52F1F749.2030501@xenomai.org>
 <52F1FB24.4090603@siemens.com> <52F1FD3B.1070304@xenomai.org>
 <52F1FEFC.9070708@siemens.com> <52F20604.4020200@xenomai.org>
 <52F20780.9010002@siemens.com> <52F20E32.3010706@xenomai.org>
In-Reply-To: <52F20E32.3010706@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : alchemy: Replace static
 variable no_alchemy_task with macro
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 2014-02-05 11:10, Philippe Gerum wrote:
> On 02/05/2014 10:42 AM, Jan Kiszka wrote:
>> So you just want me to fold patch 2 and 3 together? I don't fully get it
>> yet.
> 
> I'm asking for a clarification: do you have more patches following these
> two? I understood from the past conversation that more work was
> required, so I'm assuming you will have. If so, then we may save a lot
> of time by seeing the complete change set that would fit the bill for
> supporting standard C/C++ restrictions, the way your current port work
> seems to require it.

I'm not aware of further issues after the __typeof__ thing. However, I
will try to run through all public headers in an automated way,
including them in strict modes to check if there is something remaining.
Maybe we can also hook this into our build tests here.

> 
>>
>>>
>>>>
>>>> The no_alchemy_task thing is not a dialect issue, so I think it's clear
>>>> now.
>>>
>>> This issue is only relevant to how smart the compiler you use is with
>>> respect to optimizing the output, when it sees a statically-scoped
>>> variable which is explicitly read-only.
>>
>> Right, so one of the issue it causes has nothing to do with [strict] C++
>> compliance.
> 
> Which is the reason why I tend to suspect patches claiming about fixing
> some perceived ugliness, factual information is better. This construct
> is valid, but does not fit well with the gcc release you are aiming at,
> which is another issue. Xenomai 3.x does impose minimum requirements on
> the compiler/toolchain, including sane/working support of builtin sync
> primitives and tls.
> 
> In this respect, your patch about no_alchemy_task would have been better
> explained by the goal of not depending on too recent optimizers, which
> does make sense to me. The language is important so that my limited
> mono-neuronal brain can deal with your commit logs.

OK, will do /s/ugliness/objective reason for ugliness/.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

