From: Stephan Kappertz <stephan.kappertz@kabelmail.de>
Mime-Version: 1.0 (Apple Message framework v1283)
Date: Thu, 31 Jan 2013 15:17:41 +0100
In-Reply-To: <mailman.0.1359630001.19052.xenomai@xenomai.org>
References: <mailman.0.1359630001.19052.xenomai@xenomai.org>
Message-Id: <9EFD9D88-FCCB-489A-9DA9-06A8C8AFE8EA@kabelmail.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Ipipe pre and post patch for AM335x beagleBone/
	koenkooi branch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org


>> Hi All,
>> 
>> sorry for the long delay. As Gilles suggested I have prepared a pre and post patch for ipipe-core-3.2.21-arm-4 and the git repository supporting BeagleBone here: https://github.com/koenkooi/linux/tree/linux-ti33x-psp-3.2.21-r13g%2Bgitr720e07b4c1f687b61b147b31c698cb6816d72f01 . Should I send the patches to the list?
>> 
>> - Stephan
> 
> I think that you should.
> 
> Goran
> 

Here they are.
Usage:

* clone git repository https://github.com/koenkooi/linux/tree/linux-ti33x-psp-3.2.21-r13g%2Bgitr720e07b4c1f687b61b147b31c698cb6816d72f01

* checkout linux-ti33x-psp-3.2.21-r13g

* apply pre.patch

* run xenomai (tested with 2.6.2.1) prepare-kernel.sh

* apply post.patch

* Configure & compile kernel

- Stephan

-------------- next part --------------
A non-text attachment was scrubbed...
Name: beagleBone_pre_post_patches.tar.bz2
Type: application/x-bzip2
Size: 5820 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130131/e6446062/attachment.bin>
-------------- next part --------------




