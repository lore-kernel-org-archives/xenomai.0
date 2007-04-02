Message-ID: <46112DB7.9090200@domain.hid>
Date: Mon, 02 Apr 2007 18:22:15 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: RT-Socket-CAN bus error rate and latencies
References: <46002EE0.9040406@domain.hid>	<460167F8.50703@domain.hid>	<46017CA7.2080801@domain.hid>	<4601958C.90502@domain.hid>	<4601A6E4.9020908@domain.hid>	<46023991.4020301@domain.hid>	<46036D32.7000603@domain.hid>	<46036F22.60709@domain.hid>	<46039128.90609@domain.hid>	<4603950D.9040801@domain.hid>
	<460510D8.2010205@domain.hid> <460529D2.7020406@domain.hid>
In-Reply-To: <460529D2.7020406@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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
Cc: socketcan-core@domain.hid, Oliver Hartkopp <socketcan@domain.hid>, xenomai-core <xenomai@xenomai.org>

Hello,

Jan Kiszka wrote:
> Wolfgang Grandegger wrote:
>> ...
>> Attached is the patch and it works fine. The key function
>> rtcan_sja_enable_bus_err() is called from sendmsg():
>>
>> void rtcan_sja_enable_bus_err(struct rtcan_device *dev)
>> {
>>     struct rtcan_sja1000 *chip = (struct rtcan_sja1000 *)dev->priv;
>>
>>     if (chip->bus_err_on < 2) {
>>     if (chip->bus_err_on < 1)
>>         chip->read_reg(dev, SJA_ECC);
>>     chip->bus_err_on = 2;
>>     }
>> }
>>
>> And I do also do not see a real problem with multiple readers. I would
>> commit this solution. I'm just unsure if we should select it silently or
>> if the user should have the choice.
> 
> I would say no to user-selectability unless someone comes up with a
> serious downside of this approach.
> 
> Are there any other error interrupt sources we should treat the same
> way? Or all? Just to make the behaviour as regular as reasonable. I have
> no opinion yet, I only want to make sure we have considered this as well
> before we set the change API in stone.
> 
> Nice work!

OK, I have just commited the following changes:

2007-04-02  Wolfgang Grandegger  <wg@domain.hid>

  * ksrc/drivers/can/*: The option CONFIG_XENO_DRIVERS_CAN_BUS_ERR now
    enables bus error interrupts when an application is calling a receive
    function on a socket listening on bus errors. After one bus error has
    occured, the interrupt will be disabled to allow the application time
    for error processing and to efficiently avoid bus error interrupt
    flooding. This option is automatically selected for CAN controllers
    supporting bus error interrupts like the SJA1000.

  * include/rtdm/rtcan.h: Add some doc on bus-off and bus-error error
    conditions and the restart policy.

  * src/utils/can/rtcanconfig.c: Controller mode settings and doc
    has been corrected.

Wolfgang.

