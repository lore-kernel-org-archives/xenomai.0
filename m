Message-ID: <48318DA5.8020907@domain.hid>
Date: Mon, 19 May 2008 16:24:37 +0200
From: paradoxxa <paradoxxa2001@domain.hid>
MIME-Version: 1.0
References: <1168701330@domain.hid>	
	<2ff1a98a0805190239x5f8c8445h47d8ca3070dded1c@domain.hid>	
	<4831626B.9080208@domain.hid>	
	<2ff1a98a0805190506g10f8c1bx781434f8bc73d9a1@domain.hid>	
	<48316FCF.3030706@domain.hid>	
	<2ff1a98a0805190536q5bb3be8dg9b35265bc5b1b618@domain.hid>	
	<48317AED.7030507@domain.hid>
	<2ff1a98a0805190630o6ae730c2mcf624e8feb9649e3@domain.hid>
In-Reply-To: <2ff1a98a0805190630o6ae730c2mcf624e8feb9649e3@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: paradoxxa2001@domain.hid
Subject: Re: [Xenomai-help] at91sam9263 and user-space support compile fails
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Gilles Chanteperdrix schrieb:
> On Mon, May 19, 2008 at 3:04 PM, paradoxxa <paradoxxa2001@domain.hid> wrote:
>   
>> Gilles Chanteperdrix schrieb:
>>     
>>> On Mon, May 19, 2008 at 2:17 PM, paradoxxa <paradoxxa2001@domain.hid> wrote:
>>>
>>>
>>> No, you are talking about CONFIG_DEBUG_LL, I am talking about
>>> CONFIG_DEBUG_INFO. These are two different options. So, this make at
>>> least two options that you changed. Could you check if a kernel with
>>> an unmodified defconfig boots ?
>>>
>>>
>>>       
>> The CONFIG_DEBUG_INFO is already set in the defconfig. The CONFIG_DEBUG_LL i
>> set manually.
>> As well I had to changed the  AT91 Master Clock Frequency.
>>
>> Here are the logs of a unmodified defconfig boot:
>>     
>
> Ok. But this is a boot with your old compiler. Could you try a
> defconfig build (with I-pipe AT91 master clock frequency modified)
> with CodeSourcery compiler ?
>   
The  output what i get is "Starting Kernel ..."! That was it.

> If you can not get CodeSourcery compiler to compile correctly a Linux
> kernel, I can send you the 2007q3 compiler, or you could try to
> compile the kernel with your old compiler, and to compile user-space
> with CodeSourcery compiler.
>   
I tried it with the both compiler. When i execute 
/usr/xenomai/bin/latency i get the message "sh: 
/usr/xenomai/bin/latency: not found"

