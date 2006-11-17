Message-ID: <455DA508.4050400@domain.hid>
Date: Fri, 17 Nov 2006 13:03:20 +0100
From: Dirk Eibach <eibach@domain.hid>
MIME-Version: 1.0
References: <455D8B23.20600@domain.hid>
In-Reply-To: <455D8B23.20600@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: [Xenomai-help] Draft   for a RTDM I2C driver
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: jan.kiszka@domain.hid
Cc: xenomai-core <xenomai@xenomai.org>

jan.kiszka@domain.hid wrote:
> Dirk Eibach wrote:
>> jan.kiszka@domain.hid wrote:
>>> Dirk Eibach wrote:
>>>> Hello,
>>>>
>>>> I have spent some time designing a RTDM I2C driver based on the linux
>>>> i2c driver. It's stripped down in some aspects but porting existing
>>>> clients and adapters should be fairly easy.
>>>> For this draft I have ported the IBM PPC4xx driver, because that is what
>>>> I have here for testing.
>>>>
>>>> It's my first RTDM project, so I hope I haven't messed things up too
>>>> much.
>>>>
>>>> Any comments welcome!
>>>>
>>> Great! I almost forgot this topic as it was quiet after my reply, but
>>> now we even have code to discuss.
>> It took some time for me to understand the RTDM concepts and to
>> understand what the i2c linux driver is doing.
>>
>>> Before I start looking into implementation details, it would be nice if
>>> you could sketch the basic idea of your API proposal and the typical use
>>> cases. Code is more explicit, I know, but it's also a bit more tricky to
>>> grab an overview from it. Do you also have some simple demo to show how
>>> one should use your interface?
>>> What I grabbed so far:
>>>  - for each I2C interface, a RTDM device is registered
>>>  - rti2c-api.h is ought to become the RTDM I2C device profile
>>>  - we have read/write and a bunch of IOCTLs as API
>> Here is a typical usecase:
>>
>>   int fd;
>>
>>   //open a instance of the RTDM device
>>   fd = rt_dev_open( "rti2cppc4xx", 0);
> 
> I think we should define a more generic naming scheme here to make
> application code easier portable. I guess there can alos be more than
> one I2C controller on some system, right?

At the moment the devicename is defined by the caller of 
rti2c_adapter_register().
When the device is registered a number is assigned to the adapter. Maybe 
the devicename could be made up of some fixed text like "rti2c" followed 
by the number that is assigned to the adapter.

>>   // set the address of the device on the bus
>>   rt_dev_ioctl(fd, RTI2C_SLAVE, addr);
> 
> Is the typical use case to not change the slave address that often,
> rather to use separate device instances for accessing different slaves?
> I'm wondering if a combined address+request command may make sense.
> Maybe even a socket-based protocol device would match as well, maybe
> even better... (needs more thinking, I guess)
> 
> Does Linux expose a similar API via some character devices? Keeping the
> distance to Linux low might be a reason to not go the socket path.

The linux API is exactly the same. I had the same thoughts concerning 
combined commands (address+request) but maybe we could offer such 
commands as wrappers.

>>   // write a value to register of the addressed device
>>   rti2c_smbus_write_byte_data(fd, register, value);
>>
>>   rt_dev_close(fd);
>>
>>
>> Many common i2c usecases are packed in inline functions in rti2c-api.h
>> so you don't need to fiddle with IOCTLs that much.
> 
> Looks nice. A few of those inlines should become library functions,
> though. But that's something to optimise later.

ACK

>>> What I didn't grabbed:
>>>  - is transfer synchronous or asynchronous?
>>>  - can applications access an adapter concurrently?
>>>  - what are the major differences to the Linux model?
>> The interface is synchronous (just like its linux pendant). Applications
>> can access an adapter concurrently, access is serialized in
>> rti2-core.c/rti2c_smbus_xfer by a (per adapter) mutex.
> 
> So the typical path looks like this:
>  1. [depending on data size: allocate temporary buffer]
>  2. acquire interface mutex
>  3. issue request
>  4. pend on reply
> hardware is working...
>  5. completion IRQ arrives and wakes up pending task
>  6. collect request result
>  7. release mutex
>  8. [release buffer]
> 
> A few thoughts on this:
> 
>  - What are typical delays between 4. and 5.? Does it makes sense for
>    short requests to busy-wait (to avoid the scheduler/IRQ overhead)?
>    I've seen that there is some polling path included in the code, but
>    that would break as it calls into Linux.

Oops. I missed that schedule() call. Regarding typical delays I have to 
admit that I have not measured yet, but I would estimate about 500 us 
for the above usecase. What would you estimate the scheduler/IRQ overhead?

>  - Will a request always return? Or does it make sense to establish an
>    (optional) timeout mechanism here?

A timeout mechanism is already there: rti2c_ppc4xx_wait_for_tc() uses 
rtdm_event_timedwait to wait for the interrupt to complete. Certainly 
that is left to the implementation of the adapter.

>  - Buffer allocation for short requests may also happen on the stack, I
>    think.

That is already done. Have a look at the RTI2C_SMBUS IOCTL. Do you think 
it should also be possible to do this in the read/write calls denpending 
on the requested size?

>  - Buffer allocation for large requests may (optionally) happen
>    ahead-of-time via some special IOCTL. This would make a device
>    independent of the current system heap usage/fragmentation.
> 
>  - During concurrent use, the latency of an user is defined by its
>    priority, of course, and the number and lengths of potentially issued
>    request of some lower priority user, right? Is there a way one could
>    intercept a pending request list? Or is this list handled in toto to
>    the hardware? Melts down to "how to manage the bandwidth according to
>    the user's priority".

Concurrent use means that single RTI2C requests are called from 
different tasks. Each request is atomic (and usually quite small). So 
when a low-pri thread does a lot of requests a high-pri thread can get 
inbetween anytime. I think this way bandwidth is already managed properly.

>> The linux implementation has not only the device driver interface but
>> also a kernel-api. There is a i2c_driver concept, that enables you to
>> provide device drivers for i2c (client-)devices as kernel modules. I
>> left out this concept because I thought it does not fit the RTDM concept.
> 
> Actually, this fits very will in the RTDM concept in so far that RTDM
> can provide exactly the same API you defined for user-space also in
> kernel space. It just takes to handle the case "user_info == NULL" where
> no address checks and copy_to/froms are needed. Check other RTDM drivers
> on this.

Got it.

> Moreover, in-kernel drivers could make use of direct invocations of
> RTI2C services, check this service
> 
> http://www.xenomai.org/documentation/trunk/html/api/group__interdrv.html#g99e8509f4c8b404f0d5795b575d4c9cb
> 
> Once you locked the context, you can call into the RTDM device's
> handlers directly with the demux'ing of your current file descriptor.

Are there any examples for this?

>> Further I left out all the sysfs stuff.
> 
> That's ok.
> 
>>> I'm looking forward to see some nice generic RTI2C in Xenomai soon(er or
>>> later)!
>> Me too :)
> 
> My current optimistic feeling is that this could very well become stuff
> for 2.4. Takes to stabilise the API (even if not all parts are
> implemented then), document it like other RTDM profiles (e.g. CAN), and
> iron the implementation. Sounds like a plan, doesn't it? :)

It does.

> Jan

Dirk




