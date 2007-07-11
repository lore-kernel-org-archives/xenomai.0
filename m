From: Sebastian Smolorz <ssm@domain.hid>
Date: Wed, 11 Jul 2007 18:39:56 +0200
References: <46644E53.9000204@domain.hid>
In-Reply-To: <46644E53.9000204@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <E1I8fEK-0008TV-8m@domain.hid>
Subject: Re: [Adeos-main] New I-pipe patch for ARM needs testing.
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: adeos-main@gna.org

Hi Gilles,

Gilles Chanteperdrix wrote:
> in Xenomai repository (trunk and v2.3.x branch), you will find
> adeos-ipipe-2.6.20-arm-1.7-03.patch, the latest version of the I-pipe
> patch for ARM. In addition to merging support for two new boards (ixp4xx
> and at91sam926x), this patch adds a few important features:
> - the at91 patch now applies after the I-pipe patch with no reject ;
> - it is now possible for Xenomai to preempt Linux during the mm switch,
> which should improve Xenomai scheduling latency significantly;
> - Xenomai is now able to access directly I-pipe tsc emulation in
> user-space, providing a low overhead timing facility to user-space
> applications.
>
> Before including this patch in a new release, and because I could only
> test the patch on at91rm9200, we would like people to test the patch on
> their hardware and give us feedback about the stability and performance.
> In order to adequately stress-test Linux mm context switch, please use
> something along the lines of the attached test_switch.c.

Finally, I found the time to give adeos-ipipe-2.6.20-arm-1.7-03.patch a try on 
our S3C2440-based board. At first sight, everything runs stable. The latency 
test shows noticeable better results although I didn't run it long enough to 
give a final judgement.

I came across some issues for which I will prepare patches very soon.

--
Sebastian

