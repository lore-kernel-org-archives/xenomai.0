Message-ID: <4BB0EB2D.5040307@domain.hid>
Date: Mon, 29 Mar 2010 20:02:21 +0200
From: Daniele Nicolodi <daniele@domain.hid>
MIME-Version: 1.0
References: <4BA416AA.6050603@domain.hid> <4BA4C5EF.6020003@domain.hid>
	<20100321205955.GB3505@domain.hid> <4BA9EDEE.6070500@domain.hid>
	<20100324234409.GA3247@domain.hid>
	<4BAAA8C0.2080003@domain.hid> <4BAB6947.8020803@domain.hid>
	<20100328224717.GA2542@domain.hid>
In-Reply-To: <20100328224717.GA2542@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PULL REQUEST] analogy: bug fixes
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Alexis Berlemont <alexis.berlemont@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Alexis Berlemont wrote:
> There is a bug in cmd_write and cmd_read. I have should have taken
> into account the buffers edges. I will fix it. The function
> a4l_mark_bufrw() is not designed to handle boundaries, that is why its
> arguments represent data size not addresses.

That makes sense. I can provide a patch for cmd_read and cmd_write, as i
got the same kind of code working in my own test programs, but I'm quite
busy right now...

Cheers,
-- 
Daniele


