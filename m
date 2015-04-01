Date: Wed, 1 Apr 2015 09:13:05 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150401071305.GS32766@hermes.click-hack.org>
References: <CAL5YyVYCeiRSCOQCrx+UkiLj+jqTL2tBUpziisaiSyEV9WAg7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL5YyVYCeiRSCOQCrx+UkiLj+jqTL2tBUpziisaiSyEV9WAg7w@mail.gmail.com>
Subject: Re: [Xenomai] latency : low_init(): mlockall: Cannot allocate memory
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: ACO31 <alain.cordat@gmail.com>
Cc: Xenomai@xenomai.org

On Tue, Mar 31, 2015 at 11:01:56PM +0200, ACO31 wrote:
> Hi all,
> 
> I've built xenomai 3 rc4 on 3.16.7 kernel. no problem.
> see hereafter an extract of the result of "xeno-config --info"
> I-pipe release # detected
> Cobalt core 3.0-rc4 detected
> Build args: --with-core=cobalt ....  --enable-debug=partial
>    --enable-registry CFLAGS="-m32" LDFLAGS="-m32".
> (No error during make)
> But when I launch  "latency -p 100", I have the message
> Xenomai/cobalt: low_init(): mlockall: Cannot allocate memory

"Cannont allocate memory" is ENOMEM.

See mlockall manual page for the possible reasons for such an error:
http://linux.die.net/man/2/mlockall

Regards.

-- 
					    Gilles.

