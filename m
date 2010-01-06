Sender: Alexis Berlemont <alexis.berlemont@domain.hid>
Message-ID: <4B450B7E.80106@domain.hid>
Date: Wed, 06 Jan 2010 23:15:26 +0100
From: Alexis Berlemont <berlemont.hauw@domain.hid>
MIME-Version: 1.0
References: <4bed572e0911221135s64fc4726x1cd7235f116e11a4@domain.hid>	
	<4B12FD90.30804@domain.hid>	
	<4bed572e0911300041k5bb51bf6nbe83b2a9233d76b0@domain.hid>	
	<4B16F674.5090200@domain.hid>	
	<4bed572e0912150741l37bea514t773c71f645fbeba5@domain.hid>	
	<4B28208B.7000305@domain.hid>	
	<4bed572e0912160458i32834958q9512476f1603979d@domain.hid>	
	<4B2BF4D9.6000503@domain.hid>	
	<4bed572e1001051015l21e71e8eyaec207701c2e21ad@domain.hid>	
	<4B43BE72.6040101@domain.hid>
	<4bed572e1001060557x12ffd808k193573c565830a1b@domain.hid>
In-Reply-To: <4bed572e1001060557x12ffd808k193573c565830a1b@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Help on analogy_ni_pcimio (Alexis Berlemont?)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Ettore Pedretti <ep41@domain.hid>
Cc: xenomai@xenomai.org

Ettore Pedretti wrote:
> Hi,
> 
> There was no option in menuconfig for enabling
> CONFIG_XENO_DRIVERS_ANALOGY_DEBUG_LEVEL=1
> CONFIG_XENO_DRIVERS_ANALOGY_DRIVER_DEBUG_LEVEL=1
That's weird. There must be a bug somewhere. Could you send me your last
.config file?
> 
> I edited .config manually and that worked (I hope).
> 
> Error trace attached. I hope this will narrow-down the problem
Thank you. I think I fixed the bug. I updated my git repository (branch
analogy). Could you test it ?

If you do not want to bother with git. Here is the patch:

diff --git a/ksrc/drivers/analogy/national_instruments/mio_common.c 
b/ksrc/drive
index c722384..db9762a 100644
--- a/ksrc/drivers/analogy/national_instruments/mio_common.c
+++ b/ksrc/drivers/analogy/national_instruments/mio_common.c
@@ -3732,9 +3732,14 @@ void mio_common_detach(a4l_dev_t * dev)

  static void init_ao_67xx(a4l_dev_t * dev)
  {
-       a4l_subd_t *subd = dev->transfer.subds[NI_AO_SUBDEV];
+       a4l_subd_t *subd = a4l_get_subd(dev, NI_AO_SUBDEV);
         int i;

+       if (subd == NULL) {
+               a4l_err(dev, "%s: unable to find AO subdevice\n", 
__FUNCTION__);
+               return;
+       }
+
         for (i = 0; i < subd->chan_desc->length; i++)
                 ni_ao_win_outw(dev, AO_Channel(i) | 0x0,
                                AO_Configuration_2_67xx);

> 
> Ettore
> 
> 2010/1/5 Alexis Berlemont <berlemont.hauw@domain.hid>:
>> Hi,
>>
>> Ettore Pedretti wrote:
>>> Hi
>>>
>>> I have installed Xenomai 2.5.0 and tried to attach the module:
>>> analogy_config analogy0 analogy_ni_pcimio
>>>
>>> The error trace is attached as a text file
>> I do not see any analogy debug traces. In your kernel configuration,
>> have you configured the following options like this:
>> CONFIG_XENO_DRIVERS_ANALOGY_DEBUG=y
>> CONFIG_XENO_DRIVERS_ANALOGY_DEBUG_LEVEL=1
>> CONFIG_XENO_DRIVERS_ANALOGY_DRIVER_DEBUG_LEVEL=1
>>
>>> Regards
>>> Ettore
>>>
>> Alexis.
>>
> 
> 
> 
Alexis.

