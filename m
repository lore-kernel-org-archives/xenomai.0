Message-ID: <BLU436-SMTP235B354929DDB6910D2667EF02D0@phx.gbl>
From: Mathieu Rondonneau <mathieu_rondonneau@hotmail.com>
Date: Sat, 31 Oct 2015 20:58:27 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Support for Raspberry PI 2 B (devm_request_threaded_irq)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

irq handlers registered with devm_request_threaded_irq does not get 
triggered when interrupt fires.

The mmc driver uses this (can not load the rootfs).
Only the IPIPE patch is enabled.
the armctrl chipirq is triggering the .ack handler instead so the 
interrupt is happening.

Any suggestion on where I should look? how is this supported by the 
ipipe layer?

Thanks,
-Mathieu

