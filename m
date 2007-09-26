Message-ID: <46FA3956.7030308@domain.hid>
Date: Wed, 26 Sep 2007 12:49:58 +0200
From: Benjamin ZORES <benjamin.zores@domain.hid>
MIME-Version: 1.0
References: <46F777EE.3060100@domain.hid>	<1190748335.22323.11.camel@domain.hid>	<46FA1B3C.104@domain.hid>
	<46FA1DC7.3040504@domain.hid>
	<46FA1F22.6080602@domain.hid>
	<46FA2804.3060602@domain.hid>
In-Reply-To: <46FA2804.3060602@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Adeos PowerPC patch differences
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Wolfgang Grandegger wrote:
> Benjamin ZORES wrote:
>> Wolfgang Grandegger wrote:
>>> Benjamin ZORES wrote:
>>>> Philippe Gerum wrote:
>>>>> Yes. I have tested 2.6.22-DENX over two Freescale boards, namely 
>>>>> mpc52xx
>>>>> and mpc8548, using this very same setup. Btw, you will need to pick
>>>>> 2.0-01 which landed today in the repo, since I fixed a couple of 
>>>>> issues
>>>>> (one being serious) there.
>>>>>   
>>>> Thanks for the info about 2.0 issue.
>>>>>> And is the DENX patch specific to DENX tree or can it be 
>>>>>> applied/used
>>>>>> from vanilla kernel tree ?
>>>>>>
>>>>>>     
>>>>> It should apply to the vanilla tree without too much fuss, but the
>>>>> reference tree for the I-pipe/powerpc work is the DENX one, AFAIC.
>>>>>
>>>>>   
>>>> FYI, Adeos 2.0 / Xenomai 2.4 works fine on my PowerPC boards too.
>>>> BTW, 2.6.23-rc5 patch does not apply "as it" on -rc7 and -rc8
>>>> (for ppc64 part at least).
>>> Because head_4xx.S has been renamed to head_40x.S in 
>>> arch/powerpc/kernel recently :-(.
>>>
>>> Wolfgang.
>>>
>> No, it was due to changes in code in time.c and process.c iirc.
>
> I applied adeos-ipipe-2.6.23-rc5-powerpc-DENX-2.0-01.patch to the 
> 2.6.23-rc7 version of linux-2.6-denx. Seems you are using the official 
> kernel linux-2.6 tree.
>
Absolutely.
Sorry for not having stated this before.
Anyhow, it's easy to fix.

Ben



