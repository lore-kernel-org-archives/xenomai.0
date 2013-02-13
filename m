Message-ID: <511BEBF9.1050202@xenomai.org>
Date: Wed, 13 Feb 2013 20:39:37 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <DC570CF5-F540-40FB-B313-596AF53EDDA2@mah.priv.at>
	<F43474DF-1ADA-4463-AF44-2B498EF3024E@mah.priv.at>
	<511B7ED3.8060106@xenomai.org>
	<EBF3A505-DBCB-492B-B788-2127A053DAF1@mah.priv.at>
In-Reply-To: <EBF3A505-DBCB-492B-B788-2127A053DAF1@mah.priv.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] puzzled: running switchtest improves latency figures
 permanently
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Haberler <mail17@mah.priv.at>
Cc: Schooner <schooner30@tiscali.co.uk>, sam sokolik <samco@empirescreen.com>, John Morris <john@zultron.com>, xenomai@xenomai.org

On 02/13/2013 03:35 PM, Michael Haberler wrote:

> Are there any specific knobs you'd suggest twisting?


You have to configure what should happen when Linux is idle. You can
change what Linux does when idle, by using the kernel command line
parameters as Henri told you, or you may be able to configure what the
processor does when idle. This may be possible from the BIOS menu, or
alternatively with special tools which can be loaded by the boot-loader
before Linux. On Intel processors, such a tool is Intel BIOS
Implementation Test suite:

http://biosbits.org/

I do not know about AMD processors.

Regards.

-- 
                                                                Gilles.

