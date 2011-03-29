Message-ID: <4D91BFCB.9050306@domain.hid>
Date: Tue, 29 Mar 2011 13:17:31 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <201103291913574691512@domain.hid>
In-Reply-To: <201103291913574691512@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] The scheduling jitter of Xenomai seems too large.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "arethe.rtai" <arethe.rtai@domain.hid>
Cc: Xenomai-core <Xenomai-core@domain.hid>

arethe.rtai wrote:
> HI:
>    I tested the scheduling jitter of xenomai on a Pentuim platform. The largest jitter near 260 micro second. The largest jitter of RTAI on the same hardware platform is only about 15 micro second. 
>    Were some options configured wrong?

Probably. The most probable culprit are debug options.

-- 
                                                                Gilles.

