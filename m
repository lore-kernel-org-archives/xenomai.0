Date: Tue, 16 May 2006 12:21:23 +0200
From: "Petr Cervenka" <grugh@domain.hid>
MIME-Version: 1.0
Message-ID: <200605161221.11119@domain.hid>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: [Xenomai-help] rtdm_event_timedwait non-realtime alternative
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
I need to wait in my ioctl handler for an interrrupt. Is it possible to use some rtdm_event_timedwait alternative in non-realtime?
I'm thinking about using wait_event_interruptible_timeout. Is it a good idea or is there a better solution (e.g. rtdm_event compatible))?

Petr Cervenka


