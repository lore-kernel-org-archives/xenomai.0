From: Alex Plits <alex_plits@radwin.com>
Date: Sun, 20 Mar 2016 07:49:16 +0000
Message-ID: <DB5PR06MB110995B3101666B866BB93C28F8E0@DB5PR06MB1109.eurprd06.prod.outlook.com>
References: <DB5PR06MB1109ECFBDA54A3B1A11457608F8E0@DB5PR06MB1109.eurprd06.prod.outlook.com>
 <20160320072520.GF3345@hermes.click-hack.org>
In-Reply-To: <20160320072520.GF3345@hermes.click-hack.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Suggested approach to schedule N-RT work in kernel on
 a specific CPU core
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>



> -----Original Message-----
> From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
> Sent: Sunday, March 20, 2016 9:25 AM
> To: Alex Plits
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai] Suggested approach to schedule N-RT work in kernel
> on a specific CPU core
>=20
> On Sun, Mar 20, 2016 at 07:15:42AM +0000, Alex Plits wrote:
> > Hi,
> >
> > We have a requirement to schedule N-RT linux kernel specific work
> > (e.g. workQ) on a dedicated core from an RTDM driver running In Xenomai
> "context".
> > The current RTDM API does in fact provide an API to schedule a N-RT
> > workQ but this does not meet our needs as we need the N-RT job to run
> > on A dedicated CPU. Current API implementation will run this special
> > workQ on the CPU where the RT scheduling call occurred, so I have 2
> > queries we need help with -
> >
> > 1.       Is there an API/example/configuration that will achieve our ne=
eds?
> >
> > 2.       In case there isn't what would be the best approach to impleme=
nt
> such a mechanism - I can think of solutions but it seems excessive:
> >
> > a.       Run another Xenomai thread that has CPU affinity on the target=
 cpu
> Core which will call a dedicated RTDM blocking call (e.g. IOCTL with semT=
ake)
> and then the scheduling RTDM driver will release that semaphore - which w=
ill
> re-schedule the thread on the core we need and now it can call a N-RT IOC=
TL
> for example.
> >
> > b.      Initialize a new WorkQ on I-Pipe init which will be binded on t=
he target
> cpu Core only then add new RTDM api to schedule work on that WorkQ -
> although I'm not sure this will work as it will use the VIRQ  mechanism w=
hich
> will somehow need to change cores.
>=20
> If the Linux kernel provides a function to do this, we could implement a
> function mirroring that function in the RTDM API. Looks simple. Am I miss=
ing
> something ?
>=20

[Alex Plits]=20
The Linux provides an option to configure the workQ on specific CPU's on it=
's initialization stage of the WorkQ. I'm unsure
Of how/whether it actually schedules it's execution when schedule_work is c=
alled from a different CPU core that it was configured up-on. I'm guessing =
that if it were trivial the same mechanism would also be used in the curren=
t API for N-RT or xenomai printk mechanism (both use dedicated workQs which=
 are different than Linux WorkQs awaken via VIRQs).


> --
> 					    Gilles.
> https://click-hack.org

