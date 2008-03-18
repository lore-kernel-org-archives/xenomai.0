Message-ID: <2ff1a98a0803180300g7358e56cw262276645988fa03@domain.hid>
Date: Tue, 18 Mar 2008 11:00:49 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <405543936.30034@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <405543936.30034@domain.hid>
Subject: Re: [Xenomai-help] AT91RM9200 Real-time kernel canot use float
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: 06121777 <06121777@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

On Sat, Mar 15, 2008 at 1:21 AM, 06121777 <06121777@domain.hid> wrote:
>
>
> anybody  think about it ? I want to use float in real time kernel,my board
> is AT91RM9200

Using soft-float in kernel-space is usually considered a bad idea. But
if you still want to do it, read on.

First, you have to realize that an AT91RM9200 has no FPU, so you have
to use soft float (which means compiling with -msoft-float), which is
slow. Since you are talking about kernel space, you do not have to
change the compilation flags, since the kernel is already compiled
with -msoft-float. At the end of the compilation you will get
undefined symbols, to resolve these symbols, you may extract them from
your compiler libgcc. But be careful to only use symbols that do not
use user-space services (for instance, the function called in case of
division by 0, called _div0 or something like this, uses abort, so you
should implement your own _div0).

-- 
 Gilles Chanteperdrix

