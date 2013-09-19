MIME-Version: 1.0
In-Reply-To: <5239F446.3090407@xenomai.org>
References: <CAEk6gTBsZCz4Z0N7dF1w6UEy_OVGF7_-Zbo=gVk3+N=DDpZ_VQ@mail.gmail.com>
	<5239E937.4020805@xenomai.org> <5239F446.3090407@xenomai.org>
Date: Thu, 19 Sep 2013 12:06:56 +0200
Message-ID: <CAEk6gTCa6VrW3RuFR-=67K1RQupvjTWOZPAvtnAHF_1HA+s=8w@mail.gmail.com>
From: Drasko DRASKOVIC <drasko.draskovic@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] Xenomai Yocto Bitbake recipe configuration error
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

HI Gilles,
thanks for the answer!

On Wed, Sep 18, 2013 at 8:43 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> On 09/18/2013 07:56 PM, Gilles Chanteperdrix wrote:
>> On 09/18/2013 07:29 PM, Drasko DRASKOVIC wrote:
>>> Hi all,
>>> regarding chapter  3.4. Building for ARM here:
>>> http://www.xenomai.org/documentation/xenomai-2.6/html/README.INSTALL/
>>> we should configure like :
>>>
>>> $xenomai_root/configure CFLAGS="-march=armv4t" LDFLAGS="-march=armv4t" \
>>>   --build=i686-pc-linux-gnu --host=arm-none-linux-gnueabi-
>>>
>>> I wanted to know if CFLAGS and LDFLAGS are needed only for compile
>>> time, or maybe later for runtime also?
>>
>> You only need to pass these flags if you are using a generic multilib
>> compiler such as Mentor sourcery codebench. If you are using a compiler
>> specially built for your target, you do not need to pass any flags.


So these are only needed for compile timem if I understand correctly.
Since I am using Linaro's arm-linux-gnueabihf-gcc I will not pass
CFLAGS and LDFLAGS

>> However, I would be surprised if:
>> - it was not possible to pass spaces in CFLAGS, maybe ' works instead of "

Yes, ' works instead of ". That was the first workaround I found, but
then I got curious.

Looking at build/tmp/work/.../xenomai.../temp/run.do_configure.<pid>
log I found out that Bitbake translates these EXTRA_OECONF to :
CFLAGS=\"-march=armv7-a -mfpu=vfp3\" LDFLAGS=\"-march=armv7-a
-mfpu=vfp3\", and passes this to the shell.

So, strangely, declaring EXTRA_OECONF like:
EXTRA_OECONF += "CFLAGS="-march=armv7-a -mfpu=vfp3"
LDFLAGS="-march=armv7-a -mfpu=vfp3"
seems to be working...

However, I noticed also that configure demand include dir, as bitbake
proposes by default /usr/include, and xenomai wants
/usr/include/xenomai, so this must be added to EXTRA_OECONF:
EXTRA_OECONF += "--include=${includedir}/${BPN}"

>> - the rules for building Xenomai with Yocto did not exist somewhere.
>
> For instance:
> http://www.xenomai.org/pipermail/xenomai/2012-October/026533.html
> https://mail.gna.org/public/xenomai-help/2010-02/msg00186.html

Thanks for this links, Gumstix recipe looks very promising. Maybe it
is a good idea to explicitlydefine do_configure() procedure in .bb
file than to let bitbake and autoconf

BR,
Drasko

