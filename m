Date: Fri, 4 Sep 2009 09:33:48 +0300 (EEST)
From: "Rus V. Brushkoff" <rus@domain.hid>
In-Reply-To: <0B45E93C5FF65740AEAE690BF3848B7AD386E6@domain.hid>
Message-ID: <Pine.LNX.4.64.0909040931390.25652@domain.hid>
References: <0B45E93C5FF65740AEAE690BF3848B7AD386E6@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Xenomai-help] Differences in RT_HEAP_INFO struct between
 Xenomai2.4/2.5
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Fillod Stephane <stephane.fillod@domain.hid>
Cc: xenomai@xenomai.org

On Thu, 3 Sep 2009, Fillod Stephane wrote:

:>   Trying to backport Xenomai app from 2.5 to 2.4 noticed that 
:> rt_heap_info struct has no phys_addr field. Is this interface
:difference 
:> supposed to exist ?
:At the cost of ABI disruption, you may backport the phys_addr field
:support with the attached patch.

 Thanks, I was interested in fact that such ABI difference will exist 
forever.


		Rus

