Message-ID: <499572C2.3060609@domain.hid>
Date: Fri, 13 Feb 2009 13:16:50 +0000
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4B2EEE69E41E524EB7FCDC62A15D68D80308F137@domain.hid>
In-Reply-To: <4B2EEE69E41E524EB7FCDC62A15D68D80308F137@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Floating Point Exceptions in RT-Tasks
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: thomas.debes@domain.hid
Cc: xenomai@xenomai.org

thomas.debes@domain.hid wrote:
> Hi,
> 
> I successfully managed to enable FP Exceptions on our MPC5200 board for
> plain linux applications (via fesetenv). When I put the same trigger
> code (DivByZero) into a (native) RT task no exception is triggered until
> I force a mode switch to secondary mode (e.g. printf). How can I get
> them without performing the mode switch?

An FPU exception triggers a signal, and signal can only be sent to a
task running in secondary mode. So, even if we managed to get the signal
to be sent to the task immediately, it would cause it to switch to
secondary mode. Is it really what you want?

-- 
                                                 Gilles.

