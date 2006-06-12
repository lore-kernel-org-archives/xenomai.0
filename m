From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Mon, 12 Jun 2006 23:23:36 +0200
Message-ID: <e6km0o$d6p$1@domain.hid>
References: <200605252134.08614.niklaus.giger@domain.hid>
	<44770814.5040009@domain.hid>
	<200605261852.45980.niklaus.giger@domain.hid>
	<4485E647.7010205@domain.hid> <448DCF9F.807@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: news <news@domain.hid>
Subject: [Xenomai-core] Re: Porting xeno-{info|load|test} to a busybox system
Reply-To: niklaus.giger@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Jan Kiszka wrote:
<..> 
> Just stumbled over this again while cleaning up my mailbox. What's the
> status? Waiting for improvements, or waiting for /someone/ to type svn
> ci (and improve the topics above later)?

Yes and no. As I told there is no urgent need to apply this before 2.2.
And improvement/more insight into the whole busybox would be a great idea.

I am busy preparing the next step for the whole xeno-test/buildbot
infrastructure, which will feature:
- Small additions to my patch for xeno-test (done)
- Buildbot will run automatically xeno-test on my PPC405 board as the last
  build step (done). But it will at the moment only show, that there are
  problems with my PPC405 target (see a separat thread).
- Documentation rework (mostly done)
- Adding a test script to test xeno-test (may be a overkill, but xeno-test
  accumulated a lot of options, and I like unit test).

As nobody committed my patch, I will be much more confident to propose a
patch as soon as the unit tests for xeno-test work.

Best regards
---

Niklaus Giger


