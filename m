Message-ID: <50C8330D.8040305@xenomai.org>
Date: Wed, 12 Dec 2012 08:32:29 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1491832.238.1355257934434.JavaMail.poli@jacqueline>
	<FE9848C4-D19F-4628-8047-5E67A667A2E9@mah.priv.at>
In-Reply-To: <FE9848C4-D19F-4628-8047-5E67A667A2E9@mah.priv.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RT GPIO with Raspberry Pi
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Haberler <mail17@mah.priv.at>
Cc: xenomai@xenomai.org

On 12/12/2012 07:54 AM, Michael Haberler wrote:

> not strictly a Xenomai issue, but I'd completely bypass the kernel
> GPIO support and manipulate the GPIO registers directly - they are
> all memory mapped
> 
> some inspiration here:
> http://git.mah.priv.at/gitweb/emc2-dev.git/blob/refs/heads/rtos-integration-preview1:/src/hal/drivers/hal_gpio.c
>
>  this runs from a userland thread but kernel shouldnt be much
> different


Yeah, good idea, depending on the way to access registers, you get
concurrence issues, conflicts between applications, a lot of fun.

-- 
                                                                Gilles.

