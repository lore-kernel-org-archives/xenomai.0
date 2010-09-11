Message-ID: <7301cc886b22b37fcbc8cda61c515d07.squirrel@domain.hid>
Date: Sat, 11 Sep 2010 15:08:53 -0500 (CDT)
From: "Travis Stratman" <tstratman@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [Xenomai-help] Bottom half task scheduling
Reply-To: tstratman@domain.hid
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

I am writing a Xenomai driver with an interrupt that must trigger a
complex series of hardware accesses that may not be atomic (i.e. waiting
for DMA to complete). I'd like to move this section to a bottom half. In a
Linux driver I would use a workqueue but I haven't been able to determine
what the preferred method would be in Xenomai. All of the task creation
API that I have considered cannot be called from an interrupt handler as
they may reschedule.

Can anyone point me to some documentation or example that covers this? Any
pointers would be appreciated.

Thanks,

TAS


