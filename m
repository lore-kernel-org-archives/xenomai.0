Message-ID: <47225886.3050303@domain.hid>
Date: Fri, 26 Oct 2007 23:13:42 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <47220255.4040309@domain.hid> <472220AD.6080402@domain.hid>
	<472229DF.4060700@domain.hid>
In-Reply-To: <472229DF.4060700@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] clocktest and cyclictest work but irqloop crashes
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "Steven A. Falco" <sfalco@domain.hid>
Cc: xenomai@xenomai.org

Steven A. Falco wrote:
> Hmmm.  IRQ4 is "PCI ExternalCommand Write"?  But I'm not using PCI. 
> Here is the output:
> 
> # ./irqloop
> NULL ->unmask handler, IRQ 4, chip <NULL>

Mgmfff... Ok, regardless of whether the IRQ number is valid or not, it
would be great that Xenomai avoids jumping out of the window like this
when no IC chip descriptor is associated. Will fix, thanks.

> Test mode:    user-space task
> Port type:    serial
> Port address: 0x3f8
> Port IRQ:     4
> 
> Received IRQs:     0
> Acknowledged IRQs: 0
> Xenomai: POSIX: destroyed thread c0f80320
> 
> 
> Philippe Gerum wrote:
>> Steven A. Falco wrote:
>>   
>>> I am testing kernel 2.6.23 ARCH=powerpc with Xenomai 2.4-rc4.  The 
>>> clocktest and cyclictest work perfectly with the uic/spinlock patches.  
>>> However, the irqloop test fails with the Oops shown below.
>>>
>>>     
>>
>> Please try the patch below. It looks like the chip descriptor does not implement
>> any unmask handler, which seems odd. This patch should tell us a bit more about
>> this issue.
>>
>>   


-- 
Philippe.

