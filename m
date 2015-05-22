Date: Fri, 22 May 2015 23:05:03 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150522210503.GA1987@hermes.click-hack.org>
References: <245D3361-0412-466A-BFA1-22F2EDDC18B6@gatech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <245D3361-0412-466A-BFA1-22F2EDDC18B6@gatech.edu>
Subject: Re: [Xenomai] 3.14.17 patch initial ram disk hangup
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Yogi A. Patel" <yapatel@gatech.edu>
Cc: xenomai@xenomai.org

On Fri, May 22, 2015 at 04:47:59PM -0400, Yogi A. Patel wrote:
> Hi -
> 
> I have a Dell OptiPlex 9020 running 3.14.17. I am trying to get this system to run 3.14.17 with xenomai (using the 3.14.17 patch in the xenomai 2.6.4 source).
> 
> The computer hangs when I select the kernel at “Loading initial ram disk”. I tried booting into recovery mode and go the following output:
> 
> Kernel panic - not syncing: timer doesn’t work through Interrupt-remapped IO-APIC.
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.14.17-xenomai-2.6.4.
> 
> I’m having a hard time finding the source of the error. I’ve attached my config file. Any suggestions appreciated!

Does the exact same kernel configuration, but without CONFIG_IPIPE
and CONFIG_XENOMAI work ?

-- 
					    Gilles.

