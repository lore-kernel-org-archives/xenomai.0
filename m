From: Umair Ali <ali.umair@tut.fi>
Date: Mon, 21 Dec 2015 12:06:10 +0000
Message-ID: <2396B4D2166B62479FBBE370D4A7C1F30A7163B0@mb2010-1.intra.tut.fi>
References: <2396B4D2166B62479FBBE370D4A7C1F30A716241@mb2010-1.intra.tut.fi>,
 <20151220150333.GA25662@hermes.click-hack.org>
In-Reply-To: <20151220150333.GA25662@hermes.click-hack.org>
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

Hello Gilles, Thanks for the reply.=0A=
=0A=
> I am using the timerfd to produce the required sleep function for=0A=
> sending the raw ethernet packets using rtnet driver periodically.=0A=
> I read the file using the mmap() function and=0A=
> mlockall(MCL_CURRENT|MCL_FUTURE). My code is attached with this=0A=
> email. Gilles have already explained me with the jitter problem=0A=
> with timerfd but it is acceptable so far with me. Now the problem=0A=
> is that the code runs ok for more or less 30 secs. For this period=0A=
> of running of code the jitter is acceptable. But after some time=0A=
> the jitter increases very much and causes problem. I thought that=0A=
> this may be because the timerfd has lost the synchronization with=0A=
> application.=0A=
=0A=
>The "read" call on a timerfd reads the number of timer ticks since the las=
t read, so you can know whether an overrun occurred by checking the variabl=
e named "exp" in your program.=0A=
=0A=
I have printed the value of variable 'exp' which is 1 every time. I believe=
 that there is no overrun..=0A=
=0A=
> Or timerfd is not working fine. I tried to use the=0A=
> poll() and epoll() also but the problem persist. Can you guide me=0A=
=0A=
> poll() is not a wrapped call, so causes a switch to secondary mode.Did no=
t you see that with slackspot? Xenomai only wraps the "select"call.=0A=
=0A=
>Yeah it is my mistake that i used poll() or epoll() and you are right that=
 it will change to secondary mode. I will try >to use the select() function=
. But what do you think that it can avoid the problem.=0A=
=0A=
>Also note that by using the AF_INET family, you are no longer=0A=
>sending raw packets but UDP packets.=0A=
=0A=
>And finally I do not know what your ugly memcpy with hardcoded=0A=
>lengths do exactly, but the check (j < size) looks insufficient,=0A=
>as the memcpys are accessing data beyond j. If you receive a signal doing=
=0A=
>this, this would certainly cause a switch to secondary mode.=0A=
=0A=
Basically what i am doing is that i have pcap file of the IEC 61850 Sampled=
 values (SV). I want to playback the pcap file in the network  as real time=
 with deterministic behaviour. There is UDP module for the Rtnet. As in the=
 packet of Sampled value the data is 64bytes in the tail of the frame of th=
e SV and length of SV frames are constant. Therefore I am taking the data d=
irectly from the SV frame by using memcpy() and hard length memory access. =
Trying to encapsulate in the UDP packet to send it over the network. As the=
 data of SV is sampled values of the voltages and currents of the phases of=
 power systems which are sampled at the 80 sample per cycle and frequency i=
s 50 Hz. Therefore i need to send the data at 0.250msec or 250=B5sec. =0A=
=0A=
I have change the type of variable 'j' into unsigned long long int but stil=
l the problem presist. =0A=
=0A=
Can you guide me how i can use the UDP module of Rtnet to send UDP packets.=
=0A=
__________=0A=
______________________________=0A=
From: Gilles Chanteperdrix [gilles.chanteperdrix@xenomai.org]=0A=
Sent: Sunday, December 20, 2015 5:03 PM=0A=
To: Umair Ali=0A=
Cc: Xenomai list =FD[xenomai@xenomai.org]=FD=0A=
Subject: Re: [Xenomai] Possible sync problem with timerfd and application=
=0A=
=0A=
On Thu, Dec 17, 2015 at 02:07:20PM +0000, Umair Ali wrote:=0A=
> Hello there,=0A=
>=0A=
> I am using the timerfd to produce the required sleep function for=0A=
> sending the raw ethernet packets using rtnet driver periodically.=0A=
> I read the file using the mmap() function and=0A=
> mlockall(MCL_CURRENT|MCL_FUTURE). My code is attached with this=0A=
> email. Gilles have already explained me with the jitter problem=0A=
> with timerfd but it is acceptable so far with me. Now the problem=0A=
> is that the code runs ok for more or less 30 secs. For this period=0A=
> of running of code the jitter is acceptable. But after some time=0A=
> the jitter increases very much and causes problem. I thought that=0A=
> this may be because the timerfd has lost the synchronization with=0A=
> application.=0A=
=0A=
The "read" call on a timerfd reads the number of timer ticks since=0A=
the last read, so you can know whether an overrun occurred by=0A=
checking the variable named "exp" in your program.=0A=
=0A=
> Or timerfd is not working fine. I tried to use the=0A=
> poll() and epoll() also but the problem persist. Can you guide me=0A=
=0A=
poll() is not a wrapped call, so causes a switch to secondary mode.=0A=
Did not you see that with slackspot? Xenomai only wraps the "select"=0A=
call.=0A=
=0A=
Also note that by using the AF_INET family, you are no longer=0A=
sending raw packets but UDP packets.=0A=
=0A=
And finally I do not know what your ugly memcpy with hardcoded=0A=
lengths do exactly, but the check (j < size) looks insufficient,=0A=
as the memcpys are accessing data beyond j. If you receive a signal doing=
=0A=
this, this would certainly cause a switch to secondary mode.=0A=
=0A=
=0A=
--=0A=
                                            Gilles.=0A=
https://click-hack.org=0A=

