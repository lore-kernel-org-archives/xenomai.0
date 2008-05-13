Message-ID: <48292E0E.908@domain.hid>
Date: Tue, 13 May 2008 07:58:38 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <4825B31D.1010903@domain.hid>	<4825D0DF.6040005@domain.hid>	<48275F0D.7050900@domain.hid>	<48276DB5.7030706@domain.hid>	<48288892.1020006@domain.hid>	<48288AEF.7060502@domain.hid>
	<48288D31.8020303@domain.hid>	<4828974C.7050701@domain.hid>
	<4828ADF9.5090504@domain.hid>
In-Reply-To: <4828ADF9.5090504@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] [Socketcan-users] RTCAN & RT-Socket CAN
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Breno <breno@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Breno wrote:
> Wolfgang Grandegger wrote:
>> Breno wrote:
>>   
>>> Wolfgang Grandegger wrote:
>>>     
>>>> Breno wrote:
>>>>  
>>>>       
>>>>> Wolfgang Grandegger wrote:
>>>>>    
>>>>>         
>>>>>> Breno wrote:
>>>>>>        
>>>>>>           
>>>>>>> Wolfgang Grandegger wrote:
>>>>>>>            
>>>>>>>             
>>>>>>>> Breno wrote:
>>>>>>>>  
>>>>>>>>                
>>>>>>>>               
>>>>>>>>> Hi all, on my kernel option I can enable the RT-Socket CAN as a
>>>>>>>>> feature along with Xenomai support. Does it means if I enable it I
>>>>>>>>> start using RTCAN?
>>>>>>>>> Could anyone explain me the differences if it exists?
>>>>>>>>>                         
>>>>>>>>>                 
>>>>>>>> RT-Socket-CAN is the real-time capable variant of Socket-CAN using
>>>>>>>> the
>>>>>>>> (almost) same API. It is based on RTDM and is used together with
>>>>>>>> one of
>>>>>>>> the Xenomai skins. If you use the RT-Socket-CAN MSCAN driver, you
>>>>>>>> need
>>>>>>>> to disable it for Socket-CAN, or better, disable Socket-CAN
>>>>>>>> completely.
>>>>>>>> Here are a few links related to RT-Socket-CAN:
>>>>>>>>
>>>>>>>> http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/drivers/can/README
>>>>>>>>
>>>>>>>> http://www.xenomai.org/documentation/trunk/html/api/group__rtcan.html
>>>>>>>> http://www.xenomai.org/documentation/trunk/html/api/examples.html
>>>>>>>>
>>>>>>>> Wolfgang.
>>>>>>>>
>>>>>>>>                   
>>>>>>>>               
>>>>>>> Thanks Wolfgang, those codes are great and help me  understand some
>>>>>>> issues. But,  I should have a Makefile to compile them, shouldn't?
>>>>>>> I can 't use  only  ppc_6xx-gcc  rtcansend.c -o rtcansend, right?
>>>>>>> Do you have a Makefile?
>>>>>>>             
>>>>>>>             
>>>>>> http://www.rts.uni-hannover.de/xenomai/lxr/source/examples/native/Makefile
>>>>>>
>>>>>> shows how to make Xenomai applications using the native skin, like
>>>>>> rtcansend. Nevertheless, rtcansend will be built together with the
>>>>>> other
>>>>>> Xenomai user space applications.
>>>>>>
>>>>>> Wolfgang.
>>>>>>
>>>>>>
>>>>>>         
>>>>>>           
>>>>> Hi all, I wonder know why many function declarations take place inside
>>>>> an structure like:
>>>>>
>>>>>  #if defined(__KERNEL__) || defined(__XENO_SIM__)
>>>>>
>>>>> My compilation process always return error because it doesn't find the
>>>>> functions declarations that is  inside  those  structures!
>>>>>
>>>>> What should I do?
>>>>>     
>>>>>         
>>>> Please tell use what you compile how (source code + compile command)?
>>>>
>>>> Wolfgang.
>>>>
>>>>   
>>>>       
>>> My source code and Makefile are attached! First I'm trying to make some
>>> tests using POSIX API.
>>>     
>>
>> First, your problems have nothing to do with Socket-CAN and therefore
>> it's off-topic here. Please move this thread to the Xenomai-help mailing
>> list.
>>
>> The following commands reveal:
>>
>>   $ export CROSS_COMPILE=ppc_6xx
>>   $ export DESTDIR=/opt/eldk/ppc_6xx
>>   $ make XENO=/opt/eldk/ppc_6xx/root/xenomai
>>   ...
>>
>> Your Makefile is not appropriate for the POSIX API but the native API.
>> Have a look to working examples:
>>
>> http://www.rts.uni-hannover.de/xenomai/lxr/source/examples/posix/
>>
>> Wolfgang.
>>
>> Wolfgang.
>>   
> Hi Wolfgang, all those Makefile get me confused! I'm gonna post my
> problem about posix on Xenomai list!

The Makefile is for Xenomai applications and modules and works with
Linux 2.4 as well. That makes is somehow difficult to read. But the
compiler and linker flags for your application are:

 CC=$(shell $(XENOCONFIG) --cc)

 CFLAGS=$(shell $(XENOCONFIG) --xeno-cflags) $(MY_CFLAGS)

 LDFLAGS=$(shell $(XENOCONFIG) --xeno-ldflags) $(MY_LDFLAGS) -lnative

 LDFLAGS+=-Xlinker -rpath -Xlinker $(shell $(XENOCONFIG) --libdir)

This is for the native skin. For rtcansend you also need to add -lrtdm.

> I also tried to compile the rtcansend.c with the Makefile attached. The
> erros reported were;
> 
> /usr/local/xenomai/include/rtdm/rtdm.h:288: error: parse error before
> '(' token
> /usr/local/xenomai/include/rtdm/rtdm.h:289: error: parse error before
> '(' token
> /usr/local/xenomai/include/rtdm/rtdm.h:290: error: parse error before
> '(' token
> /usr/local/xenomai/include/rtdm/rtdm.h:291: error: parse error before
> '(' token
> /usr/local/xenomai/include/rtdm/rtdm.h:292: error: parse error before
> '(' token
> /usr/local/xenomai/include/rtdm/rtdm.h:293: error: parse error before
> '(' token
> /usr/local/xenomai/include/rtdm/rtdm.h:294: error: parse error before
> '(' token
> /usr/local/xenomai/include/rtdm/rtdm.h:295: error: parse error before
> '(' token
> 
> I'm really striving on compile all these codes!!

Are you cross compiling? Then the include path above is wrong. Please
tell use, what exactly you have typed to compile the program. Maybe just
DESTDIR is not set properly.

Wolfgang.


