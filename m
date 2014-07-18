Message-ID: <53C9627E.4010102@zultron.com>
Date: Fri, 18 Jul 2014 13:07:58 -0500
From: John Morris <john@zultron.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Debian packages for testing:  Xenomai 2.6.3, Linux 3.8.13,
 x86 and Beaglebone
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I've built new Xenomai kernel packages for the Machinekit project.  As 
the subject says, they're based on Xenomai 2.6.3 and Linux 3.8.13 and 
run on the x86 architectures (mostly vanilla with the Debian config) and 
Beaglebone (Robert C Nelson's patches and config).

They are based on the upstream Debian packaging, completely different 
from my previous packages, which were based on the awful make-kpkg 
stuff.  These promise to be much more maintainable.

RTAI kernels are also included in the new packaging.

To install:

# configure the Debian archive
sudo sh -c \
     "sudo apt-key adv --keyserver hkp://keys.gnupg.net \
         --recv-key 73571BB9; \
     echo 'deb http://deb.dovetail-automata.com wheezy main' > \
         /etc/apt/sources.list.d/machinekit.list"

# update the apt database
sudo apt-get update

# install the Xenomai kernel and headers; pick the command
# applicable to your situation
#
# amd64 architecture:
apt-get install \
     linux-image-xenomai.x86-amd64 \
     linux-headers-xenomai.x86-amd64
# i386 architecture:
apt-get install \
     linux-image-xenomai.x86-i686-pae \
     linux-headers-xenomai.x86-i686-pae
# Beaglebone:
apt-get install \
     linux-image-xenomai.beaglebone-omap \
     linux-headers-xenomai.beaglebone-omap

If you have an r8168 NIC in your PC, see 
/etc/modprobe.d/r816x_blacklist.conf to enable that driver and disable 
the r8169.

The packaging lives on GitHub:

     https://github.com/zultron/kernel-rt-deb

These kernels have been running well in the Machinekit Buildbot for some 
time now, and have seen a little testing in the Machinekit community. 
The archive signatures and a few other details are new, so please be 
patient and report any hiccups.  Feedback is greatly appreciated, 
positive or negative!

	John

