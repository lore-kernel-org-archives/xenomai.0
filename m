Date: Mon, 20 Apr 2015 19:46:23 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150420174623.GA456@hermes.click-hack.org>
References: <CAL5YyVZw6JttAzBnApqQyV-9o3ng9VG3Srv=E5bGfD1tRaZZ+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL5YyVZw6JttAzBnApqQyV-9o3ng9VG3Srv=E5bGfD1tRaZZ+g@mail.gmail.com>
Subject: Re: [Xenomai] X86 rebbot when i use latency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: ACO31 <alain.cordat@gmail.com>
Cc: xenomai@xenomai.org

On Fri, Apr 17, 2015 at 02:50:22PM +0200, ACO31 wrote:
> hi,
> 
> conf Xeno3, cobalt, kernel 3.16.7(from kernel.org),build for X86 (32bits)
> No problem on compile/install.
> I may read correct data in dmesg.
> I may do all cat about xenomai in /proc/xenomai.
> But when i run /usr/xenomai/bin/latency -p 100, the system reboot without
> message.
> could you help me.

Are you sure that the system is not simply experiencing a kernel
oops and that your system is configured to reboot in that case?

If that is the case, disable this, and run the latency test in text
mode in order to see the oops text. Or capture it via serial console
if you are lucky enough that your PC has a serial port.

-- 
					    Gilles.

