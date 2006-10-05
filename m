Message-ID: <ac3922a00610050538j450879fcv9c5fb47259959412@domain.hid>
Date: Thu, 5 Oct 2006 14:38:51 +0200
From: "Syed Amer Gilani" <amg@domain.hid>
Sender: groove.c@domain.hid
Subject: Re: [Xenomai-help] Xenomai on 2.6.17 ppc
In-Reply-To: <4524FB42.8030307@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <ac3922a00609270502s498d99bcv120ccc0f1a9f2a40@domain.hid>
	<451A6E2B.2040901@domain.hid>
	<ac3922a00609270536m396f4af0i4d60929689d4f541@domain.hid>
	<451E8999.2000801@domain.hid>
	<ac3922a00610050516j5f06ae37j69ab6efcd9a4eb8e@domain.hid>
	<4524FB42.8030307@domain.hid>
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

2006/10/5, Wolfgang Grandegger <wg@domain.hid>:
> Are the Linux 2.6.17 patches for the MPC5200 you mentioned earlier
> available somewhere? I would like to do some RT-Socket-CAN tests with
> MSCAN under Linux 2.6 but so far, I didn't succeed to make a usable
> kernel :-(.

http://www.pengutronix.de/oselas/bsp/phytec/index_de.html#phyCORE-MPC5200B

They are developed for this specific Board, i don't know if they work
on slightly different Hardware. This Package is meant to be used with
Ptxdist, but when you untar it you will find the kernel patches in the
kernel-patches-target Directory.

