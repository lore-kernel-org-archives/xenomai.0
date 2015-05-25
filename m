Message-ID: <5563280B.2040301@gatech.edu>
Date: Mon, 25 May 2015 09:47:55 -0400
From: "Yogi A. Patel" <yapatel@gatech.edu>
MIME-Version: 1.0
References: <245D3361-0412-466A-BFA1-22F2EDDC18B6@gatech.edu>
 <55617756.4080307@web.de>
In-Reply-To: <55617756.4080307@web.de>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] 3.14.17 patch initial ram disk hangup
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>, xenomai@xenomai.org


On 05/24/2015 03:01 AM, Jan Kiszka wrote:
> On 2015-05-22 22:47, Yogi A. Patel wrote:
>> Hi -
>>
>> I have a Dell OptiPlex 9020 running 3.14.17. I am trying to get this system to run 3.14.17 with xenomai (using the 3.14.17 patch in the xenomai 2.6.4 source).
>>
>> The computer hangs when I select the kernel at “Loading initial ram disk”. I tried booting into recovery mode and go the following output:
>>
>> Kernel panic - not syncing: timer doesn’t work through Interrupt-remapped IO-APIC.
> Please turn off CONFIG_IRQ_REMAP or boot the kernel with intremap=off.
> This feature is not yet compatible with I-pipe. I guess we should encode
> this into the x86 patch.
>
> Jan
>
>> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.14.17-xenomai-2.6.4.
>>
>> I’m having a hard time finding the source of the error. I’ve attached my config file. Any suggestions appreciated!
>> -------------- next part --------------
>> A non-text attachment was scrubbed...
>> Name: config
>> Type: application/octet-stream
>> Size: 163773 bytes
>> Desc: not available
>> URL: <http://xenomai.org/pipermail/xenomai/attachments/20150522/c24951de/attachment.obj>
>> -------------- next part --------------
>>
>> Yogi
>>
>> _______________________________________________
>> Xenomai mailing list
>> Xenomai@xenomai.org
>> http://xenomai.org/mailman/listinfo/xenomai
>>
>

I tried Jan's suggestion and it works with the 3.14.17-x84-6 ipipe patch 
- I can boot in get to a desktop/etc. However, the latencies are all 
over the place. I am seeing worst-case latencies anywhere between 2us-50us.

I tried Gilles' suggestion, too - and compiled with 3.14.17-x86-9 ipipe 
patch. Same thing as above.

I read around online about interrupt remapping - and I can't seem to 
find anything that hints at why this turning it off would cause the 
latencies to be all over the place.

Any thoughts/guidance appreciated!

Yogi

