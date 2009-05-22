Message-ID: <4A16A36E.7050209@domain.hid>
Date: Fri, 22 May 2009 15:06:54 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4A169F11.9000702@domain.hid>
In-Reply-To: <4A169F11.9000702@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Square wave jitter reduce with cpu load
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Adrien LECOINTRE <adrien20@domain.hid>
Cc: xenomai@xenomai.org

Adrien LECOINTRE wrote:
> Hello,
> 
> I wrote a simple program toggling a pin of the parallel port every 20 

A period of 20us is preposterous, this is not what Xenomai is made for.

> us. I observe with a scope a jitter of 4 us on my square wave. Then I 
> added a background cpu load task and I expected to observe a bigger 
> jitter but in fact the jitter becomes inferior than 1 us.

Your cpu load task is preposterous too:
- your system remains in the Xenomai domain, which you should never do;
for Linux to work correctly, you have to let Linux run from time to time;
- your cpu load task is a short loop, so it does not have any effect on
the cache, so your square wave task remains in the cache, and when it
needs to run, there is no cache effect.

-- 
                                                 Gilles.

