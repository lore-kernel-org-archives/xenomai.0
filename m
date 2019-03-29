Subject: Re: irqchip tps65217 is not pipeline-safe!
References: <AM0PR07MB5572FDFC8BB9278EC530F1DCB5590@AM0PR07MB5572.eurprd07.prod.outlook.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <91222f7d-c3c3-848d-f304-e97c4ff4f9d6@xenomai.org>
Date: Fri, 29 Mar 2019 11:37:47 +0100
MIME-Version: 1.0
In-Reply-To: <AM0PR07MB5572FDFC8BB9278EC530F1DCB5590@AM0PR07MB5572.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Giulio Moro <g.moro@qmul.ac.uk>, "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 3/28/19 8:51 PM, Giulio Moro via Xenomai wrote:
> Hi there,
> booting a 4.14.94-ti kernel with Cobalt 3.0.8 from the "stable/v3.0.x" branch, on an am3358 (PocketBeagle) I get a warning during boot "irqchip tps65217 is not pipeline-safe!". The tps65217 is the power-management IC for the board. What does this message mean exactly? Is it something to be concerned about? The board has behaved fine when running Xenomai tasks, in spite of this issue.

Nevertheless, this is unreliable. This warning is issued because the
irqchip code handling the tps65217 mfd which is enabled on your platform
was not tagged as supporting IRQ pipelining (IRQCHIP_PIPELINE_SAFE not
present in the flags). At the very least, this means that nobody cared
checking for this.

This matter is documented in Documentation/ipipe.rst.

-- 
Philippe.

