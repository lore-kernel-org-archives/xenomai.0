Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
From: Jan Jaap Kempenaar <janjaapkempenaar@gmail.com>
In-Reply-To: <53C7A6FA.5000603@xenomai.org>
Date: Thu, 17 Jul 2014 13:19:22 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <64BD7359-2A19-416C-8877-DEE2EB988EE6@gmail.com>
References: <FEB36BE3-3DA6-4594-9064-213B66B059ED@gmail.com>
 <53C65420.6040608@xenomai.org>
 <0106E84F-4693-4A95-8219-298D9E932C17@gmail.com>
 <53C7A6FA.5000603@xenomai.org>
Subject: Re: [Xenomai] modprobe cannot find RTDM kernel module during boot
	sequence
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

> On 07/17/2014 09:48 AM, Jan Jaap Kempenaar wrote:
>> Hello,
>>=20
>> Thank you for your reply.
>>=20
>>>=20
>>> You should not use kernel 3.2.21, the I-piep patch is known to
>>> contain a bug. Please update to a more recent patch.
>>>=20
>>=20
>> We are trying newer kernel versions, however have not been able yet
>> to create one that runs the xeno-test stable.
>=20
> What happens exactly?
>=20

The initial goal was to have a configuration with linux 3.8.13, and =
emdebian wheezy and to compile for armhf.
Reason we chose for 3.8.13, is that it is the latest provided patch.
Reason we want armhf is that on other setups we are running a linux =
3.6.x configuration with wheezy armhf(without xenomai).

Several issues occur here.
We use this guide as a reference for building the kernel and obtaining =
the file system:
=
http://wiki.gumstix.org/index.php?title=3DInstalling_Debian_and_Xenomai_on=
_gumstix_Overo
We automated most of the steps with scripts.
Several problems we have:

=3D=3D Wheezy Xenomai userspace compilation:

** The problem with Wheezy, both armhf and armel architectures is that =
we cannot build the debian packages as is suggested in the installation =
guide.
When running the script with chroot to create the debian packages, the =
script fails. Based on the output of the script it goes wrong when it =
tries to write the udev rules, however I think that this might not be =
the problem(it complains that it cannot stat the xenomai.rules file as =
it does not exist).

For this particular issue I am working on a reproduce script which I =
will post to the mailing list. With that in mind, is there any =
additional information that would be useful to include with this?

** Apart from trying to create debian packages with chroot, we also =
tried cross compiling which worked, however with this userspace, running =
xeno-test results in segmentation faults. I do not have traces or logs =
of this to post, we simply tried this because the creation of debian =
packages failed.

** Another thing we tried is to compile the userspace libraries on =
target. This also fails with the configure script, not being able to =
create a Makefile.

=3D=3D Currently
Because we did not have a success with the armhf or the emdebian Wheezy =
distribution, we are now working to create a version with linux 3.8.13 =
and emdebian squeeze (we have a working configuration with 3.2.21, =
xenomai 2.6.3 and the squeeze distribution).
For this I have no results yet as we are working on this.

>>> Some versions of modprobe try to insmod the module directly first,
>>> and if that fails take the dependencies into account. If the module
>>> appears in lsmod, I believe you can safely ignore this warning.
>>=20
>> After boot(and login as root), when performing the lsmod, the module
>> is also not loaded. However when we perform the "modprobe rt_module"
>> then, the module gets loaded properly.
>=20
> You should try and add "set -x" to the script which loads the modules =
in
> /etc/modules, to have a better understanding of what happens.

Thank you for this suggestion.
Using this it turned out that the issue was a typo in the module name in =
/etc/modules.


Regards,
Jan Jaap=

