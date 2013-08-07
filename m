Message-ID: <52028B6A.1040601@xenomai.org>
Date: Wed, 07 Aug 2013 20:01:14 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1124806E0C09F04A992E69AE2EC7FA3C80A6B1@swexchange01.itk.local>
In-Reply-To: <1124806E0C09F04A992E69AE2EC7FA3C80A6B1@swexchange01.itk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Problems with running Xenomai on Core i5
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Tobias Luksch <Tobias.Luksch@itk-engineering.de>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 08/07/2013 03:38 PM, Tobias Luksch wrote:
> Hello,
> 
> (Some key data to begin with: kernel v3.2.21, xenomai v2.6.2.1, 
> ipipe-core-3.2.21-x86-5.patch as within the 2.6.2.1 xenomai release, all on 
> Ubuntu 12.04 with gcc 4.6.3)
> 
> 
> currently I am trying to use Xenomai on an embedded PC with an Intel Core i5 
> CPU (M520 @ 2.40GHz). While debugging processing times of our application, I 
> encountered strange non-determinism, i.e. parts of the program doing only 
> computations (w/o any mutexes etc.) sometimes took more than twice the time to 
> compute than usual.
> 
> So I wrote a simple test program (attached) based on 
> examples/native/trivial-periodic creating a 1000Hz loop. In each cycle, a few 
> 1000 sine functions are computed, with measuring the time it takes to do so. I 
> would expect a rather constant computation time, but I see significant jitter 
> (average duration ~0.09ms, jitter up to +-40%). 
> 
> What's more, when I generate heavy CPU load on the linux side, the computation 
> time for the sine functions drops to about 0.06ms and shows no more significant 
> jitter at all. As soon as I stop producing CPU load, computation time and 
> jitter go up again.
> 
> Running the same test program on a laptop with an Intel Core2 Duo and same 
> kernel version, kernel settings, and xenomai version runs as expected: constant 
> computation time, very low jitter, no influence by adding load on the linux 
> side.
> 
> To me it looks like some power management feature of the CPU is kicking in. I 
> have disabled (hopefully) all relevant features in the BIOS (like EISS, 
> TurboBoost, Idle Modes, ...) and in the kernel (CPU frequency scaling, ..., 
> config file of me latest try is attached), /proc/cpuinfo always shows the same 
> frequency. Still I get the behavior described above.

The config file lacks CONFIG_ACPI, you should enable ACPI, only
CONFIG_ACPI_PROCESSOR should be disabled.

Other than that, you should not use 3.2.21, this version is known to
have issues with xenomai. Also, since you are using a Debian based
system, you may try to add:
deb http://www.xenomai.org/debian squeeze main

to /etc/apt/sources.list, then do

apt-get update
apt-get install xenomai-keyring
apt-get update
apt-get install linux-image-3.5.7-xenomai-2.6.2.1

-- 
                                                                Gilles.

