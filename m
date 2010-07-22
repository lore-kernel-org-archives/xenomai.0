Message-ID: <4C4823DC.4050500@domain.hid>
Date: Thu, 22 Jul 2010 12:56:28 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTilWSsSuCKRxQg0NIkeeR28eqpdJfaVm_CiemnqF@mail.gmail.com>	<4C46D49F.6030102@domain.hid>	<AANLkTikJgzkkxQyM8DQqVz17ovJmPiIkdZMIFJImExIE@mail.gmail.com>	<4C46F0D9.4030906@domain.hid>	<AANLkTilP98GMfCx1rcgWto9eBmnDwtuavBteD8inFM6V@mail.gmail.com>	<4C47F932.3060400@domain.hid>
	<AANLkTilP1f217jN3krm_Cdqu4LaYwpUMu6mMnLiUJq2f@domain.hid>
In-Reply-To: <AANLkTilP1f217jN3krm_Cdqu4LaYwpUMu6mMnLiUJq2f@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Unexpected preemption of highest priority thread
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Stephen Bryant <sbxenomai@domain.hid>
Cc: xenomai@xenomai.org

Stephen Bryant wrote:
> On 22 July 2010 08:54, Gilles Chanteperdrix <
> gilles.chanteperdrix@xenomai.org> wrote:
> 
>> Stephen Bryant wrote:
>>> On 21 July 2010 14:06, Gilles Chanteperdrix
>>> <gilles.chanteperdrix@xenomai.org
>>> <mailto:gilles.chanteperdrix@xenomai.org>> wrote:
>>>
>>>     Stephen Bryant wrote:
>>>     > I've had a look at dmesg, but cannot find any references to SMI -
>> what
>>>     > should I be looking for?
>>>
>>>     What is described in the TROUBLESHOOTING file.
>>>
>>>
>>> I have tried disabling the SMI workaround, ensuring that SMI detection
>>> is not disabled, and logging the kernel output (setting the kernel log
>>> level to 8 in grub and sending the output to the serial port to be
>>> picked up by another machine). The troubleshooting file states that I
>>> should see "Xenomai: Intel chipset found and SMI workaround not
>>> enabled, you may encounter high interrupt latencies." in this output,
>>> however this does not occur - I am using an Intel Core 2 Duo but with
>>> SMP disabled, if this has any relevance.
>> The SMI detection/workaround is based on the chipset you have. If your
>> chipset is an ICH10, Stefan posted a patch a few days ago. If it is
>> another one, then please send us the result of lspci -vv on your target.
>>
> 
> It seems to be ICH8, so the result is attached,

Please try with the following patch:

diff --git a/ksrc/arch/x86/smi.c b/ksrc/arch/x86/smi.c
index 2116899..a547e88 100644
--- a/ksrc/arch/x86/smi.c
+++ b/ksrc/arch/x86/smi.c
@@ -48,6 +48,7 @@ static struct pci_device_id rthal_smi_pci_tbl[] = {
        {PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_2)},
        {PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH7_0)},
        {PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH7_1)},
+       {PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH8_0)},
        {PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH8_4)},
        {0,},
 };


-- 
					    Gilles.

