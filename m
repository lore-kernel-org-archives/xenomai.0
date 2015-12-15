From: Umair Ali <ali.umair@tut.fi>
Date: Tue, 15 Dec 2015 16:03:58 +0000
Message-ID: <2396B4D2166B62479FBBE370D4A7C1F30A716185@mb2010-1.intra.tut.fi>
References: <2396B4D2166B62479FBBE370D4A7C1F30A716140@mb2010-1.intra.tut.fi>,
 <20151215135934.GA30622@hermes.click-hack.org>
In-Reply-To: <20151215135934.GA30622@hermes.click-hack.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Switching to secondary mode despite of use of mmap
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Thanks Gilles for the reply.=0A=
=0A=
>  The slackspot trace you show only contains calls to timerfd_create=0A=
and socket. Yes, timerfd_create and socket cause a switch to=0A=
secondary mode.=0A=
=0A=
The slackspot output file shows that socket and timerfd_create is called ag=
ain and again. But i have used these two once and then in the "while loop" =
timer is read and packet is send. Does it mean that timerfd_create and sock=
et is calling every time once the one loop finish and start other loop unti=
l while loop condition is satisfied. Is there any way i can avoid the trans=
ition to secondary mode without using timerfd_create and socket. Can i use =
cobalt kernel timers service direclty in user space. Please guide me thanks=
.=0A=
=0A=
BR =0A=
Ali=0A=
________________________________________=0A=
From: Gilles Chanteperdrix [gilles.chanteperdrix@xenomai.org]=0A=
Sent: Tuesday, December 15, 2015 3:59 PM=0A=
To: Umair Ali=0A=
Cc: xenomai@xenomai.org=0A=
Subject: Re: [Xenomai] Switching to secondary mode despite of use of mmap=
=0A=
=0A=
On Tue, Dec 15, 2015 at 11:28:02AM +0000, Umair Ali wrote:=0A=
> Hello,=0A=
>=0A=
> I am reading a file of size 600 MB using the mmap function and=0A=
> mlockall(). My question is that is it possible that mmap has not=0A=
> loaded whole file in the memory and if the whole file is not=0A=
> loaded then is it changing to secondary mode while reading the=0A=
> file.=0A=
=0A=
Unless you have not passed MCL_CURRENT | MCL_FUTURE to mlockall or=0A=
did not check mlockall return value and mlockall in fact failed, this=0A=
is impossible.=0A=
=0A=
>The size of system heap is 256KB in the menuconfig for the=0A=
> compiling kernel.=0A=
=0A=
The size of the system heap has nothing to do with mlockall.=0A=
=0A=
> If the problem, i think, i have is true then how=0A=
> i can load the such big files using mmap. The output of slackspot=0A=
> is attached with this email. My system specs are Memory 3.1GiB and=0A=
> processor is intel P4 3.2GHz x 2.=0A=
=0A=
The slackspot trace you show only contains calls to timerfd_create=0A=
and socket. Yes, timerfd_create and socket cause a switch to=0A=
secondary mode.=0A=
=0A=
--=0A=
                                            Gilles.=0A=
https://click-hack.org=0A=

