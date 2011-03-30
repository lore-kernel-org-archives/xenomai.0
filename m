Message-ID: <4D93B154.7030806@domain.hid>
Date: Thu, 31 Mar 2011 00:40:20 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTi=LM5LNr1mT-f3xY-w-ATzRNPZX3hPVsFpG=TnC@mail.gmail.com>	<4D89A334.4090802@domain.hid>	<AANLkTikiEN7Pd-F2FqgXf9MGSTqg1wq_KxsumfZeR5xX@mail.gmail.com>	<4D93A7F9.8060108@domain.hid>	<AANLkTinmEU=a6SP4yf_jVDSVS8gTuNH-6N5ALT7aT4uT@mail.gmail.com>
	<4D93AC71.7040700@domain.hid>
In-Reply-To: <4D93AC71.7040700@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] CLOCK_REALTIME synchronized to NTP
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeff Weber <jwamsc@domain.hid>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> Jeff Weber wrote:
>> On Wed, Mar 30, 2011 at 5:00 PM, Gilles Chanteperdrix <
>> gilles.chanteperdrix@xenomai.org> wrote:
>>
>>> Jeff Weber wrote:
>>>> On Wed, Mar 23, 2011 at 2:37 AM, Gilles Chanteperdrix <
>>>> gilles.chanteperdrix@xenomai.org> wrote:
>>>>
>>>>> Jeff Weber wrote:
>>>>>> I need to timetag events from a realtime context with a
>>> NPT-synchronized
>>>>>> system clock.  This topic comes up periodically on the mailing list.
>>>>>  Last I
>>>>>> recall, there was talk of adding the capability via an alternate
>>>>>> (non-CLOCK_REALTIME) clock_id. What is the status of this topic?
>>>>> The CLOCK_HOST_REALTIME is available in the xenomai-head branch (to be
>>>>> 2.6 branch, soon). It requires modifications of the I-pipe patch which
>>>>> are available, at least, on x86, but are probably not really hard to
>>>>> implement on other platforms.
>>>>>
>>>>  clock_gettime(CLOCK_HOST_REALTIME) fails when called from kernel, and
>>> from
>>>> clocktest.  Any ideas why?
>>>> Does the CLOCK_HOST_REALTIME need to be initialized in some way?
>>>> Test and config follow.
> 
> It definitely works here with clocktest. I get, for instance:

... and it definitely does not work with a 32 bits kernel.

-- 
                                                                Gilles.

