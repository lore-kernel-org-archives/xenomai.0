Message-ID: <4AD832CB.20004@domain.hid>
Date: Fri, 16 Oct 2009 10:46:03 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1f3e02580910132319v3ce08b2frb811d749def9f17@domain.hid>	
	<4AD57CE3.4050206@domain.hid>	
	<1f3e02580910152226h4fb94068kfce63fec4be38c3f@domain.hid>	
	<4AD8241C.6090200@domain.hid>
	<1f3e02580910160130m69f35a2bl5ca2b40cabadbb56@domain.hid>
In-Reply-To: <1f3e02580910160130m69f35a2bl5ca2b40cabadbb56@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Support for ARCH_MV88F6290
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Didenko Sergey <didenkos@domain.hid>
Cc: xenomai@xenomai.org, mohamad.sharifi@domain.hid

Didenko Sergey wrote:
> Thank you very much Gilles, now I have this done with no Warnings...good.
> 
> Two things are remained:
> 
> 1) warning message like "remember to run `libtool --finish
> /usr/xenomai/lib'" which are printed out when I do command
> make DESTDIR=/nfs/rootfs install
> 
> How should I run it for the board's rootfs (located on /nfs/rootfs) ?
> Is this "libtool --finish /nfs/rootfs/usr/xenomai/lib" correct?
> Should I add this path to my board's environment variable?

You can safely ignore these messages.

> 
> 2) I really need your help how to compile and run test-suit on my board.

If for instance you want to run latency on your board, then boot your
board, log on your board, then type:

cd /usr/xenomai/share/testsuite/latency
./run -- -p 1000

-- 
                                          Gilles


