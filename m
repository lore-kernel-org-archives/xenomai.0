From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16242.55671.342682.87053@domain.hid>
Date: Thu, 25 Sep 2003 14:03:03 +0200
Subject: Re: [Adeos-main] 2.6.0-test1 r1.diff
In-Reply-To: <200309250958.h8P9wde22266@domain.hid>
References: <200309250958.h8P9wde22266@domain.hid>
Reply-To: rpm@xenomai.org
List-Id: <adeos-main.nongnu.org>
List-Unsubscribe: <http://mail.nongnu.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <http://mail.gnu.org/pipermail/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <http://mail.nongnu.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Der Herr Hofrat <der.herr@domain.hid>
Cc: adeos-main@gna.org

Der Herr Hofrat wrote:
 > 
 > Hi !
 > 
 >  freez of 2.6.0-rest1 was due to  preemption being enabled - this kills teh 
 >  box in start_kernel at the first printk - which is why no output is
 >  produced.
 > 
 >  After turning of preemtpion support it boots fine ;)
 > 

Ack. Adeos/preempt code integration is not complete yet for the 2.6
series. This fact definitely needs to be documented somewhere. Thanks
for the tips.

Philippe.


