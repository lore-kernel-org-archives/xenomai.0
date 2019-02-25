Subject: Re: Fwd: Debugging system freeze, SIGXCPU
References: <CAJA_znn4P=_tmbcKCipcmYrhPUhFw4JrMWv2VAMVR0DYSx9iMA@mail.gmail.com>
 <CAJA_znnmCr7QSjsnSQbLRYTM+CyBex05sBV0gbOdVQgYuBK0Tw@mail.gmail.com>
 <0509ec7d-20b3-bc38-7a04-7516f24249a1@xenomai.org>
 <CAJA_znmGTe3C5-YoxYH1ufN7j8rrRgA_Pd8+7cYtP673C8Bhiw@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <22ae4956-2359-6fda-02ed-c174df3dd015@siemens.com>
Date: Mon, 25 Feb 2019 18:28:12 +0100
MIME-Version: 1.0
In-Reply-To: <CAJA_znmGTe3C5-YoxYH1ufN7j8rrRgA_Pd8+7cYtP673C8Bhiw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ari Mozes <arimozes@neocisinc.com>, xenomai@xenomai.org

On 25.02.19 17:57, Ari Mozes via Xenomai wrote:
> Philippe,
> Thank you for the information and the URL.
> I read through the thread, and I agree with comments that it would be
> helpful to be able to identify/blacklist/etc problematic calls when
> porting over existing code to a true RT scenario.  In our case the
> original code was written with "RT-like" behavior in mind, but as
> there is a lot of code already in place, approaches to identify
> existing problematic calls would be helpful.

You could wrap such calls like we do for malloc/free in libcobalt. But wrapping 
only works if the direct caller is processed that way - and is not some 
pre-built external library.

Therefore: Do not use libraries that you didn't validate from within 
time-sensitive code paths. Also libstdc++ may contain more surprises.

Jan

> I will continue to familiarize myself with the nitty-gritty details,
> but anything that makes the process easier is always welcome :-)
> 
> Ari
> 
> 
> On Mon, Feb 25, 2019 at 11:08 AM Philippe Gerum <rpm@xenomai.org> wrote:
>>
>> On 2/25/19 2:32 PM, Ari Mozes via Xenomai wrote:
>>> Resending this question with testcase.
>>> Can someone give the testcase a try to see if it reproduces the problem I
>>> am seeing?  Is more information needed?
>>> It takes a couple of minutes before I see the issue occur.
>>
>> The random lockup is due to std::chrono::high_resolution_clock::now()
>> invoking the vDSO form of clock_gettime().
>>
>> SIGXCPU aka Xenomai's SIGDEBUG may be sent by the core in various
>> situations, but since the code does not set the T_WARNSW for any task,
>> the only explanation is receiving a Xenomai watchdog notification. See
>> the help information about CONFIG_XENO_OPT_WATCHDOG in your kernel
>> configuration.
>>
>> After a few secs spinning in the vDSO code which may not be called from
>> real-time context, the Xenomai core pulls the break and sends SIGXCPU to
>> the offending process, unless the system locks up before the watchdog
>> could even trigger.
>>
>> Solution: use clock_gettime(CLOCK_HOST_REALTIME) instead of
>> std::chrono::high_resolution_clock::now() for getting timestamps.
>>
>> A related discussion is available at this URL:
>> https://www.xenomai.org/pipermail/xenomai/2018-December/040133.html
>>
>> --
>> Philippe.
> 
> 
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

