Message-ID: <539AC78A.1080806@xenomai.org>
Date: Fri, 13 Jun 2014 11:42:34 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <537D35BD.1030302@nta-inc.net> <538F43D9.7020809@nta-inc.net>
In-Reply-To: <538F43D9.7020809@nta-inc.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RTDM driver for Xilinx Zynq PS UART
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jeff Webb <jeff.webb@nta-inc.net>, xenomai@xenomai.org

On 06/04/2014 06:05 PM, Jeff Webb wrote:
> On 05/21/2014 06:24 PM, Jeff Webb wrote:
> 
>> Has anyone written an RTDM driver for the Xilinx Zynq PS UART?
> 
> From the lack of response, I assume the answer to this question is
> 'no'.  Given that, can someone please comment on what I have written
> below regarding the process of porting a linux serial driver to
> RDTM?
> 
>> If not, I assume the best way to obtain one would be to start with
>> the Xilinx-provided linux driver (xilinx_uartps.c) and port it to
>> RTDM. Is there a "HOWTO" or other documentation for the porting
>> process? Without further direction, I was going to compare an
>> existing pair of RTDM drivers (e.g. mpc52xx_uart.c and
>> rt_mpc52xx_uart.c) to see what changes were made and try to do
>> something similar for the Xilinx driver.  In the end, I would like
>> to have a driver that is as compatible with the RTDM 16550 driver
>> as much as possible.

I would rather use the existing drivers to see what ioctls need to be
implemented and implement them in the new driver, using the linux code
to know how to implement these ioctls.

-- 
                                                                Gilles.

