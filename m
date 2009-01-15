Message-ID: <496F2281.2000102@domain.hid>
Date: Thu, 15 Jan 2009 12:48:17 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <BAY101-W2825402A319CC124388542EAD70@domain.hid>
In-Reply-To: <BAY101-W2825402A319CC124388542EAD70@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Debugger Support
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Stephen Davies <steve_davies61@domain.hid>
Cc: xenomai@xenomai.org

Stephen Davies wrote:
> Hi All,
> 
> I currently have an application that runs under RTAI however I am now
> having problems that I wish to debug.  Debugger support for RTAI is
> limited at best (currently the only option we have is to use
> rt_printk() or printf() to the console).  I've been looking back at
> Xenomai and I see a lot of references to LTTng support which would be
> ideal and would mean I would port my RTAI app to Xenomai.  However
> these references seem to all die out around 2007.  Is there still
> support for a "proper" debugger (stepping through code, variable
> values etc...) in the current release of Xenomai?

LTTng is actively supported over Xenomai, we just still need additional
fiddling with the patch series as LTTng is not yet mainline. We are
using it here over 2.6.26 ATM, I think I just missed to post the (rather
simple) update from the published 2.6.24 version. And I'm about to port
them to the next kernel base (either 2.6.27 or .28).

Beside the LTTng tracer there is also source-level debugging, of course.
gdb for the apps, kgdb for the kernel (x86) - or via KVM, ie. kernel
source-level debugging inside a virtual x86 machine. kgdb just needs
some extra patches which I didn't update to 2.6.27 yet because I'm using
KVM now.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 26
Corporate Competence Center Embedded Linux

