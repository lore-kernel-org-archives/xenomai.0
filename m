Message-ID: <4FFED232.60506@xenomai.org>
Date: Thu, 12 Jul 2012 15:33:38 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1342097120.22964.YahooMailNeo@web120604.mail.ne1.yahoo.com>
In-Reply-To: <1342097120.22964.YahooMailNeo@web120604.mail.ne1.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai 2.6.0 installation Error
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jignesh Patel <jigneshj.patel@yahoo.com>
Cc: "rgupta108@gmail.com" <rgupta108@gmail.com>, "patelilesh32@gmail.com" <patelilesh32@gmail.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 07/12/2012 02:45 PM, Jignesh Patel wrote:
> 
> Hi,
> 
> I am trying to  installed Xenomai 2.6.0 into my desktop with my existing Linux Ubuntu(10.04 LTS) kernel 2.6.32-generic,for development of real time data network.
> 
> Below Error occurs during installing of Xenomai 2.6.0:
> 
> root@new-desktop:~/xenomai-2.6.0# ./scripts/prepare-kernel.sh --linux=/home/new/ilesh/kernel_2_6_32/linux-2.6.32 --verbose
(...)
> prepare-kernel.sh: Unable to patch kernel 2.6.32 with adeos-ipipe-2.6.37.6-x86-2.9-02.patch.

Everything is in the error message: the
adeos-ipipe-2.6.37.6-x86-2.9-02.patch does not apply to the 2.6.32
kernel, even to vanilla 2.6.32 kernel. For further details, see:

ksrc/arch/x86/patches/README

in xenomai sources.

Also note that xenomai 2.6.1 is out.

-- 
					    Gilles.

