Message-ID: <50AA4EC2.1000206@xenomai.org>
Date: Mon, 19 Nov 2012 16:22:42 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CANzNmi-O4C=z-sXqrq7HMTQ=B2apBBnZMco0p-_iHmfuu+Jexg@mail.gmail.com>
In-Reply-To: <CANzNmi-O4C=z-sXqrq7HMTQ=B2apBBnZMco0p-_iHmfuu+Jexg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Help with Xeno-test please
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Sebastian Pavez <sebastian.pavez.t@gmail.com>
Cc: Xenomai <xenomai@xenomai.org>

On 11/19/2012 04:10 PM, Sebastian Pavez wrote:
> Hi everybody!
> 
> I'm trying to get the latencies values with some load, but I think I'm
> doing something wrong. Below is the command I tried and the results, are
> they the rights parameters? if not, wich ones I should use instead? Some
> recommendations will be appreciated. I read that the xeno-test runs by
> default for 15 min, but I'm not getting that behaviour.
> 
> Please some insights, Seba.
> 
> 
> root@labcontrol:~# /usr/xenomai/bin/xeno-test -l "dohell -b
> /usr/bin/hackbench  -s 192.168.0.5 -l /usr/src/linux-3.2.32/fs/ubifs | 100"

The pipe in dohell help string is a "logical or", indicating that you
should either pass the path to ltp installation directory OR a duration
IN SECONDS.

-- 
					    Gilles.

