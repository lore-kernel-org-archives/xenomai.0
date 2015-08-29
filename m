Date: Sat, 29 Aug 2015 17:46:17 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150829154617.GF20679@hermes.click-hack.org>
References: <8655AC8285F53F42A4B1B3CAB3092C47235FC2D7@IVKEX2.fkfs.de>
 <8655AC8285F53F42A4B1B3CAB3092C47235FD2F2@IVKEX2.fkfs.de>
 <8655AC8285F53F42A4B1B3CAB3092C47235FD31D@IVKEX2.fkfs.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8655AC8285F53F42A4B1B3CAB3092C47235FD31D@IVKEX2.fkfs.de>
Subject: Re: [Xenomai] Question about priority coupling in primary and
 secondary mode
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Rothermel, Thomas" <Thomas.Rothermel@fkfs.de>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Sat, Aug 29, 2015 at 03:23:28PM +0000, Rothermel, Thomas wrote:
> Furthermore I can't use RTnet, because all other network nodes
> don't use it.

That is a wrong reason not to use RTnet.



> Then I found out that from Xenomai v2.6.x on, the option
> XENO_OPT_PRIOCPL was disabled by default, and I recompiled the
> kernel with XENO_OPT_PRIOCPL enabled. Unfortunately that didn't
> help. As far as I understand, this option should solve my
> problem...

The root thread priority coupling does not solve everything. In
particular, when a thread is suspended waiting for an interrupt, the
primary mode activity has priority over handling the non real-time
interrupt.

-- 
					    Gilles.
https://click-hack.org

