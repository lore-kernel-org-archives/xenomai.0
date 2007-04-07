Message-ID: <46180935.8050703@domain.hid>
Date: Sat, 07 Apr 2007 23:12:21 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: RT-Socket-CAN bus error rate and latencies
References: <46002EE0.9040406@domain.hid>	<460167F8.50703@domain.hid>	<46017CA7.2080801@domain.hid>	<4601958C.90502@domain.hid>	<4601A6E4.9020908@domain.hid>	<46023991.4020301@domain.hid>	<46036D32.7000603@domain.hid>	<46036F22.60709@domain.hid>	<46039128.90609@domain.hid>	<4603950D.9040801@domain.hid>	<460510D8.2010205@domain.hid>
	<460529D2.7020406@domain.hid> <46112DB7.9090200@domain.hid>
	<46180712.2070702@domain.hid>
In-Reply-To: <46180712.2070702@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Wolfgang Grandegger wrote:
>> OK, I have just commited the following changes:
>>
>> 2007-04-02  Wolfgang Grandegger  <wg@domain.hid>
>>
>>   * ksrc/drivers/can/*: The option CONFIG_XENO_DRIVERS_CAN_BUS_ERR now
>>     enables bus error interrupts when an application is calling a receive
>>     function on a socket listening on bus errors. After one bus error has
>>     occured, the interrupt will be disabled to allow the application time
>>     for error processing and to efficiently avoid bus error interrupt
>>     flooding. This option is automatically selected for CAN controllers
>>     supporting bus error interrupts like the SJA1000.
> 
> Just one final nitpicking question: Who's to read the help text of
> CONFIG_XENO_DRIVERS_CAN_BUS_ERR - except people reading Kconfig
> directly? (My point is that this explanation may rather become a code
> comment.)

Good hint. Patch comes soon. At least it's already documented in the API 
doc.

Wolfgang.


