Message-ID: <4CFA058F.4000901@domain.hid>
Date: Sat, 04 Dec 2010 10:10:39 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTinAGmVQDLOho-9vniRgcsu3rFmRuX4Ft=p7uK=i@domain.hid>
In-Reply-To: <AANLkTinAGmVQDLOho-9vniRgcsu3rFmRuX4Ft=p7uK=i@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] How to Obtaining Pci Device Private Data ( base
 Address ) with RTDM
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: adilkaraoz <adilkaraoz@domain.hid>
Cc: xenomai@xenomai.org

adilkaraoz wrote:
> Hi,
> 
> I want to obtain private data of my PLX pci device but I don't understand
> anything what I do. Starting of my code below please help me.

The way you would do this with RTDM is the same you would do it with
Linux. RTDM does not define any API, it lets you use Linux API.

If your trouble is about writing a PCI driver with Linux, then you are
asking the wrong list, since you ask to a Xenomai mailing list, mainly
talking about Xenomai.

Though we can suggest you to read the chapter on PCI devices of the
"Linux device drivers" book. Available online here:
http://lwn.net/Kernel/LDD3/

Hopefully, when you have read that book, you will understand better what
you are doing

-- 
                                                                Gilles.

