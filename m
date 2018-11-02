Subject: Re: [I-PIPE] ipipe-core-4.14.71-x86-1 released
References: <20181101175938.D29167FB@centrum.cz>
 <33f0bc4d-f8ef-9950-74ac-8b62bca6f015@xenomai.org>
 <20181102142031.712D8BE3@centrum.cz>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <77dbbfd9-f575-b361-45b8-2d299597a0d2@siemens.com>
Date: Fri, 2 Nov 2018 15:49:41 +0100
MIME-Version: 1.0
In-Reply-To: <20181102142031.712D8BE3@centrum.cz>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?Petr_=c4=8cervenka?= <grugh@centrum.cz>, Henning Schild <henning.schild@siemens.com>, Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 02.11.18 14:20, Petr Červenka via Xenomai wrote:
> You are right.
> The errors were because of version 3.0.7. I didn't realize, that prepare-kernel.sh script doesn't only apply the patch. But it also copies part of the xenomai to the kernel.
>   
> Meanwhile I tried the latest git (probably master branch). I got another error (simple to fix) in one of the rtnet drivers:
> drivers/xenomai/net/drivers/e1000e/netdev.c: In function ‘e1000e_set_interrupt_capability’:
> drivers/xenomai/net/drivers/e1000e/netdev.c:1225:11: error: implicit declaration of function ‘pci_enable_msix’; did you mean ‘pci_enable_msi’? [-Werror=implicit-function-declaration]
>       err = pci_enable_msix(adapter->pdev,
>             ^~~~~~~~~~~~~~~
>             pci_enable_msi

Known issue: There is now pci_alloc_irq_vectors only. We need to switch to that 
API and provide backward compatible wrappers for < 4.8. If you do not need this 
driver, disable it for now.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

