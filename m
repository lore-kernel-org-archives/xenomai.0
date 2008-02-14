MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18355.61321.710913.187647@domain.hid>
Date: Thu, 14 Feb 2008 08:36:41 +0100
In-Reply-To: <021201c86e89$b73b7080$25b25180$@pt>
References: <021201c86e89$b73b7080$25b25180$@pt>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] (no subject)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Pedro Mendes <pcm@domain.hid>
Cc: xenomai@xenomai.org

Pedro Mendes wrote:
 > Hi all!
 > 
 >  
 > 
 > I've been trying to get Xenomai to work with my gumstix but I can't find a
 > way to patch the linux kernel correctly. Has anyone installed Xenomai on a
 > gumstix? Could you tell me the revision of the buildroot and xenomai
 > versions you used pls (and possibly how.)?

gumstix is based on a PXA, right ? So, it should be supported by
Xenomai. Is it supported by mainline kernel, or do you need an
additional patch ? And what happens when you patch the kernel with the
I-pipe patch, what error message do you get exactly ?

-- 


					    Gilles Chanteperdrix.

