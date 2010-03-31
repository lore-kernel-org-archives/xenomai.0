Message-ID: <4BB3B15E.6060104@domain.hid>
Date: Wed, 31 Mar 2010 22:32:30 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <horvm4$cil$1@domain.hid>	<20100330200529.BEBFEE73028@domain.hid>
	<hp0agd$j1h$1@domain.hid>
In-Reply-To: <hp0agd$j1h$1@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
To: Robert Berger <gmane@domain.hid>
Cc: xenomai@xenomai.org

Robert Berger wrote:
> Thanks Wolfgang,
> 
> I did
> 
> git clone git://git.denx.de/linux-2.6-denx.git
> followed by
>> 	git checkout v2.6.33
>>
>> to get the exact state of sources these patches were created against.
>>
>>
>> See above: "git clone" followed by "git checkout" - as usual.
>>
>> Best regards,
>>
>> Wolfgang Denk
>>
> 
> And used adeos-ipipe-2.6.33-powerpc-2.9-00.patch
> plus git clone git://xenomai.org/xenomai-head
> 
> Everything builds happily for a kilauea board, but...
> 
> ./cyclictest -t3
> Segmentation fault
> 
> I'll open another thread here for this problem.
> This seems to be broken for quite some time now.

Ok. Could you run this program under gdb to see at least where the
segmentation fault happens? But first, could you show us the result of
the "ulimit -s" command before running cyclictest?

-- 
					    Gilles.

