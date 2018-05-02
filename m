From: "Pham, Phong" <phamp@ddc-web.com>
Date: Wed, 2 May 2018 01:13:26 +0000
Message-ID: <C2EC5BA46D13CD44B5915A8FEEB4C44E8A2D2291@DDCEXCH.ddc-ny.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] potentially missing timer rating check in
	select_root_only_timer()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>
Cc: "Hillman, Robert" <hillman@ddc-web.com>


Hi,

I am suspecting that in kernel/ipipe/timer.c:select_root_only_timer()

When t->irq == per_cpu(ipipe_percpu.hrtimer_irq, icpu), a condition to test the timer rating against current timer rating before installing the timer is missing.  That is t->rating > percpu_timer->rating (combined with same irq #) before the condition becomes true.

Here's screenshot:
[cid:image001.png@01D3E177.63116AC0]

Phong.

Notice: This e-mail and any files transmitted with it may contain Data Device Corporation's privileged and proprietary information. It is intended solely for the use of the individual or entity to whom it is addressed. If you are not the named recipient of this transmission, any disclosure, copying, distribution or reliance on the contents of this message is prohibited. If you received this e-mail in error, please destroy it and any attached files and notify me immediately.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: image001.png
Type: image/png
Size: 100938 bytes
Desc: image001.png
URL: <http://xenomai.org/pipermail/xenomai/attachments/20180502/fb07b0f2/attachment.png>
