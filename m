Message-ID: <51E43CE5.5020103@xenomai.org>
Date: Mon, 15 Jul 2013 20:18:13 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <A46EF8CF1BBB8E4B8A27B73E177C466402463ADE@MAIL-SINTERS-01.sinters-int.fr>,
	<51DBF250.9070804@xenomai.org>
	<A46EF8CF1BBB8E4B8A27B73E177C466402464B37@MAIL-SINTERS-01.sinters-int.fr>,
	<51DC560F.90805@xenomai.org>
	<A46EF8CF1BBB8E4B8A27B73E177C4664033EC616@MAIL-SINTERS-01.sinters-int.fr>,
	<51DDB5C3.7010307@xenomai.org>
	<A46EF8CF1BBB8E4B8A27B73E177C4664033F268F@MAIL-SINTERS-01.sinters-int.fr>,
	<51DEF6FB.6080403@xenomai.org>
	<A46EF8CF1BBB8E4B8A27B73E177C4664033F3724@MAIL-SINTERS-01.sinters-int.fr>
In-Reply-To: <A46EF8CF1BBB8E4B8A27B73E177C4664033F3724@MAIL-SINTERS-01.sinters-int.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RE : RE : RE : RE : No boot kernel with xenomai on
 i.MX6Q Sabrelite
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Younes CHALABI <y.chalabi@sinters.fr>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 07/15/2013 03:00 PM, Younes CHALABI wrote:

> Hi Gilles,
>
> I have tried to disable the CONFIG_IPIPE and CONFIG_XENOMAI manually
> on the .config, where CONFIG_cpu_IDLE was already disabled, then
> recompile but still have the same issue as previously.


It is generally not a good idea to edit the .config manually. Automatic 
dependencies may re-enable the options you want disabled.

Anyway, if indeed the kernel without CONFIG_IPIPE and CONFIG_XENOMAI 
does not boot, your problem has probably nothing to do with Xenomai.

Again, I would recommend using mx6q_defconfig and checking that this 
default configuration at least boots.


-- 
                                                                 Gilles.

