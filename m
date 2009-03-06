Message-ID: <49B10B2F.4080103@domain.hid>
Date: Fri, 06 Mar 2009 12:38:23 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <5D63919D95F87E4D9D34FF7748CE2C2A0187305A@ARVMAIL1.mra.roland-man.biz>
	<49B0FE9A.9040809@domain.hid> <49B10464.8010703@domain.hid>
In-Reply-To: <49B10464.8010703@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Floating Point Exceptions in RT-Tasks
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai@xenomai.org

Wolfgang Grandegger wrote:
> Philippe Gerum wrote:
>> roderik.wildenburg@domain.hid wrote:
>>>> Gilles sent you a patch affecting include/asm-powerpc/bits/pod.h a
>>>> few weeks
>>>> ago, that fixed an FPU issue. Are you running with this patch applied?
>>>>
>>> Yes, with 2.3.5 and 2.4.6. Both show the same behavior.
>>> Obviously, in the meantime, Wolfgang could reproduce the problem!?
>>>
>> Unfortunately, I'm not able to reproduce this bug on my side, even using
>> the latest linuxppc_devel tree. I have attached my test code to make
>> sure we are testing the same thing. This test code does raise the FPU
>> exception properly.
> 
> And it does here as well, but not the program provided by Thomas, which
> I have attached.

Still no luck, this test code works as well on my setup over a lite5200 (latest 
linuxppc_2_4_devel, Xenomai 2.4.7). I guess I need to try this on the tqm5200 
instead.

> 
> Wolfgang
> 
> 
> 


