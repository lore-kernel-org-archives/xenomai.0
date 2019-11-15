Subject: Re: [PATCH] rtdm: Do not return an error from send/recvmmsg if there
 are packets
References: <02a4475e-f687-8e87-1971-1948cecfbf34@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <4cdc4d6a-f073-611b-1b0e-306dfeecb176@xenomai.org>
Date: Fri, 15 Nov 2019 10:37:28 +0100
MIME-Version: 1.0
In-Reply-To: <02a4475e-f687-8e87-1971-1948cecfbf34@siemens.com>
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
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

On 11/14/19 7:59 PM, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> This is in line with Linux behavior.
> 
> We likely still miss an equivalent to sk_err in recvmmsg, though.

Ack. Tracing on early exit due to null vlen in sendmmsg() is still missing; having this might help in debugging issue(s) at call site.

-- 
Philippe.

