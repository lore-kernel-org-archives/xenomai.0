From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <b34c1c4809c11edb4b46cba4a50b53ec.squirrel@domain.hid>
References: <b34c1c4809c11edb4b46cba4a50b53ec.squirrel@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 20 Nov 2010 19:19:43 +0100
Message-ID: <1290277183.1933.1816.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai: incompatible ABI revision level
 (needed=1, current=3).
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: David Schlesinger <davidschles@domain.hid>
Cc: xenomai@xenomai.org

On Sat, 2010-11-20 at 13:07 -0500, David Schlesinger wrote:
> Hi,
> 
> I am new to Xenomai. I've compiled a program using Xenomai and when
> running it I recieve the following error:
> 
> Xenomai: incompatible ABI revision level
> (needed=1, current=3).
> 

This means you have outdated Xenomai libs (abirev=1) calling a recent
Xenomai kernel support (abirev=3).

> I'm not sure if there is a way to fix this error without reinstalling
> Xenomai from scratch.
> 

You probably need to rebuild your Xenomai libs (the configure+make
install step) using the same source tree than the kernel side does (i.e.
where you picked prepare-kernel.sh from), and relink your apps against
these.

> Thank You,
> David
> 

-- 
Philippe.



