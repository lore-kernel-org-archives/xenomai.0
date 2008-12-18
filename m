From: Marcin =?iso-8859-2?q?Pi=B1tek?= <rtos@domain.hid>
Date: Thu, 18 Dec 2008 16:53:42 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200812181653.42193.rtos@domain.hid>
Subject: [Xenomai-help] ARM9-based board
Reply-To: rtos@domain.hid
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

Hello,
I have used the Xenomai on the PC for last 2 years and I think its great 
system but lately I have decided that my application requires something 
smaller then PC. I would like to use some board with ARM9 processor and I 
even tried to make some experiments with one of these but it appeard that 
there's a lot of problems with this. I believe that most of these problems 
occured because the board designers haven't predicted that some users would 
like to change the system (migrate to new kernel version, use root file 
system on NFS partition) and nobody can help me with this.
So I have this question to you: could you please recommend me some board that 
you use or used and you already know that it is ok? This the list of my 
requirements:
- ARM9 processor
- GNU/Linux (kernel 2.6.x) with Xenomai 2.4.x has to work with this board
- Ethernet
- USB
- I need to run Real-Time Serial Driver with serial port to communicate with 
my special hardware
- at the development stage I would like to run system from NFS partition on my 
PC (this configuration has to be tested!, this was the biggest problem that I 
had with previous board)
I think it's quite common application and some of you probably already do such 
a things with your board?
best regards
Marcin

