Message-ID: <b54eff8c27fb8d66117fe1dc79a37ebe.squirrel@domain.hid>
Date: Tue, 12 Oct 2010 18:21:04 +0200
From: "Cagnulein" <cagnulein@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: [Xenomai-help] Float operations on ARM i.MX27
Reply-To: cagnulein@domain.hid
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

I'm continuing my experience on Xenomai and i've reached the floating
point "point" :)
I've succesfully compiled a project using some floats (division and
printf) but when i try to use a "high level" function like "ceil" or
"sqrt" the linker can't find them.

I know there isn't any hard floating point unit on this cpu, so it's all
emulated (soft floats): if it's so, i've to implement these functions
inside my project?

It's not a problem doing this, but i don't understand the reason.

Thanks in advance.
Roberto aka "Cagnulein"


