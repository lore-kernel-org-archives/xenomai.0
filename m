Resent-Message-ID: <17674.28387.740789.766293@domain.hid>
Resent-To: xenomai@xenomai.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17673.51224.770532.649650@domain.hid>
In-Reply-To: <1BECC866-4567-477D-9A18-144496828EB7@domain.hid>
References: <3BDC517D-07A0-4BD3-9C6A-332E76B32615@domain.hid>
	<17673.32941.706379.236825@domain.hid>
	<1BECC866-4567-477D-9A18-144496828EB7@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] inscrutable pipes
Date: Thu, 14 Sep 2006 23:22:32 +0200
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: ckreider <ckreider@domain.hid>

ckreider wrote:
 > That method is not very fine grained though.  You really don't want / 
 > usr/xenomai/share/doc/xenomai*, /usr/xenomai/man*, or /usr/xenomai/ 
 > include on the target and you really want /usr/xenomai on the  
 > development host.  But it does keep /dev and /lib/modules from  
 > getting polluted.  I think it just takes a soft link from /usr/ 
 > xenomai and selective gathering from DESTDIR for the target and it is  
 > pretty slick.  Thanks again.

The answer to this question should be to use a different value for
--prefix and --exec-prefix. But for this to work correctly, we should
install the testsuite under $exec_prefix.

-- 


					    Gilles Chanteperdrix.

