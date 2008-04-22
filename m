Message-ID: <480E26D8.4050903@domain.hid>
Date: Tue, 22 Apr 2008 19:56:40 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <20080423003208.517khmzxw8o484k0@domain.hid>
In-Reply-To: <20080423003208.517khmzxw8o484k0@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] migrate code from xenomai-2.3.0 to xenomai-2.3.4
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Urs Eichholzer <urs.eichholzer@domain.hid>
Cc: xenomai@xenomai.org

Hi Urs,

Urs Eichholzer wrote:
> Hi
> 
> Can I migrate my code from xenomai-2.3.0 to xenomai-2.3.4 without modification
> on the Linux OS kernel core. Is it possible to modify and patch only the whole
> xenomai source not including the Linux kernel.

As there are important bug fixes for ADEOS I-Pipe as well, you are urged
to update your Linux 2.4 kernel. Move to Xenomai 2.3.5 with the
adeos-ipipe-2.4.25-ppc-DENX-1.2-02.patch.

> Urs Eichholzer wrote:
>> Hi
>>
>> We are using Linux 2.6.19.2 and Xenomai 2.3.0
> 
> Xenomai 2.3.0 is quite old and I recommand to  update to 2.3.5., at lreast
> 
>> The problem disapeared when we not changed the baudrate (we try to
>> scan the bus..). What shoult be the time between changing the
>> baudrate?
> 
> Ah, I see. Does the attached patch help?

I'm still curious, did the patch help?

Wolfgang.


>> From: Wolfgang Grandegger [wg@domain.hid]
>> Sent: Wednesday, April 09, 2008 12:19 AM
>> To: Urs Eichholzer
>> Cc: xenomai@xenomai.org
>> Subject: Re: [Xenomai-help] CAN Probleme
>>
>> Hi Urs,
>>
>> Urs Eichholzer wrote:
>>> Hello
>>>
>>> We are just start to use the setup...
>>> We try to read parameters from a device true the CAN. From some
>>> parameters we get proper replay and with other parameters we get the
>>> following message:
>>> rtcan0: btr0=0x05 btr1=0x4f
>>> rtcan0: btr0=0x0a btr1=0x6f
>>> rtcan_mscan_start_xmit: TX buffer not empty
>> Hm, this message is pretty fatal. What version of Linux and Xenomai do
>> you use? What type of parameters do you read when the error message
>> shows up. Can you reproduce the problem with a little example program?
>>
>> Thanks,
>>
>>
>> ----------------------------------------------------------------
>> This message was sent using Samart Web Mail 2005.
>>
>>
> 
> 
> 
> ----------------------------------------------------------------
> This message was sent using Samart Web Mail 2005.
> 
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


