Message-ID: <50AB9D18.9070902@xenomai.org>
Date: Tue, 20 Nov 2012 16:09:12 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CANzNmi-O4C=z-sXqrq7HMTQ=B2apBBnZMco0p-_iHmfuu+Jexg@mail.gmail.com>	<50AA4EC2.1000206@xenomai.org>
	<CANzNmi-dFbx043zCszBwYu2yZh3awGkRAArwOnaTq3k=ijffdA@mail.gmail.com>
	<50AA5B96.9060009@xenomai.org> <50AB9449.2020203@gmail.com>
	<50AB96A0.3060204@xenomai.org> <50AB9991.9090901@gmail.com>
In-Reply-To: <50AB9991.9090901@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On 11/20/2012 03:54 PM, Sebastian Pavez wrote:
> El 20/11/2012 11:41 a.m., Gilles Chanteperdrix escribió:
>> On 11/20/2012 03:31 PM, Sebastian Pavez wrote:
>>> ioctl(RTTST_RTIOC_SWTEST_CREATE_KTASK): Cannot allocate memory
>> You still do not have enough memory.
>>
> Ok,
> I have 256 kb for CONFIG_XENO_OPT_SYS_HEAPSZ and 128 kb for 
> CONFIG_XENO_OPT_SYS_STACKPOOLSZ.
> There's a recommended value to these? or I should try a value and look 
> how they works?
> In any case, I'll try to put 512kb for both ...

The default values are for 1 core. If you have 6 cores, multiply by 6.


-- 
					    Gilles.

