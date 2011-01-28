Message-ID: <4D4332CC.7060209@domain.hid>
Date: Fri, 28 Jan 2011 22:19:08 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <002601cbbf29$d77f4e40$867deac0$@com>
In-Reply-To: <002601cbbf29$d77f4e40$867deac0$@com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] RT context
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: wcall@domain.hid
Cc: Xenomai-help@domain.hid

Wayne Call wrote:
> In the heartbeat example, there is the following comment:
> 
>  
> 
>                 /* Note: The I-pipe patch for blackfin ensures that
> gpio_set_value
> 
>                 * (among other services) can safely be called from RT
> context. */
> 
>  
> 
> So this states that the gpio_set_value can be called from an RT context.

The reason for this is that, usually, toggling a GPIO is just a matter
of writing some bit to some IO memory. On some hardware, this operation
is atomic due to the nature of the hardware interface (separated
registers allow to set or clear a bit). On other hardware, where a
read-modify-write operation may be needed on a hardware register, this
operation may be protected by a spinlock, and what the I-pipe does is
simply replace the spinlock with an "I-pipe aware" to make it safe to be
used from the primary domain. I do not know in what case the blackfin
architecture is, but what this comment tells you is just that: this
function is safe to be called from primary domain.

But there is nothing preventing you from using the same GPIO from both
Xenomai domain and Linux domain, and chances are that it is not what you
want.

> What about an I2C driver, or an SPI driver?  There are linux kernel drivers
> to support these devices.  Does it make sense to continue to use these
> drivers in the linux kernel, and somehow have an RT context that can tap
> into this data?  Does an RT context take precedence over the linux kernel
> I2C and SPI drivers?  The Xenomai is its own kernel and somehow interacts
> and works together with the linux kernel.  Do I have to re-structure a linux
> kernel I2C driver completely into a Xenomai I2C driver?
> 
>  
> 
> In the past I have written a linux kernel driver on top of the I2C driver to
> collect I2C data into a buffer.  I also wrote a Xenomai driver that makes
> calls into this top level linux kernel I2C driver to get the data.  And
> there is a Xenomai user application, running an RT context, that gets the
> data from the Xenomai driver.
>  
> 
> Is there a particular strategy I should be using for the I2C and SPI
> interfaces?

an I2C driver or an SPI driver are much more complicated than basic
gpiolib drivers, and are harder to be made easy to be used from primary
domain, if at all possible.

In the case of the I2C, in particular, some bus drivers rely on the
"wait_for_completion/complete" API, which requires interaction with
Linux scheduler.

So, if your I2C driver is in that case, some driver has to be rewritten
for Xenomai, and if you want to also allow Linux to access the hardware,
you will have to handle the mutual exclusion. This has to be assessed on
a driver by driver basis, but I would tend to think that the most common
case is that a new driver has to be written specifically for Xenomai.

-- 
                                                                Gilles.

