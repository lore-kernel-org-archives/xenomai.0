MIME-Version: 1.0
Date: Mon, 24 Sep 2012 22:34:14 +0900
Message-ID: <CAH6xOCB_pB4Mhg_WpFXtNN5ELtreYiBSD=obviojoUyGdcr7bg@mail.gmail.com>
From: Hyeongseok Kang <hseokkang@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] [Question] Why xenomai domain change the hardware timer
	to One-Shot mode?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi, I am trying to port xenomai to arm board and I have some question.

Why xenomai domain change the hardware timer to One-Shot mode by use
__ipipe_mach_set_dec() ?
Another question, what's the purpose of TSC? Is it related to one-shot mode
of timer?

Answer me please.

Robert Kang
