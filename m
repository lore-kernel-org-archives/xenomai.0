Subject: Re: xenomai 3.1/ipipe-core-4.19.128-cip28-arm-10.patch
References: <16c407c9-8ed4-4b43-b38b-aac8a270e686@gmail.com>
 <CALLqZ8RXOhONVAti+XyW6dRSCWYcnLnyG1=fYyXQgU+k7RPWAA@mail.gmail.com>
 <a1b13b3e-3d27-586a-c8bb-fec44a368f58@gmail.com>
 <CALLqZ8REwJXSjZ4m3D3_VGdfgf66ZcG0_oWq0MajEn3jMCXQWw@mail.gmail.com>
 <d88931aa-2a36-c29a-6dc5-919617dfde8d@gmail.com>
 <CALLqZ8TPySW33BFrgCRxw5m+A+x9RB8OtkUSGW5XmsJgz2xPRg@mail.gmail.com>
From: Robert Berger <xenomai.list@gmail.com>
Message-ID: <b012f4e7-2010-0d07-1cdb-60196e4ace69@gmail.com>
Date: Thu, 9 Jul 2020 00:19:50 +0300
MIME-Version: 1.0
In-Reply-To: <CALLqZ8TPySW33BFrgCRxw5m+A+x9RB8OtkUSGW5XmsJgz2xPRg@mail.gmail.com>
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

My comments are in-line.

On 08/07/2020 15:41, Greg Gallagher wrote:

> I'm using glibc 2.25.  The other thing to keep in mind is that the
> message isn't coming from the Linux kernel, it's coming from Cobalt.
> So it's possible cobalt is having some issues with a newer libc.  I'll
> have time tonight to sit down with ftrace and see if I can get a
> better idea of what's going on.
> 

I traced the issue a bit more down.

The problematic testcase is protect_trylock (posix-mutex.c:1063) since 
it calls __real_usleep()(lib/cobalt/wrappers.c:553); which causes 
[Xenomai] bad syscall <0x197>

So yes, it looks like it's a combination of Cobalt and a new glibc.

I am really surprised that no one else stumbled across this issue, since 
I can't even remember which Yocto Version used 4.19 or older kernel headers.

My hack to use 4.19 kernel headers didn't help, since, as you say, it 
does not seem to be related to this issue.

So I guess the ball is in Xenomai land ;)

Having said that I am happy to test whatever you come up with and I 
guess I could also provide some remote test setup where you can play and 
see the issue.

Regards,

Robert

