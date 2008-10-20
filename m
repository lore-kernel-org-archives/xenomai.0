Message-ID: <48FCD485.2060606@domain.hid>
Date: Mon, 20 Oct 2008 20:57:09 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <48F9F12F.7090708@domain.hid>	<48FB15A8.30703@domain.hid>	<48FB17BD.7010904@domain.hid>	<48FB1891.3060609@domain.hid>
	<48FB19F7.1030107@domain.hid>	<48FB5BD5.1060205@domain.hid>
	<48FB5F1C.401@domain.hid> <48FC405E.8010603@domain.hid>
	<48FC440E.90000@domain.hid>
In-Reply-To: <48FC440E.90000@domain.hid>
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Gilles Chanteperdrix wrote:
>>> Philippe Gerum wrote:
>>>> Well, what about merging the solutions: trap the signal from the library
>>>> constructor by default for people relying on #1, AND document the shadow signal
>>>> handler for people who can do #2?
>>> For me, merging the two, would mean keep sigshadow_install called upon
>>> thread creation, but export xeno_sigwinch_handler to be callable from
>>> user signals.
>>>
>>> This way, if people install their signal handler before the first thread
>>> creation, they have nothing to worry about. If they install their signal
>>> handler at a later time, they have to take care of calling
>>> xeno_sigwinch_handler and look at its return value.
>> Jan, do you agree? The main argument is that people may use third-party
>> libraries such as, say, libreadline or libqt which intercept the
>> SIGWINCH signal, and that we do not want to recompile these libraries to
>> run with Xenomai.
> 
> Yes, I'm fine with the current approach + doc + xeno_sigwinch_handler.

Ok. Since I am going to paste the doc in four different places, I'd 
better get it right from the beginning. Here is my prose:

 * @note: When creating or shadowing a Xenomai thread in user-space, for the
 * first time, Xenomai installs a handler for the SIGWINCH signal. If you had
 * installed a handler before that, it will be automatically called by Xenomai
 * for SIGWINCH signals that it has not sent.
 *
 * If, however, you install a signal handler for SIGWINCH after creating
 * or shadowing the first Xenomai thread, you have to explicitely call the
 * function xeno_sigwinch_handler at the beginning of your signal handler,
 * using its return to know if the signal was in fact an internal signal of
 * Xenomai (in which case it returns 1), or if you should handle the signal (in
 * which case it returns 0). xeno_sigwinch_handler prototype is:
 *
 * <b>int xeno_sigwinch_handler(int sig, siginfo_t *si, void *ctxt);</b>
 *
 * Which means that you should register your handler with sigaction, using the
 * SA_SIGINFO flag, and pass all the arguments you received to
 * xeno_sigwinch_handler.


-- 
					    Gilles.

