Message-ID: <4CB2D37E.1040104@domain.hid>
Date: Mon, 11 Oct 2010 11:06:06 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <9c78cfdc7e17a926a13b77a35adde88a.squirrel@domain.hid>
In-Reply-To: <9c78cfdc7e17a926a13b77a35adde88a.squirrel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] License Question
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: cagnulein@domain.hid
Cc: xenomai@xenomai.org

Cagnulein wrote:
> Hi, i'm following with huge interest this project and i would like to join
> in some way.
> 
> I'm developping some real time driver module for an embedeed system and i
> would like to release the source code.
> 
> I'm developping an application too that uses xenomai + my realtime drivers.
> 
> This application links xenomai_native.
> 
> I've only a question: following the gpl/lgpl license, do i have the duty
> to release my application source code?

Kernel-space is GPL, user-space is LGPL. So, it means that you must
distribute the driver source code with the application, you must
distribute the application source code with the application if it uses
the native skin in kernel-space, and you must distribute the source code
of the modified Xenomai libraries if you modified it, with the
application, if the application uses the native skin in user-space.

-- 
					    Gilles.

