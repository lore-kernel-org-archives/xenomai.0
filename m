From: "Franz Engel" <franz_lambert_engel@yahoo.de>
Date: Wed, 7 May 2014 20:37:10 +0200
Message-ID: <005801cf6a23$5c0b0760$14211620$@de>
MIME-Version: 1.0
Content-Language: de
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Installation best practice with Ubuntu 14.01 (kernel 3.13)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

 

I want to build a new computer system with an up-to-date configuration. So I
would like to ask you if my way is a good one or should I wait for newer
versions of xenomai and i-pipe. The new Ubuntu uses the Kernel 3.13. The
newest i-pipe patch from the last stable version of Xenomai supports the
kernel version 3.8. So I would install my system with the following steps:

-          Installation of Ubuntu 14.01

-          Download Vanilla-Kernel 3.8.13

-          Prepare the kernel with ipipe-core-3.8.13-x86-4.patch (or a newer
3.8.x Version from the ipipe repo) and Xenomai for x86 architecture

-          Configuration of the kernel

-          Compile Xenomai 2.6.3

-          Compile and install the new kernel

Is this o.k. or is it better to wait for an ipipe patch 3.13 or higher
(because of the last version of the Ubuntu kernel)?

 

Regards,

     Franz

