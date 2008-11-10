Message-ID: <c44fc7cdf97fcb057ab4f35cd15966ad.squirrel@domain.hid>
In-Reply-To: <20081110164656.GA766@domain.hid>
References: <20081110164656.GA766@domain.hid>
Date: Mon, 10 Nov 2008 19:51:30 +0100 (CET)
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai-help] rpc on top of unidirectional messages
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Tom Schouten <tom@domain.hid>
Cc: xenomai@xenomai.org


Tom Schouten wrote:
> Hello,
>
> With the risk of being a bit off-topic, does anyone here know of a code
> generator or library that implements RPC on top of Xenomai native or Posix
> message queues?

This is not off-topic, but I am afraid we have no ready made answer to
this need. You can probably use RPCs based on UDP sockets such as the
classical many years old Sun RPCs, or the latest XML based RPCs, or
real-time oriented CORBA implementations such as TAO. But this all looks
overkill for local communications.

-- 
                    Gilles.


