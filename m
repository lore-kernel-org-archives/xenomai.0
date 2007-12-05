Message-ID: <47563A68.8060404@domain.hid>
Date: Tue, 04 Dec 2007 21:43:04 -0800
From: Dennis Nguyen <dennisnguy@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] undefined reference to `rt_printf(char const*, ...)'
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

Hello all,

I got the "undefined reference to rt_printf" function when I called 
rt_printf in my application.  I included the header #include <rtdk.h> in 
the source file and -L /usr/xenomai/lib -lrtdk -lpthread-rt in the 
makefile.  I'm using kernel i386 2.6.23.9 and xenomai 2-4rc7. I have the 
rtdk.h include file in /usr/xenomai/include and librtdk.so in the 
/usr/xenomai/lib.
What am I missing?

Thanks in advance

