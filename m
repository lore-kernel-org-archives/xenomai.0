Message-ID: <456D608A.4040100@domain.hid>
Date: Wed, 29 Nov 2006 11:27:22 +0100
From: Dirk Eibach <eibach@domain.hid>
MIME-Version: 1.0
References: <456D5C8A.1090007@domain.hid>
In-Reply-To: <456D5C8A.1090007@domain.hid>
Subject: Re: [Xenomai-core] Draft  for a RTDM I2C driver, V2
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
To: jan.kiszka@domain.hid
Cc: xenomai@xenomai.org

jan.kiszka@domain.hid wrote:
> Dirk Eibach wrote:
>> Hello,
>>
>> I did some redesigning on my first draft.
>> - Now we have some kind of profile in include/rti2c.h.
>> - I got rid of some chunks of code that were not really needed.
>> - Linux kernel dependencies have been removed (I hope I catched all of
>> them)
> 
> Will have a look at the code later.
> 
> Did you already consider to integrate it in a local Xenomai tree and
> post patches against SVN head (=> /drivers/i2c, /include/rtdm)? Would
> make it easier to test compilation and doc generation. What is the empty
> algo folder supposed to contain one day?

I have already thought about integrating it in my local Xenomia tree, 
but for my first steps I took the easy way. Probably time has come to 
change this now.
The algo folder should be used for the implementation of common 
algorithms i.e. bit-banging or the PCF8584. Those algorithms are used 
for specific implementations that are placed in the busses folder.

> What would also be nice is a simple demo application. We still have no
> policy were to put such stuff. Maybe we'll take the chance and create an
> examples folder in SVN and/or put code/description into the wiki.

I have a simple demo application ready. Just telle me where to put it.

Dirk




