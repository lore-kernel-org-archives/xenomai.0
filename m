Message-ID: <539DAFDD.9050808@xenomai.org>
Date: Sun, 15 Jun 2014 16:38:21 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <539CCDDC.7000809@konstantin-schauwecker.de>
 <539D96FB.5040300@xenomai.org>
 <647F5D52-A9A5-4B6E-B608-E143A94BFBB0@konstantin-schauwecker.de>
In-Reply-To: <647F5D52-A9A5-4B6E-B608-E143A94BFBB0@konstantin-schauwecker.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Missing patch for Zynq
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Konstantin Schauwecker <hi@konstantin-schauwecker.de>, xenomai@xenomai.org

On 06/15/2014 04:31 PM, Konstantin Schauwecker wrote:
> Yes, that is what I was referring to. The mentioned patch 
> ipipe-core-3.8.13-arm-1.patch
> does not exist in the xenomai 2.6.3 release, or in earlier releases. There is a different patch, labelled
> ipipe-core-3.8.13-arm-3.patch
> which does however not match the Xilinx kernel.

ipipe-core-3.8.13-arm-1.patch did not match the Xilinx kernel either, it
is a patch for mainline Linux. That is what the -pre and -post patches
are there for.


-- 
                                                                Gilles.

