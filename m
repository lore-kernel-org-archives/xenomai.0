Message-ID: <c6a0fa05-8348-dfff-fc1e-938795a1f266@siemens.com>
Date: Mon, 7 Feb 2022 08:21:58 +0100
MIME-Version: 1.0
Subject: Re: UDD with shared interrupts?
Content-Language: en-US
References: <A9p1YZoCjJLY022S76mAXuvt70QWpXy_dZ-qDq4aUPqDLINgdbSY7qUhHeUmAa0FML6gZWvd7_q2SUQyTBNVeq2r-liU6CnL_ZrzuesB0dc=@codecraftsmen.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <A9p1YZoCjJLY022S76mAXuvt70QWpXy_dZ-qDq4aUPqDLINgdbSY7qUhHeUmAa0FML6gZWvd7_q2SUQyTBNVeq2r-liU6CnL_ZrzuesB0dc=@codecraftsmen.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jeff Webb <w1@codecraftsmen.org>, Xenomai <xenomai@xenomai.org>

On 02.02.22 17:12, Jeff Webb via Xenomai wrote:
> I am updating and reworking a UDD driver stub and happened to notice a difference between the UDD and UIO APIs.  It looks like udd_register_device() always passes "0" as the rtdm_irq_request() "flags" argument, whereas uio_register_device() allows flags to be passed in to request_irq().  Does this mean that shared interrupts are not currently possible with UDD drivers?  Is there a reason for this difference in the UDD and UIO APIs?
> 

You can add RTDM_IRQTYPE_SHARED as flag - but note that this will only
give you sharing between RT devices. Cross-domain sharing would break
determinism.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

