Message-ID: <4ACDB4CB.2040509@domain.hid>
Date: Thu, 08 Oct 2009 11:45:47 +0200
From: Mau <liste@domain.hid>
MIME-Version: 1.0
References: <4ACC9BEC.8090200@domain.hid> <4ACDA7C6.3090004@domain.hid>
In-Reply-To: <4ACDA7C6.3090004@domain.hid>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai on RD129 (Samsung S3C2410A)
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
Cc: Xenomai-help@domain.hid


Gilles Chanteperdrix wrote:
> Mau wrote:
>> Dear Sirs,
>> I have found this product from a company near me:
>> http://www.elpa.it/rd129it.html
>> It comes with linux preinstalled.
>> The kernel is a vanilla kernel 2.6.30 with the addition of a few kernel
>> drivers for unsupported peripherals.
>> On board there is a cpu Samsung S3C2410A, flash, ram and few other things.
>> I need to investigate the possibility to install xenomai on this thing.
>>
>> I want to know if others have used similar boards with same or similar
>> processor with success, and how complex can be to make adeos and xenomai
>> work on such processor.
> 
> This question is answered on xenomai web site. This is FAQ number 2.
> http://www.xenomai.org/index.php/FAQs
> 
>> The other question is that since we need to apply two patches to the
>> vanilla kernel (the original + adeos) is there a preferred order?
> 
> Well, if the order matters, it means that there is a conflict, and if
> there is a conflict, no matter what order you choose, you will have to
> solve it.
> 
> However, if I were you, I would choose to apply the I-pipe patch on the
> modified kernel sources tree, because it is probably simpler.
> 

Thanks Gilles for your kind answer.
I actually did see FAQ #2 before. My question was if someone on this
list is currently using such processor in some application, in order to
exchange experiences.
Anyway, I always found this list very useful and with many people
willing to help so it's ok for me to proceed with my tests.
Thanks also for your suggestion about patch order, I will sure follow
your advice.
Thanks all.
Mau.

