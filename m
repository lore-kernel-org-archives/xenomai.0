MIME-Version: 1.0
From: Andreas Glatz <andi.glatz@gmail.com>
Date: Thu, 28 Sep 2017 13:36:19 +0100
Message-ID: <CAKJ14NctuCrtTg3+pCf6zAMR_0uFmuhGQhOJSBOevDxtUfwUeQ@mail.gmail.com>
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
To: xenomai@xenomai.org

>
>> Von: Andreas Glatz
>> Gesendet: Mittwoch, 27. September 2017 15:38
>>
>> ...
>> >>>    u32Tmp        = ntohl(*reinterpret_cast<u32*>(pDat));
>> >>>    sPhasor.mag   = interpretU32AsFloat(u32Tmp);
>> >>>    u32Tmp        = ntohl(*reinterpret_cast<u32*>(pDat+4));
>> >>>    sPhasor.angle = interpretU32AsFloat(u32Tmp);
>> ...
>>
>> It's true according to the ARM doc [1]. But the pDat alignment is
>> prescribed by the sender and we're at the receiver. So I guess the
>> question is how to tell the assembler not to use ldm in the first
>> place?
>
> Try defining `*pDat` with `volatile`.
> See http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.faqs/ka16346.html (How do I avoid the compiler generating LDM/STM instructions?)

I think this does the trick and needs only minimal surgery in the
code. Currently I'm running the optimised version of the code as
yesterday, where essentially the only changes are that i defined pDat
as 'volatile u8*', and all the reinterpret_casts were changed to
contain the volatile keyword as well (otherwise the compiler starts
complaining about missing qualifiers).

I'll leave it running for a while to see if anything strange happens...

Thanks a lot everyone involved!

A.

