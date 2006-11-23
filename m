Message-ID: <4565E0D2.5000008@domain.hid>
Date: Thu, 23 Nov 2006 18:56:34 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Debugging in Xenomai
References: <DD39B5C3F4963040ADC9768BE7E430CB015D5270@domain.hid>
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB015D5270@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniel Schnell <daniel.schnell@domain.hid>
Cc: xenomai@xenomai.org

Daniel Schnell wrote:
> How do the Xenomai veterans debug their application in case of deadlocks
> / synchronization errors, crashes etc. ?

You may try to enable Xenomai debug options, it may give you some
information of why the program is crashing, for instance if you are
destroying the same object twice or such kind of errors.

If using the posix skin, one source of deadlocks is the threads
cancelation, you should cancel all the threads and then join them all
and not cancel then join each thread in turn.

-- 
                                                 Gilles Chanteperdrix

