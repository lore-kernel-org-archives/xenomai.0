From: "Pedro Mendes" <pcm@domain.hid>
References: <021201c86e89$b73b7080$25b25180$@pt>
	<18355.61321.710913.187647@domain.hid>
In-Reply-To: <18355.61321.710913.187647@domain.hid>
Date: Thu, 14 Feb 2008 13:17:24 -0000
Message-ID: <003301c86f0b$f06e6830$d14b3890$@pt>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Content-Language: pt
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
To: 'Gilles Chanteperdrix' <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Pedro Mendes wrote:
 > Hi all!
 > 
 >  
 > 
 > I've been trying to get Xenomai to work with my gumstix but I can't find
a
 > way to patch the linux kernel correctly. Has anyone installed Xenomai on
a
 > gumstix? Could you tell me the revision of the buildroot and xenomai
 > versions you used pls (and possibly how.)?

gumstix is based on a PXA, right ?

Right.

 So, it should be supported by Xenomai. Is it supported by mainline kernel,
or do you need an
additional patch ? And what happens when you patch the kernel with the
I-pipe patch, what error message do you get exactly ?
It is supported by mainline kernel and xenomai patches apply correctly.
However other patches are used for the gumstix and those are the ones
failing now. If I apply those first, then those apply correctly and xenomai
patches fail.

Pedro



