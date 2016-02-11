MIME-Version: 1.0
From: Michael Smith <2michael.smith@gmail.com>
Date: Thu, 11 Feb 2016 17:17:56 +0200
Message-ID: <CANWkrRMcQw0deq3xrPrsua1-kRuopyxOU_80_OBizZDs=U3whQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Missing rtdm_lock_get_irqsave() in API docs
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hi guys.
I have found that the function call rtdm_lock_get_irqsave() is missing
from the API documentation.
The complimentary call  rtdm_lock_put_irqrestore() is listed under:
RTDM -> Driver programming interface -> Synchronisation Services ->
Spinlock with preemption deactivation.
I found the rtdm_lock_get_irqsave() / rtdm_lock_put_irqrestore() calls
while I was looking at the serial driver example code, but could not
find the rtdm_lock_get_irqsave() listing in the API documentation.

Was this done with a purpose or is it a mistake?

Regards
Michael

