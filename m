MIME-Version: 1.0
From: Antoine Hoarau <hoarau.robotics@gmail.com>
Date: Wed, 25 Feb 2015 13:23:17 +0000
Message-ID: <CAB6vvj=qpKhxcW=88vo0Gr6CBAd=VH+ann3i=OHkZYnNNkXFpA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] rtnet issue with xenomai-3.git next branch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

>You are missing
>CONFIG_XENO_DRIVERS_NET_RTIPV4_ICMP in your kernel configuration.
>ping uses icmp packets, so, if you do not enable icmp, ping is not
>going to work.

Now it's working ! Thank you Gilles !

cd /usr/xenomai/sbin

sudo modprobe rtnet #Loaded at startup
sudo modprobe rt_e1000e #Loaded at startup because e1000e is blacklisted
sudo modprobe rtudp

sudo ./rtifconfig rteth0 up 192.168.100.101 netmask 255.255.255.0
sudo ./rtroute solicit 192.168.100.102 dev rteth0

sudo ./rtifconfig
sudo ./rtroute

# Wait a bit..
sudo ./rtping 192.168.100.102



Le mer. 25 f=C3=A9vr. 2015 =C3=A0 13:34, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> a =C3=A9crit :

On Wed, Feb 25, 2015 at 10:47:58AM +0000, Antoine Hoarau wrote:
> > Attached the strace for rtping.
>
> You are missing
> CONFIG_XENO_DRIVERS_NET_RTIPV4_ICMP in your kernel configuration.
> ping uses icmp packets, so, if you do not enable icmp, ping is not
> going to work.
>
> >
> > >You need to load rtcap.ko (after the interface) to have the capture
> > >interface.
> >
> > I get :
> > [  458.000857] RTcap: real-time capturing interface
> > [  458.000860] RTcap: rteth0 busy, skipping device!
> > [  458.000861] RTcap: no real-time devices found!
>
> Probably because you need to load rtcap before setting up the
> interface.
>
>
> --
>                                             Gilles.
>
