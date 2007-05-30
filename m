Message-ID: <465D4186.4010208@domain.hid>
Date: Wed, 30 May 2007 11:19:02 +0200
MIME-Version: 1.0
References: <465D2BE1.1080302@domain.hid> <465D3053.2040002@domain.hid>
	<465D383C.5040203@domain.hid> <465D3B37.9000900@domain.hid>
In-Reply-To: <465D3B37.9000900@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
From: Rodolfo Bamberg <rolfetas@domain.hid>
Subject: Re: [Xenomai-help] [Newbie question]Segmentation fault with
 user-space binary
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

I recompiled the kernel with TSC and latency works. The native app still
throws a segmentation fault. I should debug it

Jan Kiszka wrote:
> Rodolfo Bamberg wrote:
>   
>> I tried to use latency and got this. Am I missing something within the
>> Kernel? I didn't find an option for TSC. I use the 2.6.20.4 kernel
>>
>> /usr/bin $ latency
>> Xenomai: incompatible feature set
>> (required="sep tsc", present="sep", missing="tsc").
>>
>>     
>
> Make sure your kernel config contains CONFIG_M586TSC or better - or
> build the user space part with --disable-x86-tsc (but only if your
> hardware is really predating any Pentium class CPU).
>
> Jan
>
>   


