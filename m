Message-ID: <49C7899F.5030306@domain.hid>
Date: Mon, 23 Mar 2009 14:07:43 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <b131c9f0903230100x1b2aa2fet9e2b0efe68a7a77f@domain.hid>
In-Reply-To: <b131c9f0903230100x1b2aa2fet9e2b0efe68a7a77f@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai LTTng support
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: vikesh rambaran <vikesh.rambaran@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

vikesh rambaran wrote:
> Hi
> 
> I'm trying to get LTTng support for Xenomai 2.4.7 with Linux 2.6.28.7
> running.
> With regards the mailing list, the latest one seems to be
> 
> [ date    Tue, Feb 24, 2009 at 8:30 PM
>   subject    [Xenomai-help] [ANNOUNCE] LTTng-over-I-pipe git tree
> ]
> 
> My understanding of the sequence is :
> (please correct as necessary)
> 
> 1. Get the tree which already has LTTng and ipipe patched in
> 2. Apply trace_mark channel event patch to xenomai 2.4.7
> 3. Apply xenomai patches to kernel
> 4. Build and install
> 
> However, I am having trouble with the following and would appreciate help
> 
> a) "git clone git://git.kiszka.org/ipipe-2.6.git lttng/2.6.28-x86"
> as per the email, results in the 2.6.29-rc6. What should the command be
> to access the 2.6.28 tree ?

Additionally try "git checkout lttng/2.6.28-x86".

> 
> Note : downloading ipipe-2.6.28.7-x86-2.2-06 from
> http://git.kiszka.org/?p=ipipe-2.6.git;a=commit;h=7abbb32f691345126d96cb6b48c587e145b8ef20
> using the web interface gives the 2.6.28.7 tree. Is this ok to use ?
> 
> b) The LTTng manual mentions that there should be a kernel option
> Linux Trace Toolkit Next Generation (LTTng) under General settings. This
> seems to be
> unavailable for both the above trees. What must be done to enable this
> feature ?

It will be available in the git branch that contains LTTng.

> 
> c) Applying the xenomai instrumentation patch from
> [http://permalink.gmane.org/gmane.linux.real-time.xenomai.devel/6009]  to
> the xenomai 2.4.7
> tree using patch -p1 < "filename",  results in numerous hunks. What am i
> doing wrong ?

Hmm, I'm afraid the patch has to be back-ported manually. It was
developed against the instrumentation points in trunk, 2.4.x looks a bit
different (but you should be able to derive the adoption pattern from
that patch).

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

