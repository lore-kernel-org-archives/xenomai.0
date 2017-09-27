MIME-Version: 1.0
In-Reply-To: <dffcf471-c697-b04c-7dc9-84c169b5be62@xenomai.org>
References: <CAKJ14NdyH7FF+pwj9J-FLSnCWHOqAteKVrrbagA4eqhvETgFoA@mail.gmail.com>
 <dffcf471-c697-b04c-7dc9-84c169b5be62@xenomai.org>
From: Andreas Glatz <andi.glatz@gmail.com>
Date: Wed, 27 Sep 2017 18:25:18 +0100
Message-ID: <CAKJ14NdBR+VMq6ovb06nLi1EU4c2rA6TTo=VtC3Zdz1RWdKqZQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] Unexpected mode switches when reordering C++ lines
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

On Wed, Sep 27, 2017 at 2:53 PM, Philippe Gerum <rpm@xenomai.org> wrote:
> On 09/27/2017 03:14 PM, Andreas Glatz wrote:
>> Hi
>>
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
>>
>> Looking at the assembly, there is a clear difference:
>>
>> #if 1
>>    0x2ac5bcb8 <+304>:   ldr     r3, [r5]
>>    0x2ac5bcbc <+308>:   ldr     r2, [r5, #4]
>>    0x2ac5bcc0 <+312>:   rev     r3, r3
>>    0x2ac5bcc4 <+316>:   rev     r2, r2
>> [...]
>> #else
>>      0x2abc3cb8 <+304>:   ldm     r5, {r2, r3}
>> => 0x2abc3cbc <+308>:   rev     r2, r2
>>      0x2abc3cc0 <+312>:   rev     r3, r3
>> [...]
>> #endif
>>
>> Here the arrow indicates where the mode switch occurs, which is at the
>> 'rev' (for reverse byte order instruction), hence ntohl(). It seems
>> that the assembler optimization that collates the two ' ldr r3, [r5]'
>> and 'ldr r2, [r5, #4]' into ' ldm r5, {r2, r3}' could have something
>> to do with the mode switches...
>>
>> Any clues what causes the mode switches and how to avoid them?
>>
>
> The ugly way I'm afraid: load each 32bit word one byte at a time in a
> temp variable recomposing the 32bit quantity first, then reshuffling the
> temp variable contents to host byte order.
>

As you say Philippe, I had to memcpy() 2xu32 from the (malloc'd)
memory region into an array u32 tmpVal[2] array, and then use these
values one-by-one to process them with ntohl(), ...

I tried to cast the pDat pointer to u32* initially, but then I still
got the ldm instructions and hence mode switches as the assembler is
very good at optimizing.

I have the feeling the same could come up at other places as well as
we progress with the testing of our application. I guess a 'save'
solution is to compile the code with -O0 or -O1, because if never seen
these mode switches using these compiler options. However, an ideal
solution would be to have something to mark the memory region as
'unaligned' so the assembler then only uses ldr instead of
instructions on it... maybe there is this unicorn running around
somewhere :)

Anyways, many thanks for your help.

A.

