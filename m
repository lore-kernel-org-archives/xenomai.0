Message-ID: <507F85FA.9050704@xenomai.org>
Date: Thu, 18 Oct 2012 06:30:50 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAFNBftfgRC66N1JBEj5-e+ya4s5-RUqzeXsNs_iK6BTFrLmJ=w@mail.gmail.com>	<507E0569.5040101@xenomai.org>
	<CAFNBfteFL4Za8Va7PEd1dawWb3g1EqpdNSdhDjA9HkFDEpc8Aw@mail.gmail.com>
In-Reply-To: <CAFNBfteFL4Za8Va7PEd1dawWb3g1EqpdNSdhDjA9HkFDEpc8Aw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Latency tests - iMX53qsb
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Flavio Castro Alves Filho <flavio.alves@gmail.com>
Cc: xenomai@xenomai.org

On 10/18/2012 04:04 AM, Flavio Castro Alves Filho wrote:

> I'm trying to build using the instruction from Xenomai package
> (rel_imx_3.0.15_12.03.00) and I'm facing some issues.
> 
> The kernel does not compile when I turn off 'CPU Frequency Scaling' option.
> 
> I use imx5_defconfig from the standard kernel config files.
> 
> When I let 'CPU Frequency Scaling' on, with Xenomai, I have the
> message on Xenomai configuration options, but the build run with
> success.
> 
> Do I have to lel this option on?


Yes, probably. Please select the "performance" governor.

-- 
                                                                Gilles.

