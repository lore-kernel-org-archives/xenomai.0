From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <9c78cfdc7e17a926a13b77a35adde88a.squirrel@domain.hid>
References: <9c78cfdc7e17a926a13b77a35adde88a.squirrel@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 11 Oct 2010 11:39:49 +0200
Message-ID: <1286789989.1740.19.camel@domain.hid>
Mime-Version: 1.0
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

On Mon, 2010-10-11 at 09:50 +0200, Cagnulein wrote:
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
> 
> If you can't answer ( we are technicians not lawyers :) ), do you know
> someone who could answer to this question?

Our licensing scheme is plain simple:

- your kernel-based code based on the Xenomai infrastructure falls under
the kernel license; typically, your driver is concerned. This is GPL
land.

- linking against Xenomai's libnative support makes your application
fall under the LGPL. Distributing it does not require you to provide its
source code (this does not however invalidate any other reasons why you
would have to provide such code, if any -- but LGPL does not require
that).

-- 
Philippe.



