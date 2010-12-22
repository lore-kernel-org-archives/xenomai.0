Date: Wed, 22 Dec 2010 16:25:31 +0100 (CET)
From: Kolja Waschk <xenoka09@domain.hid>
In-Reply-To: <1293027465.22129.17.camel@domain.hid>
Message-ID: <alpine.DEB.1.10.1012221612360.11502@domain.hid>
References: <alpine.DEB.1.10.1012211818430.9596@domain.hid>
	<4D110810.1090504@domain.hid>
	<alpine.DEB.1.10.1012221012270.10955@domain.hid>
	<alpine.DEB.1.10.1012221306370.10955@domain.hid>
	<1293025850.22129.15.camel@domain.hid>
	<alpine.DEB.1.10.1012221511320.11502@domain.hid>
	<1293027465.22129.17.camel@domain.hid>
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

> wrap-link.sh in the link rules for your app:

It seems to target a problem when the application is linked statically, but in my case most of the code is put into a dynamic library. I can use the ..posix.wrappers when building the library and
omit the option when building the executable, but that doesn't seem to make a difference

Kolja



