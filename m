Message-ID: <4688E0BD.40709@domain.hid>
Date: Mon, 02 Jul 2007 13:25:49 +0200
From: Johan Borkhuis <j.borkhuis@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Switch to secondary mode
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai-help@domain.hid

Hello,

I am having some problems with an application switching to secondary 
mode. One of my applications is switching to secondary mode when a 
function is called in a library. This function itself is empty (only 
returning 0).
When I move this function out of the library into the main C-file the 
program stays in primary mode. What could be happening here?

This is the output of a backtrace:
./dsAuxEvQueTest1[0x10001858]
/lib/ld.so.1[0x3001eaf8]
[0x0]
./dsAuxEvQueTest1[0x100018f0]
./dsAuxEvQueTest1[0x10005c9c]
/lib/libpthread.so.0[0xffd32fc]
/lib/libc.so.6(__clone+0x84)[0xfe751e8]

Do I need to use some specific compile or link commandline arguments?

My architecture is ppc, Xenomai version 2.3.1 and kernel 2.6.14.

Kind regards,
    Johan Borkhuis

