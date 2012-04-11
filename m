Message-ID: <4F85B7BE.9080706@domain.hid>
Date: Wed, 11 Apr 2012 18:56:30 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAGq8jPhOy=v8Lccb+hddH9W_u8p-Ayi+XfEcFC+rHVzsSp-ghg@domain.hid>	<4F7555F7.6010102@domain.hid>	<CAGq8jPioLnu+ehj+LA5dL6OWUpxQnUH+Nh01kB088FtsLsSrGA@mail.gmail.com>	<CAGq8jPi4S4TTBy9dLYYnWuWQdX_awhXxu0C93okgFO5vWv_20A@mail.gmail.com>	<4F75B5BF.8030401@domain.hid>	<CAGq8jPgY6fTw0ufdj=pvc+Q1jrrQkYptSHTzFOQK=qSiJJU32Q@mail.gmail.com>	<4F75C7D1.4020808@domain.hid>	<CAGq8jPhqv16jgPQh631x8S2MmDhm1F4HtnrQA0xsGPe4bTo6eA@mail.gmail.com>	<4F79D5EA.3010501@domain.hid>	<CAGq8jPjq79CdBbNys1=ccV-CKSyNfG9nX-1L31Ar6WShuNE=HQ@mail.gmail.com>	<4F7D7A43.4060502@domain.hid>	<CAGq8jPhqRN0WTKHC1uJXbHyecX_tKOB6zFnDJ4=DbKtzU3mmcA@mail.gmail.com>	<CAGq8jPgON96yy7_wOCSs83QwxVrfSsTn-fe1P+EBZ8-KLMfj0A@mail.gmail.com>
	<4F8592F3.6070907@domain.hid>
In-Reply-To: <4F8592F3.6070907@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Cross-link.c ---RTSER_RTIOC_WAIT_EVENT
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

On 04/11/2012 04:19 PM, Wolfgang Grandegger wrote:
> Hi,
> 
> On 04/05/2012 02:46 PM, Minh GIANG wrote:
>> i'm sorry sir, what i displayed just in the last mail, isn't good, because
>> i removed rt_dev_ioctl(...) in cross-link program
>> And then, with  rt_dev_ioctl( RTSER_RTIOC_WAIT_EVENT ).
>>
>> [93076.465077] base=0x2f8 iir=0x4
>> [93076.465082] base=0x2f8 status=0x0
>> [93076.465084] base=0x2f8 iir=0x1
> 
> TX on rtser0:
> 
>> [93076.556794] base=0x3f8 iir=0x2
>> [93076.556799] base=0x3f8 status=0x0
>> [93076.556801] base=0x3f8 iir=0x1
> 
> RX of 8 chars on rtser1:
> 
>> [93076.557819] base=0x2f8 iir=0x4
>> [93076.557823] base=0x2f8 status=0x0
>> [93076.557825] base=0x2f8 iir=0x1
> 
>> [93076.558860] base=0x2f8 iir=0x4
>> [93076.558865] base=0x2f8 status=0x0
>> [93076.558867] base=0x2f8 iir=0x1
> 
>> [93076.559898] base=0x2f8 iir=0x4
>> [93076.559901] base=0x2f8 status=0x0
>> [93076.559903] base=0x2f8 iir=0x1
> 
>> [93076.560943] base=0x2f8 iir=0x4
>> [93076.560946] base=0x2f8 status=0x0
>> [93076.560948] base=0x2f8 iir=0x1
> 
>> [93076.561969] base=0x2f8 iir=0x4
>> [93076.561971] base=0x2f8 status=0x0
>> [93076.561973] base=0x2f8 iir=0x1
> 
>> [93076.563006] base=0x2f8 iir=0x4
>> [93076.563009] base=0x2f8 status=0x0
>> [93076.563011] base=0x2f8 iir=0x1
> 
>> [93076.564012] base=0x2f8 iir=0x4
>> [93076.564012] base=0x2f8 status=0x0
>> [93076.564012] base=0x2f8 iir=0x1
> 
>> [93076.564012] base=0x2f8 iir=0x4
>> [93076.564012] base=0x2f8 status=0x0
>> [93076.564012] base=0x2f8 iir=0x1
> 
> TX on rtser0:
> 
>> [93076.656766] base=0x3f8 iir=0x2
>> [93076.656770] base=0x3f8 status=0x0
>> [93076.656772] base=0x3f8 iir=0x1
> 
> RX on rtser1:
> 
>> [93076.657793] base=0x2f8 iir=0x4
>> [93076.657795] base=0x2f8 status=0x0
>> [93076.657797] base=0x2f8 iir=0x1
> 
> ... and so on.
> 
> This looks completely normal and I'm really puzzled why the
> rt_dev_ioctl(RTSER_RTIOC_WAIT_EVENT) does not work as expected. Ah, I
> just realized that the following patch was not yet applied:
> 
> https://mail.gna.org/public/xenomai-core/2011-11/msg00009.html
> 
> I think it will fix your problem.

Sorry, it looks like I completely forgot this patch. Could you rebase it
on the current contents of xenomai-2.6 so that I can merge it?

-- 
                                                                Gilles.

