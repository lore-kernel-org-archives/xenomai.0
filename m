Message-ID: <4DB94F19.3080408@domain.hid>
Date: Thu, 28 Apr 2011 13:27:21 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4DB8149A.7080600@domain.hid> <4DB83CBE.5040007@domain.hid>
	<4DB94BA0.1020503@domain.hid> <4DB94C9C.7080904@domain.hid>
	<4DB94E61.6070701@domain.hid>
In-Reply-To: <4DB94E61.6070701@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] Ipipe hangs on ARM MINI2440 after switching
	clocksource
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Alexey Galakhov <agalakhov@domain.hid>
Cc: adeos-main@gna.org

Alexey Galakhov wrote:
> On 04/28/2011 05:16 PM, Gilles Chanteperdrix wrote:
>> Alexey Galakhov wrote:
>>> Going to try kgdb over serial line.
>> Ok. Better try without this patch first, then try reapplying the patch
>> when you are certain that everything else works correctly. The patch
>> enables some assembly code that was never actually tested. On my side, I
>> will try and test it separately.
> That's exactly what I want to do.
> 
> Is there any documentation on ipipe's internals involved in time.c ?
> Reading C code is certainly not the fastest way to understand how things
> work :)

http://www.xenomai.org/index.php/I-pipe:ArmPorting

The parts about the tsc and gpio demuxing are outdated. But the part
about the timer is still correct.

-- 
                                                                Gilles.

