MIME-Version: 1.0
In-Reply-To: <4A116AC5.7010704@domain.hid>
References: <abaf774b0905180656y4eddca23h6241c9dc031a3ba4@domain.hid>
	<4A116AC5.7010704@domain.hid>
Date: Thu, 21 May 2009 09:35:10 +0100
Message-ID: <abaf774b0905210135qce7c61dg46ae05bb40567c13@domain.hid>
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

On 18/05/2009, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
> Steve wrote:
>> First, thank you for the help on my previous query.
>>
>> I am still working on porting a c++ application from RTAI to Xenomai,
>> and have encountered a problem with sockets, specifically the select
>> function.
>>
>> When Xenomai is not being used the code runs as expected.  Once the
>> Xenomai headers, compile options, etc, are used the select function
>> fails with the error EFAULT.  I have reproduced the error (works
>> without Xenomai, EFAULTs with Xenomai) using the following program:
>>
<snip>
>>
>> I am using Xenomai 2.4.6.1 on a vanilla 2.6.24.6 Linux kernel, and
>> running on Ubuntu 8.04.
>
> Could you try 2.4.7, to see if you are not having a bug which has
> already been fixed?
>
> What you are trying should work, even though you are not really using
> Xenomai's select but Linux plain select.
>
> --
>                                                  Gilles.
>

I have just tested my example code with Xenomai version 2.4.7 but I am
still encountering the problem.

