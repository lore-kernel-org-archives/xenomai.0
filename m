Message-ID: <53BEDB15.7020606@xenomai.org>
Date: Thu, 10 Jul 2014 20:27:33 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1404210421-17081-1-git-send-email-maxime.ripard@free-electrons.com>
 <53B294A7.5010803@xenomai.org> <20140701141536.GN28647@lukather>
 <53B30D96.60500@xenomai.org> <20140704092736.GC13487@lukather>
 <53B7B3BF.3090807@xenomai.org> <20140707160239.GF13423@lukather>
 <53BAC5C4.5060704@xenomai.org> <20140708125505.GN13423@lukather>
 <53BC2AB5.4050801@xenomai.org> <20140710150540.GE27469@lukather>
In-Reply-To: <20140710150540.GE27469@lukather>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] AT91: SAMA5D3: Adapt Ipipe for AIC5
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Thomas Petazzoni <thomas@free-electrons.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Boris Brezillon <boris@free-electrons.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, xenomai@xenomai.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 07/10/2014 05:05 PM, Maxime Ripard wrote:
> On Tue, Jul 08, 2014 at 07:30:29PM +0200, Gilles Chanteperdrix
> wrote:
>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
>> 
>> On 07/08/2014 02:55 PM, Maxime Ripard wrote:
>>> On Mon, Jul 07, 2014 at 06:07:32PM +0200, Gilles Chanteperdrix 
>>> wrote:
>>>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
>>>> 
>>>> On 07/07/2014 06:02 PM, Maxime Ripard wrote:
>>>>> On Sat, Jul 05, 2014 at 10:13:51AM +0200, Gilles
>>>>> Chanteperdrix wrote:
>>>>>>>>> Ok, so, with the changes you mentionned, I can't
>>>>>>>>> make the system crash anymore (or at least, not as
>>>>>>>>> easily as it used to be).
>>>>>>>>> 
>>>>>>>>> But: - whenever the program mentionned above calls 
>>>>>>>>> exit(), it stalls. However, ctrl+c makes the
>>>>>>>>> program exit properly, and everything seems fine
>>>>>>>>> otherwise - whenever we don't link it against
>>>>>>>>> xenomai, it just hangs. I've not figured out why
>>>>>>>>> yet
>>>>>>>>> 
>>>>>>>>> With CONFIG_XENOMAI and CONFIG_IPIPE disabled, it 
>>>>>>>>> works fine.
>>>>>>>> 
>>>>>>>> My answer was wrong, you probably need to keep the 
>>>>>>>> set_backup/clear_backup calls in he ->hold and
>>>>>>>> ->release callbacks, as the linux interrupt may
>>>>>>>> expect the backup areas to be in sync. Did you do
>>>>>>>> this, or did you go for the alternative?
>>>>>>> 
>>>>>>> I went for the alternative. I'm sending you a v2 with
>>>>>>> what I have so far, that shows the behaviour I was
>>>>>>> describing.
>>>>>> 
>>>>>> Could you try the following patch?
>>>>> 
>>>>> It actually works much better, thanks!
>>>>> 
>>>>> The above mentionned issues are gone, there's only one
>>>>> last glitch I guess. The max latency under load is around a
>>>>> few 100's of ms (while idle, it's actually around
>>>>> 200-300us, which seems more reasonable.
>>>> 
>>>> 200us or 300us seems high for a last generation cortex. 
>>>> milliseconds issues indicate an issue, does the msw column
>>>> in latency increment?
>>> 
>>> Ok, so after spending more time running xeno-test and latency
>>> 
>>> * xeno-test -l "dohell -s 192.168.0.42 -p 5566 -b 
>>> /usr/bin/hackbench 60" - the average latency measured is 37us,
>>> with a max at 53
>>> 
>>> * If I just use the same load generator program I was using 
>>> previously (which basically just run hackbench, dohell, do some
>>> dd, output some data through netcat, etc.), and latency, for 45
>>>  minutes, I get an average latency at 35us, and a max latency
>>> at 60.
>>> 
>>> So the issue seems to lie in something related to our test 
>>> program.
>>> 
>>> It's actually using CLOCK_MONOTONIC. When running just
>>> Xenomai's clocktest program, the drift is OK, but the ToD
>>> offset is quite huge and varies slightly from one run to
>>> another. This also happens using CLOCK_REALTIME.
>>> 
>>> From what I understand of the POSIX clocks, gettimeofday is
>>> always using EPOCH as a starting point, while POSIX clocks can
>>> pick whatever fixed starting point, so an offset might be
>>> expected. What's weird is that it whenever you use the
>>> CLOCK_HOST_REALTIME, which is used by xeno-test, and should be
>>> in sync with the Linux clock, this offset is no longer there.
>>> 
>>> That's the only meaningful difference I could spot between the
>>> two programs (ours vs clocktest).
>> 
>> The test you are interested in is latency, not clocktest. The
>> main differences between latency and the test you run are: - -
>> the "period" (which BTW, in your case would only be a real period
>> if you removed the call to clock_gettime at the beginning of the
>> loop, only keeping the one before the loop), which is 1ms in
>> latency case, 100us in your case
> 
> I don't really get what you mean here. If we don't call gettime at
> the beginning of the loop, but only outside, how are we supposed to
> get the next sleep expiration time?
> 
>> - - the fact that your function timespec_diff returns unsigned
>> value, so in case of early shot, you will get a very large value
>> instead of a negative ones.
>> 
>> As a general rule, we prefer Xenomai users to use the latency
>> test, because this is the one we collectively spent time
>> debugging, so it has more chances to be correct, and if you find
>> a bug, everyone benefits from the fix.
> 
> Yes, I don't doubt that latency is much more tested and reliable.
> 
> The thing is, as you probably know, we're also a training company,
> and we're using this script in our training to give an idea of the
> latency on a regular linux kernel, and then on xenomai. It also
> have the benefit of being simple enough for the trainees to be able
> to understand it rather quickly.

Xenomai 2.6 also compiles the cyclictest test, which is part of
preempt_rt testsuite, so you  can use cyclictest as a common tool to
measure latency for all rt solutions.


- -- 
                                                                Gilles.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iD8DBQFTvtsUGpcgE6m/fboRAvynAJ9tuJTt58GWoKQX/uhPMj2OZZRlzgCfWDfr
JYwKcAJO44QZyGcAVJfoIw4=
=Fvho
-----END PGP SIGNATURE-----

