Message-ID: <4A013B94.5050000@domain.hid>
Date: Wed, 06 May 2009 09:26:12 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <OF9F7779BC.BE929FEC-ONC12575AE.0025E3D1-C12575AE.00286BC5@domain.hid>
In-Reply-To: <OF9F7779BC.BE929FEC-ONC12575AE.0025E3D1-C12575AE.00286BC5@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] gatekeeper/0
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: henning.richter@domain.hid
Cc: xenomai@xenomai.org

henning.richter@domain.hid wrote:
> Hi Gilles,
> 
> I tried to run, after a simple make, sigxcpu.
> The result:
> ./sigxcpu[0x80488337]
> [0xb800c400]
> /lib/tls/i686/cmov/libphtread.so.0[0xb7fcc50f]
> /lib/tls/i686/cmov/libc.so.6(clone+0x5e)[0xb7f417ee]
> 
> This is where my system freezes or simply reboots.
> 
> Am I doing sth wrong?

You are probably setting the warning bit too early and/or for the wrong
thread. You should set the bit only for the thread which is expected to
run in primary mode, and only after it has done its non primary mode
duties (like creating new threads).

However, you should not get freezes or reboots. Any trace on the console ?

-- 
                                                 Gilles.

