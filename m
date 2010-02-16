Message-ID: <4B7AA5B4.8030007@domain.hid>
Date: Tue, 16 Feb 2010 09:03:32 -0500
From: Chris Cole <clecol@domain.hid>
MIME-Version: 1.0
References: <4B79A113.2020300@domain.hid>
	<1266263285.2375.141.camel@domain.hid>
	<4B79B972.9080000@domain.hid>
In-Reply-To: <4B79B972.9080000@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] bug: patch support for intel atom n270
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

Chris Cole wrote:
> Philippe Gerum wrote:
>> On Mon, 2010-02-15 at 14:31 -0500, Chris Cole wrote:
>>  
>>> Hello all,
>>> This is my first time on this list. I've been using RTAI (and the 
>>> Adeos HAL patch) for quite
>>> some time now on a AMD Geode platform. I just recently got a new 
>>> Intel Atom N270 CPU
>>> which I've installed Ubuntu Karmic on, however I can't get an 
>>> Adeos/RTAI patched kernel
>>> (with a known working .config) to boot on the system...it simply 
>>> hangs upon booting the kernel.
>>> Is it possible to get Intel Atom support and/or is this a known bug?
>>>
>>>     
>>
>> You should post to the RTAI mailing list to get help on fixing the RTAI
>> code.
>>
>> You may want to try running a standard Adeos patch on your system
>> without RTAI, and see if your machine boots; you can get them from:
>> http://download.gna.org/adeos/patches/v2.6/x86/
>>
>> If it does work, then maybe this will give the RTAI folks a hint to help
>> you better.
>>
>>   
> Sorry, I forgot to include that minor detail :P in my original post. I 
> did try a adeos
> patch (adeos-ipipe-2.6.32.7-x86-2.6-00.patch) on vanilla kernel 
> 2.6.32.2 from kernel.org
> which exhibited the same "hanging" behavior, which is why I'm posting 
> here and not there.
>
> Chris
Also, I realize that the patch / kernels do not match up 100% (although 
the patch applied successfully),
so I'm trying that same patch on 2.6.32.7 now to see if I get the same 
behavior.

Chris


