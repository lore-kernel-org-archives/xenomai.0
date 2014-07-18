Message-ID: <53C8E426.7060309@xenomai.org>
Date: Fri, 18 Jul 2014 11:08:54 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1546174838.19906925.1405671913876.JavaMail.root@openwide.fr>
In-Reply-To: <1546174838.19906925.1405671913876.JavaMail.root@openwide.fr>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai support for DM8148
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Pierre Ficheux <pierre.ficheux@openwide.fr>, xenomai@xenomai.org

On 07/18/2014 10:25 AM, Pierre Ficheux wrote:
> Hi all,
> 
> I'm looking for experiment about using Xenomai with TI DM8148 and "standard" TI kernel (2.6.37).
> 
> It seems standard ADEOS patch does not apply correctly to the TI kernel.
> 
> thx by advance,
> 
> http://processors.wiki.ti.com/index.php/DM814x_Overview
> http://software-dl.ti.com/dsps/dsps_public_sw/psp/LinuxPSP/DM814x_04_01/04_01_00_07/index_FDS.html
> 

No wonder why, the TI kernel for this board is patched beyond all
recognition. The code driving the interrupt controller chip on the
centaurus needs some attention to be Adeos-aware.

HTH,

-- 
Philippe.

