Message-ID: <4CB492CE.3020906@domain.hid>
Date: Tue, 12 Oct 2010 18:54:38 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <b54eff8c27fb8d66117fe1dc79a37ebe.squirrel@domain.hid>
In-Reply-To: <b54eff8c27fb8d66117fe1dc79a37ebe.squirrel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Float operations on ARM i.MX27
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
> I'm continuing my experience on Xenomai and i've reached the floating
> point "point" :)
> I've succesfully compiled a project using some floats (division and
> printf) but when i try to use a "high level" function like "ceil" or
> "sqrt" the linker can't find them.

If you read sqrt or ceil manpage, you will see that you need to add -lm
on gcc command line. As you would do on your host system.

> 
> I know there isn't any hard floating point unit on this cpu, so it's all
> emulated (soft floats): if it's so, i've to implement these functions
> inside my project?

No. This is not to say that there are no issues on ARM, but this one is
a purely classical beginner mistake.

For the FPU issue, see:
http://www.arm.linux.org.uk/mailinglists/faq.php#f3


-- 
					    Gilles.

