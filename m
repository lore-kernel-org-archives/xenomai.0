MIME-Version: 1.0
In-Reply-To: <edafc147-2eee-249d-4ee4-b96869605ccd@alaxarxa.net>
References: <CAKJ14NegF9o5h27cN1m3CKrtNHSnCZ8Fv5+Vuezd3h6r86hAAA@mail.gmail.com>
 <edafc147-2eee-249d-4ee4-b96869605ccd@alaxarxa.net>
From: Andreas Glatz <andi.glatz@gmail.com>
Date: Wed, 20 Dec 2017 09:19:39 +0000
Message-ID: <CAKJ14Ne-pgWY_wgZ80UiDoggk8qcZD=Jrm-xG=OfwhZUYNXB2A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] RTnet fixes - testers needed
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
Cc: xenomai@xenomai.org

>>> I have pulled wip/rtnet-fixes branch with the last commit of Philippe from Sun
>>> Dec 17 15:27:04 2017 +0100: net/udp: ioctl: fix temp arg buffer type
>>>
>>> I have created the packages and new kernel with the same configuration that I had.
>>>
>>> I run my application, that it's a POSIX application Wrapped and I still have the
>>> same error when I activate SMAP:
>>
>> I see that the page fault occurs in rt_packet_ioctl()... by the looks
>> of this bug it might be similar to the one I found in udp.c (see my
>> post from Sunday)... basically the ioctl still tries to access user
>> memory, which causes that stack trace. I'm currently a bit busy - I
>> hope I can continue debugging this by the end of this week. In the
>> meantime could you recompile your kernel with debug info which should
>> improve the kernel bug output?
>>
>
> I have compiled the kernel with  CONFIG_DEBUG_KERNEL=Y. But, I have seen that
> there's another option.
>
> Which one could be the best for this case?
>

I think you want CONFIG_DEBUG_INFO, which depends on CONFIG_DEBUG_KERNEL=Y.

On ARM I also enabled CONFIG_DEBUG_INFO_DWARF4... but the help says
it's just for gdb + optimised code so I think you can leave it out.

Cheers,

A.

