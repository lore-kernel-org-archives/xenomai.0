MIME-Version: 1.0
References: <20210926100716.32080-1-dariobin@libero.it>
 <CALLqZ8SjgvN8zsA22f04-_gj8N_pzSuTaKDiT8ufTHpJ6UDm+Q@mail.gmail.com>
In-Reply-To: <CALLqZ8SjgvN8zsA22f04-_gj8N_pzSuTaKDiT8ufTHpJ6UDm+Q@mail.gmail.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Sun, 3 Oct 2021 20:27:24 -0400
Message-ID: <CALLqZ8RGB8-dd0o54EyMyA=a0BuZdJXTHDE7HDR0YJic+eLn+w@mail.gmail.com>
Subject: Re: [RESEND PATCH] arm: ipipe: omap-gpio: Fix interrupts delivering
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Dario Binacchi <dariobin@libero.it>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

On Sun, Sep 26, 2021 at 7:59 AM Greg Gallagher <greg@embeddedgreg.com>
wrote:

>
>
> On Sun, Sep 26, 2021 at 6:07 AM Dario Binacchi <dariobin@libero.it> wrote=
:
>
>> If you set the irq trigger as edge rising or falling the interrupts are
>> no longer delivered to the upper layers. The gpiokeys driver, for
>> example, no longer detects the change in the state of the pins mapped
>> to the buttons.
>>
>> Fixes: c041e938312b ("arm: ipipe: Fix up the omap-gpio driver to deliver
>> interrupts properly to the pipeline")
>> Signed-off-by: Dario Binacchi <dariobin@libero.it>
>> ---
>>  drivers/gpio/gpio-omap.c | 5 +----
>>  1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
>> index c8192c82d2b1..ae527d65bfc2 100644
>> --- a/drivers/gpio/gpio-omap.c
>> +++ b/drivers/gpio/gpio-omap.c
>> @@ -577,9 +577,6 @@ static int omap_gpio_irq_type(struct irq_data *d,
>> unsigned type)
>>         }
>>         raw_spin_unlock_irqrestore(&bank->lock, flags);
>>
>> -#ifdef CONFIG_IPIPE
>> -       irq_set_handler_locked(d, handle_level_irq);
>> -#else
>>         if (type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_LEVEL_HIGH))
>>                 irq_set_handler_locked(d, handle_level_irq);
>>         else if (type & (IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING))
>> @@ -590,7 +587,7 @@ static int omap_gpio_irq_type(struct irq_data *d,
>> unsigned type)
>>                  * So just use handle_simple_irq.
>>                  */
>>                 irq_set_handler_locked(d, handle_simple_irq);
>> -#endif
>> +
>>         return 0;
>>
>>  error:
>> --
>> 2.17.1
>
>
> Thanks, applying to 5.4 and 4.19. I=E2=80=99ll have a. Updated release th=
is week.
>
> Thanks
>
> Greg
>
>>
>>
>> Applied to master, starting the 4.19 and 5.4 update.

Thanks

-Greg
