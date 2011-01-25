Date: Tue, 25 Jan 2011 10:06:00 +0100 (CET)
From: Kolja Waschk <xenoka09@domain.hid>
In-Reply-To: <4D3E8EF9.2010606@domain.hid>
Message-ID: <alpine.DEB.1.10.1101251004590.12329@domain.hid>
References: <OF1911EB62.67FE0A4E-ONC125781E.0029C740-C125781E.002C4F5B@LocalDomain>
	<alpine.DEB.1.10.1101200922440.1211@domain.hid>
	<4D384CC9.2040303@domain.hid>
	<alpine.DEB.1.10.1101201702340.1990@domain.hid>
	<4D386922.5080807@domain.hid>
	<alpine.DEB.1.10.1101201811090.1990@domain.hid>
	<4D387148.3030306@domain.hid>
	<alpine.DEB.1.10.1101211222330.3495@domain.hid>
	<4D3D7107.7030603@domain.hid>
	<alpine.DEB.1.10.1101250941170.12329@domain.hid>
	<4D3E8EF9.2010606@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: "Kolja Waschk,,," <xenoka09@domain.hid>
Subject: Re: [Xenomai-help] debug posix skin - pthread_cond_wait return EPERM
Reply-To: xenoka09@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hi,

> The link order is wrong. It should be -lpthread_rt -lxenomai -lpthread.

Okay, thanks, fixing that doesn't prevent the SEGV though.

Kolja

