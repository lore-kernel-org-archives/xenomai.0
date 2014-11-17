Date: Mon, 17 Nov 2014 08:21:24 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141117072124.GP4656@sisyphus.hd.free.fr>
References: <9540924A-C2CD-4465-AA62-CD3E0DC6938D@gmail.com>
 <CA+C+_XQBJ21AuO-rzeia9tPvtkZV1CWcieJV43Tmr8pJnEaa4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+C+_XQBJ21AuO-rzeia9tPvtkZV1CWcieJV43Tmr8pJnEaa4Q@mail.gmail.com>
Subject: Re: [Xenomai] Remote debug question
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Mathew Benson <mathew.benson@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Sun, Nov 16, 2014 at 06:22:22PM -0600, Mathew Benson wrote:
> GDB:  GNU gdb (Ubuntu 7.7.1-0ubuntu5~14.04.2) 7.7.1

You shoult not be using gdb, but arm-linux-gnueabihf-gdb, right? If
you are using an arm-linux-gnueabihf toolchain.

-- 
					    Gilles.

