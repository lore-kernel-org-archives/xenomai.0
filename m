MIME-Version: 1.0
In-Reply-To: <54207DBE.5000008@xenomai.org>
References: <CAFvTJFEsnycSeft7DEeRFXFTXb8E8xLbzFANk2HVt50ikd14gQ@mail.gmail.com>
 <54206D56.7040509@xenomai.org>
 <CAFvTJFGhGfuficFeDLxnDZQT=gSnmtn95933_zi16YSbD8Q9uQ@mail.gmail.com>
 <54207DBE.5000008@xenomai.org>
Date: Mon, 22 Sep 2014 16:05:33 -0400
Message-ID: <CAFvTJFEGFCK7wL85-_rT21wEsfin+cMOpk6xSvE-j8otQBJo3A@mail.gmail.com>
From: Sam Hajian <saeid.hajian@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] kernel panic with IPIPE and LPAE on ARM OMAP5 board
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai@xenomai.org

On Mon, Sep 22, 2014 at 3:51 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:
> On 09/22/2014 09:49 PM, Sam Hajian wrote:
>>> As a general rule, turning debug options off to make bugs disappear is
>>> not really a good option, the sooner you catch a bug the better. Anyway,
>> I seems I was not clear, I said I tried 2 scenarios. I initially tried
>> IPIPE & LPAE and there was a null pointer dereference, as shown in the
>> log.
>>
>> [    7.132601] Unable to handle kernel NULL pointer dereference at
>> virtual address 00000000
>> [    7.149256] pgd = c0003000, hw pgd = c0003000
>> [    7.158295] [00000000] *pgd=80000080004003, *pmd=00000000
>> [    7.169475] Internal error: Oops: 206 [#1] SMP ARM
>>
>>  When I traced it, found that in debug code which is set by
>> CONFIG_SLUB_DEBUG. to confirm that when I had this flag off the null
>> pointer dereference was gone. But ran into other problem with invalid
>> paging request.
>
> How is that different to what I said? You turned off a debug option
> (CONFIG_SLUB_DEBUG) and made a bug disappear.
>
I just wanted to provide more info and be complete, that is all. I think my
second try with no debug shows that there are some problem with paging
request in MM code when LPAE in on but you are the expert. Anyway can you
please help.

Saeid
