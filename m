Message-ID: <4C0E05F6.5030200@domain.hid>
Date: Tue, 08 Jun 2010 10:57:26 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTimIDghE4o5RpesavooS0cB96ekIgYTXv8rkPRZb@domain.hid>
In-Reply-To: <AANLkTimIDghE4o5RpesavooS0cB96ekIgYTXv8rkPRZb@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] [RTnet-users] Alignment problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Cyril Wallois <walloiscyril@domain.hid>
Cc: xenomai@xenomai.org, rtnet-users@domain.hid

Cyril Wallois wrote:
> Hello everybody,
> 
> I try rtnet with the last stable version of xenomai (2.5.3 and linux
> kernel 2.6.26) and I have a new error code :

Still on ARM, right? Do you have the same issue if you use an I-pipe
patch for a more recent kernel versions (anything more recent than 2.6.28).

Other than that, you do not give us enough information to help solving
your issue. What about the last issue you had? What was the value of the
r3 register at the time of the alignment fault?

-- 
					    Gilles.

