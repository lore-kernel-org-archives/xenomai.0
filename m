Message-ID: <4E70EA11.6060502@domain.hid>
Date: Wed, 14 Sep 2011 19:53:21 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <CANKLDms-kVpt6hk7adH880tK5xJL2=D9Y=M25Cn-0hBDueuUfQ@mail.gmail.com>
	<4E70A876.3020009@domain.hid> <4E70AADF.6010201@domain.hid>
	<1316011174.8027.7.camel@domain.hid>
In-Reply-To: <1316011174.8027.7.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] multicore: reserving core(s) for Xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Henry Bausley <hbausley@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2011-09-14 16:39, Henry Bausley wrote:
> Jan does the lack of 100% isolation imply if a Xenomai kernel thread
> running on the isolated CPU used to much duty cycle Linux would lock up
> since it couldn't get a chance at the isolated cpu.

Yep - just like some plain Linux RT thread running as CPU hog on a
vanilla kernel with highest prio and rt-group throttling disabled.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

