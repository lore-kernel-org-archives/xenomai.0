Message-ID: <45E59B70.2010700@domain.hid>
Date: Wed, 28 Feb 2007 16:10:40 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Re: high latency every 8 seconds
References: <45E4646A.10205@domain.hid>	<45E46D67.9030600@domain.hid>	<45E48543.8030800@domain.hid>
	<17892.51246.767507.976015@domain.hid>
	<45E56DD1.4050408@domain.hid>
In-Reply-To: <45E56DD1.4050408@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Theo Veenker <Theo.Veenker@domain.hid>
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

Theo Veenker wrote:
> Gilles Chanteperdrix wrote:
>>The only thing I see in 2.3 that could be a problem is the fact that
>>user space mapping of posix shared memory is no longer enabled by
>>default, was it your problem, are you using posix shared memory for
>>communication between kernel-space and user-space ?
>>
> 
> 
> That could have been the problem. I'm using shared memory. As time
> permits I will try again and report what happens.

Ok, if this is the issue, simply enable "Shared memory" under the menu
Real-time sub-system/Interfaces/POSIX API of the kernel configuration menu.

-- 
                                                 Gilles Chanteperdrix

