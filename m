Message-ID: <2ff1a98a0802140557u393d119dk473bc8e901df07c3@domain.hid>
Date: Thu, 14 Feb 2008 14:57:38 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <003301c86f0b$f06e6830$d14b3890$@pt>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <021201c86e89$b73b7080$25b25180$@pt>
	<18355.61321.710913.187647@domain.hid>
	<003301c86f0b$f06e6830$d14b3890$@pt>
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

On Thu, Feb 14, 2008 at 2:17 PM, Pedro Mendes <pcm@domain.hid> wrote:
> Pedro Mendes wrote:
>   > Hi all!
>   >
>   >
>   >
>   > I've been trying to get Xenomai to work with my gumstix but I can't find
>  a
>   > way to patch the linux kernel correctly. Has anyone installed Xenomai on
>  a
>   > gumstix? Could you tell me the revision of the buildroot and xenomai
>   > versions you used pls (and possibly how.)?
>
>  gumstix is based on a PXA, right ?
>
>  Right.
>
>
>   So, it should be supported by Xenomai. Is it supported by mainline kernel,
>  or do you need an
>  additional patch ? And what happens when you patch the kernel with the
>  I-pipe patch, what error message do you get exactly ?
>  It is supported by mainline kernel and xenomai patches apply correctly.
>  However other patches are used for the gumstix and those are the ones
>  failing now. If I apply those first, then those apply correctly and xenomai
>  patches fail.

Ok. Please send me the URLs where I can download these gumstix
patches, if possible, I will arrange to avoid the conflicts. In the
meantime, you can probably fix the rejects by hand, I would be
surprised if the rejects happened on really critical parts of the
code.

-- 
 Gilles Chanteperdrix

