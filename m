From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17484.61900.845103.177715@domain.hid>
Date: Mon, 24 Apr 2006 17:42:04 +0200
Subject: Re: [Xenomai-help] Error while running test suit (required="sep tsc", 
	present="sep", missing="tsc").
In-Reply-To: <3e9157940604240829u22307f54v2108ff8744c4ebeb@domain.hid>
References: <3e9157940604240829u22307f54v2108ff8744c4ebeb@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Deepak Joglekar <joglekar.deepak@domain.hid>
Cc: xenomai@xenomai.org

Deepak Joglekar wrote:
 > Hi,
 > 
 > I am using kernel 2.6.15.7 and Xenomai 2.1
 > 
 > While writing this mail I noticed the probable reason.
 > parameter
 > #define CONFIG_X86_TSC 1 should be
 > #define CONFIG_XENO_X86_TSC 1

No, the issue is that you enable usage of tsc in user-space by
passing the --enable-x86-tsc to configure, whereas you choosed, in
kernel configuration, a processor without tsc enabled.

-- 


					    Gilles Chanteperdrix.

