MIME-Version: 1.0
Date: Mon, 14 Oct 2013 11:32:16 +0530
Message-ID: <CAMgy_J3qnbCESGmr+Cqu167gXZVEyeRuUfy=UZ4T+QJvSCfvpw@mail.gmail.com>
From: Shamju Joseph <shamju.joseph@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] Atomic variables in Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Is there any provision to have atomic variable declarations in Xenomai?
Something like 'sig_atomic_t' with C, so that a global variable accessed by
multiple Xenomai tasks won't corrupt the value and the change to variable
happens atomically.
Thanks,
Shamju Joseph.
