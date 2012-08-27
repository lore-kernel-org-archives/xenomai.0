Message-ID: <503B0569.1050609@xenomai.org>
Date: Mon, 27 Aug 2012 07:28:09 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <201208262252.27556.paul_c@tuxcnc.org>
In-Reply-To: <201208262252.27556.paul_c@tuxcnc.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] oops on ARM1176 SoC
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Paul <paul_c@tuxcnc.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Le 26/08/2012 23:52, Paul a écrit :
>
> Finally got hold of an RS232 interface for my ARM1176 board and have
> been trying to capture a fatal kernel crash log. Have compiled various
> kernels and pared the config down to a bare minimum - The trace for the
> latest crash is attached. This happens when unloading xeno-nucleus,
> kinda at a loss as to where to go from here, so any pointers would be
> much appreciated.

It seems nobody tried xenomai compiling as a module with the "hostrt" 
feature, a call to rthal_catch_hostrt(NULL) is missing in __xeno_sys_exit.

-- 
Gilles.

