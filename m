Message-ID: <4CB3857C.30303@domain.hid>
Date: Mon, 11 Oct 2010 23:45:32 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTi=6d4sZN11G0TfDXZPfwS8dDkhgE=LjnGcS4AG1@domain.hid>
	<AANLkTinrw0yUPApypmaN4L+Auv4WtE+BRJr-wkDjiAE-@domain.hid>
	<4CB36116.8090507@domain.hid>
	<201010112309.22031.kisda@domain.hid>
In-Reply-To: <201010112309.22031.kisda@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai and PEAK can bus card problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Stefan Kisdaroczi <kisda@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

Stefan Kisdaroczi wrote:
> Am Montag 11 Oktober 2010, 21:10:14 schrieb Gilles Chanteperdrix:
>> Peter Pastor wrote:
>>> Hey Gilles,
>>>
>>> Thanks for the hint. I "fixed" this problem by loading the nvidia driver
>>> (instead of nv) as default. Now the graphic cards uses IRQ 24 which does
>>> not collide with IRQ 11 of the CAN bus card (see attached lspci.txt).
>>>
>>> The only other device that uses IRQ 11 is
>>> # 00:00.0 Host bridge [0600]: Intel Corporation 5520 I/O Hub to ESI Port
>>> [8086:3406] (rev 13)
>>>
>>> But I guess that is ok, is it ? I checked the FAQs and went through the
>>> list but I feel I can't do much. I will try a few things and disable
>>> everything that is unneeded. The FAQ list also suggests to enable
>>> CONFIG_PCI_MSI which is disabled right now. What would now be a
>>> reasonable thing to do ?
>> Keep PCI_MSI disabled. The FAQ is wrong and should be fixed.
> 
> Hi Gilles and Jan,
> 
> what is wrong with PCI_MSI? In late june there was a discussion on this list 
> about irq-sharing [1]. Jan's statement at the end of the discussion:
>> The better news is that modern hardware now more and more provides MSI,
>> and that's an inherently unshared IRQ source.
> 
> We consider ordering custom built pcie boards (msi) to solve the irq-sharing 
> problem i have with my pci board. Bad idea ?
> 
> Stefan
> 
> [1] https://mail.gna.org/public/xenomai-help/2010-06/msg00194.html

The patch Adeos as-is does not support MSI. See the thread here:
https://mail.gna.org/public/adeos-main/2008-08/threads.html

-- 
                                                                Gilles.

