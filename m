Message-ID: <4E153BFA.601@domain.hid>
Date: Thu, 07 Jul 2011 06:54:18 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <C15B4995-28DC-403B-8117-B9F8062571D4@domain.hid>
In-Reply-To: <C15B4995-28DC-403B-8117-B9F8062571D4@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai 2.5.3 vs gettimeofday() --> livelock?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeremy Friesner <jaf@domain.hid>
Cc: xenomai@xenomai.org

On 07/06/2011 10:38 PM, Jeremy Friesner wrote:
> My first question is:  Am I right in suspecting that gettimeofday()
> can occasionally spin/livelock, when called from a Xenomai 2.5.3
> real-time thread?  FWIW, it gets called from the real-time thread
> once every 333mS.

Yes, this is a known issue.

> 
> And if that is the case, my second question is:  Is there an
> alternative "safe" way to call gettimeofday() (or something
> equivalent) so that the real-time thread can find out the current PTP
> system time?  Or do I need to re-write my code so that the real-time
> thread never calls gettimeofday()?
> 
> Is there a recommended practice for using Xenomai threads in
> conjunction with PTP?

There are several ways out:
- the rtdk library provides a version of gettimeofday which switches to
secondary mode before calling the real gettimeofday. In order to use it,
you have to link your application with:
-Wl,--wrap,gettimeofday -lrtdk
- you can forcibly emit the syscall like the clocktest application does.

-- 
                                                                Gilles.

