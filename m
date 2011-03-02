Message-ID: <4D6E8A06.9060508@domain.hid>
Date: Wed, 02 Mar 2011 19:18:46 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20110302151603.GA14557@domain.hid>
	<4D6E61B6.906@domain.hid>
In-Reply-To: <4D6E61B6.906@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Stuck MSI in normal Linux driver
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Richard Cochran <richardcochran@domain.hid>
Cc: xenomai@xenomai.org

On 2011-03-02 16:26, Gilles Chanteperdrix wrote:
> Richard Cochran wrote:
>> I am running Xenomai 2.5 git master on a P2020 with kernel 2.6.36.
>>
>> We have a custom PCIe card that raise a MSI, with a normal (not rtdm)
>> driver. It appears that the interrupt comes just once and then is
>> stuck. It work under plain Linux, but I cannot rule out a HW timing
>> bug either.
>>
>> The wiki pages 
>>
>>    http://www.xenomai.org/index.php/FAQs
>>    http://www.xenomai.org/index.php/Configuring_x86_kernels
>>
>> say not to enable MSI on x86, with a link to a very old (2008)
>> discussion. I found a newer mail
>>
>>    https://mail.gna.org/public/xenomai-help/2010-01/msg00095.html
>>
>> claiming that MSI is okay.
> 
> No. This is my fault. I simply had forgotten that MSI were not OK on x86.
> 
>>
>> Is there a known problem with MSI and Xenomai?
> 
> There is a known problem with MSI on x86 (explained by the FAQ link).
> 
>>
>> If so, where/how can I start to get working on fixing it?
>>
>> (I don't need the MSI in a rtdm or adeos context.)
> 
> Given that the problem is that the interrupt controller ack/mask
> functions (if I recall correctly) need, on x86, to use some Linux
> primitives which can not be called from Xenomai domain, I am not sure it
> is easy to fix. And the fact that you do not need the MSI in Xenomai
> domain does not change anything, since ack/mask routines are called
> ahead of the pipeline anyway.

The current situation looks like this:
 - MSI[-X] usage for plain Linux drivers is fine, we are using it on
   machines where you can hardly avoid MSI today
 - MSI[-X] usage for RTDM (ie. RT) drivers is basically fine as long as
   you avoid enabling/disabling from RT context (also used for quite
   a while here, no known issues under this restriction)

Fixing that enabling/disabling (i.e. mask/unmask) is indeed tricky for
classic MSI as we can't rely on direct hardware (too slow). It's easier
for MSI-X - as long as the addressed device is not delaying the mask
operation in firmware or wherever (seen only with MSI devices so far,
but might be possible with MSI-X as well).

Note that much of this is arch independent, only the PCI config space
access method required for classic MSI may vary (likely positively).

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

