From: Lowell Gilbert <kludge@be-well.ilk.org>
Date: Wed, 18 Feb 2015 17:03:33 -0500
Message-ID: <44bnkqho7e.fsf@lowell-desk.lan>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Xenomai] interrupt service
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi.

I have a kernel task created with rtdm_task_init(). I can wake it up
from my ioctl handler in non-RT, but not from inside my ISR, which was
hooked with rtdm_irq_request(). I tried it with a semaphore, with an
event, and then with just rtdm_task_unblock(). I'm probably doing
something silly here; are there any obvious places to look?

Thanks.

