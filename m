Message-ID: <51A0A2CA.3070107@xenomai.org>
Date: Sat, 25 May 2013 13:38:50 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <519D4262.2070206@free.fr>
	<519DC1C1.3020005@xenomai.org>	<51A0924D.6040309@free.fr>
	<51A09F08.9040500@xenomai.org>
In-Reply-To: <51A09F08.9040500@xenomai.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] RTDM for a GPIO line in RT mode
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: CF <cfoissac@free.fr>
Cc: xenomai@xenomai.org

On 05/25/2013 01:22 PM, Gilles Chanteperdrix wrote:

> On 05/25/2013 12:28 PM, CF wrote:
> 
>> Le 23/05/2013 09:14, Gilles Chanteperdrix a écrit :
>>> On 05/23/2013 12:10 AM, CF wrote:
>>>
>>>> Hello,
>>>>
>>>> Despite my munerous reading, i'm locked in how to perform a basic RTDM
>>>> for a simple ppc board.
>>>>
>>>> This is a simple pin level setting. The linux kernel module i developped
>>>> follow theses steps:
>>>> -reading DTS for IOCTL et GPIOCTL base adress registers
>>>> - out_be32(addr, value) at theses register to set line as an output and
>>>> then set the logical level with setbits32(addr, bit) or clrbits32(addr,bit)
>>>>
>>>> Basically, it works but in NRT  ops modes, so i'm unable (or at least i
>>>> lack indication) to do this in RT ops mode (i don't think it is
>>>> important, but i use ioctl to make my changes). I based my work on
>>>> tut01/tut02 drivers, except i end up in using ioctl instead or
>>>> read/write in the RTDM driver.
>>>>
>>>> I guess i still could read the DTS in nrt mode (because it is done at
>>>> rtdm_dev_register() time and won't interfere with RT task), but how can
>>>> i drive the hardware directly in RT op mode ?
>>>
>>> Hi,
>>>
>>> I am not sure I understand the problem you have. If the board you use
>>> uses gpiolib (I do not know if gpiolib is customary on ppc), you simply
>>> have to check that the gpiolib callbacks do not use any Linux services
>>> which can not be called from RT mode (if it uses a spinlock, the usual
>>> method is to turn the spinlock into an I-pipe spinlock, see:
>>> http://www.xenomai.org/index.php/I-pipe-core:ArmPorting#GPIOs_in_real-time_drivers)
>>>
>>> If you are accessing directly the GPIO controller registers, and need a
>>> "read-modify-write" operation, which what you posted seem to suggest,
>>> you probably want to put a spinlock around these operations, but apart
>>> from that, you can do this from an RT driver ioctl callback.
>>>
>>> Regards.
>>>
>>
>> Thank you Gilles, very much.
>>
>> Precisely, my main concern is how to know if i use linux services (in
>> others words, how can i say a function - in my case in_beX() or
>> out_beX() - is RT compatible ?). If you have some documentations about
>> this, thank you :)
> 
> 
> Anything which relies on a Linux critical section (spinlocks, mutex,
> local_irq_save) to ensure some software data coherency can not work when
> in xenomai domain, because the Xenomai domain can interrupt Linux at any
> point including in the middle of a critical section.
> 
> 

So, to answer your question, yes, you can use the in_beX out_beX since
they only perform read/write to mmio registers. The only thing you have
to pay attention to, is to make sure that Linux could not have been
interrupted while writing to the same register, for this you use an
ipipe_spinlock.

-- 
                                                                Gilles.

