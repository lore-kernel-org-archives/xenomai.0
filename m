Message-ID: <47CFD700.5070001@domain.hid>
Date: Thu, 06 Mar 2008 12:35:28 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <Pine.LNX.4.64.0803041734290.26008@domain.hid>	<47CE8544.9070800@domain.hid>	<Pine.LNX.4.64.0803051337420.394@domain.hid>	<47CE9A92.10206@domain.hid>
	<Pine.LNX.4.64.0803051410580.394@domain.hid>
	<47CEA5FD.4080202@domain.hid>
In-Reply-To: <47CEA5FD.4080202@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Shared IRQ issue with Xeno Peak PCI CAN driver
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
> Klaas Gadeyne wrote:
>> --- rtcan_sja1000.c     (revision 3533)
>> +++ rtcan_sja1000.c     (working copy)
>> @@ -765,7 +765,7 @@
>>       if (ret) {
>>          printk(KERN_ERR "ERROR %d: IRQ %d is %s!\n",
>>                 ret, chip->irq_num, ret == -EBUSY ?
>> -              "busy, check shared interrupt support" : "invalid");
>> +              "busy. If you have a card with > 1 channel, check if CONFIG_XENO_OPT_SHIRQ* is set" : "invalid");
>>          return ret;
>>       }
>>
>> Not kernel coding style, I know :-)
> 
> #ifndef CONFIG_XENO_OPT_SHIRQ
> 	printk("Enable CONFIG_XENO_OPT_SHIRQ")
> ?

No. In the past the config name changed with 2.4 and that was the main
reason to remove it from the driver. I'm going to update the description
and error messages as suggested by Klaas, but avoiding the config name.

Thanks,

Wolfgang.

