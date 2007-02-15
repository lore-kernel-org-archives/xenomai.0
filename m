From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45D46704.9050109@domain.hid>
References: <45D45AEA.50404@domain.hid> <1171547803.24117.8.camel@domain.hid>
	<45D46704.9050109@domain.hid>
Content-Type: text/plain
Date: Thu, 15 Feb 2007 18:25:45 +0100
Message-Id: <1171560346.24117.77.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: [Xenomai-core] Re: I-pipe 1.7 breaks mlockall safety check
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Thu, 2007-02-15 at 14:58 +0100, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > On Thu, 2007-02-15 at 14:06 +0100, Jan Kiszka wrote:
> >> Hi all,
> >>
> >> I think I found another unwanted side-effect of the no-cow changes:
> >>
> >> With the I-pipe 1.7 patch series the test for missing mlockall no longer
> >> works. I just - once again - wrote a test program that was lacking this
> >> call, but only with I-pipe 1.6-06 (same Xenomai version: latest trunk) I
> >> get the usual error message on startup.
> >>
> > 
> > I can't reproduce this with 1.7-01 here. Which Xenomai codebase are you
> > currently using (trunk/, 2.3.x maintenance or stock 2.3)?
> 
> Specifically trunk, but the first observation was over 2.3.x
> maintenance. The test code is using the posix skin.

I still don't find any explanation for that behaviour, only trivially
testing with and without mlockall() in a bare main routine though.

In relation to this, I've rolled out 1.7-02/x86, so that we could close
the last pending issue(s) holding v2.3.1 wrt the interrupt pipeline
support. Specifically, the -nocow related changes have been amended, and
we are now back to the implementation that prevailed in the 1.6 series
wrt vmalloc and ioremap memory, while still retaining the ability to
break COW eagerly for the RT threads.

Feedback welcome on this.

-- 
Philippe.



