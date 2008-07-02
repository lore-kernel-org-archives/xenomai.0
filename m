Message-ID: <486BC7AD.3060108@domain.hid>
Date: Wed, 02 Jul 2008 20:23:41 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <51B669A8A7D2914E9AB2B3F40AC6553E647060@domain.hid>
	<486BC042.5030300@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E647061@domain.hid>
In-Reply-To: <51B669A8A7D2914E9AB2B3F40AC6553E647061@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] remote gdb debugging and Xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Karch, Joshua" <jkarch@domain.hid>
Cc: xenomai@xenomai.org

Karch, Joshua wrote:
> Gilles,
> 
> Regarding GDB, from what I saw in README.INSTALL,  I have to get the
> GDB sources and compile a custom version of GDB/GDB server for my
> target machine, right?

I was referring to Xenomai README.INSTALL explaining how to enable debug
symbols in Xenomai libraries.

 I simply apt-get installed gdb on this machine
> so I don't have a custom version.

The problem is that if you have gdb 6.5 on the host and gdbserver 6.4 on
the target it will not work. You have to use exactly the same version.

-- 


					    Gilles.

