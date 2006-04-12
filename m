From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17468.59019.121961.858682@domain.hid>
Date: Wed, 12 Apr 2006 13:37:47 +0200
Subject: Re: [Xenomai-core] Missing extern "C" { in include/posix/fcntl.h
In-Reply-To: <54DC87D6AB55F34DAC460DFFF590346E2121A1@domain.hid>
References: <54DC87D6AB55F34DAC460DFFF590346E2121A1@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "Meier, Hans" <Hans.Meier@domain.hid>
Cc: xenomai@xenomai.org

Meier, Hans wrote:
 > Hi everybody,
 > 
 > Obviously a 
 > 
 > #ifdef __cplusplus
 > extern "C" {
 > #endif
 > 
 > (only the first half of it, the closing '}' exists) is missing in
 > include/posix/fcntl.h, see the patch below. 
 > 
 > The problem still exists in 2.1.0 as well as in trunk.

Patch applied, thanks.

-- 


					    Gilles Chanteperdrix.

