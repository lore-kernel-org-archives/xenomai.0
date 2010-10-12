Message-ID: <4CB47ECA.8060201@domain.hid>
Date: Tue, 12 Oct 2010 17:29:14 +0200
From: Anders Blomdell <anders.blomdell@domain.hid>
MIME-Version: 1.0
References: <4CB33738.206@domain.hid>	<4CB338AB.3070803@domain.hid>	<4CB339F9.5080202@domain.hid>	<4CB33F04.3000600@domain.hid>	<4CB34031.5090505@domain.hid>	<4CB3424A.5090504@domain.hid>	<4CB4299D.70600@domain.hid>
	<4CB43704.4020504@domain.hid> <4CB45B06.2070905@domain.hid>
	<4CB46855.4010401@domain.hid> <4CB473E4.8020709@domain.hid>
	<4CB4774F.2040904@domain.hid>
In-Reply-To: <4CB4774F.2040904@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai and capabilities
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2010-10-12 16.57, Gilles Chanteperdrix wrote:
> Anders Blomdell wrote:
>> On 2010-10-12 15.53, Gilles Chanteperdrix wrote:
>>> Anders Blomdell wrote:
>>>> CAP_DAC_OVERRIDE fixes this issue (and how safe is that :-( )
>>>>
>>>> How necessary are CAP_SYS_RAWIO and CAP_DAC_OVERRIDE [the two capabiltities i
>>>> think have the most severe security implications] when main has started running,
>>>> i.e. could I drop them after initialization and still do something useful?
>>> Again: you have just found some reason why Xenomai is unsecure, it just
>>> proves that it is unsecure and there are probably other reasons why it
>>> is unsecure. So, here I do not concur with Jan. Security *is* a
>>> black-and-white domain. Any security hole makes the system unsecure,
>>> there is no gray area, no "partially secure" code.
>> Hence it's essentially a black area, but plugging holes still makes sense in
>> order to eventually arrive at a secure system.
> 
> There are probably huge changes in the code which would be required to
> make it secure. I do not want to tackle this issue. It would be a huge
> amount of work, only required for very few of Xenomai users. It is not
> even on my already long ever-growing todo list. And I suspect it is not
> on Philippe's either.
> 
>>
>>> Either you are ready to make a thourough auditing of the code and plug
>>> all the security holes you find, or you consider Xenomai unsecure.
>> See my questions and comments as a step in this direction, but I am not and will
>> never be competent enough to find all holes.
> 
> Neither am I. Knowing the code is not enough. One more reason to not
> even try and tackle this issue.
> 
>>
>>> Plugging two holes you have found and say "I stop now, this is
>>> 'reasonably' secure" does not really make sense.
>> I totally agree, but plugging the obvious holes is at least not a step backward
>> in this respect.
>>
>> CAP_DAC_OVERRIDE -> write anything anywhere in the filesystem
>> CAP_SYS_RAWIO -> trash memory at will
> 
> Not really memory, but more MMIO and IOPORTs areas. Many users want
> that. It is even required on ARM to have the TSC emulation working.
> 
>>
>> Does anybody know why these capabilities are required (execept for the MAYDAY page?)
> 
> You really want MAYDAY support if you want the users to be able to
> recover from stupid programming error with the help of the watchdog.
> Without mayday + watchdog, infinite loop means hard lockup needing reboot.
> 
> The point is that since the user able to run Xenomai applications can
> break the systems in so many way (simply by using the SCHED_FIFO
> scheduling policy, you start being dangerous for the system), why trying
> and restricting its powers? It would only get in the way of people for
> which security is not an issue.
> 
> For instance, if we disable CAP_SYS_RAWIO, it will make it hard for ARM
> users to use their platform at its full potential.
OK, so short answer is you are root when you run Xenomai (or can easily become
root)?

Fine with me, but it's always good to know.

CAP_DAC_OVERRIDE still needs fixing for
http://www.xenomai.org/index.php/Non-root_RT to work.

Regards

Anders

-- 
Anders Blomdell                  Email: anders.blomdell@domain.hid
Department of Automatic Control
Lund University                  Phone:    +46 46 222 4625
P.O. Box 118                     Fax:      +46 46 138118
SE-221 00 Lund, Sweden

