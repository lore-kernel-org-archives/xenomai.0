Message-ID: <4E1AF2AD.8070909@domain.hid>
Date: Mon, 11 Jul 2011 14:55:09 +0200
From: Kim Mathiassen <kimmat@domain.hid>
MIME-Version: 1.0
References: <4E157F1C.9060606@domain.hid> <4E1ADC25.5000800@domain.hid>
In-Reply-To: <4E1ADC25.5000800@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] 32 bits libraries for x86_64 architecture
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

On 07/11/2011 01:19 PM, Gilles Chanteperdrix wrote:
> On 07/07/2011 11:40 AM, Kim Mathiassen wrote:
>> Hi
>>
>> I am doing a project where I am going to use Labview for linux.
>> Unfortunately Labview only have a 32-bit version and I have a 64 bit
>> system. I want to use Xenomai with Labview for DAQ, and therefor I need
>> 32 bits libraries that Labview can call. I read a message in the
>> mailing-list which where of a similar character:
>>
>> https://mail.gna.org/public/xenomai-help/2008-05/msg00294.html
>>
>> I have tried to compile the user-space Xenomai libraries with the m32
>> option, but I only get -ENOSYS error which implies that the function is
>> not implemented. Is there any plan to implement 32 bit wrappers for a 64
>> bit system? Do I have to install a 32 bit kernel in order to use Xenomai
>> with Labview? Does anyone have a suggestion on how to solve the problem?
>>
>> I the message the linked to above, it was suggested that I could
>> implement the wrappers. Does anyone know about how much work this would
>> be? If it isn't a lot of work, maybe someone could point me to where in
>> the code I should start looking.
>>
>> I am also thinking of making a 64 bit deamon that a 32 bit library can
>> communicate with. I am not sure if this will work, because I do not know
>> if there are IPC (InterProcess Communication) that can handle both 32
>> and 64 bit on Linux?
> No Xenomai service is currently implemented in 32 bits mode. It is a ton
> of work to do so, because you need to write wrappers for all the system
> calls, and there are probably a handful of hundreds of them (a grep | wc
> gives 433).
>
> So, currently, it seems easier to use either a complete 64 bits or  to a
> complete 32 bits system, not a mix of both.
>
Thanks for the reply. I have been implementing the deamon approach. It 
seems to be working. Unix sockets can communicate between 32 and 64 bit 
programs.


