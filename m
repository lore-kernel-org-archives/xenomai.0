From: Robert Berger <gmane@domain.hid>
Date: Wed, 31 Mar 2010 23:15:05 +0300
Message-ID: <hp0agd$j1h$1@domain.hid>
References: <horvm4$cil$1@domain.hid>
	<20100330200529.BEBFEE73028@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
In-Reply-To: <20100330200529.BEBFEE73028@domain.hid>
Subject: Re: [Xenomai-help] find bits and pieces for Denx PPC/ipipe/xenomai?
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

Thanks Wolfgang,

I did

git clone git://git.denx.de/linux-2.6-denx.git
followed by
> 
> 	git checkout v2.6.33
> 
> to get the exact state of sources these patches were created against.
> 
> 
> See above: "git clone" followed by "git checkout" - as usual.
> 
> Best regards,
> 
> Wolfgang Denk
> 

And used adeos-ipipe-2.6.33-powerpc-2.9-00.patch
plus git clone git://xenomai.org/xenomai-head

Everything builds happily for a kilauea board, but...

./cyclictest -t3
Segmentation fault

I'll open another thread here for this problem.
This seems to be broken for quite some time now.

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
...Reusing software is a lot like reusing toilet paper. - Rick Anthony

My public pgp key is available at:
http://pgp.mit.edu:11371/pks/lookup?op=get&search=0x90320BF1


