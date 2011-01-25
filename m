Date: Tue, 25 Jan 2011 10:48:22 +0100 (CET)
From: Kolja Waschk <xenoka09@domain.hid>
In-Reply-To: <4D3E97D5.3050609@domain.hid>
Message-ID: <alpine.DEB.1.10.1101251047290.12329@domain.hid>
References: <alpine.DEB.1.10.1101251010320.12329@domain.hid>
	<4D3E97D5.3050609@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: "Kolja Waschk,,," <xenoka09@domain.hid>
Subject: Re: [Xenomai-help] NULL pointer access on bfin when linking with
 xenomai and pthread
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

> Some Xenomai code is executed before the main function is called. What I
> do not understand is why gdb does not stop at the place of the segfault?

Ahm, well, I should look for libs with debug info included.  I don't think the
precanned toolchains come with those. So if necessary, this will now take a while... K.


