MIME-Version: 1.0
In-Reply-To: <4B6BFEDC.60403@domain.hid>
References: <20100204105700.GB20669@domain.hid>
	<4B6ADA01.2080803@domain.hid>
	<20100205103744.GA12904@domain.hid>
	<4B6BFEDC.60403@domain.hid>
Date: Fri, 5 Feb 2010 13:39:58 +0100
Message-ID: <b88603c31002050439n790f4f71kd6e152198de511f2@domain.hid>
From: Henri Roosen <henriroosen@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai-help] Force switch back to primary domain
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Unfortunately I was not able to capture the problem in a basic
application :-( and I cannot sent our full application as is. It is
easy to reproduce with our app.

But... As a quick (quick?!) test I disabled CONFIG_XENO_FASTSYNCH.
Then I could not reproduce the problem anymore. So it I guess it is
somewhere in that area...

We use the rt_mutex implementation from the Xenomai native skin from user space.


On Fri, Feb 5, 2010 at 12:19 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> Tschaeche IT-Services wrote:
>> Hi,
>>
>> On Thu, Feb 04, 2010 at 03:30:25PM +0100, Gilles Chanteperdrix wrote:
>>> It would be nice if you could try Xenomai 2.5.1, the latest stable
>>> release, to see if you are not having a problem that we already fixed.
>>
>> it seems as we (Henri and me) have problems with the mutex implementation
>> (FAST_SYNC) in 2.5.1. we'll try and give you feedback when we have time
>> to debug this issue.
>
> If you have a test program which fails, just send that, we will try and
> sort it out.
>
> --
> Gilles Chanteperdrix, Free Electrons
> Kernel, drivers, real-time and embedded Linux
> development, consulting, training and support.
> http://free-electrons.com
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>

