From: Der Herr Hofrat <der.herr@domain.hid>
Message-Id: <200309250958.h8P9wde22266@domain.hid>
Date: Thu, 25 Sep 2003 11:58:38 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] 2.6.0-test1 r1.diff
List-Id: <adeos-main.nongnu.org>
List-Unsubscribe: <http://mail.nongnu.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <http://mail.gnu.org/pipermail/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <http://mail.nongnu.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org


Hi !

 freez of 2.6.0-rest1 was due to  preemption being enabled - this kills teh 
 box in start_kernel at the first printk - which is why no output is
 produced.

 After turning of preemtpion support it boots fine ;)

hofrat
 


