Message-ID: <45DC57F9.8000302@domain.hid>
Date: Wed, 21 Feb 2007 15:32:25 +0100
MIME-Version: 1.0
Subject: Re: [Xenomai-help] real-time ethernet
References: <45DC4C85.8090807@domain.hid> <45DC51F8.7090508@domain.hid>
In-Reply-To: <45DC51F8.7090508@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
From: Roland Tollenaar <rwatollenaar@domain.hid>
Reply-To: rolandtollenaar@domain.hid
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
Cc: Xenomai-help@domain.hid

Hi,

Thanks. I think I will stick to CAN. I hope I achieve the speed.

Could you possibly look at my tsc issue and give your opinion please? I 
am actually desperately waiting for someone to comment on that and 
obviously hoping that there are no severe problems to be expected if I 
run the user part built with;

--disable-tsc

and the kernel in 486 processor family.


Regards,

Roland.

Jan Kiszka wrote:
> Roland Tollenaar wrote:
>> Hi,
>>
>> Again a bit of advice required. I have the choice of interacting with a
>> remoteIO station via ethernet or CAN as well. I need CAN anyway for the
>> sensor but I suspect that communicating with the remote IO station via
>> ethernet might be substantially easier programming than doing this with
>> CANOpen.
>>
>> Can anyone confirm this? Does anyone with experience in both prefer one
>> or the other?
>>
>> And what can be said about this and xenomai? Would I use the standard
>> sys/socket library or is there a real-time xenomai implementation of the
>> same functionality?
> 
> Check
> 
> http://www.rtnet.org
> http://www.xenomai.org/index.php/RTnet:Main.
> 
> If it is simple to set up? Well, I'm probably the wrong person to ask...
> 
> Jan
> 

