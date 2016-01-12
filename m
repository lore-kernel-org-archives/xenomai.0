From: "Heinick, J Michael" <Michael.Heinick@Honeywell.com>
Date: Tue, 12 Jan 2016 15:43:42 +0000
Message-ID: <D9EDB4F689BF9F4EA6F2158A073942732E7C9FEA@de08ex3008.global.ds.honeywell.com>
References: <D9EDB4F689BF9F4EA6F2158A073942732E7C9E64@de08ex3008.global.ds.honeywell.com>
 <5693C218.5070701@xenomai.org>
In-Reply-To: <5693C218.5070701@xenomai.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Test program not accessing RTDM driver
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>



-----Original Message-----
From: Philippe Gerum [mailto:rpm@xenomai.org]=20
Sent: Monday, January 11, 2016 9:54 AM
To: Heinick, J Michael; xenomai@xenomai.org
Subject: Re: [Xenomai] Test program not accessing RTDM driver

On 01/11/2016 03:33 PM, Heinick, J Michael wrote:
>
> .........1.........2.........3.........4.........5.........6.........7
> ....|
>
> Currently, I have a RTDM driver that installs with insmod, creates the=20
> node in /dev/rtdm, uninstalls with rmmod, and removes the node from=20
> /dev/rtdm.  At this early stage this RTDM driver is only a skeleton=20
> that should log a message with rtdm_printk whenever the open, close,=20
> read, write, and ioctl handlers are called. So far I have been unable=20
> to get any indication that any of the handlers I have written for the=20
> driver are interacting with the small test program even though the=20
> program appears to run without errors.
>
> The ioctl call in the test program generates the following message in=20
> the dmesg file:
>
> [12503.672657] [Xenomai] tcgrtdmtest[3595] called regular ioctl() on=20
> /dev/rtdm/tcgrtdm
>
> The example at=20
> http://git.xenomai.org/xenomai-jro.git/tree/demo/posix/cobalt/gpiopwm.
> c?h=3D410c recently suggested by Jorge Ramirez Ortiz has been somewhat=20
> helpful, but I still do not know what I am missing.  Are my=20
> rtdm_device and rtdm_driver structures correct enough to get the=20
> handlers called, or is the problem elsewhere?
>
> Thanks for any help that you can provide.
> Mike H.

The issue is with the link stage of your user-space program: the posix I/O =
calls used in your code such as open/ioctl and friends should be provided b=
y libcobalt.so, but they are not. When the substitution takes place, RTDM h=
andles the calls, otherwise the calls are routed via the glibc/uclibc to th=
e regular kernel, which ends up reaching a dummy placeholder driver, which =
eventually issues the warning message in the kernel log (foo[pid] called re=
gular <func> on /dev/rtdm/device).

The substitution happens when the proper application build flags are used, =
based on the linker's --wrap switch. So the fix is likely to be applied to =
your application Makefile. Even if slightly outdated wrt Xenomai 3.x, the d=
oc below gives some hints (you should assume libcobalt.so when reading libp=
thread_rt.so):

http://xenomai.org/2014/08/porting-a-linux-application-to-xenomai-dual-kern=
el/#Compilation_for_the_Xenomai_POSIX_skin

--
Philippe.

---------------------------------------------------------------------------=
------------------

Thank you, Philippe.

The makefile now looks like this:

XENO_CONFIG :=3D /usr/xenomai/bin/xeno-config
CFLAGS :=3D $(shell $(XENO_CONFIG) --posix --cflags)
LDLAGS :=3D $(shell $(XENO_CONFIG) --posix --ldflags)
CC :=3D $(shell $(XENO_CONFIG) --cc)

default:
	$(CC) -c -o tcgrtdmtest.o tcgrtdmtest.C $(CFLAGS) $(LDFLAGS)
	/usr/xenomai/bin/wrap-link.sh -v $(CC) -o tcgrtdmtest tcgrtdmtest.o -Wl,@/=
usr/xenomai/lib/cobalt.wrappers -L/usr/xenomai/lib -lcobalt -lpthread -lrt

Then I found out that I had to set LD_LIBRARY_PATH=3D/usr/xenomai/lib.=20
Now when the test program runs I no longer get the message in the
dmesg file that the regular ioctl is being called.

But now the open statement is generating an "Operation not permitted"=20
message in its ouput, and still not logging any messages in the
dmesg file.  It does this even when I run as superuser.

So, referring to the link:
  http://xenomai.org/2014/06/running-a-xenomai-application-as-a-regular-use=
r/
I ran id to get my gid which turned out to be 1000, and then, as superuser,
entered  echo 1000 > sys/module/xenomai/parameters/allowed_group
There is no /dev/rtpipe.  I still get the same "Operation not permitted"
message, even as superuser.  What else should I check and do?

Again, your help is greatly appreciated,
Mike H.

