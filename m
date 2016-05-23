References: <20160502190557.GK2055@csclub.uwaterloo.ca>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <61255129-081b-7518-9ec6-2e6fdac782a7@xenomai.org>
Date: Mon, 23 May 2016 11:12:02 +0200
MIME-Version: 1.0
In-Reply-To: <20160502190557.GK2055@csclub.uwaterloo.ca>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] arm/ipipe: irq-crossbar: Fix NULL pointer
 dereference
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>, xenomai@xenomai.org

On 05/02/2016 09:05 PM, Lennart Sorensen wrote:
> arm/ipipe: irq-crossbar: Fix NULL pointer dereference
> 
> The TI irq-crossbar driver needs to declare the irq_hold and irq_release
> functions, otherwise IPIPE will dereference a NULL pointer.
> 
> Tested on AM5728.
> 

Merged, thanks.

-- 
Philippe.

