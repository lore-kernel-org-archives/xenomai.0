From: Stephane Grosjean <s.grosjean@peak-system.com>
Message-ID: <d8ab0bd9-b115-7c0e-1234-6e2ea8c35982@peak-system.com>
Date: Mon, 13 Jun 2016 15:14:05 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: [Xenomai]  Linux RT driver migrating to 3.0...
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai@xenomai.org

Hi!

Successfully running for years a Xenomai 2.6.x RT driver under some 
dual-kernel Linux versions, we'd like to migrate it to Xenomai 3.x.

First step consisting in compiling the driver is over, time has come to 
test it.

Everything looks like the rtm_mutex_lock() locks the entire system when 
running a Xenomai 3.x cobalt Linux, while it doesn't with 2.6.x: in 
fact, in some particular cases, this rtdm_mutex_lock() might be called 
from the "init_module()", so I'm afraid that the calling task isn't a RT 
one, but a Linux regular one, isn't it? So maybe it's actually the 
reason why...

But, in that case, why such a call was not a problem with Xenomai 2.6.x?

Thanks for your help and regards,

Stéphane

--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt - HRB 9183 
Geschaeftsfuehrung: A.Gach, U.Wilhelm
--

