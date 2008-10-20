Message-ID: <48FC405E.8010603@domain.hid>
Date: Mon, 20 Oct 2008 10:25:02 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <48F9F12F.7090708@domain.hid>	<48FB15A8.30703@domain.hid>	<48FB17BD.7010904@domain.hid>	<48FB1891.3060609@domain.hid>
	<48FB19F7.1030107@domain.hid>	<48FB5BD5.1060205@domain.hid>
	<48FB5F1C.401@domain.hid>
In-Reply-To: <48FB5F1C.401@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH 1/1] Use SIGWINCH to trigger
 priority	change in user-space.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: Jan Kiszka <jan.kiszka@domain.hid>, Xenomai core <Xenomai-core@domain.hid>

Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
>> Well, what about merging the solutions: trap the signal from the library
>> constructor by default for people relying on #1, AND document the shadow signal
>> handler for people who can do #2?
> 
> For me, merging the two, would mean keep sigshadow_install called upon
> thread creation, but export xeno_sigwinch_handler to be callable from
> user signals.
> 
> This way, if people install their signal handler before the first thread
> creation, they have nothing to worry about. If they install their signal
> handler at a later time, they have to take care of calling
> xeno_sigwinch_handler and look at its return value.

Jan, do you agree? The main argument is that people may use third-party
libraries such as, say, libreadline or libqt which intercept the
SIGWINCH signal, and that we do not want to recompile these libraries to
run with Xenomai.

-- 
                                                 Gilles.

