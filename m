References: <2C2C7702C02C48D7A264944F1391A7F1@itd206>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <faf6b09c-9aa7-df50-5827-43af9e4dd3b6@xenomai.org>
Date: Mon, 11 Jun 2018 15:31:42 +0200
MIME-Version: 1.0
In-Reply-To: <2C2C7702C02C48D7A264944F1391A7F1@itd206>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Reg:Xenomaui support for Powerpc p1022
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Sureshvs <sureshvs@datapatterns.co.in>, xenomai@xenomai.org

On 06/11/2018 01:10 PM, Sureshvs wrote:
> Hi
> 
>  
> I am using freescale P1022 PowerPC based processor board.xenomai support is available for p1022 ?
> In your website, suported architectures for powerpc1022 is not mentioned.
> 

A port to the fsl p1022-DS reference board was completed some time ago
for Xenomai 2.6 [1]. This should work with Xenomai 3.x too, provided the
interrupt pipeline patch (aka I-pipe/powerpc) for the target kernel
release runs properly on this board. I have no reason to doubt it, but
in absence of recent test on such platform, there is no guarantee.

[1]
https://git.xenomai.org/xenomai-2.6.git/commit/?id=6aed189e0942235a98b91635ddad6ee963f964ce


-- 
Philippe.

