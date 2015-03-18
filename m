Date: Wed, 18 Mar 2015 08:54:01 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150318075401.GM16113@hermes.click-hack.org>
References: <CAC=FX11g823+4e50Tx4yDkp9ukGp588Qunp5epOFgFDc9EgGew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC=FX11g823+4e50Tx4yDkp9ukGp588Qunp5epOFgFDc9EgGew@mail.gmail.com>
Subject: Re: [Xenomai] irqbench: irqloop device or resource busy
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Pavel Anistratov <pavel903@gmail.com>
Cc: xenomai@xenomai.org

On Wed, Mar 11, 2015 at 08:48:59PM +0600, Pavel Anistratov wrote:
> I’m trying to test interrupt handling from parallel port using irqloop
> program from irqbench, but when I try to start irqloop I get an error:
> $ root@debian:/home/user/xenomai-2.6.4/src/testsuite/irqbench# ./irqloop -i 1
> $ irqloop: error starting test: Device or resource busy
> 
> I loaded kernel module with modprobe xeno_irqbench command, but the
> problem seems to occur during the first access command:
> ioctl(benchdev, RTTST_RTIOC_IRQBENCH_START, &config)
> How to solve this problem?
> 
> I’m using the last stable release Xenomai 2.6.4 and Debian 7.8
> (wheezy) 32-bit with kernel 3.16.0

Maybe the irq is already occupied by Linux parallel port driver and
unloading it would avoid that?

-- 
					    Gilles.

