Message-ID: <4F034332.3040708@domain.hid>
Date: Tue, 03 Jan 2012 19:04:34 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAL8zT=h3+AYe56fWhbKr3nY8VhYcNjx=sPRe0cak5hvF+aM6yA@mail.gmail.com>
	<4F0341CA.9080101@domain.hid>
In-Reply-To: <4F0341CA.9080101@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Ipipe breaks my MPC8541 board boot
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

On 01/03/2012 06:58 PM, Gilles Chanteperdrix wrote:
> On 01/03/2012 06:49 PM, Jean-Michel Hautbois wrote:
>> cpm2_cascade is dedicated to my board, but has nothing impressive :
>> static void cpm2_cascade(unsigned int irq, struct irq_desc *desc)
>> {
>>          int cascade_irq;
>>
>>          while ((cascade_irq = cpm2_get_irq())>= 0)
>>                  generic_handle_irq(cascade_irq);
>
> Replace generic_handle_irq with ipipe_handle_chained_irq.
>

You have to fixup the eoi handling as well, check how this is done in 
arch/powerpc/platforms/85xx/sbc8560.c.

-- 
Philippe.

