Date: Sun, 6 Mar 2016 17:23:05 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160306162305.GB1783@hermes.click-hack.org>
References: <56DC4081.4040807@esiee.fr>
 <20160306150817.GA1783@hermes.click-hack.org>
 <56DC5749.8020506@esiee.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <56DC5749.8020506@esiee.fr>
Subject: Re: [Xenomai] rtnet/xenomai-3.0.1+3.18.20kernel: tdma & nomac issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Thierry Grandpierre <thierry.grandpierre@esiee.fr>
Cc: xenomai@xenomai.org

On Sun, Mar 06, 2016 at 05:14:01PM +0100, Thierry Grandpierre wrote:
> Thanks for a so fast answer!
>=20
>=20
> Le 06/03/2016 16:08, Gilles Chanteperdrix a =E9crit :
> > On Sun, Mar 06, 2016 at 03:36:49PM +0100, Thierry Grandpierre wrote:
> >> 1) RTNET/TDMA : I am unsuccessfully  trying to run rtnet/xenomai 3 on 2
> >> virtual machines : a VM as master and a VM as slave. Synchro frames are
> >> sent by the master and received on the slave machine (seen with
> >> wireshark on the rteth0 of each machine) but slave never answer. Both
> >> machine are VMs connected by a  VM to VM private network  (VMnet0 in
> >> VMware)
> > Are you sure the network emulation you use transmit all kinds of
> > packets? In qemu, for instance, the default network emulation is not
> > able to transmit icmp packets and probably not rtcfg packets (they
> > use a custom ethertype). I have tested rtcfg with Xenomai 3.0.1 and
> > it worked. I have not tried transmitting files though, just used it
> > as a kind of DHCP.
> I use VMware Workstation 11.0.0 build-2305329 and setup vm0 as a=20
> Host-only (connect VMs internally in a private network) without=20
> connecting any host virtual adapter to this network neither DHCP.
>=20
> As explained, using wireshark on the second VM I saw the sync frame sent =

> by the first VM so I think that yes the packets seems to be transmitted :
> wireshark on the master : 100    0.494738000    Vmware_cc:8c:1b=20
> Broadcast    TDMA    42 Synchronisation
> wireshark on the slave : 204    0.484035000    Vmware_cc:8c:1b=20
> Broadcast    TDMA    64 Synchronisation
>=20
> =3D=3D> the strange thing is the size difference 42 on the master versus =
64=20
> received on the slave...22 bytes difference
> I will try to get more info. on that..

An ethernet packet is forbidden to occupy less than 64 bytes, so the
sender pads the packet to 64 bytes before sending it.

>=20
>=20
> >
> >> Rtnet on the slave machine is waiting with message :
> >>       /usr/xenomai/sbin/rtcfg rteth0 add 10.0.0.2 -stage1 -
> >>       Waiting for all slaves.../usr/xenomai/sbin/rtcfg rteth0 wait"
> >>
> >> Rtnet on the master machine is also hanging with message
> >>     /usr/xenomai/sbin/rtifconfig rteth0 up 10.0.0.2
> >>     Stage 1: searching for master...
> >>
> >> I think rtnet on the slave machine doesn't see/understand the sync
> >> frames. Below all details are given.
> >>
> >> 2)RTNET/NOMAC:
> >> When trying nomac, once everything is configured, I'm getting " ioctl:
> >> Resource temporarily unavailable" when pinging. Details are also given
> >> at the end.
> > This probably means that the network is not up, but I am a little
> > confused, as I thought I added this check after the 3.0.1 release.
> > Are you using the 3.0.1 release, or the current git?
> > Anyway, if that is the case, when you run rtifconfig you should not
> > see the RUNNING flag. You have to wait for the network to be up and
> > running before being able to actually send packets.
> >
> I used the 3.0.1 release, not the git version.
>=20
> How can I disable this RUNNING flag (I thought is was normal to have=20
> running..) ?  it never goes off by itself :-(

Sorry, you do not want to disable the RUNNING flag. What I meant is
that with current Xenomai 3.0 git, the flag is not set when the
network is not up, at which point sending a packet will cause
EAGAIN to be returned. When the network is up the RUNNING flag will
appear in rtifconfig output, and at that point, you can start
sending packets.

I would suggest you try Xenomai 3.0 git to see if any commit since
the release fix the issue you have.

--=20
					    Gilles.
https://click-hack.org

