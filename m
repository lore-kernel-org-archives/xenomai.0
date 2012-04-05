Message-ID: <4F7D7A43.4060502@domain.hid>
Date: Thu, 05 Apr 2012 12:56:03 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <CAGq8jPhOy=v8Lccb+hddH9W_u8p-Ayi+XfEcFC+rHVzsSp-ghg@domain.hid>	<4F7555F7.6010102@domain.hid>	<CAGq8jPioLnu+ehj+LA5dL6OWUpxQnUH+Nh01kB088FtsLsSrGA@mail.gmail.com>	<CAGq8jPi4S4TTBy9dLYYnWuWQdX_awhXxu0C93okgFO5vWv_20A@mail.gmail.com>	<4F75B5BF.8030401@domain.hid>	<CAGq8jPgY6fTw0ufdj=pvc+Q1jrrQkYptSHTzFOQK=qSiJJU32Q@mail.gmail.com>	<4F75C7D1.4020808@domain.hid>	<CAGq8jPhqv16jgPQh631x8S2MmDhm1F4HtnrQA0xsGPe4bTo6eA@mail.gmail.com>	<4F79D5EA.3010501@domain.hid>
	<CAGq8jPjq79CdBbNys1=ccV-CKSyNfG9nX-1L31Ar6WShuNE=HQ@mail.gmail.com>
In-Reply-To: <CAGq8jPjq79CdBbNys1=ccV-CKSyNfG9nX-1L31Ar6WShuNE=HQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
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
To: Minh GIANG <giang.hminh@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

On 04/04/2012 11:18 AM, Minh GIANG wrote:
> hello,
> 
> i did what you told me, i compiled the kernet with patch which you send me,
> and the result of dmesg
> 
> [ 1636.156641] base=0x2f8 iir=0x1
> [ 1636.157672] base=0x2f8 iir=0x4
> [ 1636.157675] base=0x2f8 status=0x100
> [ 1636.157677] base=0x2f8 iir=0x1
> [ 1636.158713] base=0x2f8 iir=0x4
> [ 1636.158715] base=0x2f8 status=0x100
> [ 1636.158717] base=0x2f8 iir=0x1
> [ 1636.250404] base=0x3f8 iir=0x2
> [ 1636.250407] base=0x3f8 status=0x0
> [ 1636.250410] base=0x3f8 iir=0x1
> [ 1636.251425] base=0x2f8 iir=0x4
> [ 1636.251427] base=0x2f8 status=0x100
> [ 1636.251429] base=0x2f8 iir=0x1
> [ 1636.252016] base=0x2f8 iir=0x4
> [ 1636.252016] base=0x2f8 status=0x100
> [ 1636.252016] base=0x2f8 iir=0x1
> [ 1636.252016] base=0x2f8 iir=0x4
> [ 1636.252016] base=0x2f8 status=0x100
> [ 1636.252016] base=0x2f8 iir=0x1
> [ 1636.252016] base=0x2f8 iir=0x4
> [ 1636.252016] base=0x2f8 status=0x100
> [ 1636.252016] base=0x2f8 iir=0x1
> [ 1636.252016] base=0x2f8 iir=0x4
> [ 1636.252016] base=0x2f8 status=0x100
> [ 1636.252016] base=0x2f8 iir=0x1
> [ 1636.256619] base=0x2f8 iir=0x4
> [ 1636.256621] base=0x2f8 status=0x100
> [ 1636.256623] base=0x2f8 iir=0x1
> [ 1636.257665] base=0x2f8 iir=0x4
> [ 1636.257668] base=0x2f8 status=0x100
> [ 1636.257670] base=0x2f8 iir=0x1
> [ 1636.258693] base=0x2f8 iir=0x4
> [ 1636.258696] base=0x2f8 status=0x100
> [ 1636.258698] base=0x2f8 iir=0x1
> 
> i wait your response

Looks pretty normal, at a first glance. Could you please send a longer
trace covering more than one cycle? I will then have a closer look after
eastern.

BTW: what Xenomai and Linux kernel version do you use?

Wolfgang.

