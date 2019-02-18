Subject: [rtnet] e1000e/netdev.c deprecated pci_enable_msix
References: <20181101175938.D29167FB@centrum.cz>
 <33f0bc4d-f8ef-9950-74ac-8b62bca6f015@xenomai.org>
 <20181102142031.712D8BE3@centrum.cz>
 <77dbbfd9-f575-b361-45b8-2d299597a0d2@siemens.com>
From: alessio margan <alessio.margan@iit.it>
Message-ID: <5fe69155-3ecd-d8fe-3cfe-93cc6d3bea94@iit.it>
Date: Mon, 18 Feb 2019 14:31:31 +0100
MIME-Version: 1.0
In-Reply-To: <77dbbfd9-f575-b361-45b8-2d299597a0d2@siemens.com>
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
To: xenomai@xenomai.org

Hi all,

when compile the kernel linux-4.14.89-xeno-next I got this error, and I 
need to use the e1000e driver.

I come from a 4.9.51-xeno-3.0.6 and I would like to update xenomai with 
the last changes

For the moment I just comment the call to pci_enable_msix, there are any 
progress for the API switch ?

TIA

Alessio



On 02/11/18 15:49, Jan Kiszka via Xenomai wrote:
> On 02.11.18 14:20, Petr Červenka via Xenomai wrote:
>> You are right.
>> The errors were because of version 3.0.7. I didn't realize, that 
>> prepare-kernel.sh script doesn't only apply the patch. But it also 
>> copies part of the xenomai to the kernel.
>>   Meanwhile I tried the latest git (probably master branch). I got 
>> another error (simple to fix) in one of the rtnet drivers:
>> drivers/xenomai/net/drivers/e1000e/netdev.c: In function 
>> ‘e1000e_set_interrupt_capability’:
>> drivers/xenomai/net/drivers/e1000e/netdev.c:1225:11: error: implicit 
>> declaration of function ‘pci_enable_msix’; did you mean 
>> ‘pci_enable_msi’? [-Werror=implicit-function-declaration]
>>       err = pci_enable_msix(adapter->pdev,
>>             ^~~~~~~~~~~~~~~
>>             pci_enable_msi
>
> Known issue: There is now pci_alloc_irq_vectors only. We need to 
> switch to that API and provide backward compatible wrappers for < 4.8. 
> If you do not need this driver, disable it for now.
>
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


