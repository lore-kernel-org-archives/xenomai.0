Message-ID: <53FF982B.2040203@xenomai.org>
Date: Thu, 28 Aug 2014 22:59:23 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20140828203532.GA17690@csclub.uwaterloo.ca>
 <53FF93A3.8070101@xenomai.org> <20140828204759.GB17690@csclub.uwaterloo.ca>
 <53FF95CE.8060803@xenomai.org> <20140828205109.GC17690@csclub.uwaterloo.ca>
In-Reply-To: <20140828205109.GC17690@csclub.uwaterloo.ca>
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

On 08/28/2014 10:51 PM, Lennart Sorensen wrote:
> On Thu, Aug 28, 2014 at 10:49:18PM +0200, Gilles Chanteperdrix wrote:
>> If you have JTAG with gdb server, then simply connect gdb and dump
>> printk_buf.
> 
> Yeah I guess I could do that, but then I have to use eclipse because it
> is ti's debugger.  But I will if I have to.

Yet another solution is to enable early printk via the "DCC" channel,
which should normally get the early printks to be sent to the JTAG. You
can then ask your JTAG to display the messages.

The openocd command seems to be "target_request debugmsgs charmsg". I
have never tried this on TI processors, but I have tried it on other
processors with other JTAG, which shows that at least, on Linux side, it
works.

-- 
                                                                Gilles.

