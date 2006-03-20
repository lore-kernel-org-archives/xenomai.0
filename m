Date: Mon, 20 Mar 2006 14:34:51 +0100
From: "Petr Cervenka" <grugh@domain.hid>
MIME-Version: 1.0
Message-ID: <200603201434.15258@domain.hid>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: [Xenomai-help] rtdm_event_timedwait hang-up
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
I'm trying to port a  driver of a AD card to RTDM.
When I use rtdm_event_timedwait in IOCTL handler (called from NRT user app), the system will hang-up immediately.
Does it have something to do with: https://mail.gna.org/public/xenomai-help/2006-03/msg00035.html
, ie. it's not possible to call wait /caller blocking functions from non-real-time, is it?
Is there a posibility to do some workaround to solve this or other alternative. I need to wait couple of seconds for IRQ from device.

My configuration: kernel-2.6.15.6, adeos-ipipe-2.6.15-i386-1.2-01, xenomai-2.1.0
Thanks for any help

Petr Cervenka


