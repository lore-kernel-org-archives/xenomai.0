Message-ID: <4EF2FCD9.5010105@domain.hid>
Date: Thu, 22 Dec 2011 10:48:09 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4EF27CD5.4060603@domain.hid>
In-Reply-To: <4EF27CD5.4060603@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] hang in rtcansend
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Andrew Tannenbaum <trb@domain.hid>
Cc: xenomai@xenomai.org

On 12/22/2011 01:41 AM, Andrew Tannenbaum wrote:
> If I just run rtcansend with no args (so it prints a help message), it
> exits ok on 2.6.0 with no hang.  But if I run rtcansend or rtcanrecv
> with any CAN i/o, they hang in the cleanup function, though they do
> their processing before then correctly.
> 
> Any idea why rtcansend/recv would hang for me here on 2.6.0?

Is this behaviour reproducible with the virtual rtcan driver?


-- 
					    Gilles.

