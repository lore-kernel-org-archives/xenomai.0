References: <266d7c1efc534a3284787e54599e952b@ocnapvsw3301.ocr.priv>
 <11364_1515604182_5A5648D6_11364_10471_1_CALLqZ8S5LHPi+5qAGfiCVQOyAnK+bTjhK2Mxt1vqQei6jbfq_A@mail.gmail.com>
 <b9e65123fdf64354b661e1d2532e0cd2@ocnapvsw3301.ocr.priv>
From: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
Message-ID: <895b0fd2-5bbf-16f6-c6f3-78cf60d7d394@alaxarxa.net>
Date: Thu, 11 Jan 2018 10:13:12 +0100
MIME-Version: 1.0
In-Reply-To: <b9e65123fdf64354b661e1d2532e0cd2@ocnapvsw3301.ocr.priv>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] R: Xenomai 3.0.6 - ipipe-3.18.20 - kernel build error
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Fazio Maurizio <maurizio.fazio@leonardocompany.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Two work workarrounds:

1) Disable in you kernel config CONFIG_IA32_EMULATION


2) apply this:


https://git.xenomai.org/xenomai-3.git/commit/?id=cc283c7f26c1b097b94a61bb25c2564f51daf16d

Leopold

On 11/01/18 10:00, Fazio Maurizio wrote:
> Yes, I'm building for x86_64...
> I patched the kernel using the prepare-kernel script:
>>>  ./prepare-kernel.sh --linux=/home/ams/linuxsrc/linux-3.18.20-xenomai
>>> --ipipe=ipipe-core-3.18.20-x86-9.patch --arch=x86
> 
> Then I build the kernel using the  "make rpm" command under the kernel tree... then (if all operations are completed) I install the just generated rpm files... in this case the operation fails during the kernel building...
> 
> I attached the kernel config file...
> 
> Thanks in advance
> 
> Maurizio Fazio
> 
> Chief Technical Office / Aircraft Systems Software Engineer
> 
> 
> 
> Leonardo S.p.A.
> C.so Francia, 426 - Torino - 10146 - Italy Tel. +39 011 756 3308 / 3761
> 
> maurizio.fazio@leonardocompany.com
> www.leonardocompany.com
> 
> ————————————————————————————————–——————
> HELICOPTERS/AERONAUTICS/ELECTRONICS, DEFENCE & SECURITY SYSTEMS/SPACE ————————————————————————————————–——————
> 
> 
> 
> Company General Use
> 
> 
> Il presente messaggio e-mail e ogni suo allegato devono intendersi indirizzati esclusivamente al destinatario indicato e considerarsi dal contenuto strettamente riservato e confidenziale. Se non siete l'effettivo destinatario o avete ricevuto il messaggio e-mail per errore, siete pregati di avvertire immediatamente il mittente e di cancellare il suddetto messaggio e ogni suo allegato dal vostro sistema informatico. Qualsiasi utilizzo, diffusione, copia o archiviazione del presente messaggio da parte di chi non ne è il destinatario è strettamente proibito e può dar luogo a responsabilità di carattere civile e penale punibili ai sensi di legge.
> Questa e-mail ha valore legale solo se firmata digitalmente ai sensi della normativa vigente.
> 
> The contents of this email message and any attachments are intended solely for the addressee(s) and contain confidential and/or privileged information.
> If you are not the intended recipient of this message, or if this message has been addressed to you in error, please immediately notify the sender and then delete this message and any attachments from your system. If you are not the intended recipient, you are hereby notified that any use, dissemination, copying, or storage of this message or its attachments is strictly prohibited. Unauthorized disclosure and/or use of information contained in this email message may result in civil and criminal liability. “
> This e-mail has legal value according to the applicable laws only if it is digitally signed by the sender
> -----Messaggio originale-----
> Da: Greg Gallagher [mailto:greg@embeddedgreg.com]
> Inviato: mercoledì 10 gennaio 2018 18:10
> A: Fazio Maurizio
> Cc: xenomai@xenomai.org
> Oggetto: Re: [Xenomai] Xenomai 3.0.6 - ipipe-3.18.20 - kernel build error
> 
> Hi,
>   Can you post more information on how you are building the patched kernel?  I'm assuming you are building for x86_64?
> 
> Thanks
> 
> Greg
> 
> On Wed, Jan 10, 2018 at 11:16 AM, Fazio Maurizio <maurizio.fazio@leonardocompany.com> wrote:
>> Hello,
>> I have some problems in building the 3.18.20 stable kernel patched
>> with Xenomai 3.0.6 - Cobalt - ipipe-core-3.18.20-x86-9.patch The installed operating system is Centos 7. The same kernel patched using Xenomai 3.0.5 and the same ipipe patch works without any problems.
>>
>> The following lines are the errors during the kernel building
>>
>> In file included from kernel/xenomai/bufd.c:23:0:
>> arch/x86/xenomai/include/asm/xenomai/syscall.h: In function ‘__xn_get_syscall_n’:
>> arch/x86/xenomai/include/asm/xenomai/syscall.h:60:2: error: implicit
>> declaration of function ‘__COBALT_CALL32_SYSNR’
>> [-Werror=implicit-function-declaration]
>>  return __xn_syscall_p(regs) ? __xn_syscall(regs)
>>
>> In file included from arch/x86/xenomai/machine.c:22:0:
>> arch/x86/xenomai/include/asm/xenomai/syscall.h: In function ‘__xn_get_syscall_n’:
>> arch/x86/xenomai/include/asm/xenomai/syscall.h:60:2: error: implicit
>> declaration of function ‘__COBALT_CALL32_SYSNR’
>> [-Werror=implicit-function-declaration]
>>  return __xn_syscall_p(regs) ? __xn_syscall(regs)
>>
>> The only difference is the new release of Xenomai 3.0.6 instead of the older 3.0.5 version...
>>
>> Thanks in advance
>>
>> Maurizio Fazio
>>
>> Chief Technical Office / Aircraft Systems Software Engineer
>>
>>
>>
>> Leonardo S.p.A.
>> C.so Francia, 426 - Torino - 10146 - Italy
>> Tel. +39 011 756 3308 / 3761
>>
>> maurizio.fazio@leonardocompany.com
>> www.leonardocompany.com
>>
>> ————————————————————————————————–——————
>> HELICOPTERS/AERONAUTICS/ELECTRONICS, DEFENCE & SECURITY SYSTEMS/SPACE
>> ————————————————————————————————–——————
>>
>>
>>
>> Il presente messaggio e-mail e ogni suo allegato devono intendersi indirizzati esclusivamente al destinatario indicato e considerarsi dal contenuto strettamente riservato e confidenziale. Se non siete l'effettivo destinatario o avete ricevuto il messaggio e-mail per errore, siete pregati di avvertire immediatamente il mittente e di cancellare il suddetto messaggio e ogni suo allegato dal vostro sistema informatico. Qualsiasi utilizzo, diffusione, copia o archiviazione del presente messaggio da parte di chi non ne è il destinatario è strettamente proibito e può dar luogo a responsabilità di carattere civile e penale punibili ai sensi di legge.
>> Questa e-mail ha valore legale solo se firmata digitalmente ai sensi della normativa vigente.
>>
>> The contents of this email message and any attachments are intended solely for the addressee(s) and contain confidential and/or privileged information.
>> If you are not the intended recipient of this message, or if this message has been addressed to you in error, please immediately notify the sender and then delete this message and any attachments from your system. If you are not the intended recipient, you are hereby notified that any use, dissemination, copying, or storage of this message or its attachments is strictly prohibited. Unauthorized disclosure and/or use of information contained in this email message may result in civil and criminal liability. “
>> This e-mail has legal value according to the applicable laws only if it is digitally signed by the sender
>> _______________________________________________
>> Xenomai mailing list
>> Xenomai@xenomai.org
>> https://xenomai.org/mailman/listinfo/xenomai
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: config-3.18.20
> Type: application/octet-stream
> Size: 138948 bytes
> Desc: config-3.18.20
> URL: <http://xenomai.org/pipermail/xenomai/attachments/20180111/d766d129/attachment.obj>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai
> 


-- 
--
Linux User 152692     GPG: 05F4A7A949A2D9AA
Catalonia
-------------------------------------
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

