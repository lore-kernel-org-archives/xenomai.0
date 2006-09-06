MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17662.51500.428340.616539@domain.hid>
Date: Wed, 6 Sep 2006 15:12:12 +0200
Subject: Re: AW: [Xenomai-help] resubmission : memset of heap
	crashes	Xenomai-Task
In-Reply-To: <44FEC63E.3070009@domain.hid>
References: <5D63919D95F87E4D9D34FF7748CE2C2A4E9CDD@ARVMAIL1.mra.roland-man.biz>
	<17662.49530.72472.462058@domain.hid>
	<44FEC63E.3070009@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: Roderik_Wildenburg@domain.hid, xenomai@xenomai.org

Wolfgang Grandegger wrote:
 > I was able to reproduce the problem on my MPC5200 system some time ago
 > and I have checked the index "i" as well. "i" was not out-of-range, 
 > IIRC. The problem only shows up on PowerPC., at least Jan was unable
 > to reproduce it on a x86 system. How could we debug the seg fault. Do
 > you have a good idea? Would the IPIPE tracer help?

Ok. Now the question remains: does this problem still exist with version
2.2.2 ? The heaps overhead computations have changed recently.

-- 


					    Gilles Chanteperdrix.

