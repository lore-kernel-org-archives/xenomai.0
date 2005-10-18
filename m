MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17236.44896.867414.960846@domain.hid>
Date: Tue, 18 Oct 2005 10:16:32 +0200
Subject: Re: [Xenomai-help] compiling xenomai on x86_64
In-Reply-To: <4354ADA9.2010809@domain.hid>
References: <4353F109.7000707@domain.hid>
	<4353F411.4000500@domain.hid>
	<4353F896.1040508@domain.hid>
	<435402B4.5060004@domain.hid>
	<17236.13453.672147.550393@domain.hid>
	<4354ADA9.2010809@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
 > > #! /bin/sh
 > > exec `expr "$0" : 'i686-linux-\(.*\)'` -m32r ${1+"$@"}
 > > 
 > > It should work with most build systems...
 > > 
 > 
 > Yes, this seems to work (and fail) just like the "CC=" approach.

Are you sure your distribution does not provide a cross-compiler ? I
worked once on an x86_64 with Fedora Core installed. And there was an
i386-linux-gcc, but it needed a special package.

-- 


					    Gilles Chanteperdrix.

