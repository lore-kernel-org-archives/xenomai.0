MIME-Version: 1.0
Sender: bodgesoc@gmail.com
In-Reply-To: <52DBC5FE.6060806@xenomai.org>
References: <CAN1+YZVvgPNNHFub5QAkw6SeSUPuf1dv_94kYGqhbjMpNt70Sg@mail.gmail.com>
 <CAN1+YZWOjxf=s+6LH3Xymzx_mwWa6XmO_Xt7SHF589RzJCANBA@mail.gmail.com>
 <52D8609C.5050903@xenomai.org>
 <CAN1+YZW+nJgMb0hLy2JWZW6JrxA+mZzA+-oN-gjQgeGTcoe0jg@mail.gmail.com>
 <CAN1+YZUY_3FExF=qrUtMQDQxTqossnQsPCy6zfPjfqp8PitZCg@mail.gmail.com>
 <52D9984F.9080203@xenomai.org>
 <CAN1+YZWnLC=MLxWqYd9xH1URimWnOdEhU4mwZ0S3QFdpghUaGQ@mail.gmail.com>
 <52DAE756.3070606@xenomai.org>
 <CAN1+YZWmjvsu7My92EBktFhWYhheRJvdYrEq=r3+Ravp_Wzoyw@mail.gmail.com>
 <52DBC5FE.6060806@xenomai.org>
From: Andy Pugh <andy@bodgesoc.org>
Date: Mon, 20 Jan 2014 18:45:37 +0100
Message-ID: <CAN1+YZUKkC0qCB40N684QgGfYpGx64C9uNRBa2NFfGDCSRatxw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] Fwd: Kernel Compilation Problems
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
Cc: xenomai <xenomai@xenomai.org>

I am skiing all this week, I will try the patch on my return, thanks.

On 19 January 2014 13:33, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> On 01/18/2014 11:31 PM, Andy Pugh wrote:
>> On 18 January 2014 12:43, Gilles Chanteperdrix
>> <gilles.chanteperdrix@xenomai.org> wrote:
>>
>>> It is an imx6, right? Could you try ton run the X server without
>>> acceleration (using the fbdev driver)?
>>
>> That does look a lot more promising:
>>
>> RTT|  00:00:43  (periodic user-mode task, 1000 us period, priority 99)
>> RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat worst
>> RTD|      6.404|     13.219|     42.202|       0|     0|      1.709|     44.921
>> RTD|      3.856|     14.416|     46.916|       0|     0|      1.709|     46.916
>> RTD|      3.765|     15.383|     36.954|       0|     0|      1.709|     46.916
>> RTD|      2.939|     15.292|     40.489|       0|     0|      1.709|     46.916
>> RTD|      2.886|     15.669|     75.785|       0|     0|      1.709|     75.785
>> RTD|      3.679|     15.752|     42.689|       0|     0|      1.709|     75.785
>> RTD|      4.585|     17.161|     47.861|       0|     0|      1.709|     75.785
>> RTD|      4.590|     16.749|     46.838|       0|     0|      1.709|     75.785
>> RTD|      3.343|     14.154|     28.101|       0|     0|      1.709|     75.785
>> RTD|      3.323|     16.641|     48.358|       0|     0|      1.709|     75.785
>>
>> The 75uS was the point where I opened a web browser. Running glxgears
>> seemed to have no effect at all
>>
> BTW, you should wait a bit more than 43 seconds to hope having a good
> approximation of the worst case. Using LTP is recommended.
>
> Could you try the following patch to see if it improves anything?
>
> diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
> index d9cb476..fe177c8 100644
> --- a/arch/arm/mm/cache-l2x0.c
> +++ b/arch/arm/mm/cache-l2x0.c
> @@ -41,7 +41,7 @@ static inline void cache_wait_way(void __iomem *reg, unsigned long mask)
>  {
>         /* wait for cache operation by line or way to complete */
>         while (readl_relaxed(reg) & mask)
> -               ;
> +               cpu_relax();
>  }
>
>  #ifdef CONFIG_CACHE_PL310
> @@ -136,6 +136,7 @@ static void __l2x0_flush_all(void)
>         debug_writel(0x00);
>  }
>
> +#ifndef CONFIG_IPIPE
>  static void l2x0_flush_all(void)
>  {
>         unsigned long flags;
> @@ -145,6 +146,51 @@ static void l2x0_flush_all(void)
>         __l2x0_flush_all();
>         spin_unlock_irqrestore(&l2x0_lock, flags);
>  }
> +#else
> +static void l2x0_clean_line_idx(unsigned line, unsigned way)
> +{
> +       void __iomem *base = l2x0_base;
> +
> +       writel_relaxed((way << 28) | (line << 5), base + L2X0_CLEAN_LINE_IDX);
> +       cache_wait(base + L2X0_CLEAN_LINE_IDX, 1);
> +}
> +
> +static void l2x0_flush_way(unsigned way, unsigned len, unsigned lines)
> +{
> +       unsigned long flags;
> +       unsigned line, i;
> +
> +       for (line = 0; line < lines; line += len ) {
> +               spin_lock_irqsave(&l2x0_lock, flags);
> +               debug_writel(0x03);
> +               for (i = 0; i < len && line + i < lines; i++)
> +                       l2x0_clean_line_idx(line + i, way);
> +               cache_sync();
> +               debug_writel(0x00);
> +               spin_unlock_irqrestore(&l2x0_lock, flags);
> +       }
> +
> +       spin_lock_irqsave(&l2x0_lock, flags);
> +       debug_writel(0x03);
> +       writel_relaxed((1 << way), l2x0_base + L2X0_CLEAN_WAY);
> +       cache_wait_way(l2x0_base + L2X0_CLEAN_WAY, (1 << way));
> +       cache_sync();
> +       debug_writel(0x00);
> +       spin_unlock_irqrestore(&l2x0_lock, flags);
> +}
> +
> +static void l2x0_flush_all(void)
> +{
> +       unsigned lines, len, way, ways;
> +
> +       ways = fls(l2x0_way_mask);
> +       lines = l2x0_size / (ways * CACHE_LINE_SIZE);
> +       len = L2X0_SPINLOCK_LEN / CACHE_LINE_SIZE;
> +
> +       for (way = 0; way < ways; way++)
> +               l2x0_flush_way(way, len, lines);
> +}
> +#endif
>
>  static void l2x0_clean_all(void)
>  {
>
>
> --
>                                                                 Gilles.



-- 
atp

