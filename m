Subject: Re: xenomai 3.1/ipipe-core-4.19.128-cip28-arm-10.patch
References: <16c407c9-8ed4-4b43-b38b-aac8a270e686@gmail.com>
 <CALLqZ8RXOhONVAti+XyW6dRSCWYcnLnyG1=fYyXQgU+k7RPWAA@mail.gmail.com>
From: Robert Berger <xenomai.list@gmail.com>
Message-ID: <a1b13b3e-3d27-586a-c8bb-fec44a368f58@gmail.com>
Date: Tue, 7 Jul 2020 19:30:40 +0300
MIME-Version: 1.0
In-Reply-To: <CALLqZ8RXOhONVAti+XyW6dRSCWYcnLnyG1=fYyXQgU+k7RPWAA@mail.gmail.com>
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

Hi Greg,

I digged a bit deeper and it looks like although I tell Yocto/BitBake to 
use 4.19.x kernel headers it auto generates this:

/unix/sysv/linux/arm/arch-syscall.h:#define __NR_clock_nanosleep_time64 407

Will try something more drastic to see what happens.

Regards,

Robert

