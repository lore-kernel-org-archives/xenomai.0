Date: Thu, 14 Feb 2008 10:58:37 +0100
From: "Petr Cervenka" <grugh@domain.hid>
MIME-Version: 1.0
Message-ID: <200802141058.2356@domain.hid>
References: 200802141029.19685@domain.hid> <200802141029.19685@domain.hid>
	<200802141055.1177@domain.hid>
In-Reply-To: <200802141055.1177@domain.hid>
Content-Type: text/plain; charset="windows-1250"
Content-Transfer-Encoding: 8bit
Subject: [Xenomai-help] Slow sin function
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

Hello again.
I have another problem and I'm not sure if it is connected with Xenomai ,
but perhaps you already met similar problem.
Occasionally  the math sin function takes an enormous amount of time
(400-450 us on Athlon A64 X2 4800+). When I detect this and make the sin function
call with the same parameter again, it takes the same (long) time. I
suspect that this function is for some values is unreasonably slow. I'll
try to capture some such values and post them here.
I don't remember such behavior before the transition to newer 64bit linux
distribution (Kubuntu 7.10 amd64 and kernel 2.6.24).
Petr Cervenka


