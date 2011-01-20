Date: Thu, 20 Jan 2011 09:28:41 +0100 (CET)
From: Kolja Waschk <xenoka09@domain.hid>
In-Reply-To: <OF1911EB62.67FE0A4E-ONC125781E.0029C740-C125781E.002C4F5B@LocalDomain>
Message-ID: <alpine.DEB.1.10.1101200922440.1211@domain.hid>
References: <OF1911EB62.67FE0A4E-ONC125781E.0029C740-C125781E.002C4F5B@LocalDomain>
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
To: Pierre.QUELIN@solystic.com
Cc: xenomai@xenomai.org

Hi,

> pthread_cond_wait (). it returns EPERM when the application is started with gdb.

I also stumbled over this

(see https://mail.gna.org/public/xenomai-help/2010-12/msg00080.html)

and so far have not found a solution. In my application, there's a tight loop
calling pthread_cond_wait and I have to issue usleep(100) in case of EPERM, to
avoid total lockup when running with gdbserver. It is absolutely no issue
without gdbserver though.

Kolja


