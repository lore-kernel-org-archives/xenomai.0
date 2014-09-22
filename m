Message-ID: <54208009.5040504@xenomai.org>
Date: Mon, 22 Sep 2014 22:01:13 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAFvTJFEsnycSeft7DEeRFXFTXb8E8xLbzFANk2HVt50ikd14gQ@mail.gmail.com>	<54206D56.7040509@xenomai.org>
 <CAFvTJFGhGfuficFeDLxnDZQT=gSnmtn95933_zi16YSbD8Q9uQ@mail.gmail.com>
In-Reply-To: <CAFvTJFGhGfuficFeDLxnDZQT=gSnmtn95933_zi16YSbD8Q9uQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] kernel panic with IPIPE and LPAE on ARM OMAP5 board
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Sam Hajian <saeid.hajian@gmail.com>, xenomai@xenomai.org

On 09/22/2014 09:49 PM, Sam Hajian wrote:
>> As a general rule, turning debug options off to make bugs disappear is
>> not really a good option, the sooner you catch a bug the better. Anyway,
> I seems I was not clear, I said I tried 2 scenarios. I initially tried
> IPIPE & LPAE and there was a null pointer dereference, as shown in the
> log.
> 
> [    7.132601] Unable to handle kernel NULL pointer dereference at
> virtual address 00000000
> [    7.149256] pgd = c0003000, hw pgd = c0003000
> [    7.158295] [00000000] *pgd=80000080004003, *pmd=00000000
> [    7.169475] Internal error: Oops: 206 [#1] SMP ARM
> 
>  When I traced it, found that in debug code which is set by
> CONFIG_SLUB_DEBUG. to confirm that when I had this flag off the null
> pointer dereference was gone. But ran into other problem with invalid
> paging request.
> 
> [    5.309728] Unable to handle kernel paging request at virtual
> address 5f3f1c00
> [    5.324624] pgd = c0003000, hw pgd = c0003000
> [    5.333678] [5f3f1c00] *pgd=80000080005003, *pmd=00000000
> 
>> ipipe_pin_range_globally probably has never been used with 3 level page
>> tables, which are enabled by LPAIE. In order to see if this is the only
>> problem, you can try and return at the beginning of
>> ipipe_pin_range_globally. You will not be able to run xenomai correctly
>> with this, but if the system boots normally, it means that indeed, like
>> you think, the problem is in that function.
>>
> I tried that but the same problem it dies very early (null pointer
> dereference at virtual add 0x0) even before getting to
> ipip_pin_range_globally probably in debug code.

Then you are back to square 1: you have to debug the oops with
disassembler and register values.

-- 
                                                                Gilles.

