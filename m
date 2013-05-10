Message-ID: <518D24E8.6070305@xenomai.org>
Date: Fri, 10 May 2013 18:48:40 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <516BA4E9.3070201@xenomai.org>
	<90FBAEE5-D70C-4563-B9DB-776D6E4E7FA9@kabelmail.de>
	<516D933F.8060502@xenomai.org>
	<F484004F-9908-449C-A4DA-CB73E47EE764@kabelmail.de>
	<5182B1B5.1000107@xenomai.org>
	<12E434B4-4F26-44AC-8D50-2CF70B5089E1@kabelmail.de>
	<5183FFB3.1000006@xenomai.org>
	<8D9AB79C-4A66-4511-B08B-ACF825FED1BF@kabelmail.de>
	<518A98F5.30000@xenomai.org>
	<0ECFC8C0-CF1D-4D65-9724-B0A1A91887DC@kabelmail.de>
	<518CF43E.3080601@xenomai.org>
	<5F179C54-A023-4C27-9082-13195B16B9BB@kabelmail.de>
	<518D07BB.1060900@xenomai.org>
	<A359148C-7FCB-4D8C-A5DC-461065767DDA@kabelmail.de>
In-Reply-To: <A359148C-7FCB-4D8C-A5DC-461065767DDA@kabelmail.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Raspberry and Beaglebone patches
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Stephan Kappertz <stephan.kappertz@kabelmail.de>
Cc: Xenomai <xenomai@xenomai.org>

On 05/10/2013 06:40 PM, Stephan Kappertz wrote:

>>>>
>>>
>>> I'm using your git repository directly. Applied my post.patch and
>>> compiled the kernel. So this is 3.8.0. Looks like my Xenomai user
>>> space compile was broken. Still working on fixing it.
>>
>>
>> What options did you pass to the configure script?
>>
>>
>> -- 
>>                                                                Gilles.
>>
> 
> ../configure --target=arm-buildroot-linux-uclibcgnueabi --host=arm-buildroot-linux-uclibcgnueabi --build=i686-pc-linux-gnu --prefix=/usr --exec-prefix=/usr --sysconfdir=/etc --program-prefix="" --enable-static --enable-shared  CFLAGS="-march=armv7-a -mfpu=vfp3" LDFLAGS="-march=armv7-a -mfpu=vfp3" --includedir=/usr/include/xenomai/
> 
> This is a buildroot build.


Could you:
- tell me what version of gcc, binutils, etc... you use?
- show me a disassembly of the xeno_bind_skip_opt function in libxenomai.so?
- instrument the function xeno_sigill_handler in
src/skins/common/bind.c to see if you are indeed taking the SIGILL signal?
- send me (privately) your kernel configuration?

Thanks in advance.
Regards.

-- 
                                                                Gilles.

