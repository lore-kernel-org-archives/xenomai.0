Message-ID: <53FF93A3.8070101@xenomai.org>
Date: Thu, 28 Aug 2014 22:40:03 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20140828203532.GA17690@csclub.uwaterloo.ca>
In-Reply-To: <20140828203532.GA17690@csclub.uwaterloo.ca>
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
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>, xenomai@xenomai.org

On 08/28/2014 10:35 PM, Lennart Sorensen wrote:
> So I did some experiments on 3.12 kernel on an omap5726.
> 
> Xenomai/ipipe seems to work great (after all it managed to pass the
> xenomai test suite).
> 
> LPAE+KVM also works great.
> 
> However if you enable LPAE (with or without KVM) while ipipe is enabled
> (with or without xenomai enabled), then the kernel never boots (no
> console messages at all).
> 
> Any ideas where to start on debugging this problem?

Chances are high that the kernel starts booting, but encounters a 
problem before enabling the console. In order to get the traces, see:

http://xenomai.org/2014/06/porting-xenomai-to-a-new-arm-soc/#The_kernel_stops_after_the_message_8220Uncompressing_Linux8230_done_booting_the_kernel8221

-- 
                                                                Gilles.

