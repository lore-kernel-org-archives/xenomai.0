Message-ID: <53FF95CE.8060803@xenomai.org>
Date: Thu, 28 Aug 2014 22:49:18 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20140828203532.GA17690@csclub.uwaterloo.ca>
 <53FF93A3.8070101@xenomai.org> <20140828204759.GB17690@csclub.uwaterloo.ca>
In-Reply-To: <20140828204759.GB17690@csclub.uwaterloo.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai/Ipipe on arm with LPAE enabled not booting
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: xenomai@xenomai.org

On 08/28/2014 10:47 PM, Lennart Sorensen wrote:
> On Thu, Aug 28, 2014 at 10:40:03PM +0200, Gilles Chanteperdrix wrote:
>> Chances are high that the kernel starts booting, but encounters a 
>> problem before enabling the console. In order to get the traces, see:
>>
>> http://xenomai.org/2014/06/porting-xenomai-to-a-new-arm-soc/#The_kernel_stops_after_the_message_8220Uncompressing_Linux8230_done_booting_the_kernel8221
> 
> Unfortunately the serial port is NOT 8250 on the omap5, although it is
> a 16750 supposely, just driven by another driver (this is changing in
> the future fortunately).
> 
> I will give it a try though.
> 
> It didn't occur to me to look at the porting docs given "it already
> works". :)
> 

If you have JTAG with gdb server, then simply connect gdb and dump
printk_buf.

-- 
                                                                Gilles.

