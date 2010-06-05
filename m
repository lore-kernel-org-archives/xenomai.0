From: ines <inesbouhamed@domain.hid>
Date: Sat, 5 Jun 2010 17:56:05 +0000 (UTC)
Message-ID: <loom.20100605T194222-984@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] h264 for xenomai
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

hi,
I built the uClinux kernel for NIOS II (http://www.nioswiki.com/) and I  added a 
co-scheduler xenomai to this kernel to reduce  its latency.
Now,I want to implement the encoder 
h264(http://iphome.hhi.de/suehring/tml/download/old_jm/jm16.2.zip) with xenomai 
services.
So I tried to compile it before editing it, but I had these error messages:
http://www.mediafire.com/?mmlnmkzjfzd
you can find the Makefile file in :
http://www.mediafire.com/file/wmtm4izt1jn/Makefile
Could you pleeeeeeease help me?
PS:
  my application contains the files. c , a subfolder for inc. h and Makefile.
  Xenomai version: v2.5.0
  on cycloneIII 3C25 platform 



