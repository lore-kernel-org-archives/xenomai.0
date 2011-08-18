Message-ID: <4E4D65B9.2090901@domain.hid>
Date: Thu, 18 Aug 2011 15:19:21 -0400
From: Andrew Tannenbaum <trb@domain.hid>
MIME-Version: 1.0
References: <4E4D60C9.1020409@domain.hid>
In-Reply-To: <4E4D60C9.1020409@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] odd code for loopback option in
	/src/utils/can/rtcansend.c
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org, Wolfgang Grandegger <wg@domain.hid>

Andrew Tannenbaum wrote:

> It looks like the default value for loopback is -1, and if you set it to
> 0 or 1, it turns loopback on, which seems strange. I don't understand
> rt_dev_setsockopt() fully, so I'm not sure if it's a bug - I don't know
> if -1 and 0 and 1 are three separate loopback states, but I think it
> merits attention. I think either the code is wrong or the help string
> and man page are not clear.

Ah, I see what it's doing.  It's changing an existing state, so there 
are three choices:

-1: no change
0: clear
1: set

So the code looks correct.

-Andy

