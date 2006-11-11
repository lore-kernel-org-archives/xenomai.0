From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17750.2115.314322.395360@domain.hid>
Date: Sat, 11 Nov 2006 18:28:35 +0100
Subject: Re: [Xenomai-core] [PATCH] Doxygen hyperlinking utilitiy and demo
	programs
In-Reply-To: <4554636C.4070704@domain.hid>
References: <4554636C.4070704@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Wolfgang Grandegger wrote:
 > Hello,
 > 
 > the attached patch adds the RT-Socket-CAN utility programs as examples 
 > to the Doxygen documentation setup. This creates some nice cross 
 > reference from the documented API functions to the example code lines 
 > and vice versa. In a similar way, the Xenomai demo programs and code 
 > snippets could be integrated making it much easier to find example code 
 > or the description of an API function used in an example.
 > 
 > Please have a look and comment?

This is a good idea. The native skin snippets were created with
the same idea in mind, it looks like I somehow forgot to finish the
work.

Now, about your patch, will not this hunk break some things ?

 >  # EXCLUDE_PATTERNS tag to specify one or more wildcard patterns to exclude 
 >  # certain files from those directories.
 >  
 > -EXCLUDE_PATTERNS       = 
 > +EXCLUDE_PATTERNS       = "*.c"


-- 


					    Gilles Chanteperdrix.

