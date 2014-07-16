Message-ID: <53C6CC9B.4040009@xenomai.org>
Date: Wed, 16 Jul 2014 15:03:55 -0400
From: Jorge Ramirez Ortiz <jro@xenomai.org>
MIME-Version: 1.0
References: <mailman.653.1404749254.5713.xenomai@xenomai.org>
 <53C3E6CE.2040306@xenomai.org> <53C42ADE.7040204@gmail.com>
 <53C44696.2070906@xenomai.org> <53C44EE9.3040000@xenomai.org>
In-Reply-To: <53C44EE9.3040000@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] sensoray 626 patch  [Re: Xenomai Digest, Vol 27,
	Issue 12]
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wojciech Domski <wojciech.domski@gmail.com>, xenomai@xenomai.org


>>>  Thank you for committing the driver.
>>>  I have access to the Sensoray 626 board and I will test the remarks you have
>>>  proposed. It will take me sometime, however. First of all I would like to test my
>>>  driver with two Sensoray boards. For now, I see that it won't work with more than
>>>  one card. It requires some changes to the attach and probe function. After I
>>>  implement this functionality I will take a look into the interrupt handling 
>>> service.
>>>
>>>  Seizing the opportunity, I would like to ask you a question about handling PCI
>>>  device. When I'm calling pci_register_driver() and I have two exactly the same PCI
>>>  devices will this function call appropriate probe() function two times? If yes,
>>>  then is the probe() function an appropriate place to make list of available 
>>> devices?
>>>
>>>  Wojciech Domski
>>>
>>>  Domski.pl
>>>
>>>  Wojciech.Domski.pl
>>>
>>
>>  invoking pci_register_driver in dev_s626_attach causes the probe interface in the
>>  pci driver to be executed for all the devices of the kind described in the pci id
>>  table; this is probably the reason why you can only register one.
>>
>
> of course, in case it was not clear, you can only register the pci driver once
>
>>  It might be easier to follow the approach in analogy/national_instruments/mite.c


please have a look to the changes I pushed (untested). let me know if it helps with 
your issues.
http://git.xenomai.org/xenomai-jro.git/log/?h=sensoray

[note that this driver is still very much work in progress but I thought you'll need 
it sooner rather than later]

>>
>>  mite_init registers the driver which ends up calling mite_probe which will create a
>>  mite_struct and add it to the list of mite_devices.
>>  Incidentally if you were wondering, this is the reason why if the
>>  pci_register_driver call succeeded the driver can display all the devices in the
>>  system.
>>
>>  the same would need to be done for the s626
>>
>>  on a different note, we are adding a new interface to rtdm to support the busy 
>> loops.
>>  rtdm_busywait_safe(__condition, __busy_delay, __busy_wait)
>>
>>  this should allow you to do things like this
>>
>>  -       while (!MC_TEST(P_MC2, MC2_UPLD_DEBI))
>>  -               rtdm_task_sleep(2000);
>>  +       ret = rtdm_busywait_safe(!MC_TEST(P_MC2, MC2_UPLD_DEBI), BUSY_DELAY,
>>  BUSY_SLEEP);
>>  +       if (ret)
>>  +               __a4l_err( "error waiting");
>>
>>
>

-- 
jro


