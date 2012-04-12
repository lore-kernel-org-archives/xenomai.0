Message-ID: <4F8689BD.4050508@domain.hid>
Date: Thu, 12 Apr 2012 09:52:29 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <CAGq8jPhOy=v8Lccb+hddH9W_u8p-Ayi+XfEcFC+rHVzsSp-ghg@domain.hid>	<4F7555F7.6010102@domain.hid>	<CAGq8jPioLnu+ehj+LA5dL6OWUpxQnUH+Nh01kB088FtsLsSrGA@mail.gmail.com>	<CAGq8jPi4S4TTBy9dLYYnWuWQdX_awhXxu0C93okgFO5vWv_20A@mail.gmail.com>	<4F75B5BF.8030401@domain.hid>	<CAGq8jPgY6fTw0ufdj=pvc+Q1jrrQkYptSHTzFOQK=qSiJJU32Q@mail.gmail.com>	<4F75C7D1.4020808@domain.hid>	<CAGq8jPhqv16jgPQh631x8S2MmDhm1F4HtnrQA0xsGPe4bTo6eA@mail.gmail.com>	<4F79D5EA.3010501@domain.hid>	<CAGq8jPjq79CdBbNys1=ccV-CKSyNfG9nX-1L31Ar6WShuNE=HQ@mail.gmail.com>	<4F7D7A43.4060502@domain.hid>	<CAGq8jPhqRN0WTKHC1uJXbHyecX_tKOB6zFnDJ4=DbKtzU3mmcA@mail.gmail.com>	<CAGq8jPgON96yy7_wOCSs83QwxVrfSsTn-fe1P+EBZ8-KLMfj0A@mail.gmail.com>	<4F8592F3.6070907@domain.hid>	<4F85B7BE.9080706@domain.hid>	<4F85B869.2060102@domain.hid>	<4F85D505.6080002@domain.hid>
	<CAGq8jPj4dNaukTMZXo6+C=UA-TfpP5h9FOU07FUTnX0TTDsqCA@mail.gmail.com>
In-Reply-To: <CAGq8jPj4dNaukTMZXo6+C=UA-TfpP5h9FOU07FUTnX0TTDsqCA@mail.gmail.com>
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

On 04/11/2012 10:51 PM, Minh GIANG wrote:
> ok for CC, i was afraid of spam everyone by my mail. I answer your
> questions.
> 
> - non, i didn't modify cross-link program  (even if i used to modify this
> program to make it run, but it worked the same way)
> 
> - Xenomai 2.6

What version (cat /proc/xenomai/version)?

> 
> - Linux 2.6.38 and patch Adeos 2.6.38 of course
> 
> - i build the program in Eclipse C++ so my command in setting configuration
> is
> 
> command :   g++
> All options:   -l/usr/xenomai/include -O3 -wall -c -fmessage-length=0

That bogous! Please try the image created as shown below:

  $ cd <xenomai-2.6-path>/examples/rtdm/profiles/serial
  $ make XENO=/usr/xenomai/bin

Wolfgang.

