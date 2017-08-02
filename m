References: <CADXNiGXcYVk8JUDv24_TVLtvRQ=hJaaSiMzwQPct5V92U-jGYw@mail.gmail.com>
 <640d22cb-ac74-6702-8c15-76ace5732262@xenomai.org>
 <CADXNiGW4EB96ovgEqutmYthLS9rk9paHGj0BGQG_dZCmiB2S6Q@mail.gmail.com>
 <CADXNiGW83FQPkVvdsdYzNSjVHmE0pL1YbxuNVpC4bd3uZJBN1g@mail.gmail.com>
 <4d7df01d-e90b-2598-6424-7336732c2be5@xenomai.org>
 <CADXNiGXDwfAtX3f7FpjeSRe0NsJcZi_EW2=+9MZd-93xWBQkJA@mail.gmail.com>
 <CADXNiGXfA0EE3BRKQWmDQa8Ks9rfjL+00PTsXg+1xbz3kiY2Bw@mail.gmail.com>
From: Tom Evans <tom_usenet@optusnet.com.au>
Message-ID: <c8debbac-f9fb-fc86-d121-92b8d4dd5284@optusnet.com.au>
Date: Wed, 2 Aug 2017 15:41:31 +1000
MIME-Version: 1.0
In-Reply-To: <CADXNiGXfA0EE3BRKQWmDQa8Ks9rfjL+00PTsXg+1xbz3kiY2Bw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] real-time spi driver for imx6
Reply-To: tom_usenet@optusnet.com.au
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, jackson.jones@gmail.com

On 02/08/17 12:31, Jackson Jones wrote:
> Philippe,

i.MX6 SPI Driver.

I hope that one is better (meaning completely rewritten) than the i.MX53 one. 
It has all sorts of problems.

You might want to check to see if any of the i.MX53 driver problems I found 
and fixed are in the i.MX6 ones:

https://community.nxp.com/message/585208#585208

You should be able to transfer BLOCKS of data to the SPI driver and not have 
to have it context switch on every byte.

We got different performance between using the "write()" call and the 
"ioctl(SPI_IOC_MESSAGE)" one.

> We are using this in a medical device. We have the spi device
 > connected to an FPGA which in turn communicates with an RF board.

Maybe you could program the FPGA to perform 64-bit (or longer) SPI reads, and 
reduce your context switching that way.

The i.MX6 SPI hardware is quite capable and smart. It is likely the driver 
isn't using the features that would reduce the loading you're seeing.

Rather than trying to write a bad Xenomai driver, getting a sensible and 
efficient Linux driver might be a better option.



