MIME-Version: 1.0
Date: Fri, 4 Sep 2015 00:30:56 +1200
Message-ID: <CAFkYNwbN0kkAQLWtfvV8tpnCRbVnsiGSDcjXAonJ0uHa22mUgA@mail.gmail.com>
From: vibnwis <vibnwis@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] installing Xenomai for PandaBoard ES
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

HI there,
I am trying to install Xenomai onto kernel for Pandaboard ES. I am
following the steps published by Andreas,
http://www.xenomai.org/pipermail/xenomai/2014-April/030696.html

1) Setup and patch kernel
 > BASEDIR=`pwd`
 > git clone git://github.com/RobertCNelson/armv7-multiplatform.git
 > cd ${BASEDIR}/armv7-multiplatform/
 > git checkout origin/v3.14.x -b v3.14
 > ./build_deb.sh # checks out the 3.14 kernel source and adds some
patches

However, at step ./build_deb.sh I encountered the following errors.
Would someone help to point out what went wrong, please?

------------------------------------

+ Detected build host [Ubuntu 15.04]
+ host: [x86_64]
+ git HEAD commit: [06adda0add71287381a1473fa8af6a62d6bdbe8d]
Dependency check skipped, you are on your own.
-----------------------------
Unrecognized deb based system:
-----------------------------
Please cut, paste and email to: bugs@rcn-ee.com
-----------------------------
git: 06adda0add71287381a1473fa8af6a62d6bdbe8d
uname -m
x86_64
lsb_release -a
No LSB modules are available.
Distributor ID:	Ubuntu
Description:	Ubuntu 15.04
Release:	15.04
Codename:	vivid
-----------------------------
* Failed dependency check

----------------------------------------
