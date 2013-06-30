Message-ID: <51D07B48.9060206@xenomai.org>
Date: Sun, 30 Jun 2013 20:39:04 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <51CD5651.6030804@wanadoo.fr>
In-Reply-To: <51CD5651.6030804@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Thermal issue on iMX6q
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

On 06/28/2013 11:24 AM, Thierry Bultel wrote:

> I understand that the thermal management is disabled with xenomai,
> because CPU_FREQ is forbidden.


If you are using the Freescale kernel, CPU_FREQ should actually be 
enabled. But it is true that the frequency should not be changed after 
Xenomai is started, as Xenomai does not support it. However, if I 
remember correctly, there was a kernel parameter allowing to select a 
frequency at boot time.

-- 
                                                                 Gilles.

