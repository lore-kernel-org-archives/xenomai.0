Message-ID: <488A073F.1090403@domain.hid>
Date: Fri, 25 Jul 2008 19:02:55 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <C1C62166118DFA4A8BBA01A2411F0D170BF3D1BE92@domain.hid>
In-Reply-To: <C1C62166118DFA4A8BBA01A2411F0D170BF3D1BE92@domain.hid>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai-help] Problem with time-out ends
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: BARRE Sebastien <sbarre@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>, Fabien MAHOT <fabien.mahot@domain.hid>

BARRE Sebastien wrote:
> Hi,
> 
> I continue the work that Fabien MAHOT began about the port of the
> SDELCC applications on the Xenomai POSIX skin.
> 
> I tryed the patches you send him. First, I applied the
> "ipipe-longer-atomicswitch.diff‎" patch , but the test program
> "testTimer12_corrected" still froze the system without any kernel
> message on the console. Then I need to reboot.
> 
> Then, I applied the both "xeno-fix-harden-bug.diff‎" patch and
> "ipipe-longer-atomicswitch.diff‎" patch, the test program run in a
> loop since 24 hours without problem. It works ! It seems that the 2
> patches is necessary to correct the problem. Is it what you expected
> ?

Not quite. Could you give a try to Xenomai 2.4.4, using the latest Adeos
patch for 2.6.26 downloaded from gna.org (and not the Adeos patch which
ships with Xenomai 2.4.4) ?

-- 


					    Gilles.

