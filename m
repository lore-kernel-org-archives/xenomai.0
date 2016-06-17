From: "Heinick, J Michael" <Michael.Heinick@Honeywell.com>
Date: Fri, 17 Jun 2016 13:25:05 +0000
Message-ID: <D9EDB4F689BF9F4EA6F2158A073942732E801E4B@de08ex3008.global.ds.honeywell.com>
References: <D9EDB4F689BF9F4EA6F2158A073942732E8007D6@de08ex3008.global.ds.honeywell.com>
 <20160608193911.GA31360@hermes.click-hack.org>
 <D9EDB4F689BF9F4EA6F2158A073942732E8008F3@de08ex3008.global.ds.honeywell.com>
 <20160609174118.GD1785@hermes.click-hack.org> <575AF2E1.3060401@siemens.com>
 <D9EDB4F689BF9F4EA6F2158A073942732E801DAA@de08ex3008.global.ds.honeywell.com>
 <20160616171605.GD32532@hermes.click-hack.org>
In-Reply-To: <20160616171605.GD32532@hermes.click-hack.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Xenomai/Cobalt on i7-3770S CPU
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>



-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]=20
Sent: Thursday, June 16, 2016 1:16 PM
To: Heinick, J Michael
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai] Xenomai/Cobalt on i7-3770S CPU

On Thu, Jun 16, 2016 at 03:51:17PM +0000, Heinick, J Michael wrote:
> problem, the stripped down driver would hang the core2 computer just=20
> like the i7 computer.

Are you running a graphic system? If yes, have you tried to plug a serial c=
onsole or netconsole to try and retrieve the kernel console when the hang h=
appens? Because if the hang is in fact a kernel oops, the oops message may =
indicate what the problem is.

> Eventually, I noticed that only nrt
> handlers were specified in the ops structure. After moving our ioctl=20
> functions to .ioctl_rt, both the stripped down driver and the full=20
> driver run on both the core2 and i7 computers.

You can not call "sleeping" services from an _nrt handler. If that is what =
you were doing.

> Why the core2 computers appeared to work with only the ioctl_nrt=20
> handler specified in the full driver and hang the i7 computer is still=20
> a mystery to us.

Did the two machines run with the same kernel? Or were there differences in=
 the kernel configuration? Like I-pipe checks disabled/enabled?

--=20
					    Gilles.
https://click-hack.org

----------------------------------------------------------
Thanks Gilles,

Yes, I was making an rtdm_sem_down call in the ioctl_nrt to wait for the rt=
dm_sem_up in the interrupt handler.  I probably set it that way months ago =
when I was developing calls in the full driver to configure the device, and=
 did not remember it when I implemented the interrupts and things still app=
eared to work on the core2 machine where development was taking place.  The=
 stripped down driver eliminated the interrupt handler and put the rtdm_sem=
_up call in the write handler that was called by the user program to fake a=
n interrupt.  The stripped down driver with the ioctl_nrt would hang the co=
mputer on both machines.  Changing ioctl_nrt to ioctl_rt enabled both the s=
tripped down driver and the full driver to work on all machines. =20

All machines were running xenomai 3.0.1 with ipipe release 10 on linux 3.14=
.44.  There were probably some differences in kernel configuration, but any=
thing involving things like i-pipe just used defaults.  Since the fix the S=
uper Logics i7 computer has been updated to Xenomai 3.0.2.

I suppose now I should separate my ioctl_nrt stuff to a separate function f=
rom the ioctl_rt stuff, and then I will I have both functions specified in =
the ops structure of the rtdm_driver structure.  I will have to look up how=
 xenomai is going to determine which one to use.

Thanks for the help,
Mike

