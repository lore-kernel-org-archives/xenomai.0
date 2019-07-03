From: alessio margan <alessio.margan@iit.it>
Subject: Re: fail clocktest -C CLOCK_HOST_REALTIME
References: <fa7df77f-23f9-4cc2-cc2e-aa1f9d4010bc@iit.it>
 <b2696236-4ba3-c9b0-a22f-9210f83cd163@siemens.com>
Message-ID: <bdab9339-22bb-1da3-8453-e79bfeb204b2@iit.it>
Date: Wed, 3 Jul 2019 20:22:40 +0200
MIME-Version: 1.0
In-Reply-To: <b2696236-4ba3-c9b0-a22f-9210f83cd163@siemens.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

now I have the proper config

(base) embedded@com-exp:/usr/src/linux-4.14.89-xeno-stable-v3.0.x$ cat 
.config | grep HOSTRT
CONFIG_XENO_OPT_HOSTRT=y
CONFIG_IPIPE_HAVE_HOSTRT=y

.. it 's compiling, I let you know

Thanks

Alessio


On 03/07/19 19:26, Jan Kiszka wrote:
> On 03.07.19 18:47, alessio margan via Xenomai wrote:
>> Hi all,
>>
>> I ve updated xenomai and switching from 3.0.6 to 3.0.9 with kernel 
>> 4.14.89
>>
>> clocktest -C CLOCK_HOST_REALTIME
>>
>> fails with this message
>>
>> NVDSO_FEAT_HOST_REALTIME not available
>> clock_gettime failed for clock id 32
>> XNVDSO_FEAT_HOST_REALTIME not available
>>
>>
>> I can not set CONFIG_XENO_OPT_HOSTRT=y in kernel config and seems 
>> that the
>> difference with the config I ve used with 3.0.6 was this.
>>
> Argh... That got lost in the initial x86 ipipe port to 4.14. And, thus,
> it's now also missing in 4.19. Will update both branches. You can try
> this hunk already:
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index b147b5c53af6..8409b9073422 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -147,6 +147,7 @@ config X86
> select HAVE_IRQ_TIME_ACCOUNTING
> select HAVE_IPIPE_SUPPORT if X86_64
> select HAVE_IPIPE_TRACER_SUPPORT
> + select IPIPE_HAVE_HOSTRT if IPIPE
> select IPIPE_HAVE_SAFE_THREAD_INFO if IPIPE
> select IPIPE_WANT_PTE_PINNING if IPIPE
> select IPIPE_HAVE_VM_NOTIFIER if IPIPE
>
> Thanks for reporting!
> Jan
>
-- 

ISTITUTO ITALIANO DI TECNOLOGIA

Alessio Margan
Chief Technician
Advanced Robotics Department

alessio.margan@iit.it
Via Morego 30, 16163 Genova
Tel. +39 010 71781-754

www.iit.it

Legal Disclaimer
This electronic message contains information that is confidential. The information is intended for the use of the addressee only.
If you are not the addressee we would appreciate your notification in this respect.
Please note that any disclosure, copy, distribution or use of the contents of this message is prohibited and may be unlawful.
We have taken every reasonable precaution to ensure that any kind of attachment to this e-mail has been swept for viruses.
However, we cannot accept liability for any damage sustained as a result of software viruses
and would advise you to carry out your own virus checks before opening any attachment.
Avvertenza legale
Questo messaggio Email contiene informazioni confidenziali riservate ai soli destinatari.
Qualora  veniate in possesso di tali informazioni senza essere definito come destinatario vi reghiamo di leggere le seguenti note.
Ogni apertura, copia, distribuzione del contenuto del messaggio e dei suoi allegati è proibito e potrebbe violare le presenti leggi.
Abbiamo attivato ogni possibile e ragionevole precauzione per assicurare che gli allegati non contengano virus.
Comunque non assumeremo alcuna responsabilità per ogni eventuale danno causato da virus software e simili
in quanto è onere del destinatario verificarne l’assenza in ogni allegato attuando propri indipendenti controlli.


