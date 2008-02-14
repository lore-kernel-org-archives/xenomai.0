Message-ID: <47B4564F.6010509@domain.hid>
Date: Thu, 14 Feb 2008 15:55:11 +0100
From: Johan Borkhuis <j.borkhuis@domain.hid>
MIME-Version: 1.0
References: <12460.62.39.72.60.1202995942.squirrel@domain.hid>	
	<47B44693.6070203@domain.hid>
	<2ff1a98a0802140551ve405dd7v66419157978a8235@domain.hid>
In-Reply-To: <2ff1a98a0802140551ve405dd7v66419157978a8235@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problem of thread creation with Xenomai Posix
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

Gilles Chanteperdrix wrote:
> When using Xenomai posix skin, pthread_create creates real-time tasks
> as well. 

Yes, that is what I would expect, as the Xenomai Posix skin is used :-)

> And the main thread is automatically shadowed (by library
> init code).
>   

I did not know this. Is this true for all  skins? I did see problems 
(like the one described here) when I started an application that created 
a RT-thread without first shadowing the main thread.

Kind regards,
    Johan Borkhuis

-- 
Johan Borkhuis                                  Dutch Space BV
email:        j.borkhuis@domain.hid          Newtonweg 1
phone:        071-5245788                       Leiden
fax:          071-5245499                       The Netherlands


