From: Carlos Novaes <carlosnov@domain.hid>
Date: Wed, 28 Jan 2009 21:13:48 -0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200901282113.48357.carlosnov@domain.hid>
Subject: [Xenomai-help] proc interface isn't created
Reply-To: Carlos Eduardo de Brito Novaes <carlosnov@domain.hid>
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

Hello.
I am using xenomai to develop a real time driver and got some strange 
behaviour.
On my study machine, a recent 64 bit and ubuntu 8.10 I could write and compile 
some xenomai code.
But, on my work machine, an old PC with ISA BUS and a stripped version of LFS 
(linux from scratch), I cant create memory heap and the /proc/xenomai dir wont 
be created. There is no errors until "create_heap".
I cant find any difference on XENO part of both .config. 
Can someone give me any hint?

Thank you so much

-- 

Carlos Novaes

