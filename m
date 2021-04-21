Subject: Re: RTSerial Difference in Behavior Between 2.6.4 & 3.1
References: <CY4PR02MB261531B57960FF9BD47E890BDC489@CY4PR02MB2615.namprd02.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <39840ca2-483a-1ece-f6e2-c1a49f3fb462@siemens.com>
Date: Wed, 21 Apr 2021 09:00:08 +0200
MIME-Version: 1.0
In-Reply-To: <CY4PR02MB261531B57960FF9BD47E890BDC489@CY4PR02MB2615.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Alan Gaglio <AGaglio@jerviswebb.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 20.04.21 16:45, Alan Gaglio via Xenomai wrote:
> I am in the process of upgrading from 32-bit/Xenomai 2.6.4/Ubuntu 14.04.4/
> Linux 3.16.7 to 64-bit/Xenomai 3.1/Ubuntu 20.04.1/Linux 5.4.77 and I'm
> experiencing an rtserial event difference in behavior. Our application
> depends on single-byte interrupts from rtserial ports, which we're
> not seeing despite having configured rtserial ports the same between our 2
> different image configurations that run on the same x86 hardware.
> Attached is a modified cross-link.c example that highlights this
> difference in behavior. Also included is relevant detail for each target,
> build, and sample program output.
> 
> My modified cross-link.c transmits 26 characters every 1 second and prints
> the number of RX_PEND events along with reception bins every 26 characters
> read by the receive thread. Reception bins show the number of bytes
> read per RX_PEND event [0-16,17+]. The total number of bytes
> processed equals the sum of all bins multiplied by the quantity they
> represent. For example, these snipped outputs (from the below greater
> details) were taken following a total of 208 bytes transmitted. In
> 2.6.4 we have 208 events * 1 byte = 208 bytes and in 3.1 we have
> 48 events * 4 bytes + 8 events * 2 bytes = 208 bytes. We expect/desire the
> second bin to be exclusively non-zero (2.6.4 output), indicating an RX_PEND
> event for each byte that arrives on the serial port.
> 
> 2.6.4 Output:
> rx.events=1  | rx.rx_pending=1 | r_t=1618404168709819446
> Count= 208 bins=0 208 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
> 3.1 Output:
> rx.events=1  | rx.rx_pending=2 | r_t=1618406767806828954
> Count=  56 bins=0 0 8 0 48 0 0 0 0 0 0 0 0 0 0 0 0 0
> 
> I'm not sure where to take the next level of troubleshooting and am happy to
> provide additional detail, run tests, etc. The attached cross-link includes
> some preprocessor defines to modify program behaviors that I can explain if
> helpful. Details shown below are also attached with line wrapping removed
> for reference.
> 

Didn't dig through all the detailed information you provided yet, but
the first questions that come up for me would be

 - do interrupts for the UART arrive at the expected rate, or are they
   already delayed?

 - already tried to collect a system trace (ftrace event tracing) to
   gain an overview of what the application does when and what happens
   Xenomai-wise in the core (context switch, interrupts, etc.)?

If interpreting the trace is tricky, share it. Also taking tracing on
both 2.6 and 3.1 setups can help to find differences.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

