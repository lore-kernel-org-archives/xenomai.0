References: <CAKJ14NegF9o5h27cN1m3CKrtNHSnCZ8Fv5+Vuezd3h6r86hAAA@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <fb9085b9-c4b7-0719-0919-382cde732d97@xenomai.org>
Date: Tue, 19 Dec 2017 11:38:08 +0100
MIME-Version: 1.0
In-Reply-To: <CAKJ14NegF9o5h27cN1m3CKrtNHSnCZ8Fv5+Vuezd3h6r86hAAA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RTnet fixes - testers needed
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Andreas Glatz <andi.glatz@gmail.com>, xenomai@xenomai.org, leo@alaxarxa.net


Hi Andreas,

On 12/19/2017 11:17 AM, Andreas Glatz wrote:
>>
>> I have pulled wip/rtnet-fixes branch with the last commit of Philippe from Sun
>> Dec 17 15:27:04 2017 +0100: net/udp: ioctl: fix temp arg buffer type
>>
>> I have created the packages and new kernel with the same configuration that I had.
>>
>> I run my application, that it's a POSIX application Wrapped and I still have the
>> same error when I activate SMAP:
> 
> I see that the page fault occurs in rt_packet_ioctl()... by the looks
> of this bug it might be similar to the one I found in udp.c (see my
> post from Sunday)... basically the ioctl still tries to access user
> memory, which causes that stack trace. I'm currently a bit busy - I
> hope I can continue debugging this by the end of this week. 

I should be able to squeeze this debug task in the coming 48 hours, I
have your latest patched queued already. Let me know if you want to keep
on addressing this issue, otherwise I'll tackle this stuff.

Thanks,

-- 
Philippe.

