Message-ID: <2ff1a98a0806110528l1d50fd75g79348cca81b94e29@domain.hid>
Date: Wed, 11 Jun 2008 14:28:37 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <e2ba8ccba8e14750cb4a9dbdafcc5be7@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <e2ba8ccba8e14750cb4a9dbdafcc5be7@domain.hid>
Subject: Re: [Xenomai-help] xenomai scheduler's ticks period
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: matthieu.connaulte_xenomai@domain.hid
Cc: xenomai@xenomai.org

On Wed, Jun 11, 2008 at 11:18 AM, Matthieu
<matthieu.connaulte_xenomai@domain.hid> wrote:
> So, do I have to understand that all skins have their own scheduler ?

Starting with Xenomai 2.4, every skin has its own tick source, yes.

> To schedule at 1ms, specifying option tick_arg=1000 to xeno_vxworks module
> doesn't ! I thing
> that I do it in a bad way, endeed I added "options xeno_vxworks
> tick_arg=1000" to /etc/modprobe.conf/local ... (In fact I must add this
> module manually, it isn't loaded automatically while a vxworks instruction
> need to execute).

We never even thought about auto module loading usually people know
which module they need. Note that it seems that the module
auto-loading feature is somewhat deprecated by kernel people, since it
is now possible to disable it, and the udev daemon loads all possible
modules at boot time instead of waiting that a module is really needed
before loading it, thereby killing module auto-loading.

However you should note that /etc/modprobe.conf/something will only
work if you use "modprobe" to load module. If you use insmod, the
arguments should be passed on insmod command line.

If you use modprobe and the tick_arg parameter does not work, could
you post the example program showing the issue you met?

-- 
 Gilles

