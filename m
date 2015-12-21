Date: Mon, 21 Dec 2015 13:40:07 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151221124007.GA20764@hermes.click-hack.org>
References: <2396B4D2166B62479FBBE370D4A7C1F30A716241@mb2010-1.intra.tut.fi>
 <20151220150333.GA25662@hermes.click-hack.org>
 <2396B4D2166B62479FBBE370D4A7C1F30A7163B0@mb2010-1.intra.tut.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <2396B4D2166B62479FBBE370D4A7C1F30A7163B0@mb2010-1.intra.tut.fi>
Subject: Re: [Xenomai] Possible sync problem with timerfd and application
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Umair Ali <ali.umair@tut.fi>
Cc: Xenomai list =?utf-8?B?4oCOW3hlbm9tYWlAeGVub21haS5vcmdd4oCO?= <xenomai@xenomai.org>

On Mon, Dec 21, 2015 at 12:06:10PM +0000, Umair Ali wrote:
> Hello Gilles, Thanks for the reply.
>=20
> > I am using the timerfd to produce the required sleep function for
> > sending the raw ethernet packets using rtnet driver periodically.
> > I read the file using the mmap() function and
> > mlockall(MCL_CURRENT|MCL_FUTURE). My code is attached with this
> > email. Gilles have already explained me with the jitter problem
> > with timerfd but it is acceptable so far with me. Now the problem
> > is that the code runs ok for more or less 30 secs. For this period
> > of running of code the jitter is acceptable. But after some time
> > the jitter increases very much and causes problem. I thought that
> > this may be because the timerfd has lost the synchronization with
> > application.
>=20
> >The "read" call on a timerfd reads the number of timer ticks since the l=
ast read, so you can know whether an overrun occurred by checking the varia=
ble named "exp" in your program.
>=20
> I have printed the value of variable 'exp' which is 1 every time. I belie=
ve that there is no overrun..
>=20
> > Or timerfd is not working fine. I tried to use the
> > poll() and epoll() also but the problem persist. Can you guide me
>=20
> > poll() is not a wrapped call, so causes a switch to secondary mode.Did =
not you see that with slackspot? Xenomai only wraps the "select"call.
>=20
> >Yeah it is my mistake that i used poll() or epoll() and you are right th=
at it will change to secondary mode. I will try >to use the select() functi=
on. But what do you think that it can avoid the problem.
>=20
> >Also note that by using the AF_INET family, you are no longer
> >sending raw packets but UDP packets.
>=20
> >And finally I do not know what your ugly memcpy with hardcoded
> >lengths do exactly, but the check (j < size) looks insufficient,
> >as the memcpys are accessing data beyond j. If you receive a signal doing
> >this, this would certainly cause a switch to secondary mode.
>=20
> Basically what i am doing is that i have pcap file of the IEC
> 61850 Sampled values (SV). I want to playback the pcap file in the
> network as real time with deterministic behaviour. There is UDP
> module for the Rtnet. As in the packet of Sampled value the data
> is 64bytes in the tail of the frame of the SV and length of SV
> frames are constant. Therefore I am taking the data directly from
> the SV frame by using memcpy() and hard length memory access.
> Trying to encapsulate in the UDP packet to send it over the
> network. As the data of SV is sampled values of the voltages and
> currents of the phases of power systems which are sampled at the
> 80 sample per cycle and frequency is 50 Hz. Therefore i need to
> send the data at 0.250msec or 250=B5sec.
>=20
> I have change the type of variable 'j' into unsigned long long int
> but still the problem presist.
>=20
> Can you guide me how i can use the UDP module of Rtnet to send UDP
> packets.

The problem is not the type of j. The problem is that if you test
j < size

and then use j + something

j + something may well be above size.

As far as I know, there is no problem with sending UDP packets over
RTnet, actually, I verified the round trip time of two machines
running RTnet over several hours, and it did not have any issue.
Neither has the timerfd system, as tested by the latency test.

I was just trying to signal you that you came on that list asking
for a way of sending raw packets, I replied you with an example
program doing exactly that, but now you have rewritten a program
using UDP packets (keeping some parts of the program I sent you
which are now useless, namely retrieving the MAC address of the
network card). You are not sending raw packets.

--=20
					    Gilles.
https://click-hack.org

