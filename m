References: <7EBABB3E-8E3D-4AD0-9C08-5B1C464690BF@bela.io>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <e5832242-8d40-2ee7-929c-fd7c167434d4@xenomai.org>
Date: Tue, 18 Jul 2017 10:06:25 +0200
MIME-Version: 1.0
In-Reply-To: <7EBABB3E-8E3D-4AD0-9C08-5B1C464690BF@bela.io>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Porting Xenomai 3 cobalt to Raspberry Pi 3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Liam Donovan <liam@bela.io>, xenomai@xenomai.org

On 07/17/2017 06:20 PM, Liam Donovan wrote:
> Hello
> 
> I’m attempting to port the xenomai cobalt core to the pi3 (actually to a compute module 3, but as far as I can tell they use the same chip) with a 4.9 kernel, and am having some trouble. The ipipe patch applies successfully and the kernel compiles (with CONFIG_IPIPE set and CONFIG_XENOMAI not set) but it fails with the following oops during boot:
> 

<snip>

It looks like the timer interrupt does not go through the pipeline but
directly to the regular kernel core instead, which is the basic issue.
This patch may be missing significant portions of the interrupt pipeline
logic.

There is an ongoing port of Xenomai 3.x to rpi3. I'll follow up on it.

-- 
Philippe.

