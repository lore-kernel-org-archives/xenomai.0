Message-Id: <54FDA16A0200005500018D13@iwesmail-ks.iwes.fraunhofer.de>
Date: Mon, 09 Mar 2015 13:34:34 +0100
From: <jonas.platte@iwes.fraunhofer.de>
References: <54FD770A0200005500018D03@iwesmail-ks.iwes.fraunhofer.de>
 <54FD7EBF0200005500018D0E@iwesmail-ks.iwes.fraunhofer.de>
 <54FD7EBF0200005500018D0E@iwesmail-ks.iwes.fraunhofer.de>
 <20150309104447.GD17373@hermes.click-hack.org>
In-Reply-To: <20150309104447.GD17373@hermes.click-hack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: Re: [Xenomai] rtnet: could not insert 'rtudp': Invalid argument
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: gilles.chanteperdrix@xenomai.org
Cc: xenomai@xenomai.org

Thanks a lot! rtnet now works, and (I don't know whether I should find =
this good or bad)
I can reproduce the issue Antoine had: When starting rtnet, the system =
hangs. I guess
it's a kernel module that gets itself into an endless loop, as all my SSH =
connections fail
and trying to open new ones results in a timeout.

I didn't find anything interesting in /var/log/kernel.log.1 and I don't =
know where else I
could find debug info, but by commenting out things and adding some debug =
echo
statements, I was able to pin down the issue to the start_master() =
function. When it's
not called, I can already "rtping 127.0.0.1" successfully after "rtnet =
start", which is about
as far as I came with rtnet on Xenomai 2.6. I will try to find the exact =
command that
makes the system hang, and try to get rtping working across two devices =
afterwards.

>>> Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> 09.03.2015 =
11:44 >>>
On Mon, Mar 09, 2015 at 11:06:39AM +0100, jonas.platte@iwes.fraunhofer.de =
wrote:
>  I have managed to set up rtnet with Xenomai 3.0 with the help of
> Gilles now, but I am running running into a problem that I haven't
> had with Xenomai 2.6: When trying to start rtnet, "modprobe rtudp"
> fails. Rebinding the driver for the ethernet card that's supposed
> to do the realtime communication works, so the setup isn't
> completely broken.
>=20
> I can reproduce the same error message by manually calling "sudo
> modprobe rtudp" or "sudo insmod
> /lib/modules/3.14.28/kernel/drivers/xenomai/net/stack/ipv4/udp/rtudp.ko".=

>=20
> dmesg and /var/log/kern.log sadly don't show anything directly
> related, but I still attached the dmesg output generated when
> executing "rtnet start", maybe it can give a hint.
>=20
> If someone could give me a tip on where to find more debug info,
> that would be nice.

See:
https://xenomai.org/pipermail/xenomai/2015-February/033377.html=20

--=20
					    Gilles.


