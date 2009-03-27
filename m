MIME-version: 1.0
Content-transfer-encoding: 7BIT
Content-disposition: inline
Content-type: text/plain; charset=iso-8859-1
From: Peter =?iso-8859-1?q?W=E4chtler?= <pwaechtler@domain.hid>
Date: Fri, 27 Mar 2009 16:41:09 +0100
References: <200903271538.10434.pwaechtler@domain.hid>
	<49CCE84E.7060708@domain.hid>
In-reply-to: <49CCE84E.7060708@domain.hid>
Message-id: <200903271641.09389.pwaechtler@domain.hid>
Subject: Re: [Xenomai-core] use case: possible to boot Posix subsystem in
 <50ms and then Linux?
Reply-To: pwaechtler@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Am Friday 27 March 2009 15:53:02 schrieb Gilles Chanteperdrix:
>
> Xenomai kernel-space support is started somewhere in the middle of the
> boot process, so, you can probably start kernel-space applications at
> that time. User-space only works when init has been started, which
> happens a bit later during the boot process. But you can start Xenomai
> applications before all the system services have been started.
>

I think the fundamental question is: does Adeos provide a scheduler? 

And I guess the answer is yes, at least "Life-with-Adeos" doc mentions
primary and secondary execution modes/domains.

In the use case it would be necessary that OSEK subsystem is able to schedule 
between a static number of preconfigured threads WITHOUT the precondition 
that Linux is up and running.

>
> As a side note, I have a question for the automotive industry people.
> Would there be an interest in developing an OSEK skin for Xenomai? I
> have been thinking about that for some time, but still have not found
> time to start the job. I have read the OSEK spec, and found the
> interface pretty simple (though some part of the job has to be done
> offline, and annoyingly need to read XML files). The OSEK com spec, on
> the other hand, looks rather scary.

There are open source OSEK implementations. AFAIK, all far from completeness.

You can start with
http://opensek.sourceforge.net/

or have a look at the list at 
http://en.wikipedia.org/wiki/OSEK

	Peter

