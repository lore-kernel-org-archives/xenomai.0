References: <CADXNiGXcYVk8JUDv24_TVLtvRQ=hJaaSiMzwQPct5V92U-jGYw@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <640d22cb-ac74-6702-8c15-76ace5732262@xenomai.org>
Date: Fri, 30 Jun 2017 21:25:21 +0200
MIME-Version: 1.0
In-Reply-To: <CADXNiGXcYVk8JUDv24_TVLtvRQ=hJaaSiMzwQPct5V92U-jGYw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] real-time spi driver for imx6
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jackson Jones <jackson.jones@gmail.com>, Xenomai@xenomai.org

On 06/29/2017 11:15 PM, Jackson Jones wrote:
> Are there any plans to add a real-time driver for the imx6 spi?
> 
> 

No ongoing work to my knowledge. The ECSPI is fairly straightforward to
control in PIO mode. FWIW, I believe that writing a backend driving this
chip on top of Cobalt's generic SPI core should be possible, using the
bcm2835 implementation we already have in tree as an example.

testsuite/spitest.c illustrates the API exposed to userland by the SPI
core, which can use read/write calls or a memory-mapped transfer buffer.

-- 
Philippe.

