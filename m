References: <CAMHY3mtVrTsjGR7kGtREsXYWWjR48Dgm3RBs3aGsVCDXb5JAuQ@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <0db5f8d2-8931-7c4b-9a39-943a74175fe2@xenomai.org>
Date: Thu, 27 Apr 2017 15:49:46 +0200
MIME-Version: 1.0
In-Reply-To: <CAMHY3mtVrTsjGR7kGtREsXYWWjR48Dgm3RBs3aGsVCDXb5JAuQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] support for Samsung s5p6818 SOC
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Testtest Chen <test1111.chen@gmail.com>, xenomai@xenomai.org

On 04/26/2017 11:32 AM, Testtest Chen wrote:
> Hi, We are going to implement the Xenomai onto Samsung s5p6818 SOC which is
> currently using ARM 32 bits kernel 3.4.39.
> Do you have related support on this?

I don't think we ever came across this SOC, so for 32bit support, you
would have to port some outdated IRQ pipeline code to this hardware,
based on an existing patch available from [1]. Xenomai 2.6.5 legacy
release should still build on top of this (Xenomai 3.x would not).

[1] http://xenomai.org/downloads/ipipe/v3.x/arm/older/

-- 
Philippe.

