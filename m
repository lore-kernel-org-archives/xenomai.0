Message-ID: <4E552695.7090401@domain.hid>
Date: Wed, 24 Aug 2011 18:28:05 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAL+uwv-D111pO40ZT=ipXU+V1Ss8Fi4L1DfXWj=o+f2UxFubaA@mail.gmail.com>	<4E54EAE4.2060705@domain.hid>	<CAL+uwv9Lg6uhqwy_YMxevFt4e8RJLrxZhm186L4-0xAHYDgLUw@domain.hid>	<4E54F5B4.5070100@domain.hid>
	<CAL+uwv_429MvgmL8urkFc+4KWqRj328F7AhZUMc_u-UwjO_Gzg@domain.hid>
In-Reply-To: <CAL+uwv_429MvgmL8urkFc+4KWqRj328F7AhZUMc_u-UwjO_Gzg@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Hanging
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: suresh reddy <sureshreddy.balijepalli@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On 08/24/2011 04:12 PM, suresh reddy wrote:
> Thank you Giles.
> 
> yes .The rt_printf is single-writer/ single -reader.

No, each thread has a buffer. But the point is that the thread which
empties the buffers and prints them run in secondary mode, so, it will
not run if there is always a real-time thread running, the buffer will
fill up, and nothing will be printed.

-- 
					    Gilles.

