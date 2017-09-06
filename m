References: <f61b6963a0f94bd0a09eb5eb359370e5@ocnapvsw3301.ocr.priv>
 <2154_1504634485_59AEE675_2154_8860_1_425b607a-6b79-420c-9ec1-e441f6a1434e@xenomai.org>
 <0be5b5280bb04fac807e522365c22e7d@ocnapvsw3301.ocr.priv>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <6f5edd75-961a-73f2-d41e-ec6843e8870b@xenomai.org>
Date: Wed, 6 Sep 2017 15:48:01 +0200
MIME-Version: 1.0
In-Reply-To: <0be5b5280bb04fac807e522365c22e7d@ocnapvsw3301.ocr.priv>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] R:  Xenomai 2.6.4 - POSIX skin thread creation limit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Fazio Maurizio <maurizio.fazio@leonardocompany.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 09/06/2017 03:07 PM, Fazio Maurizio wrote:
> Hello,
> 
> I tried to execute the swithtest application and the following output is the result...
> For me It's not simple to understand the meaning of this output... but evidently there is an allocation memory problem.
> 
> The following is the current kernel configuration... as you wrote last time it's recommendable to increase CONFIG_XENO_OPT_SYS_HEAPSZ and CONFIG_XENO_OPT_SYS_STACKPOOLSZ values... but before a kernel recompilation I would know the meaning of these parameters in order to understand how much I can increase these values

For a description, please check the help strings in the Kconfig for each
of these parameters (visible with e.g. make xconfig/gconfig).

-- 
Philippe.

