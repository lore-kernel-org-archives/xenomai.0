Message-ID: <4F75C7D1.4020808@domain.hid>
Date: Fri, 30 Mar 2012 16:48:49 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <CAGq8jPhOy=v8Lccb+hddH9W_u8p-Ayi+XfEcFC+rHVzsSp-ghg@domain.hid>	<4F7555F7.6010102@domain.hid>	<CAGq8jPioLnu+ehj+LA5dL6OWUpxQnUH+Nh01kB088FtsLsSrGA@mail.gmail.com>	<CAGq8jPi4S4TTBy9dLYYnWuWQdX_awhXxu0C93okgFO5vWv_20A@mail.gmail.com>	<4F75B5BF.8030401@domain.hid>
	<CAGq8jPgY6fTw0ufdj=pvc+Q1jrrQkYptSHTzFOQK=qSiJJU32Q@mail.gmail.com>
In-Reply-To: <CAGq8jPgY6fTw0ufdj=pvc+Q1jrrQkYptSHTzFOQK=qSiJJU32Q@mail.gmail.com>
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

On 03/30/2012 04:34 PM, Minh GIANG wrote:
> hi,
> 
> with option RTSER_RTIOC_WAIT_EVENT in rt_dev_ioctl(), this function returns
> un number -110 (Connection timed out)
> with option RTSER_RTIOC_GET_STATUS in rt_dev_ioctl(), this function returns
> un number 0 (not message)

You should call this function *after* the timeout happened. What does
the "struct rtser_status"  contain? Especially the "line_status" is of
interest.

> 
> Anyway, currently it works without  rt_dev_ioctl(), i can see rt_dev_read()
> wait data event (with debug mode) while giving the period of write
> task,  for exemple  = two seconds.
> 
> so can i remove the funtion rt_dev_ioctl?

The rt_dev_ioctl should work. You can remove it, but the problem will
remain. To debug the problem you could also add some printk's here:

http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/drivers/serial/16550A.c#223

Especially the value of "iir" might be interesting.

Wolfgang.

