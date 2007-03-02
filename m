Message-ID: <45E838E3.80506@domain.hid>
Date: Fri, 02 Mar 2007 15:46:59 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] problems installing peak CAN dongle
References: <bc4264770703020023o4e15cdafh6e254fff4b225e8a@domain.hid>	<45E7E49C.2000005@domain.hid>	<bc4264770703020123s28450a37n60bb1e49798f32b8@domain.hid>	<45E7F453.9090803@domain.hid>	<bc4264770703020228p4d01b96co85731b9657fce7b6@domain.hid>	<45E7FFA6.3060405@domain.hid>	<bc4264770703020250q3ead4769kb2cbcc67d130dc3f@domain.hid>	<bc4264770703020252i8856466i80dfc882b9ad3ce2@domain.hid>	<45E808C7.4010101@domain.hid>
	<45E80CDB.1040504@domain.hid>	<45E82460.1030809@domain.hid>
	<45E82887.8090809@domain.hid> <45E837AC.1060609@domain.hid>
In-Reply-To: <45E837AC.1060609@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
Cc: Xenomai-help@domain.hid

Wolfgang Grandegger wrote:
> Roland Tollenaar wrote:
>>>
>>> Inspect /proc/rtcan or watch the log messages.
>>>
>>>> Then I presume I will send a message on 1 and then see it appear on 
>>>> the rtcanrecv rtcan1 ?
>>>
>>> Yes, but with rtcan2.
>> Does this not depend on the outcome of the earlier inspection of 
>> /proc/rtcan or is rtcan2 an educated guess? To clarify: I will be 
>> sending and recieving on rtcan2 in loopback mode in order to test?
> 
> The virtual can driver will install two devices. Have you seen something 
> different? If you then load xeno_can_peak_dng... The devices will be 
> named according to order they are installation, of course.

FYI, I just committed the following changes to the trunk:

2007-03-02  Wolfgang Grandegger  <wg@domain.hid>

         * include/rtdm/rtcan.h: Document CAN controller modes and remove
         definition of SIOCGIFINDEX to avoid potential conflicts with the
         corresponding definition in kernel header files.

         * ksrc/drivers/can/sja1000/rtcan_peak_dng.c: add plug-n-play
         support to ensure that the parallel port device is powered on
         and do proper cleanup.

Wolfgang.

