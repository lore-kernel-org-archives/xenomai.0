Message-ID: <BAY101-F3323C9AB4F084CE48E3BCEE2F70@domain.hid>
From: "Marco Rossi" <cicciobombo123@domain.hid>
Date: Fri, 10 Nov 2006 17:00:27 +0100
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Subject: [Xenomai-help] Problem with multiport serial board
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




Hi every body. I'm testing my multiport serial board (2 extra serial port) 
with shared interrupt using the program found at 
http://www.rts.uni-hannover.de/rtaddon/rt_serial_uprog.tar.bz2 .

I insert the module xeno_16550A.ko in the follow way:
insmod /.../xeno_16550A.ko ioaddr=0x3f8, 0x2f8, 0xd800, 0xdc00 irq=4,3,5,5 
start_index=0

When I use only a extra port the program works, but when I try to write in 
the first extra port and to read in the second extraport I got an error 
opening the second extraport.

For example if I write in ttS0 and I read from ttyS2 all work; if   I write 
in ttS2 and I read from ttyS3 i get :
can't open rtser3 (the rt_dev_open return a negative file descriptor).
Thank in advance
Marco

_________________________________________________________________
Idee per i tuoi viaggi... 
http://search.live.com/results.aspx?q=viaggi&mkt=it-it&FORM=LVSP&go.x=18&go.y=15


