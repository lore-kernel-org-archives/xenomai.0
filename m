Message-ID: <532DC149.9000704@xenomai.org>
Date: Sat, 22 Mar 2014 17:58:49 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <40A5BE95-8E78-4CD6-81D2-C97AA7A58FBB@open.ac.uk>
 <5B55252A-19D2-4A0D-82BE-FC77BFA6AEE1@open.ac.uk>
 <529DFEC3.1050106@xenomai.org>
 <90F2A7A6-5B5E-4A25-8D9D-3D50D0EC0826@open.ac.uk>
 <529E2801.5060505@xenomai.org> <529EEB7C.4090308@xenomai.org>
 <529EED06.4010108@xenomai.org> <529EF58A.8030003@xenomai.org>
 <529EF680.1040108@xenomai.org> <529EF89E.6000302@xenomai.org>
 <529EFB3D.6090900@xenomai.org> <529F03FC.8040409@xenomai.org>
 <529F04DD.2070201@xenomai.org> <529F0C48.20705@xenomai.org>
 <529F0DBC.9080905@xenomai.org> <529F13A1.5070403@xenomai.org>
 <529F1913.4030604@xenomai.org> <529F1974.60900@xenomai.org>
 <529F2BED.2030403@xenomai.org> <529F5254.8060501@xenomai.org>
 <529F69AD.6060003@xenomai.org>
 <CE87D5F4-FE47-4310-A74F-7F8E4CCEC92B@open.ac.uk>
 <52A05ED2.9050003@xenomai.org>
 <E8F821A2-2BD0-440D-BDA1-3751BD443662@open.ac.uk>
 <52A5E155.2040303@xenomai.org>
 <3F3EA914-853F-49FD-95E2-5148A5CD7440@open.ac.uk>
 <4061C04AFD7DEC43911DCD1D655809401199EE31F5@SI-MBX13.de.bosch.com>
In-Reply-To: <4061C04AFD7DEC43911DCD1D655809401199EE31F5@SI-MBX13.de.bosch.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Analogy NI 6052E
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Erhart Robert (CC-DA/ESR3)" <Robert.Erhart@de.bosch.com>
Cc: Kurijn Buys <Kurijn.Buys@open.ac.uk>, "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 03/21/2014 03:33 PM, Erhart Robert (CC-DA/ESR3) wrote:
> Servus,
> 
> I had the same problem on my System:
> xenomai 2.6.3
> linux 3.8.13
> PCIe-6251
> 
> Here is a small patch for this problem. 
> Relevant is only the line  <transfer = (a4l_trf_t *) p->private;>. The other stuff removes only the compiler warnings.

Merged, thanks.


-- 
                                                                Gilles.

