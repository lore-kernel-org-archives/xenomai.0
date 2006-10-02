Subject: Re: [Xenomai-help] Xenomai on 2.6.17 ppc
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <451E8999.2000801@domain.hid>
References: <ac3922a00609270502s498d99bcv120ccc0f1a9f2a40@domain.hid>
	<451A6E2B.2040901@domain.hid>
	<ac3922a00609270536m396f4af0i4d60929689d4f541@domain.hid>
	<451E8999.2000801@domain.hid>
Content-Type: text/plain
Date: Mon, 02 Oct 2006 20:46:21 +0200
Message-Id: <1159814782.5054.21.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
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
Cc: xenomai-help <xenomai@xenomai.org>

On Sat, 2006-09-30 at 17:13 +0200, Wolfgang Grandegger wrote:

> I realized, that the differences to Linux 2.6.18 are quite small and non 
> critical. Attached is a ADEOS-IPIPE patch for Linux 2.6.17, which should 
> work on your MPC5200 as well (the idle loop problem for 6xx is solved).
> Would be nice if you could test the patch and report the results. It's 
> difficult these days to get a 2.6.x kernel built and booted on an 
> MPC5200 :-(.
> 
> Note: this patch requires another small fix for Xenomai (see 
> attachment). Philippe, could you please apply it? TIA.

Applied, thanks.

-- 
Philippe.



