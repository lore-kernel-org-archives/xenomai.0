From: Thomas Witzel <witzel.thomas@domain.hid>
Date: Wed, 25 Oct 2006 16:10:36 -0400
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610251610.36530.witzel.thomas@domain.hid>
Subject: [Xenomai-help] RTDM/ALSA hybrid driver ?
Reply-To: witzel.thomas@domain.hid
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

I'm now trying to create a sound driver that will start and stop playback in 
real time. Is it better to implement a driver for RTDM from scratch, or is it 
reasonable to just add a RTDM interface for the required functionality to an 
existing ALSA driver ? The advantage of the latter approach is of course, 
that everything that doesn't need to be done in realtime already exists 
through ALSA and I only would have to implement the pcm triggers through 
RTDM. Is that reasonable at all ?

Thomas

