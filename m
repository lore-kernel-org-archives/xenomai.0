Message-ID: <4FECA5AE.2010903@xenomai.org>
Date: Thu, 28 Jun 2012 20:42:54 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4FEC9EA4.7020102@wanadoo.fr>
In-Reply-To: <4FEC9EA4.7020102@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rtser_xxx API availability on ARM iMX6 ?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Thierry Bultel <thierry.bultel@wanadoo.fr>
Cc: xenomai@xenomai.org

On 06/28/2012 08:12 PM, Thierry Bultel wrote:
> Hi,
> 
> Are these serial services supported on the named platform ?

No. The IMX serial driver is specific to this family of SOCs, and
xenomai does not currently have a driver for it.

> Is ipipe_serial_debug usable, too ?

ipipe_serial_debug works, yes.

-- 
                                                                Gilles.

