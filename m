References: <CAKJ14NdyH7FF+pwj9J-FLSnCWHOqAteKVrrbagA4eqhvETgFoA@mail.gmail.com>
 <CAKJ14NfuNCtfK9bT5Oh+dRYAKhW+4KgaFO5w=xt=exJOw6forQ@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <e847e788-f0c4-9d27-9dd7-4cb9c22de649@xenomai.org>
Date: Wed, 27 Sep 2017 15:31:38 +0200
MIME-Version: 1.0
In-Reply-To: <CAKJ14NfuNCtfK9bT5Oh+dRYAKhW+4KgaFO5w=xt=exJOw6forQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Unexpected mode switches when reordering C++ lines
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Andreas Glatz <andi.glatz@gmail.com>, xenomai@xenomai.org

On 09/27/2017 03:26 PM, Andreas Glatz wrote:
>> I've got two versions of the same piece of code, the only difference
>> is that lines are reordered:
>>
>> #if 1
>>    u32Tmp        = ntohl(*reinterpret_cast<u32*>(pDat+4));
>>    sPhasor.angle = interpretU32AsFloat(u32Tmp);
>>    u32Tmp        = ntohl(*reinterpret_cast<u32*>(pDat));
>>    sPhasor.mag   = interpretU32AsFloat(u32Tmp);
>> #else
>>    u32Tmp        = ntohl(*reinterpret_cast<u32*>(pDat));
>>    sPhasor.mag   = interpretU32AsFloat(u32Tmp);
>>    u32Tmp        = ntohl(*reinterpret_cast<u32*>(pDat+4));
>>    sPhasor.angle = interpretU32AsFloat(u32Tmp);
>> #endif
>>
>> In case '#if 1' sPhasor.angle is assigned before sPhasor.mag, and
>> everything works fine.
>>
>> In case '#if 0' it's the other way round, and I get mode switches
>> caused by the first (but not second) ntohl().
> 
> I forgot to mention the mode switch is actually a unaligned access
> exception as shown here:
> $> cat /proc/xenomai/faults
> TRAP         CPU0        CPU1
>   0:            0          50    (Data or instruction access)
>   1:            0           0    (Section fault)
>   2:            0           0    (Generic data abort)
>   3:            0           0    (Unknown exception)
>   4:            0           0    (Instruction breakpoint)
>   5:            0           0    (Floating point exception)
>   6:            0           0    (VFP Floating point exception)
>   7:            0           0    (Undefined instruction)
>   8:            0    14629654    (Unaligned access exception)
> 

I believe that the ldm instruction is causing this, not rev. If so, this
would mean that %r5 contains an unaligned address for a 32bit read.

-- 
Philippe.

