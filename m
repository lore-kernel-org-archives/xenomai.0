Message-ID: <4579CD41.6060102@domain.hid>
Date: Fri, 08 Dec 2006 21:38:25 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] [PATCH] ppc mvme5500
References: <1165537720.4578b1b879da9@domain.hid>
	<45795320.5060806@domain.hid>
	<1165595720.45799448b0adc@domain.hid>
In-Reply-To: <1165595720.45799448b0adc@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: barbalace@domain.hid
Cc: adeos-main@gna.org

Hello,

barbalace@domain.hid wrote:
> ;-) Yes, the problem are the Linux spin_* functions, sincerly I don't understand
> why there are this spin_* functions (maybe for another architecture, different
> from ppc???).
> 'in_le32' and 'out_le32' are substantially atomic, are declared in
> include/asm-ppc/io.h:
> 
> extern inline unsigned in_le32(const volatile unsigned __iomem *addr)
> {
> 	unsigned ret;
> 
> 	__asm__ __volatile__("lwbrx %0,0,%1;\n"
> 			     "twi 0,%0,0;\n"
> 			     "isync" : "=r" (ret) :
> 			     "r" (addr), "m" (*addr));
> 	return ret;
> }
> extern inline void out_le32(volatile unsigned __iomem *addr, int val)
> {
> 	__asm__ __volatile__("stwbrx %1,0,%2; eieio" : "=m" (*addr) :
> 			     "r" (val), "r" (addr));
> }
> 
> The load istruction is lwbrx and the store istruction is stwbrx: one istruction
> = atomic (do you agree?). isync and eieio are synchronization istruction, if
> executed in a second time doesn't change the behaviour.

Yes, but there are these eieio and sync instructions which have to do 
with out of order accesses. To be sure I ask on the linuxppc-embedded ML 
  and the answer is here: 
http://ozlabs.org/pipermail/linuxppc-embedded/2006-December/025456.html

> I test this patch with and without the IPIPE enabled.
>>From my point of view I think is better to remove the spin_* in the ppc arch to
> avoid the spinlock overhead. For a portability issue is better to use a pragma
> #ifdef structure.

Therefore my previous patch should be the right fix. I case it works, 
I'm going to integrate it into the PPC ADEOS IPIPE patches.

Wolfgang.

> Antonio
> 
> 
> Quoting Wolfgang Grandegger <wg@domain.hid>:
> 
>> barbalace@domain.hid wrote:
>>> I'm working on linux 2.6.14 + ipipe + xenomai2.2.0 (refer to thread
>>> https://mail.gna.org/public/xenomai-help/2006-05/msg00082.html, maybe the
>> same
>>> case-study).
>>>
>>> I'm using ipipe patch:
>>>   adeos-ipipe-2.6.14-ppc-1.3-05.patch
>>>
>>> this and next patch I tried, doesn't work and some write on the flash, if
>> you
>>> doesn't protect it again write (with on-board jumpers).
>>>
>>> I make this simple patch (that I past at the end of the mail).
>>> To use it I recommend to:
>>> 1. extract a Vanilla linux kernel
>>> 2. patch it with the Motorola patch (BSP)
>>> 3. patch it with the ipipe patch (adeos-ipipe-2.6.14-ppc-1.3-05.patch)
>>> 4. apply this patch
>>>
>>> I test it only with write protect enable on the MVME5500 board; flash and
>> eeprom
>>> were not writeable, ensure this with a cat on /proc/cpuinfo.
>> Ah, oh, this is another prime example of PIC code requiring a patch,
>> also on PowerPC :-(. The problem are the Linux spin_* functions in
>> include/asm-ppc/mv64x60.h:
>>
>> /* Define I/O routines for accessing registers on the 64x60 bridge. */
>> extern inline void
>> mv64x60_write(struct mv64x60_handle *bh, u32 offset, u32 val) {
>> 	ulong	flags;
>>
>> 	spin_lock_irqsave(&mv64x60_lock, flags);
>> 	out_le32(bh->v_base + offset, val);
>> 	spin_unlock_irqrestore(&mv64x60_lock, flags);
>> }
>>
>> extern inline u32
>> mv64x60_read(struct mv64x60_handle *bh, u32 offset) {
>> 	ulong	flags;
>> 	u32     reg;
>>
>> 	spin_lock_irqsave(&mv64x60_lock, flags);
>> 	reg = in_le32(bh->v_base + offset);
>> 	spin_unlock_irqrestore(&mv64x60_lock, flags);
>> 	return reg;
>> }
>>
>> Why not just iron them with the "spin_*_hw" variants, or remove them
>> completely? That's what your patch does as well. I think the out_le32
>> and in_le32 functions already access the registers atomically. To be
>> save, use "spin_*_hw". Does the attached patch work with and without
>> IPIPE enabled?
>>
>> Thanks for reporting.
>>
>> Wolfgang.
>>
>>> regards,
>>>   Antonio Barbalace
[...]


