Message-ID: <4CC2C8AB.70708@domain.hid>
Date: Sat, 23 Oct 2010 13:36:11 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1281709057.650414331@domain.hid> <4C65583D.3030800@domain.hid>
	<1281960823.030215299@domain.hid> <4C692FC3.5040802@domain.hid>
	<1283531433.789315367@domain.hid>
	<1283590285.1709.2153.camel@domain.hid>
	<1287134519.029617765@domain.hid>
	<1287143691.028416668@domain.hid> <4CB85C64.9040307@domain.hid>
	<1287496324.10921156@domain.hid> <4CBDF92F.20403@domain.hid>
	<1287832106.517512323@domain.hid> <4CC2C361.5020608@domain.hid>
	<1287832939.719617755@domain.hid>
In-Reply-To: <1287832939.719617755@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Very high latencies under stress testing
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: edward.robbins@domain.hid
Cc: xenomai@xenomai.org

edward.robbins@domain.hid wrote:
> Yep, sorry the words got to the keyboard bypassing my brain... it's built already...

So, you are all set-up I guess. In one terminal, launch latency, in
another terminal, launch dohell. When, in that second terminal, you see:

Listening on any address 5566

>From another computer, run:
netcat the-box-where-dohell-runs 5566 > /dev/null

We can probably do something simpler with the inetd "discard" service,
but I have not tried yet.

-- 
                                                                Gilles.

