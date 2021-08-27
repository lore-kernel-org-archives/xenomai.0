Subject: Re: Doing DMA from peripheral to userland memory
References: <10a0-6128b080-11d-29fb8780@204571863>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <a047fceb-2cec-d660-28c5-420fc177e9b0@siemens.com>
Date: Fri, 27 Aug 2021 15:01:23 +0200
MIME-Version: 1.0
In-Reply-To: <10a0-6128b080-11d-29fb8780@204571863>
Content-Type: text/plain; charset="utf-8"
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
To: =?UTF-8?Q?Fran=c3=a7ois_Legal?= <devel@thom.fr.eu.org>, xenomai@xenomai.org

On 27.08.21 11:29, François Legal via Xenomai wrote:
> Hello,
> 
> working on a zynq7000 target (arm cortex a9), we have a peripheral that generates loads of data (many kbytes per ms).
> 
> We would like to move that data, directly from the peripheral memory (the OCM of the SoC) directly to our RT application user memory using DMA.
> 
> For one part of the data, we would like the DMA to de interlace that data while moving it. We figured out, the PL330 peripheral on the SoC should be able to do it, however, we would like, as much as possible, to retain the use of one or two channels of the PL330 to plain linux non RT use (via dmaengine).
> 
> My first attempt would be to enhance the dmaengine API to add RT API, then implement the RT API calls in the PL330 driver.
> 
> What do you think of this approach, and is it achievable at all (DMA directly to user land memory and/or having DMA channels exploited by xenomai and other by linux) ?
> 

IIRC, the topic of DMA also popped up in the context of SPI support in
the past. In any case, you likely want to check how Dovetail and EVL /
Xenomai 4 is possibly already addressing, to get an idea of potential
solution patterns.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

