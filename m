From: stefano.franzoni@domain.hid
Date: Fri, 16 Jan 2009 17:36:29 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Message-Id: <20090116163634.2C8C11C066@domain.hid>
Subject: [Xenomai-help] malloc greater than 4K issue
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>


Dear experts

we have a systems with Ubuntu Linux 2.6.25.11 and Xenomai 2.4.4.
The system has a Pentium III (Coppermine) 1GHz.
The Xenomai installation seems to be ok.

The application, in an Rt task in user mode, allocates and uses a buffer of
4K or greater.
The buffer is allocated with malloc.

When the buffer is greater that 4K the progam exits with a sementation
fault.

I have no idea of the origin of the issue.
I ask you if the use of malloc for buffer greater than 4K is correct or the
use of other APIs is suggested.
I have tried also with rt_heap_create but I receive an error of "permission
denied".

Any suggestions?

Thanks in advance

Stefano


