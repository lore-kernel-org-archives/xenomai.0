Message-ID: <4E1C2FAE.2060103@domain.hid>
Date: Tue, 12 Jul 2011 13:27:42 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAG1VJdr9-_WbBTg+L7tAT8+aGOM7oH844F3NfcRmQrHLcCvpAw@domain.hid>
	<4E1ADEA7.30003@domain.hid>
	<CAG1VJdoogk8gUPxct1LQ32mtK4ezBDnDpah45fhrUcm6W_JNyw@domain.hid>
	<CAG1VJdqzY1d09hddO1-uRYuDYY2oVxMQpwzVpt6Yf-mWRYi9pA@mail.gmail.com>
In-Reply-To: <CAG1VJdqzY1d09hddO1-uRYuDYY2oVxMQpwzVpt6Yf-mWRYi9pA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Compiling Library files over Xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Ashish Budhiraja <ashishmach@domain.hid>
Cc: xenomai@xenomai.org

On 07/12/2011 01:10 PM, Ashish Budhiraja wrote:
> Hello Again,
> 
> Thanks a lot. I figured out, actually somehow "inline" declaration were not
> allowed and the library is really complex,
> so I couldn't change it. The solution was to change it to static.

inline declarations are allowed in C, simply, the inline functions must
be static as well.


-- 
                                                                Gilles.

