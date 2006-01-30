From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17374.2360.273205.998312@domain.hid>
Date: Mon, 30 Jan 2006 13:40:24 +0100
Subject: Re: [Xenomai-core] broken docs
In-Reply-To: <43DE03CF.3070603@domain.hid>
References: <FDBBB5CC70676540B3EF7CFE83FD94E0210CE1@domain.hid>
	<43DE03CF.3070603@domain.hid>
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
Cc: ROSSIER Daniel <Daniel.Rossier@domain.hid>, xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
 > ROSSIER Daniel wrote:
 > > Dear Xenomai workers,
 > > 
 > > Would it be possible to have an updated API documentation for Xenomai
 > > 2.0.x ? (I mean with formal parameters in function prototypes)
 > > 
 > > I tried to regenerate it with make generate-doc, but it seems that a
 > > SVN working dir is required.

make generate-doc is needed for maintenance only. If you want to
generate doxygen documentation, simply add --enable-dox-doc to Xenomai
configure command line.

 > > 
 > > It would be great.
 > 
 > I just had a "quick" look at the status of the documentation in
 > SVN-trunk (2.1). Unfortunately, doxygen is a terrible tool (to express
 > it politely) when it comes to tracking down bugs in your formatting.
 > Something is broken in all modules except RTDM, and although I spent *a
 > lot* of time in getting RTDM correctly formatted, I cannot tell what's
 > wrong with the rest. This will require some looooong evenings of
 > continuous patching the docs, recompiling, and checking the result. Any
 > volunteers - I'm lacking the time? :-/

Looking at the difference between RTDM documentation blocks and the
other modules is that the other modules use the "fn" tag. Removing the
"fn" tag from other modules documentation blocks seems to solve the
issue.

-- 


					    Gilles Chanteperdrix.

