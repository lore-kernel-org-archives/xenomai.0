MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17664.3405.935244.253039@domain.hid>
Date: Thu, 7 Sep 2006 14:15:09 +0200
Subject: Re: AW: AW: [Xenomai-help] resubmission : memset of heap
	crashes	Xenomai-Task
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A4E9E80@domain.hid>
References: <5D63919D95F87E4D9D34FF7748CE2C2A4E9E80@domain.hid>
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
To: Roderik_Wildenburg@domain.hid
Cc: xenomai@xenomai.org

Roderik_Wildenburg@domain.hid wrote:
 > P.s.: with 2.2.2 I noticed, that in /proc/xenomai/interfaces vxWorks is not listed although I compiled the kernel with support for vxworks. Is this o.K. ?

The vxworks interface probably failed to start, likely because it needs
periodic timer and you load the native interface that set the hardware
timer to aperiodic mode.

-- 


					    Gilles Chanteperdrix.

