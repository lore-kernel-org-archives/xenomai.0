Message-ID: <4B50AF89.1000909@domain.hid>
Date: Fri, 15 Jan 2010 19:10:17 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1263470867-1533-1-git-send-email-wg@domain.hid>
	<4B5076F9.40508@domain.hid> <4B507B06.4080206@domain.hid>
In-Reply-To: <4B507B06.4080206@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH xenomai-2.5 0/3] rtcan: mscan: new
 OF	platform driver for MPC521x and MPC5200
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: Xenomai-core@domain.hid, Wolfgang Grandegger <wg@domain.hid>

Wolfgang Grandegger wrote:
> Gilles Chanteperdrix wrote:
>> Wolfgang Grandegger wrote:
>>> From: Wolfgang Grandegger <wg@domain.hid>
>>>
>>> This patch series adds RT-Socket-CAN support for the MSCAN on the MPC512x
>>> from Freescale by introducing a new OF platform driver for both, the
>>> MPC521x and MPC5200, while still keeping the old driver for the MPC5200
>>> for compatibility with older kernel versions.
>> Hi Wolfgang,
>>
>> there seems to be something missing, because I get a compilation error
>> on lite-5200:
>> http://sisyphus.hd.free.fr/~gilles/bx/#powerpc
> 
> Well, I obviously did not test the driver with old versions of the Linux
> kernel, sorry. 

No problem, that is what the build test is for.


> For 2.6.29 and 2.6.30 the following patch should fix the build:

Ok. I applied a slightly different modification (fixing in wrappers.h).
I am waiting for your fix for 2.4 for pushing.


> For 2.4 I will have a close look now.
> 
> This proves, your regression test build tool is really useful.

That is, if you assume people in the wild are trying older versions...

-- 
					    Gilles.

