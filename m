From: Umair Ali <ali.umair@tut.fi>
Date: Fri, 6 May 2016 15:25:36 +0000
Message-ID: <2396B4D2166B62479FBBE370D4A7C1F30A733234@mb2010-3.intra.tut.fi>
References: <2396B4D2166B62479FBBE370D4A7C1F30A733197@mb2010-3.intra.tut.fi>
 <20160504210030.GK1761@hermes.click-hack.org>
 <2396B4D2166B62479FBBE370D4A7C1F30A733219@mb2010-3.intra.tut.fi>
 <20160506151720.GH3264@csclub.uwaterloo.ca>
In-Reply-To: <20160506151720.GH3264@csclub.uwaterloo.ca>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] mmap a file in rtdm moudle without switching the mode
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Thanks Len Sorensen

> Well my understanding is that you do NOT ever read files from kernel spac=
e.  You let user space do that and pass the data.

>This doesn't mean it can't be done, just that the kernel maintainers seem =
quite insistent that you don't do file access from kernel space.

What I am doing is as follows
- Open the file and mapped the file using mmap() in the user space in real =
time.
-  a kernel module is running in the back ground with timer initialized
-  run the application in user space and pass the mmap pointer along with t=
he size of file to the kernel module by using the read() function to read t=
he device.
- In the read_rt thread of module the pointer of the mapped file is assigne=
d to the global  char pointer and timer is started.
- The timed function is using the global char pointer to access file but fa=
ils when the read_rt ends
- Meanwhile the user space app is also ended after passing the pointer and =
file size.

Is there any way I can copy the data of mmap from userspace to a buffer in =
kernel or any virtual address so I can use the data over and over even thou=
gh the user app is ended. Because timer is running in the back end and need=
 to read the file again and again.

Thanks & BR

-----Original Message-----
From: Lennart Sorensen [mailto:lsorense@csclub.uwaterloo.ca]=20
Sent: May-06-16 6:17 PM
To: Umair Ali
Cc: Gilles Chanteperdrix; xenomai@xenomai.org
Subject: Re: [Xenomai] mmap a file in rtdm moudle without switching the mod=
e

On Fri, May 06, 2016 at 03:04:03PM +0000, Umair Ali wrote:
> Hello gilles,
>=20
> Thanks for the patience and the reply. I am sorry for asking such questio=
ns. I am newbie so need some guidance. I have searched for linux device dri=
vers on the internet and I found the book (https://lwn.net/Kernel/LDD3/) . =
Can you recommend me which chapter will be very helpful for me. I want to r=
ead a big file of size 600MB in kernel space and need to read it periodical=
ly by timers. I think the answers lies in the using functions rtdm_malloc, =
rtdm_safe_copy_from _user. I know the good way to is open the file in the u=
serspace and send the address to kernel space. Any example will help me a l=
ot.=20

Well my understanding is that you do NOT ever read files from kernel space.=
  You let user space do that and pass the data.

This doesn't mean it can't be done, just that the kernel maintainers seem q=
uite insistent that you don't do file access from kernel space.

Certainly doing file access sounds like something you would not want to try=
 and do from the realtime side of things.  You probably can't.

--
Len Sorensen

