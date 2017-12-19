MIME-Version: 1.0
In-Reply-To: <fb9085b9-c4b7-0719-0919-382cde732d97@xenomai.org>
References: <CAKJ14NegF9o5h27cN1m3CKrtNHSnCZ8Fv5+Vuezd3h6r86hAAA@mail.gmail.com>
 <fb9085b9-c4b7-0719-0919-382cde732d97@xenomai.org>
From: Andreas Glatz <andi.glatz@gmail.com>
Date: Tue, 19 Dec 2017 10:46:40 +0000
Message-ID: <CAKJ14NdXdqw5Y-UVp4vigRD5LF+-NCPmg+FzvrrNFd+tr9jWUg@mail.gmail.com>
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

>>>
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
>> hope I can continue debugging this by the end of this week.
>
> I should be able to squeeze this debug task in the coming 48 hours, I
> have your latest patched queued already. Let me know if you want to keep
> on addressing this issue, otherwise I'll tackle this stuff.
>

I think you'll be at it before me then :) I already made some more
progress in the UDP case. I can send you my latest patch tonight. I'm
also happy to keep testing + fixing when I find time for it! I can use
the RTnet UDP app from the company that I ported from kernel 3.0 to
4.9 to test the RTnet UDP stack.

Best,

A.

