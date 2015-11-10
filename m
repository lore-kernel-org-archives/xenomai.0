From: "Buchner, Michael AVL/AT" <Michael.Buchner@avl.com>
Date: Tue, 10 Nov 2015 21:46:26 +0000
Message-ID: <6d95a62970594405956318008839e431@ATGRZSW1692.avl01.avlcorp.lan>
Content-Language: de-DE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Missing libraries, tests and modules (Xenomai 3.x)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello,



I am trying to compile xenomai 3.0.1 for Ubuntu 14.04.3 with kernel version 3.18.20. Therefore I am using the description from here:

https://xenomai.org/2014/06/building-debian-packages/ and adapted it, where necessary. I attached my description at the end of my post, so you can see what I have done so far.



All works fine for building the .deb-packages and installing them seems also to work. I can select the new kernel in the grub-menu and the system boots without any problems.



But when I will do some basic testing like described below there are two major problems I am facing to.

The first one is, that there is no module called xeno_klat.ko but there is only a xeno_rtdmtest.ko.

The second problem is, that there is no subfolder "xenomai" in "/usr/" so I am also not able to start the latency tests.

I also tried to copy the tests from a other machine with xenomai 2.6 but when I try to start them I get errors that the shared libraries are missing. (stupid idea I know)



What could be the problem, that the module and the tests are missing or what else do I have to do to get these?



Thanks a lot and best regards,

Michael







Steps for testing  the installation:

Load test driver

$ insmod /lib/modules/3.18.20-xenomai-3.0.1-3.0.1-ipipe/kernel/drivers/

                   xenomai/testing/xeno_klat.ko



Run tests

$ /usr/xenomai/bin/latency

$ /usr/xenomai/bin/klatency





Steps for building the .deb-packages:

Install all further needed programs



$ sudo apt-get install devscripts debhelper dh-kpatches findutils

                   kernel-package libncurses-dev fakeroot zlib1g-dev automake bc



Get Xenomai Kernel and build .deb-packages



$ wget -O - http://xenomai.org/downloads/xenomai/stable/latest/

                   xenomai-3.0.1.tar.bz2 | tar  -jxf - $ cd xenomai-3.0.1 $ DEBEMAIL="your@email" DEBFULLNAME="Your Name" debchange -v 3.0.1

                   Release 3.0.1

$ sudo debuild -uc -us

$ cd ..



Install the .deb-packages

$ sudo dpkg -i *.deb



Patch and configure Kernel

Get an appropriate Kernel-patch

$ wget https://xenomai.org/downloads/ipipe/v3.x/x86/

                   ipipe-core-3.18.20-x86-3.patch



Get Linux Kernel

$ wget https://www.kernel.org/pub/linux/kernel/v3.x/linux-3.18.20.tar.xz

$ tar -xf linux-3.18.20.tar.xz

$ sudo rm linux-3.18.20.tar.xz

$ cd linux-3.18.20



Patch Kernel

$ /path_to_xenomai_root/scripts/prepare-kernel.sh --arch=x86_64

                     --linux=. --ipipe=../ipipe-core-3.18.20-x86-3.patch



Configure Kernel

$ cd linux-kernel/

$ make menuconfig



Under

CPU Power Management --->

CPU Frequency scaling

disable  [ ] CPU Frequency scaling



Under

Xenomai/cobalt (NEW)  --->

Drivers --->

Testing drivers

enable everything.

Exit and save the new configuration.



Build Kernel

$ CLEAN_SOURCE=no fakeroot make-kpkg --initrd --append-to-version

                   -xenomai-3.0.1  --revision 1.0 kernel_image kernel_headers



Install Kernel

$ sudo dpkg -I linux-image*.deb



Testing the installation

Load test driver

$ ssh root@192.168.7.2<mailto:root@192.168.7.2>

$ insmod /lib/modules/*/kernel/drivers/xenomai/testing/xeno_klat.ko



Run tests

$ /usr/xenomai/bin/latency

$ /usr/xenomai/bin/klatency


DI Michael Buchner
Development Engineer
Consumption Measurement
Business Unit Measurement & Instrumentation

michael.buchner@avl.com<mailto:michael.buchner@avl.com>
T: +43 316 787 5747
AVL LIST GMBH
A-8020 Graz, Hans-List-Platz 1
www.avl.com<http://www.avl.com/>


[cid:image001.jpg@01D078F5.A2FF5EF0]<https://www.facebook.com/AVL.List?ref=ts&fref=ts>   [cid:image002.jpg@01D078F5.A2FF5EF0] <https://twitter.com/avl_list>    [cid:image003.jpg@01D078F5.A2FF5EF0] <https://www.xing.com/companies/avllistgmbh>    [cid:image004.jpg@01D078F5.A2FF5EF0] <https://www.linkedin.com/company/avl>    [cid:image005.jpg@01D078F5.A2FF5EF0] <https://www.youtube.com/user/AVLList>


____________________________________________________________________________
AVL List GmbH, Firmensitz: Graz, Firmenbuchnummer: FN 53507M, Landesgericht fuer ZRS Graz
-------------- next part --------------
A non-text attachment was scrubbed...
Name: image001.jpg
Type: image/jpeg
Size: 944 bytes
Desc: image001.jpg
URL: <http://xenomai.org/pipermail/xenomai/attachments/20151110/389cd60b/attachment.jpg>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: image002.jpg
Type: image/jpeg
Size: 914 bytes
Desc: image002.jpg
URL: <http://xenomai.org/pipermail/xenomai/attachments/20151110/389cd60b/attachment-0001.jpg>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: image003.jpg
Type: image/jpeg
Size: 829 bytes
Desc: image003.jpg
URL: <http://xenomai.org/pipermail/xenomai/attachments/20151110/389cd60b/attachment-0002.jpg>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: image004.jpg
Type: image/jpeg
Size: 961 bytes
Desc: image004.jpg
URL: <http://xenomai.org/pipermail/xenomai/attachments/20151110/389cd60b/attachment-0003.jpg>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: image005.jpg
Type: image/jpeg
Size: 970 bytes
Desc: image005.jpg
URL: <http://xenomai.org/pipermail/xenomai/attachments/20151110/389cd60b/attachment-0004.jpg>
