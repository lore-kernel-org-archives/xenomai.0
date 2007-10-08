Date: Mon, 08 Oct 2007 15:03:20 +0200
From: "Petr Cervenka" <grugh@domain.hid>
MIME-Version: 1.0
Message-ID: <200710081503.15198@domain.hid>
Content-Type: text/plain; charset="windows-1250"
Content-Transfer-Encoding: 8bit
Subject: [Xenomai-help] rt_queue with multiple listeners
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

Hello,
I would like to use a rt_queue (or some similar mechanism) in a special broadcast mode. I need one queue and multiple listeners, but I need to ensure that every listener gets every queue element. Some of the listeners could still work, when the function "rt_queue_send" is called. So I need some "fixed reference count" to be reached before the element is removed from the queue. The solution could be one queue for every listener. But I hope someone knows a better solution. Could you help me with this?
Petr Cervenka


