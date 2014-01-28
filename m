Message-ID: <52E7F09C.40807@xenomai.org>
Date: Tue, 28 Jan 2014 19:02:04 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CF0C8022.1881D%jsynesio@us-power.com>
In-Reply-To: <CF0C8022.1881D%jsynesio@us-power.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] NetLink for IPC between Xenomai Driver and User Space
 App
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: John Syn <john3909@gmail.com>
Cc: Xenomai@xenomai.org

On 01/28/2014 06:29 AM, John Syn wrote:
> Is there any ways to implement NetLink in a Xenomai Driver?
>
> I¹m thinking that a Netlink IPC interface would simplify the interface
> between a Xenomai device driver and a user space app (nodejs with
> asynchronous I/O) compared with IOCTL/syscalls.

RTDM, the interface used to create drivers for xenomai, allows you to 
define drivers for arbitrary socket protocols (this is used for instance 
by rtnet to implement IP/UDP socket, or by the RTIPC driver to implement 
specialized IPCs), so, you can define the AF_NETLINK socket if you like.


-- 
					    Gilles.

