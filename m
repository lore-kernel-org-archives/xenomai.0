Subject: Re: Testing of 4.4/Ipipe + Xenomai 3.0.X on ARM32
References: <20181123122716.tgg3utytwyrkzyid@jholzmayr.localdomain>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <d1808069-d213-7e9f-010f-abd2c88b0480@siemens.com>
Date: Fri, 23 Nov 2018 13:48:27 +0100
MIME-Version: 1.0
In-Reply-To: <20181123122716.tgg3utytwyrkzyid@jholzmayr.localdomain>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Josef Holzmayr <holzmayr@rsi-elektrotechnik.de>, xenomai@xenomai.org

Hi Sepp,

On 23.11.18 13:27, Josef Holzmayr via Xenomai wrote:
> Hello!
> 
> To improve the testing situation for the 4.4 Kernel family on ARM32, I
> created a set of layers [1] for OpenEmbedded. Currently the features are
> rather limited:
> 
> - only the Morty branch exists, as this one natively includes Linux 4.4
>    and therefore the GCC version etc. matches.

To my best knowledge, there is no dependency (yet) between a too new compiler 
and kernel 4.4. We are building 4.4-cip with pyro, e.g.

> - only one BSP layer so far, namely the Beaglebone. This was chosen for
>    two major reasons: a) it is supported well enough in 4.4. to not need
>    additional patches which might introduce new issues, and b) it is
>    hardware that I have here ready for testing.

I was thinking about which ARMv7 board to add to xenomai-images (enabling qemu 
will be first, though), and that is a good candidate there as well.

Another half-done topic here: CI builds. For that, the BB defconfig could be 
useful too.

> - no higher automation like a kas cofiguration so far. Yet this probably
>    will be the first limitation to be gotten rid of.
> 
> My current planning is to add a set of testing scripts based of
> Philippe's suggestion, and run that suite on each new release for a
> couple of days and post the results to the ML.

That sounds very helpful! We should try to keep common parts (anything unrelated 
to the image build system) in the core so that we can reuse that in 
xenomai-images as well.

> 
> Preliminary results to kick off things:
> - xeno-test completes successfully
> - latency -t0 under load maxes at ~58µs
> - latency -t2 under load maxes at ~18µs
> 

Great! According to [1], we could then tag 63637800 also for ARM? Or do you want 
to run more of the tests you have in mind first?

Jan

> Greetz
> 
> [1] https://github.com/LetoThe2nd/meta-xenomai
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

