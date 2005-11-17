Message-ID: <437C5119.4060100@domain.hid>
Date: Thu, 17 Nov 2005 10:44:57 +0100
From: =?ISO-8859-1?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
MIME-Version: 1.0
References: <OF53595BAB.2AA49C4A-ONC12570BA.0035EF11-C12570BA.0036F2D4@domain.hid>
	<437B2D05.6070003@domain.hid>
In-Reply-To: <437B2D05.6070003@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Blocking reads from pipes
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi,

My application consists of a real time module and a non-realtime user
mode program. They communicate through several pipes.

The user mode program creates a thread (pthread) that opens a pipe and
blocks in a read call, waiting for data. Under certain conditions, the
user mode program must do an orderly exit, and thus I need a way to
unblock that thread.

I've done that in the past with sockets. If you have one thread blocked
reading from a socket handle, and you close it from another thread, the
read call will immediately return with an error code.

However, that doesn't seem to work with xenomai pipes. One posix thread
blocked reading from a pipe (using posix open/read) won't unblock when
you close the file handle from another thread.

Any suggestions?

Thanks.

Nacho.





