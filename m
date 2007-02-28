Message-ID: <45E58849.6030605@domain.hid>
Date: Wed, 28 Feb 2007 14:48:57 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] CAN question
References: <bc4264770702270848t6a65ec84nb72f9df20a52ba8f@domain.hid>		<45E46D5C.8040001@domain.hid>	<bc4264770702271434x6efb5955sd75768a39f14c187@domain.hid>	<45E53578.5080204@domain.hid>
	<45E57FC7.8050404@domain.hid> <45E582D5.8010800@domain.hid>
In-Reply-To: <45E582D5.8010800@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> Roland Tollenaar wrote:
>> Hi Jan,
>>
>>> Err? What are practical cases for you?
>>>
>>> Both modes are _debugging_ features.
>> Huh? There only seem to be two flavours. Listen_only or loopback. Are
>> you saying that for normal operation it does not matter at all what the
>> setting is? I.e. don't even have to bother setting the parameter?
>>
> 
> Check the documentation of SIOCSCANCTRLMODE. It should clearly state
> that those are modes can be activated additionally and independently.
> Also check what happens in the existing rtcanconfig code, it underlines
> this.
> 
> If you find an even better way to express this in the doc: patches are
> welcome.

I'm going to update the doc as follows:

/*!
  * @anchor CAN_CTRLMODE @name CAN controller modes
  * Special CAN controllers modes, which can be or'ed together.
  *
  * @note These modes are hardware-dependent. Please consult the hardware
  * manual of the CAN controller for more detailed information.
  *
  * @{ */

/*! Listen-Only mode
  *
  *  In this mode the CAN controller would give no acknowledge to the
  *  CAN-bus, even if a message is received successfully and messages
  * would not be transmitted. This mode might be useful for
  * bus-monitoring, hot-plugging or throughput analysis. */
#define CAN_CTRLMODE_LISTENONLY 0x1

/*! Loopback mode
  *
  * In this mode the CAN controller does an internal loop-back, a message
  * is transmitted and simultaneously received. That mode can be used for
  * self test operation. */
#define CAN_CTRLMODE_LOOPBACK   0x2

Hope it's clearer now. For the moment, just don't care about special 
features.

Wolfgang.


