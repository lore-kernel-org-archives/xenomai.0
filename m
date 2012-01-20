Message-ID: <4F19B0E2.6060209@domain.hid>
Date: Fri, 20 Jan 2012 19:22:26 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CA+fRa6cOs0iz37X8VKFPawXLDV4cDb5=u21FgS7JSP3dSmc+FQ@mail.gmail.com>
	<4F0E12FA.8030606@domain.hid>
	<1B09CB90-7C04-4595-B7D4-19BFA9DF10AD@gmail.com>
In-Reply-To: <1B09CB90-7C04-4595-B7D4-19BFA9DF10AD@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] troubles with library inclusion
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jakub Nowacki <j.s.nowacki@domain.hid>
Cc: xenomai@xenomai.org

On 01/20/2012 06:18 PM, Jakub Nowacki wrote:
> 
> On 11 Jan 2012, at 22:53, Gilles Chanteperdrix wrote:
> 
>> On 01/11/2012 11:49 PM, Daniele wrote:
>>> Hello,
>>> 
>>> We are trying to use xenomai with analogy library
>>> 
>>> [xenomai 2.6.0, kernel 2.6.38.8]
>>> 
>>> Compiling the program  we got the following error:
>>> 
>>> 
>>> "undefined reference to 
>>> a4l_open<http://www.xenomai.org/documentation/trunk/html/api/group__descriptor1__lib.html#ga810401871fe8005ee0157c6910f94466>
>>>
>>> 
"
>>> 
>>> The compiler detects correctly the function prototypes but it
>>> can't found their complete definition.
>>> 
>>> taking care of our MakeFile we also have read this:
>>> 
>>> https://mail.gna.org/public/xenomai-help/2011-07/msg00036.html
>>> 
>>> but we noticed that our makefile already contains this
>>> instructions for our skin, native.
>>> 
>>> How could we get rid of this?
>> 
>> You need to link with the libanalogy driver, so, simply add
>> "-lanalogy" on the compiler command line.
>> 
> 
> I had a similar problem. Namely, it was complaining about having
> undefined reference. I added the -lanalogy to the flags generated
> with 'xeno-config --skin=native --ldflags' and everything compiled
> and linked correctly, but when I start my application I get error:
> 
> /usr/xenomai/lib/libanalogy.so.1: undefined symbol: rt_dev_ioctl
> 
> I after adding -lrtdm after -lanalogy everything, again, complied and
> linked correctly, but I get new error:
> 
> librtdm.so.1: shared object cannot be dlopen()ed

If you need to dlopen librtdm, please reconfigure xenomai passing:
--enable-dlopen-skins

-- 
                                                                Gilles.

