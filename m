Message-ID: <542437D3.4080605@xenomai.org>
Date: Thu, 25 Sep 2014 17:42:11 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <d5e7531ec6454715adde3750c412a062@CVEX13.valentin-carl.de>
 <5424316B.3040002@xenomai.org>
In-Reply-To: <5424316B.3040002@xenomai.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] bad syscall <167772715>/ Segmentation fault during
 xeno-test
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Reitinger, Peter" <preitinger@carl-valentin.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 09/25/2014 05:14 PM, Philippe Gerum wrote:
> On 09/25/2014 04:52 PM, Reitinger, Peter wrote:
>> Dear Xenomai people,
>>
>> I have recently tried to migrate from 2.x to 3.x, but when I tried to run xeno-test, I get the following output:
>>
>>
> 
> [snip]
> 
>> [   94.434282] [Xenomai] bad syscall <167772715>
>> Segmentation fault
>> root@dimm-am335x:/usr/xenomai/bin#
>>
>>
>>
>> Probably I just forgot one or another little thing to adapt...?
>>
> 
> This is not a Xenomai 3 syscall signature, but a Xenomai 2.x's. Could
> you provide the output of /usr/xenomai/bin/version -a?
> 

Never mind, I can reproduce on igep, this looks like arm-specific. I'll
follow up on this. Thanks.

-- 
Philippe.

