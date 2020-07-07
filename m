Subject: Re: xenomai 3.1/ipipe-core-4.19.128-cip28-arm-10.patch
References: <16c407c9-8ed4-4b43-b38b-aac8a270e686@gmail.com>
 <CALLqZ8RXOhONVAti+XyW6dRSCWYcnLnyG1=fYyXQgU+k7RPWAA@mail.gmail.com>
 <a1b13b3e-3d27-586a-c8bb-fec44a368f58@gmail.com>
 <CALLqZ8REwJXSjZ4m3D3_VGdfgf66ZcG0_oWq0MajEn3jMCXQWw@mail.gmail.com>
From: Robert Berger <xenomai.list@gmail.com>
Message-ID: <de705804-291c-55de-66bd-0f3ee3a40138@gmail.com>
Date: Wed, 8 Jul 2020 00:12:39 +0300
MIME-Version: 1.0
In-Reply-To: <CALLqZ8REwJXSjZ4m3D3_VGdfgf66ZcG0_oWq0MajEn3jMCXQWw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

My comments are in-line

On 07/07/2020 20:48, Greg Gallagher wrote:
> Yocto seems to be expecting that the
> kernel you are using is going to be 5.4 and is generating headers
> based on that.  So apps think that 407 is a valid system call but our
> 4.19 kernel doesn't know what system call that is.  I don't have a lot
> of yocto experience but you could try moving to an older yocto branch
> that supports 4.19 kernels and see what happens.

Well ;)

Every OE/YP release comes with some default kernel version and one would 
think the kernel headers of this kernel version are used to build the 
glibc, which kind of is the case, but it's 2 different recipes.

So although I use kernel version 4.19.x to apply the xenomai patch it 
still uses 5.4 kernel headers by default. I knew that and added my own 
4.19 kernel-headers recipe. But it looks like it was not used to build 
glibc, since I see some auto generated file with the 407 syscall.

I am still fighting trying to build a glibc with 4.19 kernel headers 
(which I think I managed).

I'll keep you updated.

> 
> -Greg

Thanks,

Robert

> 
>>
>> Will try something more drastic to see what happens.
>>
>> Regards,
>>
>> Robert


