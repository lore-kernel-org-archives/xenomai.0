Message-ID: <5139D7BC.9080709@xenomai.org>
Date: Fri, 08 Mar 2013 13:21:16 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAOE4DFXJUx0fk5B7rJGGXEVoae1BGTsZdd+igJAYFsT0kuD-cg@mail.gmail.com>
In-Reply-To: <CAOE4DFXJUx0fk5B7rJGGXEVoae1BGTsZdd+igJAYFsT0kuD-cg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xenomai patch for imx6
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Mohammadreza Babaee <mrezababaee@gmail.com>
Cc: xenomai@xenomai.org

On 03/08/2013 11:33 AM, Mohammadreza Babaee wrote:

> Hello Everyone,
> 
> I have a Freescale board with IMX6Q ac CPU. I want to apply proper Xenomai
> Patch on a proper kernel source. Do you know which kernel version and which
> Xenomai patch should I use.


Support for mx6q exists as a separate patch for Freescale branch based
on Linux 3.0, see ksrc/arch/arm/patches/README for details.

Or is mainline starting with the I-pipe patches for 3.2, 3.4 and 3.5.

3.2 being broken, 3.4 or 3.5 are recommended.

The version of Xenomai is irrelevant, except that if you want to use the
I-pipe patches for Linux 3.4 or 3.5, you have to use the latest xenomai
release. Using the latest xenomai release is recommended anyway.

-- 
                                                                Gilles.

