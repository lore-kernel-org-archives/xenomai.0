Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 Feb 2008 07:57:22 -0700
Message-ID: <51CAD0CE1504444DBE77CBBE51A0135D376B55@domain.hid>
In-Reply-To: <47B1A892.5020707@domain.hid>
References: <51CAD0CE1504444DBE77CBBE51A0135D376B33@domain.hid>	<47B14FF9.8010207@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D376B4B@slcmail.slc.mew.int>
	<47B1A023.8090009@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D376B4D@slcmail.slc.mew.int>
	<47B1A892.5020707@domain.hid>
From: "Steven Seeger" <sseeger@domain.hid>
Subject: Re: [Xenomai-help] pit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

> For sure, if there are system states where the periodic tasks do not
> have to run, calling rt_task_set_periodic(..., TM_INFINITE) will help
to
> reduce unneeded load.

That's what I thought.

> I bet the overhead was not measurable because everything lived in
kernel
> space, right?

It was negligible, but I don't know for certain if that's because it was
in kernel space. It seems to be the case, though.=20
=20
> Keep another advantage in mind: going to user space allows you (or
your
> contractor) to distribute closed-source applications without
consulting
> costly lawyers - if that can help at all... :)

The source code is distributed with each unit. On bad sectors of a flash
card. But hey, it's there.

I'm going out of town but will return next week. I'll be thinking about
the design and share some ideas with you all. I will also go kernel
fault hunting for Philippe now that I know what he wants. I appreciate
everyone's help and feel bad that at this juncture I have to disappear
for a while. I can tell that you're all anxious to help figure out
what's going on so we (you) can make Xenomai a wonderful project that
leads to peace on earth and clean energy. ;)

Steven


