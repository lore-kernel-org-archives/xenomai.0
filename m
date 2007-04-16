Message-ID: <4623820C.6060306@domain.hid>
Date: Mon, 16 Apr 2007 16:02:52 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <403B28AE6257B548B66BB88414AC78330174BBCE@STEGOSAURE.adetel.com>
In-Reply-To: <403B28AE6257B548B66BB88414AC78330174BBCE@STEGOSAURE.adetel.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] AT91SAM9261 adeos support for 2.6.19 kernel
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: BOUIN Alexandre <abouin@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

BOUIN Alexandre wrote:
> ---|------------|------------|------------|--------|-------------------------
> RTS|      14.501|      47.532|      81.368|       0|    00:00:37/00:00:37

A test of 37 seconds is definitely not enough. You should let the test
run for at least a few hours. And if you do not see latencies higher
than 100 microseconds you are probably not loading the system enough or
the AT91SAM9261 is much better than other ARMs.

-- 
                                                 Gilles Chanteperdrix

