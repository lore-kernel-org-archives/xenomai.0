Message-ID: <5239F446.3090407@xenomai.org>
Date: Wed, 18 Sep 2013 20:43:18 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAEk6gTBsZCz4Z0N7dF1w6UEy_OVGF7_-Zbo=gVk3+N=DDpZ_VQ@mail.gmail.com>
	<5239E937.4020805@xenomai.org>
In-Reply-To: <5239E937.4020805@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai Yocto Bitbake recipe configuration error
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Drasko DRASKOVIC <drasko.draskovic@gmail.com>
Cc: xenomai@xenomai.org

On 09/18/2013 07:56 PM, Gilles Chanteperdrix wrote:
> On 09/18/2013 07:29 PM, Drasko DRASKOVIC wrote:
>> Hi all,
>> regarding chapter  3.4. Building for ARM here:
>> http://www.xenomai.org/documentation/xenomai-2.6/html/README.INSTALL/
>> we should configure like :
>>
>> $xenomai_root/configure CFLAGS="-march=armv4t" LDFLAGS="-march=armv4t" \
>>   --build=i686-pc-linux-gnu --host=arm-none-linux-gnueabi-
>>
>> I wanted to know if CFLAGS and LDFLAGS are needed only for compile
>> time, or maybe later for runtime also?
> 
> You only need to pass these flags if you are using a generic multilib
> compiler such as Mentor sourcery codebench. If you are using a compiler
> specially built for your target, you do not need to pass any flags.
> However, I would be surprised if:
> - it was not possible to pass spaces in CFLAGS, maybe ' works instead of "
> - the rules for building Xenomai with Yocto did not exist somewhere.

For instance:
http://www.xenomai.org/pipermail/xenomai/2012-October/026533.html
https://mail.gna.org/public/xenomai-help/2010-02/msg00186.html

-- 
                                                                Gilles.

