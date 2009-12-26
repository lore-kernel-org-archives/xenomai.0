Sender: Alexis Berlemont <alexis.berlemont@domain.hid>
Message-ID: <4B35543D.2000809@domain.hid>
Date: Sat, 26 Dec 2009 01:09:33 +0100
From: Alexis Berlemont <berlemont.hauw@domain.hid>
MIME-Version: 1.0
References: <4B309A29.6030405@domain.hid> <4B316C4B.1030009@domain.hid>
	<4B320DF6.9010506@domain.hid>
In-Reply-To: <4B320DF6.9010506@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Build tests: analogy, blackfin, rtcan and nios2.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

Hi Gilles,

Gilles Chanteperdrix wrote:
> Alexis Berlemont wrote:
>> Hi Gilles,
>>
>> Gilles Chanteperdrix wrote:
>>> Hi,
>>>
>>> Since I started talking about it, I have run build tests fixing a few
>>> things here and there. The current status is this (still at the same
>>> place: http://sisyphus.hd.free.fr/~gilles/bx):
>>>
>>> * analogy: I have tried to disable some parts of analogy when compiling
>>> on machines without CONFIG_PCI, as compiling parts using PCI on a
>>> machine without PCI support, give various levels of warning and even
>>> errors depending on the architecture. Doing this, I stumbled across this
>>> compilation error:
>>> http://sisyphus.hd.free.fr/~gilles/bx/beagle/2.6.28-arm-none-linux-gnueabi-gcc-4.3.3/log.html#1
>>> this is with CONFIG_NI_MIO, but without CONFIG_NI_MITE.
>>>
>>> So, Alex, could you:
>>> - fix that error, if this combination is supposed to make sense
>> Yes it makes sense. I think the MITE is integrated into all PCI boards
>> but the driver should work with the MITE disabled (one day, we could add
>> the ISA boards).
>>> - fix the Kconfig/Makefile so that no PCI code is compiled if CONFIG_PCI
>>> is not set (I tried and do this myself, but better one who knows than
>>> 100 who have to search...). As I said, doing this result in various
>>> levels of success depending on the architecture.
>> Ack. I will fix these problems as quickly as possible.
> 
> Ok. The fix for the second problem would be nice to have soon, as
> analogy breaks the build on blackfin for this reason. If it is of any
> help, you can send me a patch for this fix only which I will apply on my
> side while you are working on other changes.
> 

I modified the common part of the NI driver so that the PCI code can be 
disabled without any compilation issues.

I made a pull request which contains the fixes.

Merry Christmas.

Alexis.

