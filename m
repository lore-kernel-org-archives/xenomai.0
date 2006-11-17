Message-ID: <455D7FCE.5050209@domain.hid>
Date: Fri, 17 Nov 2006 10:24:30 +0100
From: Dirk Eibach <eibach@domain.hid>
MIME-Version: 1.0
References: <455D6F83.40008@domain.hid>
In-Reply-To: <455D6F83.40008@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: [Xenomai-help] Draft  for a RTDM I2C driver
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
>> Hello,
>>
>> I have spent some time designing a RTDM I2C driver based on the linux
>> i2c driver. It's stripped down in some aspects but porting existing
>> clients and adapters should be fairly easy.
>> For this draft I have ported the IBM PPC4xx driver, because that is what
>> I have here for testing.
>>
>> It's my first RTDM project, so I hope I haven't messed things up too much.
>>
>> Any comments welcome!
>>
> 
> Great! I almost forgot this topic as it was quiet after my reply, but
> now we even have code to discuss.

It took some time for me to understand the RTDM concepts and to 
understand what the i2c linux driver is doing.

> Before I start looking into implementation details, it would be nice if
> you could sketch the basic idea of your API proposal and the typical use
> cases. Code is more explicit, I know, but it's also a bit more tricky to
> grab an overview from it. Do you also have some simple demo to show how
> one should use your interface?

> What I grabbed so far:
>  - for each I2C interface, a RTDM device is registered
>  - rti2c-api.h is ought to become the RTDM I2C device profile
>  - we have read/write and a bunch of IOCTLs as API

Here is a typical usecase:

   int fd;

   //open a instance of the RTDM device
   fd = rt_dev_open( "rti2cppc4xx", 0);

   // set the address of the device on the bus
   rt_dev_ioctl(fd, RTI2C_SLAVE, addr);

   // write a value to register of the addressed device
   rti2c_smbus_write_byte_data(fd, register, value);

   rt_dev_close(fd);


Many common i2c usecases are packed in inline functions in rti2c-api.h 
so you don't need to fiddle with IOCTLs that much.

> What I didn't grabbed:
>  - is transfer synchronous or asynchronous?
>  - can applications access an adapter concurrently?
>  - what are the major differences to the Linux model?

The interface is synchronous (just like its linux pendant). Applications 
can access an adapter concurrently, access is serialized in 
rti2-core.c/rti2c_smbus_xfer by a (per adapter) mutex.

The linux implementation has not only the device driver interface but 
also a kernel-api. There is a i2c_driver concept, that enables you to 
provide device drivers for i2c (client-)devices as kernel modules. I 
left out this concept because I thought it does not fit the RTDM concept.
Further I left out all the sysfs stuff.

> I'm looking forward to see some nice generic RTI2C in Xenomai soon(er or
> later)!

Me too :)

> Jan

Dirk




