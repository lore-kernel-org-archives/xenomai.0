From: Umair Ali <ali.umair@tut.fi>
Date: Mon, 21 Dec 2015 14:29:07 +0000
Message-ID: <2396B4D2166B62479FBBE370D4A7C1F30A7163DD@mb2010-1.intra.tut.fi>
References: <2396B4D2166B62479FBBE370D4A7C1F30A716241@mb2010-1.intra.tut.fi>
 <20151220150333.GA25662@hermes.click-hack.org>
 <2396B4D2166B62479FBBE370D4A7C1F30A7163B0@mb2010-1.intra.tut.fi>,
 <20151221124007.GA20764@hermes.click-hack.org>
In-Reply-To: <20151221124007.GA20764@hermes.click-hack.org>
Content-Language: en-US
Content-Type: text/plain; charset="windows-1256"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Possible sync problem with timerfd and application
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: =?windows-1256?Q?Xenomai_list_=FD=5Bxenomai=40xenomai=2Eorg=5D=FD?= <xenomai@xenomai.org>

I am very sorry for disturbing you for many basic and stupid questions. Act=
ually i am new to linux and xenomai therefore i really appreciate you patie=
nce. Please forgive me.=0A=
=0A=
>The problem is not the type of j. The problem is that if you test=0A=
>j < size=0A=
>=0A=
>and then use j + something=0A=
>=0A=
>j + something may well be above size.=0A=
=0A=
I have printed the value of j in every turn of the while loop. I have found=
 that the j has a value always less than size. the maximum size is 60219844=
2 and the  last value of j is 602198334. Therefore i dont think the value o=
f j is higher or above the size at any time.=0A=
=0A=
>As far as I know, there is no problem with sending UDP packets over=0A=
>RTnet, actually, I verified the round trip time of two machines=0A=
>running RTnet over several hours, and it did not have any issue.=0A=
>Neither has the timerfd system, as tested by the latency test.=0A=
=0A=
>I was just trying to signal you that you came on that list asking=0A=
>for a way of sending raw packets, I replied you with an example=0A=
>program doing exactly that, but now you have rewritten a program=0A=
>using UDP packets (keeping some parts of the program I sent you=0A=
>which are now useless, namely retrieving the MAC address of the=0A=
>network card). You are not sending raw packets.=0A=
=0A=
Its true that i have just modified same code, as you send me for raw ethern=
et packets, for UDP packets. i have a UDP server running in embedded hardwa=
re named dSPACE. When i run the code i can see the UDP traffic and the serv=
er (in dSPACE) is able to receive the packets also. Therefore i was sure th=
at it is also the way to send UDP packets. Do you think this can still be t=
he problem. I have gone through the link (https://xenomai.org/rtnet-program=
ming/). This is for xenomai 2 but not for xenomai 3. Is there any similar l=
ink for programming Rtnet with xenomai 3.=0A=
=0A=
I am very confused what can be problem. Do you have idea how to trace back =
the problem. =0A=
=0A=
I think i should now work in the kernel space and take the advice of the ke=
rnel timers. Please guide me to use the RTnet module in kernel space app.=
=0A=
=0A=
Thanks & Br=0A=
Ali=0A=
=0A=
 =0A=
=0A=
=0A=
=0A=
________________________________________=0A=
From: Gilles Chanteperdrix [gilles.chanteperdrix@xenomai.org]=0A=
Sent: Monday, December 21, 2015 2:40 PM=0A=
To: Umair Ali=0A=
Cc: Xenomai list =FD[xenomai@xenomai.org]=FD=0A=
Subject: Re: [Xenomai] Possible sync problem with timerfd and application=
=0A=
=0A=
On Mon, Dec 21, 2015 at 12:06:10PM +0000, Umair Ali wrote:=0A=
> Hello Gilles, Thanks for the reply.=0A=
>=0A=
> > I am using the timerfd to produce the required sleep function for=0A=
> > sending the raw ethernet packets using rtnet driver periodically.=0A=
> > I read the file using the mmap() function and=0A=
> > mlockall(MCL_CURRENT|MCL_FUTURE). My code is attached with this=0A=
> > email. Gilles have already explained me with the jitter problem=0A=
> > with timerfd but it is acceptable so far with me. Now the problem=0A=
> > is that the code runs ok for more or less 30 secs. For this period=0A=
> > of running of code the jitter is acceptable. But after some time=0A=
> > the jitter increases very much and causes problem. I thought that=0A=
> > this may be because the timerfd has lost the synchronization with=0A=
> > application.=0A=
>=0A=
> >The "read" call on a timerfd reads the number of timer ticks since the l=
ast read, so you can know whether an overrun occurred by checking the varia=
ble named "exp" in your program.=0A=
>=0A=
> I have printed the value of variable 'exp' which is 1 every time. I belie=
ve that there is no overrun..=0A=
>=0A=
> > Or timerfd is not working fine. I tried to use the=0A=
> > poll() and epoll() also but the problem persist. Can you guide me=0A=
>=0A=
> > poll() is not a wrapped call, so causes a switch to secondary mode.Did =
not you see that with slackspot? Xenomai only wraps the "select"call.=0A=
>=0A=
> >Yeah it is my mistake that i used poll() or epoll() and you are right th=
at it will change to secondary mode. I will try >to use the select() functi=
on. But what do you think that it can avoid the problem.=0A=
>=0A=
> >Also note that by using the AF_INET family, you are no longer=0A=
> >sending raw packets but UDP packets.=0A=
>=0A=
> >And finally I do not know what your ugly memcpy with hardcoded=0A=
> >lengths do exactly, but the check (j < size) looks insufficient,=0A=
> >as the memcpys are accessing data beyond j. If you receive a signal doin=
g=0A=
> >this, this would certainly cause a switch to secondary mode.=0A=
>=0A=
> Basically what i am doing is that i have pcap file of the IEC=0A=
> 61850 Sampled values (SV). I want to playback the pcap file in the=0A=
> network as real time with deterministic behaviour. There is UDP=0A=
> module for the Rtnet. As in the packet of Sampled value the data=0A=
> is 64bytes in the tail of the frame of the SV and length of SV=0A=
> frames are constant. Therefore I am taking the data directly from=0A=
> the SV frame by using memcpy() and hard length memory access.=0A=
> Trying to encapsulate in the UDP packet to send it over the=0A=
> network. As the data of SV is sampled values of the voltages and=0A=
> currents of the phases of power systems which are sampled at the=0A=
> 80 sample per cycle and frequency is 50 Hz. Therefore i need to=0A=
> send the data at 0.250msec or 250=B5sec.=0A=
>=0A=
> I have change the type of variable 'j' into unsigned long long int=0A=
> but still the problem presist.=0A=
>=0A=
> Can you guide me how i can use the UDP module of Rtnet to send UDP=0A=
> packets.=0A=
=0A=
The problem is not the type of j. The problem is that if you test=0A=
j < size=0A=
=0A=
and then use j + something=0A=
=0A=
j + something may well be above size.=0A=
=0A=
As far as I know, there is no problem with sending UDP packets over=0A=
RTnet, actually, I verified the round trip time of two machines=0A=
running RTnet over several hours, and it did not have any issue.=0A=
Neither has the timerfd system, as tested by the latency test.=0A=
=0A=
I was just trying to signal you that you came on that list asking=0A=
for a way of sending raw packets, I replied you with an example=0A=
program doing exactly that, but now you have rewritten a program=0A=
using UDP packets (keeping some parts of the program I sent you=0A=
which are now useless, namely retrieving the MAC address of the=0A=
network card). You are not sending raw packets.=0A=
=0A=
--=0A=
                                            Gilles.=0A=
https://click-hack.org=0A=

