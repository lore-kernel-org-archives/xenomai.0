Message-ID: <4D88D66F.6020605@domain.hid>
Date: Tue, 22 Mar 2011 18:03:43 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <COL122-W1001B88CC08016B1C1774EBDCE0@domain.hid>
	<4D80BA8B.7050803@domain.hid>, <4D81C6AD.8050803@domain.hid>
	<COL122-W637BE46C7D8B2CB7F79760BDB50@domain.hid>,
	<4D88925C.3040609@domain.hid>
	<COL122-W1673FD60DDA60D713554EBDB40@domain.hid>
	<4D88D39D.907@domain.hid>
In-Reply-To: <4D88D39D.907@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] MSI support in Xenomai
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Jan Kiszka wrote:
> On 2011-03-22 16:55, krishna m wrote:

>> Mar 22 21:12:47 localhost kernel: test_dev: Probe for device function=0
>> Mar 22 21:12:47 localhost kernel: test_dev 0000:15:00.0: found PCI INT A -> IRQ 10
> 
> Here you get IRQ 10...
> 
>> Mar 22 21:12:47 localhost kernel: pci_bar = 0xfe000000
>> Mar 22 21:12:47 localhost kernel: Xenomai: RTDM: RT open handler is deprecated, 
>> driver requires update.
>> Mar 22 21:12:47 localhost kernel: Xenomai: RTDM: RT close handler is deprecated, 
>> driver requires update.
> 
> [ These messages also have a meaning, though unrelated to the crash. ]
> 
>> Mar 22 21:12:47 localhost kernel: test_dev: IRQ 16 successfully assigned to the 
>> device.
> 
> ...but here IRQ 16 is assigned. Broken output or a real inconsistency?
> 
> Also, where is the MSI? You should see log messages about MSI/MSI-X IRQ
> number assignment when properly enabling the support at PCI level.

Maybe pci_enable_msi was called after request_irq ?


-- 
					    Gilles.

