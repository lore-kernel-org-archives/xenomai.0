Message-ID: <4D2CE77C.7000109@domain.hid>
Date: Wed, 12 Jan 2011 00:27:56 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <6FCCA913376DD7488F4139A4D11B8F48016311A5@domain.hid>	<4D1FAE66.8080005@domain.hid>	<6FCCA913376DD7488F4139A4D11B8F4801673CAB@troe2k1.cs.myharris.net>	<4D24E3AC.2000904@domain.hid>
	<4D24EB92.3050104@domain.hid>	<4D24F0B7.7010604@domain.hid>	<6FCCA913376DD7488F4139A4D11B8F4801673CD4@domain.hid>
	<4D25C9D6.4030707@domain.hid>
In-Reply-To: <4D25C9D6.4030707@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] [Xenomai -help] User space access to DMA memory
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Herrera-Bendezu, Luis" <lherrera@domain.hid>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> Herrera-Bendezu, Luis wrote:
>> On 01/05/2011 5:29 PM Gilles Chanteperdrix wrote:
>>> Steven A. Falco wrote:
>>>> On 01/05/2011 04:33 PM, Gilles Chanteperdrix wrote:
>>> Ok. Could you try to do the same operation with the native API? You just
>>> have to pass H_SHARED | H_DMA | H_NONCACHED as flags to rt_heap_create
>>> to get the same effect as pci_dma_alloc_coherent.
>>>
>>> Just to see if the error lies in RTDM implementation or in Xenomai
>>> generic code.
>>>
>>>
> (...)
> What about the other thing I asked you to test?
> 

Ping? Any news about this test?

-- 
                                                                Gilles.

