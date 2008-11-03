Message-ID: <490F0C59.9060506@domain.hid>
Date: Mon, 03 Nov 2008 15:36:09 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Using Xenomai in early boot phase.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

Hello,

I want to use a Xenomai task overtaking the duties of a watchdog running
under Linux as soon as the Xenomai layer is available during boot up. Is
  there a function or variable I could inspect? With 2.3.x, I called
rtdm_init_task() until it returned without error but with 2.4.x it
results in a kernel crash :-(.

Wolfgang.

