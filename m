Message-ID: <483294AE.6050208@domain.hid>
Date: Tue, 20 May 2008 11:06:54 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <60078.189.4.74.190.1209348044.squirrel@domain.hid>	<481580F2.9090707@domain.hid>	<4815BFDA.1040904@domain.hid>	<4815C3A5.1020606@domain.hid>	<4815C937.6000700@domain.hid>	<4815D4B1.8040207@domain.hid>	<481682B8.4050104@domain.hid>	<4816BF96.6010400@domain.hid>	<57472.150.162.12.153.1209499591.squirrel@domain.hid>	<48180F67.4080809@domain.hid>	<482B8494.7050009@domain.hid>	<482BD2D4.5070408@domain.hid>	<482C922E.1080002@domain.hid>	<482C9719.1080803@domain.hid>	<482CA5B9.3030203@domain.hid>	<482CA862.9070105@domain.hid>
	<482D988A.8040503@domain.hid> <48328F76.4090603@domain.hid>
In-Reply-To: <48328F76.4090603@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] [Socketcan-users] RT - Socketcan
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
Cc: socketcan@domain.hid, xenomai-help <xenomai@xenomai.org>

Hi Breno,

first I moved this thread to the Xenomai-Help ML, because it's off-topic
on the Socket-CAN ML. Only questions related to the Socket-CAN API or
Linux Socket-CAN implementation should be send there.

Wolfgang Grandegger wrote:
> Breno wrote:
>> Wolfgang Grandegger wrote:
> [...deletions...]
> 
>>>>>> Wolfgang, that's seems to work perfectly. I got another simple(very
>>>>>> simple) question. Follow the commands:
>>>>>> *
>>>>>> sh-3.00# ./rtcanrecv rtcan1 &
>>>>>>
>>>>>> *[1] 950
>>>>>> *sh-3.00# ./rtcanrecv rtcan1 &*
>>>>>> *sh-3.00# ./rtcansend rtcan0 -i123 A B C D E F G H*
>>>>>>
>>>>>> #0: (2) <0x07b> [8] 00 00 00 00 00 00 00
>>>>>>
>>>>>> So, I received correctly the ID message the length but the data is 00.
>>>>>> Is there any configuration missing?
>>>>>>     
>>>>>>         
>>>>> You have to specify the message bytes correctly.
>>>>>
>>>>> ./rtcansend rtcan0 -i0x123 0xA 0xB 0xC 0xD 0xE 0xF
>>>>>
>>>>> should work better.
>>>>>
>>>>> Wolfgang.
>>>>>   
>>>>>       
>>>> Wolfgang, that's weird! I did your suggestion and I got:
>>>>
>>>> *sh-3.00# ./rtcansend rtcan0 -i0x123 0xA 0xB 0xC 0xD 0xE 0xF*
>>>> #0: (2) <0x123> [6] 00 00 00 0d 0e 0f
>>>>
>>>> It seems losing some packages, isn't it?
>>>>     
>>> Wired, could you try:
>>>
>>> ./rtcansend -v -i0x123 rtcan0 0xA 0xB 0xC 0xD 0xE 0xF
>>> ./rtcansend -v -i0x123 rtcan0 1 2 3 4 5 6 7 8
>>>
>>> Wolfgang.
>>>
>>>   
>> Hi Wolfgang, I got the messages below with verbose enable as you 
>> suggested me.*
>>
>> sh-3.00# ./rtcansend rtcan0 -v -i0x123 0xA 0xB 0xC 0xD 0xE 0xF 0xG*
>> interface rtcan0
>> s=1, ifr_name=rtcan0
>> <0x123> [7] 0a 0b 0c 0d 0e 0f 00
>> Cleaning up...
>> #1: (2) <0x123> [7] 00 00 00 0d 0e 0f 00
>> *sh-3.00# ./rtcansend rtcan0 -v -i0x123 0xA 0xB 0xC 0xD 0xE 0xF 0xG*
>> interface rtcan0
>> s=1, ifr_name=rtcan0
>> <0x123> [7] 0a 0b 0c 0d 0e 0f 00
>> Cleaning up...
>> #2: (2) <0x123> [7] 00 00 00 0d 0e 0f 00
> 
> The last "00" is OK because 0xG is not a valid hexadecimal number...
> 
>> *sh-3.00# ./rtcansend rtcan0 -v -i0x123 1 2 3 4 5 6 7 8            *
>> interface rtcan0
>> s=1, ifr_name=rtcan0
>> <0x123> [8] 01 02 03 04 05 06 07 08
>> Cleaning up...
>> #4: (2) <0x123> [8] 00 00 00 04 05 06 07 08
>>
>> When you say wired, means I think that it could be a connection problem?
> 
> ... but the first 3 are wired and I'm really puzzled why that happens. I
> have to try myself. I do not believe that it's a connection problem. Do
> you have a CAN Bus analyzer?

How have you built rtcansend and rtcanrecv? Please use the binaries made
and installed by "make install".

Wolfgang.


