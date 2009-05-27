MIME-Version: 1.0
In-Reply-To: <4A1514E7.90801@domain.hid>
References: <abaf774b0905180656y4eddca23h6241c9dc031a3ba4@domain.hid>
	<4A116AC5.7010704@domain.hid>
	<abaf774b0905210135qce7c61dg46ae05bb40567c13@domain.hid>
	<4A1514E7.90801@domain.hid>
Date: Wed, 27 May 2009 16:12:48 +0100
Message-ID: <abaf774b0905270812n32a76ee8ga2820622986fa54a@domain.hid>
From: Steve <sbxenomai@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] select(2) generates EFAULT
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

On 21/05/2009, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> Steve wrote:
>> On 18/05/2009, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>> wrote:
>>> Steve wrote:
>>>> First, thank you for the help on my previous query.
>>>>
>>>> I am still working on porting a c++ application from RTAI to Xenomai,
>>>> and have encountered a problem with sockets, specifically the select
>>>> function.
>>>>
>>>> When Xenomai is not being used the code runs as expected.  Once the
>>>> Xenomai headers, compile options, etc, are used the select function
>>>> fails with the error EFAULT.  I have reproduced the error (works
>>>> without Xenomai, EFAULTs with Xenomai) using the following program:
>>>>
>> <snip>
>>>> I am using Xenomai 2.4.6.1 on a vanilla 2.6.24.6 Linux kernel, and
>>>> running on Ubuntu 8.04.
>>> Could you try 2.4.7, to see if you are not having a bug which has
>>> already been fixed?
>>>
>>> What you are trying should work, even though you are not really using
>>> Xenomai's select but Linux plain select.
>>>
>>> --
>>>                                                  Gilles.
>>>
>>
>> I have just tested my example code with Xenomai version 2.4.7 but I am
>> still encountering the problem.
>
> You need to pull the latest 2.4.x git version [1].
>
> Jan
>
> [1] http://git.xenomai.org/?p=xenomai-2.4.git;a=summary
>
>

Sorry, just realised I sent this directly to Jan and no-one else:

I have grabbed the latest version of 2.4.x (19th May 2009) and the
select problem has been solved.  Thank you all for your suggestions,
and I will make sure to grab the latest git version in future (I
hadn't realised that 'snapshot' refered to the entire release instead of
a small part (or snapshot) of it, allowing for http download from that
page, sorry).

Thank you again,

Steve

