From: "Giataganas, Petros" <petros.giataganas11@imperial.ac.uk>
Date: Tue, 12 Feb 2013 19:20:59 +0000
Message-ID: <CC872764D2E12B469BE82C0BF22F24DF2716AB5A@icexch-m2.ic.ac.uk>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Xenomai linux kernel compile
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi all,

Thank you for your amazing work on xenomai and the documentation that suppo=
rts it.

I have to say that I am newbie but I have not found any solution on mr. Goo=
gle!

I am running ubuntu 12.04 and I want to run xenomai 2.6.2.1

My problem is presented when I am doing the full kernel compile based on th=
e guide :

http://www.stanley.gatech.edu/skelly/uncategorized/installing-xenomai-on-ub=
untu-12-04/

In particular, when I execute the command:  sudo dpkg -i linux-image-*.deb

it gives me the error:

--------------------------------
ERROR (dkms apport): kernel package linux-headers-3.5.7-xenomai-2.6.2.1 is =
not supported
Error! Bad return status for module build on kernel: 3.5.7-xenomai-2.6.2.1 =
(i686)
Consult /var/lib/dkms/nvidia-current/304.64/build/make.log for more informa=
tion.
ERROR (dkms apport): kernel package linux-headers-3.5.7-xenomai-2.6.2.1 is =
not supported
ERROR (dkms apport): kernel package linux-headers-3.5.7-xenomai-2.6.2.1 is =
not supported
ERROR (dkms apport): kernel package linux-headers-3.5.7-xenomai-2.6.2.1 is =
not supported
Error! Bad return status for module build on kernel: 3.5.7-xenomai-2.6.2.1 =
(i686)
Consult /var/lib/dkms/nvidia-current-updates/304.64/build/make.log for more=
 information.
Error! Bad return status for module build on kernel: 3.5.7-xenomai-2.6.2.1 =
(i686)
Consult /var/lib/dkms/nvidia-experimental-310/310.14/build/make.log for mor=
e information.
Error! Bad return status for module build on kernel: 3.5.7-xenomai-2.6.2.1 =
(i686)
Consult /var/lib/dkms/nvidia-experimental-304/304.48/build/make.log for mor=
e information.
--------------------------------------------

which is definitely due to my graphics card.

Is there any solution on that? Am I doing something wrong?

I have to say that the kernel is created and when I am booting there it wor=
ks but the resolution is really low and it does not allow me to install any=
 of the nvidia drivers. When I totally removed the nvidia drivers from the =
synaptic, I managed to have full resolution on my screen (running therefore=
 the default drivers and not the nvidia ones).

However, now I am not sure if the kernel is builded correctly and if I am w=
orking in the user space or in the kernel space when for example I am runni=
ng the code for  "./trivial-periodic"  (there I am having steady 1000 ms wi=
th small variations).

The final question is: have I installed correctly the xenomai real-time or =
I should do the process from the beginning? Should I consider something in =
the kernel config for the Nvidia drivers or not?

Sorry if I am asking a problem that you have already solved in another thre=
ad.

Thank you in advance!

Petros Giat.
