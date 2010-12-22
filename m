Date: Wed, 22 Dec 2010 15:14:56 +0100 (CET)
From: Kolja Waschk <xenoka09@domain.hid>
In-Reply-To: <1293025850.22129.15.camel@domain.hid>
Message-ID: <alpine.DEB.1.10.1012221511320.11502@domain.hid>
References: <alpine.DEB.1.10.1012211818430.9596@domain.hid>
	<4D110810.1090504@domain.hid>
	<alpine.DEB.1.10.1012221012270.10955@domain.hid>
	<alpine.DEB.1.10.1012221306370.10955@domain.hid>
	<1293025850.22129.15.camel@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: "Kolja Waschk,,," <xenoka09@domain.hid>
Subject: Re: [Xenomai-help] gdb/gdbserver hangs during rt_task_create
Reply-To: Kolja Waschk <xenoka09@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai GNA <xenomai@xenomai.org>

> Your Makefile may have an issue. Do you happen to link with
> libpthread_rt.so in addition to libnative.so?

Yes, because most of the code uses the native API, but one part uses pthread_* calls.. ?

Kolja


