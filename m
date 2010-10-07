Message-ID: <4CADDF57.4070609@domain.hid>
Date: Thu, 07 Oct 2010 16:55:19 +0200
From: Javier Herrero <jherrero@domain.hid>
MIME-Version: 1.0
References: <4CA8D713.8090900@domain.hid>
	<1286462018.13186.44.camel@domain.hid>
In-Reply-To: <1286462018.13186.44.camel@domain.hid>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Adeos-main] Problem with dm9000 and
	adeos-ipipe-2.6.34-blackfin-1.14-02.patch
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main@gna.org

  Hi, Philippe,

Thank you very much for your answer. I later found that the interrupt 
for the dm9000 was not defined OK in the platform data (it was somehow 
enabled both for rising edge and for high level). Surprisingly, this 
caused no problem without the adeos patch - this is the reason we did 
never caught that error before!

Once this was corrected, the system boots OK and the network works, but 
not OK - after a short while, two dm9000 driver messages 'status check 
fail: 70' appears. These messages indicate a problem in the reading of 
the dm9000 rx buffer. Once a status check of that kind appears, the 
driver disables automatically the dm9000 interrupts.

Since now the system boots, I can easily check /proc/interrupt. I will 
also check with the patch that you suggest, and come back with any news :)

Best regards,

Javier

El 07/10/2010 16:33, Philippe Gerum escribió:
> On Sun, 2010-10-03 at 21:18 +0200, Javier Herrero wrote:
>> Hello,
>>
>> I'm trying adeos on a Blackfin BF532 board with a DM9000 ethernet
>> interface. If ethernet is down (cable disconnected) the system boots and
>> works OK, but as soon as the ethernet cable is plugged, the system
>> apparently hangs. After several seconds, a message  dm9000 dm9000.0:
>> status check fail: 226 appears.
>>
>> I've read a previous post about problems with dm9000 and an ARM
>> processor,
>> https://mail.gna.org/public/xenomai-help/2010-03/msg00147.html but it
>> seems that there was not a response.
>>
>
> dm9000 is probably not the important issue, what makes a difference is
> which kind of IRQ is handled by this device. Knowing about the output
> of /proc/interrupts when the pipeline is disabled would help.
>
> You may want to upgrade to this patch as well:
> http://download.gna.org/adeos/patches/v2.6/blackfin/older/adeos-ipipe-2.6.34-blackfin-1.15-01.patch
>
>
>> Thank you very much. Best regards,
>>
>> Javier
>>
>

-- 
------------------------------------------------------------------------
Javier Herrero                            EMAIL: jherrero@domain.hid
Chief Technology Officer
HV Sistemas S.L.                          PHONE:         +34 949 336 806
Los Charcones, 17                         FAX:           +34 949 336 792
19170 El Casar - Guadalajara - Spain      WEB: http://www.hvsistemas.com


