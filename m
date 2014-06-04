Message-ID: <538F43D9.7020809@nta-inc.net>
Date: Wed, 04 Jun 2014 11:05:45 -0500
From: Jeff Webb <jeff.webb@nta-inc.net>
MIME-Version: 1.0
References: <537D35BD.1030302@nta-inc.net>
In-Reply-To: <537D35BD.1030302@nta-inc.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: xenomai@xenomai.org

On 05/21/2014 06:24 PM, Jeff Webb wrote:

> Has anyone written an RTDM driver for the Xilinx Zynq PS UART?

 From the lack of response, I assume the answer to this question is 'no'.  Given that, can someone please comment on what I have written below regarding the process of porting a linux serial driver to RDTM?

> If not, I assume the best way to obtain one would be to start with the
> Xilinx-provided linux driver (xilinx_uartps.c) and port it to RTDM.
> Is there a "HOWTO" or other documentation for the porting process?
> Without further direction, I was going to compare an existing pair
> of RTDM drivers (e.g. mpc52xx_uart.c and rt_mpc52xx_uart.c) to see
> what changes were made and try to do something similar for the Xilinx
> driver.  In the end, I would like to have a driver that is as
> compatible with the RTDM 16550 driver as much as possible.
>
>
> I will try to digest the information here:
>
>    http://www.xenomai.org/documentation/trunk/html/api/group__rtdm.html
>    http://www.xenomai.org/documentation/trunk/html/api/group__rtserial.html
>
> and look at the simple RTDM example here:
>
>    xenomai-2.6.3/examples/rtdm/driver-api
>
> This mailing-list thread also looks informative:
>
>    http://www.xenomai.org/pipermail/xenomai/2010-August/021220.html
>
> Any advice would be appreciated.
>
> Thanks,
>
> -Jeff
>
>
>


