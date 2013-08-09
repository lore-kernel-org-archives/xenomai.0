Message-ID: <52053496.6040704@xenomai.org>
Date: Fri, 09 Aug 2013 20:27:34 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1124806E0C09F04A992E69AE2EC7FA3C80A9A7@swexchange01.itk.local>
In-Reply-To: <1124806E0C09F04A992E69AE2EC7FA3C80A9A7@swexchange01.itk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Problems with running Xenomai on Core i5
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Tobias Luksch <Tobias.Luksch@itk-engineering.de>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 08/09/2013 02:48 PM, Tobias Luksch wrote:
> Hello Gilles,
> 
> thank you for your help. I disabled ACPI in the kernel as another
> desperate try while hunting down my problem, now I will enable it
> again.
> 
> I mainly opted for kernel version 3.2.21 as we need a 3.2 kernel
> because of some other software we have to use in the project and the
> adeos patch for 3.2.21 came with the xenomai 2.6.2.1 tarball. Could
> you suggest another 3.2 kernel version, or would you discourage me
> from using a 3.2.x kernel at all?

If you want to use the 3.2 kernel, you have to backport some patches
from the 3.4 or 3.5 branch.

-- 
                                                                Gilles.

