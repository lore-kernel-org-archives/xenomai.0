Message-ID: <4628DBE8.7070106@domain.hid>
Date: Fri, 20 Apr 2007 17:27:36 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <403B28AE6257B548B66BB88414AC78330174BBD9@domain.hid>
In-Reply-To: <403B28AE6257B548B66BB88414AC78330174BBD9@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] New patch for AT91SAM9261 adeos support for 2.6.19
 kernel
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: BOUIN Alexandre <abouin@domain.hid>
Cc: adeos-main@gna.org

BOUIN Alexandre wrote:
> The clock settings of the AT91SAM9261-EK board I am using, displayed by the
> kernel are:
> Clocks: Clocks: CPU 198 MHz, master 99 MHz, main 18.432 MHz
> 
> Running a 2.6.19 I-pipe kernel, setting the nucleus latency
> (/proc/xenomai/latency) to 323us

It is a high. You should get plenty of negative values.


>, I get a worst case latency of 231 us

What is your kernel configuration, do not you have some statistics/debug
options enabled ?

-- 
                                                 Gilles Chanteperdrix

