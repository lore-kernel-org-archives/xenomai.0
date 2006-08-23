From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17644.42025.91539.33163@domain.hid>
Date: Wed, 23 Aug 2006 20:53:29 +0200
Subject: Re: [Xenomai-core] [PATCH] semicolon delimiters & quotes
In-Reply-To: <200608231931.43452.paul_c@domain.hid>
References: <200608231931.43452.paul_c@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Paul <paul_c@domain.hid>
Cc: xenomai@xenomai.org

Paul wrote:
 > 
 > Hi Folks
 > 
 > Having found a problem with another project where semicolons in a few make 
 > targets were causing the shell to barf, I grepped xenomai trunk for similar 
 > problems. In doing so, I also spotted a few echos where the text wasn't 
 > quoted - A sure fire problem should anyone run the offending rule.
 > 
 > Small patch attached.

Could you tell us a bit more about the errors you had on the other
project ? I never got any error when sticking the semicolon to the last
shell line token. I also read the portable shell rules in autobook and
do not find any mention to such a problem. As for quoting the arguments
of echo, I am pretty sure that it is not needed.

-- 


					    Gilles Chanteperdrix.

