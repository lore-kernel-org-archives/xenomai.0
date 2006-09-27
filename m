Message-ID: <451A6E2B.2040901@domain.hid>
Date: Wed, 27 Sep 2006 14:27:23 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai on 2.6.17 ppc
References: <ac3922a00609270502s498d99bcv120ccc0f1a9f2a40@domain.hid>
In-Reply-To: <ac3922a00609270502s498d99bcv120ccc0f1a9f2a40@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
To: Syed Amer Gilani <amg@domain.hid>
Cc: xenomai@xenomai.org

Syed Amer Gilani wrote:
> I have a custom mpc5200 Board with needs patches to get Linux running
> on it. But those Patches are only available for 2.6.17. Before i try
> to backport those patches i just wanted to ask if there is a way to
> run Xenomai on 2.6.17 for ppc.

I posted a commented ADEOS-IPIPE patch for 2.6.18 for PPC end of last 
week (see https://mail.gna.org/public/adeos-main/2006-09/msg00009.html). 
Unfortunately, the PowerPC Linux kernel is a fast moving target these 
day due to the merge ppc, ppc64 -> powerpc and there are a few 
significant changes between 2.6.17 and 2.6.18, IIRC. But it's still 
worth a try.

Wolfgang.


