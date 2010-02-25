Message-ID: <4B862216.10100@domain.hid>
Date: Thu, 25 Feb 2010 08:09:10 +0100
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
References: <4B856ADF.1030100@domain.hid> <4B858711.9040806@domain.hid>
	<4B85E29D.2000202@domain.hid>
In-Reply-To: <4B85E29D.2000202@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai built by OpenEmbedded
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bob Feretich <bob.feretich@domain.hid>
Cc: xenomai@xenomai.org

Hi Bob,

Bob Feretich schrieb:
> Sorry, I reused an old e-mail and forgot to change the subject line last
> time. The subject line is more accurate on this e-mail.
> 
> How can I locate this previous report?  (identified below)

https://mail.gna.org/public/xenomai-help/2010-02/msg00069.html
https://mail.gna.org/public/xenomai-help/2009-08/msg00047.html

regards
kisda

> I am willing to spend some time pushing Xenomai forward on this front,
> but I will probably need some help. I have been involved with Linux
> system building just long enough to be dangerous. Installing a co-kernel
> is a new frontier for me.
> 
> Normally, when I need to attach a new module to the Angstrom kernel, I...
> 
>    1. bitbake the Linux system. (Kernel source is deleted upon completion.)
>    2. bitbake the Angstrom kernel using the "-c compile" option, which
>       leaves the kernel source and intermediate files in place.
>    3. Build my kernel modules within the context of the kernel.
> 
> My theory is that the below sequence may work for Xenomai...
> 
>    1. bitbake the Linux system. (Kernel source is deleted upon completion.)
>    2. bitbake the Angstrom kernel using the bitbake "-c compile" option,
>       which leaves the kernel source and intermediate files in place.
>    3. Apply the appropriate Adios kernel patches.
>    4. Rebuild the Angstrom kernel using the "-c compile" option, which
>       should use the patched  kernel source.
>    5. Add the Xenomai sub-tree to the root file system.
>    6. Build my modules as before.
> 
> Does this make sense?
> 
> Regards,
> Bob Feretich
> 
> On 2/24/2010 12:07 PM, Gilles Chanteperdrix wrote:
>> Bob Feretich wrote:
>>   
>>> Lately I have been using the OpenEmbedded bitbake tool to build my Linux 
>>> systems (Angstrom for BeagleBoard based).  Has anyone created a recipe 
>>> set to build Xenomai under OpenEmbedded?
>>>
>>> What I really want to do is install Xenomai into the BeagleBoard 
>>> Angstrom kernel.
>>>     
>>
>> Yes, recently someone reported using this method. However, he had issues
>> with -Wl,--as-needed which we did not elucidate completely.
>>   
>>> Regards,
>>> Bob
>>> _______________________________________________
>>> Xenomai-help mailing list
>>> Xenomai-help@domain.hid
>>> https://mail.gna.org/listinfo/xenomai-help
>>>
>>>     
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


