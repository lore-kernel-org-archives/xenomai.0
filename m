From: Robert Berger <gmane@domain.hid>
Date: Sat, 10 Apr 2010 22:43:08 +0300
Message-ID: <hpqkbk$5m2$1@domain.hid>
References: <hp0bdv$mp4$1@domain.hid> <4BB4FE00.7040101@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
In-Reply-To: <4BB4FE00.7040101@domain.hid>
Subject: Re: [Xenomai-help] cyclictest -tn where n!=1 causes segfault with
	Kilauea
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

Gilles Chanteperdrix wrote:
> Robert Berger wrote:
>> ./cyclictest -t2
>> Segmentation fault
> 
> This issue is fixed by commit 428aa42410efe575f7bb9729447e6dc49159ef5e
> http://git.xenomai.org/?p=xenomai-2.5.git;a=commit;h=428aa42410efe575f7bb9729447e6dc49159ef5e
> 

Confirmed!

What's currently under git in combination with a 2.6.33 tag from the
DENX tree works now on the kilauea board.

Regards,

Robert

-- 
Robert Berger
Embedded Software Specialist

Reliable Embedded Systems
Consulting Training Engineering
Tel.: (+30) 697 593 3428
Fax.:(+30) 210 684 7881
email: robert.berger@domain.hid
URL: http://www.reliableembeddedsystems.com
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
...The nice thing about standards is that there are so many of them to
choose from - Andrew S. Tanenbaum

My public pgp key is available at:
http://pgp.mit.edu:11371/pks/lookup?op=get&search=0x90320BF1





