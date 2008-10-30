Message-ID: <f8b4363d0810300324q54a6f2p8744e8f013afd941@domain.hid>
Date: Thu, 30 Oct 2008 06:24:45 -0400
From: "Antino Kim" <antinokim@domain.hid>
In-Reply-To: <490989CD.6030903@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <f8b4363d0810300151p7782d43au76e009d9ce9f9303@domain.hid>
	<49097EFE.4000606@domain.hid>
	<f8b4363d0810300255j34f7d10dre9cbbc9ca3c9bf0d@domain.hid>
	<490989CD.6030903@domain.hid>
Subject: Re: [Xenomai-help] [Total Newbie] Module xeno_native not found
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

I basically followed the instruction I found online:

http://www.captain.at/xenomai-installation.php

In short, I did:
Download both vanilla kernel & xenomai
Patched the kernel with xenomai script
Compiled kernel <-- took longest time!
Install xenomai (configure, make all and make install)

Anything that I might have missed? What stage might have gone wrong?

Thanks.



On Thu, Oct 30, 2008 at 6:17 AM, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> Antino Kim wrote:
>> Hello Jan,
>>
>> First of all, I appreciate you looking into this.
>>
>> When I run:
>>
>> dmesg | grep xenomai
>>
>> I get nothing back. Does that mean something went wrong?
>>
>> I have attached .config file. I have no idea what has gone wrong, and
>> unlike when I was compiling the kernel I can't seem to find much
>> information on the internet. I would appreciate your feedback.
>
> Your config shows no sign of Xenomai at all - something went wrong with
> your local build. Please read the installation doc carefully and repeat
> the described steps. At this chance, select a processor type that is
> appropriate for your CPU (CONFIG_M586 is generic, but suboptimal for
> many applications)
>
> Jan
>
> --
> Siemens AG, Corporate Technology, CT SE 2
> Corporate Competence Center Embedded Linux
>



-- 
For The Best,
Antino Kim

