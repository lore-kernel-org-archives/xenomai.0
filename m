Message-ID: <4F0C7F68.1060402@domain.hid>
Date: Tue, 10 Jan 2012 19:11:52 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4EF27CD5.4060603@domain.hid>
	<4EF8FBB6.4060107@domain.hid> <4EF8FD8D.2090306@domain.hid>
	<4EFB696E.8000508@domain.hid>
	<4EFC4E21.3000804@domain.hid> <4EFC677B.20500@domain.hid>
	<CAJPpvENavHPfvhuS-Ugsje738V=3kko+7dnvv6_AS3F09pbF4w@domain.hid>
	<4EFC887D.3070205@domain.hid>
	<4F0393A2.2000703@domain.hid>
	<4F0C7A60.10203@domain.hid>
In-Reply-To: <4F0C7A60.10203@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] hang in rtcansend
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Andrew Tannenbaum <trb@domain.hid>
Cc: xenomai@xenomai.org

On 01/10/2012 06:50 PM, Andrew Tannenbaum wrote:
> I have tried several variations, like running make dist and then just
> running debuild, but it fails the same way.
> 
> I notice that when I get a dist tarball, I compile from the
> xenomai-2.6.0 directory, but when I start with the git tree, I compile
> from xenomai-2.6 and it generates some files in the ../xenomai-2.6.0
> directory.  Is this part of the problem?  It works for the base version
> but not the merged version, so I'm not clear on this.

Normally, when you run "make dist", the directory should be called
xenomai-2.6.0, not xenomai-2.6. Or am I missing something?

-- 
					    Gilles.

