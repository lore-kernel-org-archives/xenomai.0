From: Umair Ali <ali.umair@tut.fi>
Date: Fri, 6 May 2016 15:04:03 +0000
Message-ID: <2396B4D2166B62479FBBE370D4A7C1F30A733219@mb2010-3.intra.tut.fi>
References: <2396B4D2166B62479FBBE370D4A7C1F30A733197@mb2010-3.intra.tut.fi>
 <20160504210030.GK1761@hermes.click-hack.org>
In-Reply-To: <20160504210030.GK1761@hermes.click-hack.org>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello gilles,

Thanks for the patience and the reply. I am sorry for asking such questions=
. I am newbie so need some guidance. I have searched for linux device drive=
rs on the internet and I found the book (https://lwn.net/Kernel/LDD3/) . Ca=
n you recommend me which chapter will be very helpful for me. I want to rea=
d a big file of size 600MB in kernel space and need to read it periodically=
 by timers. I think the answers lies in the using functions rtdm_malloc, rt=
dm_safe_copy_from _user. I know the good way to is open the file in the use=
rspace and send the address to kernel space. Any example will help me a lot=
.=20

Thanks & BR
Ali

-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]=20
Sent: May-05-16 12:01 AM
To: Umair Ali
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai] mmap a file in rtdm moudle without switching the mod=
e

On Wed, May 04, 2016 at 01:03:35PM +0000, Umair Ali wrote:
> Hello ,
>=20
> My aim is to open and read a file in the rtdm module. This file will=20
> be accessed or red  periodically using the kernel timers until the=20
> whole file is read completely. What I am doing is as follows
> - Open the file and mapped the file using mmap() in the user space in rea=
l time.
> -  a kernel module is running in the back ground with timer=20
> initialized
> -  run the application in user space and pass the mmap pointer along with=
 the size of file to the kernel module by using the read() function to read=
 the device.
> - In the read_rt thread of module the pointer of the mapped file is assig=
ned to the global  char pointer and timer is started.
> - The timed function is using the global char pointer to access file=20
> but fails when the read_rt ends
> - Meanwhile the user space app is also ended after passing the pointer an=
d file size.
>=20
> The above technique is not working because when the read_rt ends then the=
 kernel is stuck. I have read on the net that I should pass the pointer of =
mmaped file from userspace to the kernel space as mmap is ponting the file =
to kernel memory. It seems to me that memory is erased once the user space =
app or read_rt in module ends. Please guide me if I am on the right path or=
 what should I do so that I can read the file in the module and read period=
ically using kernel timer. Is there any rtdm functions which I have missed =
and can help me.=20

No, you are not on the right track. I do not understand the problems you ha=
ve, I believe I understand what you are trying to achieve, but I do not see=
 an easy angle to give you the lot of information you lack. I believe readi=
ng "linux device drivers" would be in order to have a little understanding =
of how a standard linux driver works and is implemented, then read the RTDM=
 API documentation to understand how to replace Linux kernel functions with=
 their RTDM equivalent.

--=20
					    Gilles.
https://click-hack.org

