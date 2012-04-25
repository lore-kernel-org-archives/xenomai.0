Message-ID: <4F97C395.4080306@domain.hid>
Date: Wed, 25 Apr 2012 11:27:49 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <CAGq8jPhOy=v8Lccb+hddH9W_u8p-Ayi+XfEcFC+rHVzsSp-ghg@domain.hid>	<4F75B5BF.8030401@domain.hid>	<CAGq8jPgY6fTw0ufdj=pvc+Q1jrrQkYptSHTzFOQK=qSiJJU32Q@mail.gmail.com>	<4F75C7D1.4020808@domain.hid>	<CAGq8jPhqv16jgPQh631x8S2MmDhm1F4HtnrQA0xsGPe4bTo6eA@mail.gmail.com>	<4F79D5EA.3010501@domain.hid>	<CAGq8jPjq79CdBbNys1=ccV-CKSyNfG9nX-1L31Ar6WShuNE=HQ@mail.gmail.com>	<4F7D7A43.4060502@domain.hid>	<CAGq8jPhqRN0WTKHC1uJXbHyecX_tKOB6zFnDJ4=DbKtzU3mmcA@mail.gmail.com>	<CAGq8jPgON96yy7_wOCSs83QwxVrfSsTn-fe1P+EBZ8-KLMfj0A@mail.gmail.com>	<4F8592F3.6070907@domain.hid>	<4F85B7BE.9080706@domain.hid>	<4F85B869.2060102@domain.hid>	<4F85D505.6080002@domain.hid>	<CAGq8jPj4dNaukTMZXo6+C=UA-TfpP5h9FOU07FUTnX0TTDsqCA@mail.gmail.com>	<4F8689BD.4050508@domain.hid>	<CAGq8jPgV3aQrz6-Y0LqrjT1HA2udHG887o1EFd4bS5eFvp6gkw@domain.hid>	<4F87036D.1050605@domain.hid>
	<CAGq8jPi17=r6=k0Zayfky-Z7_7gtopf=ManFBp+9_v0nGe301w@domain.hid>
In-Reply-To: <CAGq8jPi17=r6=k0Zayfky-Z7_7gtopf=ManFBp+9_v0nGe301w@domain.hid>
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

On 04/25/2012 11:11 AM, Minh GIANG wrote:
> hello,
> 
> Thank you for helping me solve my problem.
> 
> You recommend me to update to a more recent version. But I think the
> xenomai version 2.6.0 is the lastest version over http://www.xenomai.org
>  site.

You are right. The latest fixes are in the git repository, which you can
get with the following command:

  $ git clone git://git.xenomai.org/xenomai-2.6.git

> By the way, i have a short question. When i make run cross-link program, i
> don't understand why there is a leak memory. Even if, i try to remove all
> parasite in while loop, but the leak memory is always constant. i think the
> problem comes from rt_dev_write() or rt_dev_read() which don't release the
> memory buffer. im wrong?

What makes you think that there is a memory leak? How do you observe it
and what is running while your are testing with cross-link?

Wolfgang.


